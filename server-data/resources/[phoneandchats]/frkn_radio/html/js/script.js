window.onload = function (e) {
    $('.radio').hide()
    $('#radioFrequence').change(function (){
        var value = $(this).val()
        if(value.length > 3){
            $(this).val(value.slice(0, 3))
        }
    });
    $('input').on('keypress', function (event) {
        var regex = new RegExp("^[a-zA-Z0-9]+$");
        var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
        if (!regex.test(key)) {
            event.preventDefault();
            return false;
        }
    });
    tippy('.btn', {
        content: 'Telsizi kapat',
    });
    window.addEventListener("message", function(event) {

        var data = event.data;
        if(data.action = 'openUi'){
            $('.radio').show()
        }

        $('.connect').click(function (){
            document.getElementById('audio_on')
            document.getElementById('audio_on').load();
            document.getElementById('audio_on').volume = 0.3;
            document.getElementById('audio_on').play();
            $.post('http://frkn_radio/updateFrequence', JSON.stringify({
                frequence: $('#radioFrequence').val()
            }));
        })
        $('.btn').click(function (){
            document.getElementById('audio_off')
            document.getElementById('audio_off').load();
            document.getElementById('audio_off').volume = 0.3;
            document.getElementById('audio_off').play();
            $.post('http://frkn_radio/closeRadio');
            $('.radio').hide()
        })
    });
    window.addEventListener('keyup', (e) => {
        if (e.key === 'Escape') {
            $.post('http://frkn_radio/closeNui');
            $('.radio').hide()
        }
    })
}