
/* javascript functions for dspRegister page  */

function checkEmail(emailAddress){
	$.get( "lc.cfc", { method: "checkEmail", email: emailAddress } )
	  .done(function( data ) {
	  	    var obj = $.parseJSON(data);
	  	    // {"COLUMNS":["ID"],"DATA":[]}
		  	if (obj['DATA'][0] > 0 ){
		  		alert("That email is in use.\nAlready a member? \nLogin below.");
		  		$('#joinEmail').val('');
		  		$('#joinEmail2').val('');
		  		$('#loginDiv').attr('class','show row');
		  	 }	
	  });
 }

function hide(element){
	document.getElementById(element).className='hide';
}

function show(element){
	document.getElementById(element).className='show row';
}

function validateJoin(form){
	
	var rValue = true;
	var rMsg = '';
	/* these are referenced by name. */
	if(form['email'].value != form['email2'].value){
		rMsg = "Email addresses don't match.\n";
	}
	if (form['password'].value != form['password2'].value){
		rMsg += "Passwords don't match.\n";
	}
	
	if (rMsg != ''){
		alert(rMsg);
		rValue = false;
	}
	return rValue;
}
