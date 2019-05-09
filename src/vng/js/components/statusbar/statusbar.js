import $ from 'jquery';


var obj = $("#starting");
var pro = $("#progressbar");
var proInd = $("#progressbar-indicator");
var statusLabel = $("#statuslabel");

function update() {
    $.ajax({
        url: window.url + obj.attr(window.attr_name) + '/',
        success: (data, textStatus, jqXHR) => {
            var session = data;
            if (session[window.percentage]) {
                pro.css('width', `${session[window.percentage]}%`);
                proInd.text(session[window.percentage] + '%');
                statusLabel.text(session[window.status]);
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
