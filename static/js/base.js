$(document).ready(function(){
    var auth0_id = $('#current_user').attr('title')
    var user_id = ""
    if (!auth0_id) return

    $.ajax({
        url: '/api/user',
        type: 'POST',
        data: {
            auth0_id: auth0_id,
        },
        dataType: 'json',
        async: false,
        success: function(data) {
            user_id = data.user_id
        }
    })

    // set href for redirecting to current user page
    document.getElementById('current_user').setAttribute('href', `/user/${user_id}`)
    document.getElementById('current_gists').setAttribute('href', `/user/${user_id}`)
})

