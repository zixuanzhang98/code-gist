DROP TABLE IF EXISTS star;
DROP TABLE IF EXISTS fork;
DROP TABLE IF EXISTS gist_comment;
DROP TABLE IF EXISTS gist;
DROP TABLE IF EXISTS gist_user;

CREATE TABLE gist_user
(
    user_id  SERIAL,               -- id generated by postgresql
    auth0_id TEXT NOT NULL UNIQUE, -- id generated by auth0
    user_name TEXT NOT NULL,       -- user_name from auth0
    picture TEXT NOT NULL,         -- picture url generated by auth0
    CONSTRAINT pk_user PRIMARY KEY (user_id)
);

CREATE TABLE gist
(
    gist_id       SERIAL,
    user_id       SERIAL      NOT NULL,
    gist_name     TEXT        NOT NULL,
    user_name     TEXT        NOT NULL,
    description   TEXT        NOT NULL,
    content       TEXT        NOT NULL,
    created       TIMESTAMP NOT NULL,
    last_modified TIMESTAMP NOT NULL,
    stars         INTEGER DEFAULT 0,
    comments      INTEGER DEFAULT 0,
    CONSTRAINT pk_gist PRIMARY KEY (gist_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES gist_user (user_id)
);

CREATE TABLE gist_comment
(
    comment_id   SERIAL,
    content      TEXT        NOT NULL,
    commented_at TIMESTAMP   NOT NULL,
    user_id      SERIAL      NOT NULL,
    gist_id      SERIAL      NOT NULL,
    CONSTRAINT pk_gist_comment PRIMARY KEY (comment_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES gist_user (user_id),
    CONSTRAINT fk_gist_id FOREIGN KEY (gist_id) REFERENCES gist (gist_id)
);

CREATE TABLE star
(
    user_id SERIAL,
    gist_id SERIAL,
    CONSTRAINT pk_star PRIMARY KEY (user_id, gist_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES gist_user (user_id),
    CONSTRAINT fk_gist_id FOREIGN KEY (gist_id) REFERENCES gist (gist_id)
);


INSERT INTO gist_user(auth0_id, user_name, picture)
VALUES ('test_auth0_id', 'ZZX', 'test_picture');

INSERT INTO gist_user(auth0_id, user_name, picture)
VALUES ('test_auth0_id2', 'WZY', 'test_picture2');

INSERT INTO gist_user(auth0_id, user_name, picture)
VALUES ('test_auth0_id3', 'CZY', 'test_picture3');

INSERT INTO gist(user_id, gist_name, user_name, description, content, created, last_modified)
VALUES (1, 'test_gist', 'ZZX', 'test_description1', 'No content', current_timestamp, current_timestamp);

INSERT INTO gist(user_id, gist_name, user_name, description, content, created, last_modified)
VALUES (1, 'test_gist2', 'ZZX', 'test_description1', 'No content...', current_timestamp, current_timestamp);

INSERT INTO star VALUES (2, 1);

INSERT INTO star VALUES (3, 1);

INSERT INTO star VALUES (3, 2);

INSERT INTO gist_comment(content, commented_at, user_id, gist_id)
VALUES('This gist is great!', current_timestamp, 2, 1);

INSERT INTO gist_comment(content, commented_at, user_id, gist_id)
VALUES('Cool!', current_timestamp, 3, 1);

INSERT INTO gist_comment(content, commented_at, user_id, gist_id)
VALUES('Fantastic!', current_timestamp, 3, 2);