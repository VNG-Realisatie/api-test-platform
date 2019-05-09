import $ from 'jquery';


var obj = $("#starting");

function update() {
    $.ajax({
        url: window.url + obj.attr(window.attr_name) + '/',
        success: (data, textStatus, jqXHR) => {
            var session = data;
            if (session[window.percentage]) {
                obj.html(`${session[window.status]}: ${session[window.percentage]}%<br />
                <div style='background-color: green; width: ${session[window.percentage]}%; height: 20px;'></div>`)
                if (session[window.percentage] < 100) setTimeout(() => {
                    update();
                }, 2000);
                if (session[window.percentage] == 100) {
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
