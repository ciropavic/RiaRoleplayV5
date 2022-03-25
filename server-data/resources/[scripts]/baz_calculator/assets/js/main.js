$(function(){
	window.onload = (e) => {
		$('#container').hide();
	    $('#bg').hide();
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined && item.type === 'ui') {			
				if (item.display === true) {
					$('#container').show();
					$('#bg').show();
					document.onkeyup = function(data) {
						if (data.which === 27) {
							$('#container').hide();
							$('#bg').hide();
							$.post('http://baz_calculator/NUIFocusOff', JSON.stringify({}));
						}
					}
				}
			}
		});
	};
});