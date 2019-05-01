import $ from 'jquery';


var obj = $("#starting");

function update() {
    $.ajax({
        url: window.url + obj.attr(window.attr_name) + '/',
        success: (data, textStatus, jqXHR) => {
            var session = data
            if (session.deploy_status) {
                obj.html(`${session.deploy_status}: ${session.deploy_percentage}%<br />
                <div style='background-color: green; width: ${ session.deploy_percentage}%; height: 20px;'></div>`)
                if (session.deploy_percentage < 100) setTimeout(() => {
                    update();
                }, 2000);
                if (session.deploy_percentage == 100) {
                    setTimeout(() => {
                        location.reload();
                    }, 500);
                }
            }
        }
    })
}

if (obj.length == 1)
    setTimeout(update, 500)


console.log(window.url)
