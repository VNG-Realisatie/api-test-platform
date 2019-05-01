import $ from 'jquery';


var obj = $("#starting");

function update() {
    $.ajax({
        url: window.url + obj.attr('session_id') + '/',
        success: (data, textStatus, jqXHR) => {
            var session = data
            if (session.deploy_status) {
                obj.html(`${session.deploy_status}: ${session.deploy_percentage}%<br />
                <div style='background-color: green; width: ${ session.deploy_percentage}%; height: 20px;'></div>`)
                if (session.deploy_percentage < 100) setTimeout(() => {
                    update();
                }, 1000);
                if (session.deploy_percentage == 100) {
                    setTimeout(() => {
                        location.reload();
                    }, 2000);
                }
            }
        }
    })
}

if (obj.length == 1)
    setInterval(update, 500)


console.log(window.url)
