//Shows and clears error messages.
function clearValidationError() {
	var p = document.getElementById("validationError");
	p.innerHTML = "";
}

function showError(errorMessage) {
	var p = document.getElementById("validationError");
	p.innerHTML = errorMessage;
}



//Validations for username, password, confirm password.
var invalidPattern = new RegExp("[^a-zA-Z]");

var validateUsername = function(input) { 
	var username = input.value;
	if(invalidPattern.test(username)) {
		input.parentNode.className = "form-group has-error";
		showError("Username must only contain letters.");
		return false;
	}
	input.parentNode.className = "form-group has-success";
	clearValidationError();
	return true;
}

var validatePassword = function(input) {
	var password = input.value;
	if(invalidPattern.test(password)) {
		input.parentNode.className = "form-group has-error";
		showError("Password must only contain letters.");
		return false;
	}
	input.parentNode.className = "form-group has-success";
	clearValidationError();
	return true;
}

var validateConfirmPassword = function(input) {
	var confirmPassword = input.value;
	var password = document.SignUpForm.children[2].children[1].value;
	if(confirmPassword != password) {
		input.parentNode.className = "form-group has-error";
		showError("Passwords do not match.")
		return 0;
	}
	input.parentNode.className = "form-group has-success";
	clearValidationError();
	return false;
}

function validateForm() {
	var validators = [validateUsername, validatePassword, validateConfirmPassword];
	var formFields = document.SignUpForm.getElementsByClassName("form-data");
	var dataLabels = document.SignUpForm.getElementsByClassName("data-label");
	for(var i = 0; i < formFields.length; ++i) {
		if(! formFields[i].value) {
			showError(dataLabels[i].innerHTML + " cannot be let empty.");
			formFields[i].focus();
			return false;
		}
	}
}


