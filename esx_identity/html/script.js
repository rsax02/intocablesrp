jQuery(document).ready(function ($) {
    $('.form-control').keyup(function (event) {
        var textBox = event.target;
        var start = textBox.selectionStart;
        var end = textBox.selectionEnd;
        textBox.value = textBox.value.charAt(0).toUpperCase() + textBox.value.slice(1).toLowerCase();
        textBox.setSelectionRange(start, end);
	});
	$('.date').keyup(function (event){
		var textBox=event.target;
		if(event.keyCode!=8){
			if(textBox.value.length==2 || textBox.value.length==5){
				textBox.value=textBox.value+"/";
			}else if(textBox.value.length==3 && textBox.value.charAt(2)!="/"){
				c = textBox.value.charAt(2)
				textBox.value=textBox.value.replaceAt(2,"/")+c
			}else if(textBox.value.length==6 && textBox.value.charAt(5)!="/"){
				c = textBox.value.charAt(5)
				textBox.value=textBox.value.replaceAt(5,"/")+c
			}
		}
	});
});

String.prototype.replaceAt=function(index, char) {
    var a = this.split("");
    a[index] = char;
    return a.join("");
}

$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.type == "enableui") {
			document.body.style.display = event.data.enable ? "block" : "none";
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx_identity/escape', JSON.stringify({}));
		}
	};
	
	$("#register").submit(function(event) {
		event.preventDefault(); // Prevent form from submitting
		
		// Verify date
		var date = $("#dateofbirth").val();
		//var day = $("#dateofbirth").val().charAt(0)+$("#dateofbirth").val().charAt(1);
		//var month = $("#dateofbirth").val().charAt(3)+$("#dateofbirth").val().charAt(4);
		
		//console.log(date.split("/")[2],date.split("/")[0],date.split("/")[1])
		var dateCheck = new Date(date.split("/")[1]+"/"+date.split("/")[0]+"/"+date.split("/")[2]);
		if (dateCheck == "Invalid Date") {
			date == "invalid";
			return
		}

		$.post('http://esx_identity/register', JSON.stringify({
			firstname: $("#firstname").val(),
			lastname: $("#lastname").val(),
			dateofbirth: date,
			sex: $("input[type='radio'][name='sex']:checked").val(),
			height: $("#height").val()
		}));
	});
});
