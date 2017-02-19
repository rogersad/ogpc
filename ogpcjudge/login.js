
function validate(){
	var cat = $('#categoryID').prop('selectedIndex');
	var user = $('#lastnameFI').val();
	var message = '';
	
	if (user.length < 3){
		message += 'Please enter your name, minimum 3 characters.\n\n';
	}
	if (cat <= 0){
		message += 'Category must be selected.\n\n';
	}
	
	if (message.length > 0){
		alert(message);
		return false;
	}
	else return true;
	
}
