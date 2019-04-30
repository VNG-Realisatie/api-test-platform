import JSONFormatter from 'json-formatter-js';
import $ from 'jquery';

var jjson = $('#json-content').text();
jjson = JSON.parse(jjson);
const formatter = new JSONFormatter(jjson, 1, {
    hoverPreviewEnabled: true
});
$('#translate').append(formatter.render());
