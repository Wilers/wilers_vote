$(document).ready(function(){
    display(false)
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    window.addEventListener('message', function(event){
        var item = event.data;
        var iframe = document.getElementById("wilers_vote");
        iframe.setAttribute("src", item.lien);
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://wilers_vote/exit', JSON.stringify({}));
            return
        }
    };
})

function Close() {
    $.post('http://wilers_vote/exit', JSON.stringify({}));
    return
}
