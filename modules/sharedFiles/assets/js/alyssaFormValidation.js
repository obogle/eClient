/*
	Name:				Alyssa Morgan
	Date:				Aug 12 2015
	Modifications:		
						
	Description:		Startinh my form validation library


*/



$( document ).ready(function() {   	
			
			//email validation
			$(".validateEmail").change(function()
			{	
				//check not blank
				if($(this).val() != ''){
					var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  					//if in email format
					 if(! regex.test($(this).val())){
						 $('#emailValidationError').remove();
						 
						 $(this).val('');
						 $( "<div class='errors' id='emailValidationError' style='display:none;'><i class='fa fa-envelope'></i> Please enter a valid email address</div>" ).insertBefore(this)
						  $('#emailValidationError').slideDown( 1000, function(){ 	
							$('#emailValidationError').delay(4000).slideUp( 1000, function(){ 	
								$('#emailValidationError').remove();
						 	});
						 });
					 }
				}
			
			});
			
			
			//phone number validation
			
			function stripPhone(phoneWithCharacters){
				phone = phoneWithCharacters.replace(/\D/g,'');
				return phone;
				
			}
			function formatPhone(phoneWithCharacters){
				formatted = '('+ phone.substr(0, 3) + ')' + phone.substr(3, 3) + '-' + phone.substr(6,4)
				return formatted;
			}
			
			$(".validatePhoneNumber").change(function()
			{	
				var stringElement=$("#"+$(this).attr('id'))
				
				
				if(stringElement.val() != '')
				{
					var str = stripPhone(stringElement.val());
					//var filter=/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/i
					//if (filter.test(str)){
					if(str.length == 10 ){
						stringElement.val(''+formatPhone(str)+'');
					}else{
						$('#phoneNumberValidationError').remove();
						
						$(this).val('');
						 $( "<div class='errors' id='phoneNumberValidationError' style='display:none;'><i class='fa fa-phone'></i> Please enter a valid phone number with area code. For example (xxx)xxx-xxxx</div>" ).insertBefore(this)
						  $('#phoneNumberValidationError').slideDown( 1000, function(){ 	
							$('#phoneNumberValidationError').delay(4000).slideUp( 1000, function(){ 	
								$('#phoneNumberValidationError').remove();
						 	});
						 });
					}
				}
			});//end phone number validation
			
			//validate only numbers
			$(".validateNumbersOnly").change(function()
			{
				
				var stringElement=$("#"+$(this).attr('id'))
				var str =stringElement.val()
				if(str != '')
				{
					var filter= /^[0-9]+$/i
					if (filter.test(str)){
					
					}else{
						$('#numbersOnlyValidationError').remove();
						
						$(this).val('');
						 $( "<div class='errors' id='numbersOnlyValidationError' style='display:none;'><i class='fa fa-sort-numeric-asc'></i> Please enter numbers only</div>" ).insertBefore(this)
						  $('#numbersOnlyValidationError').slideDown( 1000, function(){ 	
							$('#numbersOnlyValidationError').delay(4000).slideUp( 1000, function(){ 	
								$('#numbersOnlyValidationError').remove();
						 	});
						 });
					}
				}
			});
			
			//validate letters only numbers
			$(".validateLettersOnly").change(function()
			{
				var stringElement=$("#"+$(this).attr('id'))
				var str =stringElement.val()
				if(str != '')
				{
					var filter= /^[A-Za-z]+$/i
					if (filter.test(str)){
					
					}else{
						$('#lettersOnlyValidationError').remove();
						
						$(this).val('');
						 $( "<div class='errors' id='lettersOnlyValidationError' style='display:none;'><i class='fa fa-sort-alpha-asc'></i> Please enter letters only</div>" ).insertBefore(this)
						  $('#lettersOnlyValidationError').slideDown( 1000, function(){ 	
							$('#lettersOnlyValidationError').delay(4000).slideUp( 1000, function(){ 	
								$('#lettersOnlyValidationError').remove();
						 	});
						 });
					}
				}
			});
	
	}); //document Ready
	
	
	/*
			
	
			//////////////////////END Form Next Previous Submit And progress bar JS//////////////////////////////////////////////////////////////
			
			
			*/
				
			//real time validation need BOTH on change and on click
			$(".mustValidate").change(function(){
				if(!$(this).val() || $(this).val() == "doNotPassErrorCheck")
				{
					$(this).addClass('input-error');
				}else{
					$(this).removeClass('input-error');
				}
			});
			$(".mustValidate").click(function(){
				if(!$(this).val() || $(this).val() == "doNotPassErrorCheck")
				{
					$(this).addClass('input-error');
				}else{
					$(this).removeClass('input-error');
				}
			});
			//END real time validation
			//form validation check mandetory feilds not blank
			function validateForm(idOfElementWithChildrenToValidate) {	
				
				var noFieldsBlank = 'True';
				$('#forFeildsBlankError').remove();
				
				$(idOfElementWithChildrenToValidate + ' .mustValidate').each(function(currentEl){
					
					//radio button check
					if ($(this).is(':radio')) {
						 if (! $('input[name='+ $(this).attr('name') +']:checked').length) {
								//so it doesnt repeat
								if(! $('#radio'+$(this).attr('name')).length){
									//from bootstrap
								   $( "<div class='radioErrors errors' id='radio"+ $(this).attr('name')+"' style='display:none'>Please choose one of the options below</div>" ).insertBefore('label[for="'+$(this).attr('id')+'"]');
								  
								   $('#radio'+$(this).attr('name')).slideDown( 1000, function(){ 	
										$('#radio'+$(this).attr('name')).slideUp( 1000, function(){ 	
											$('#radio'+$(this).attr('name')).remove();
										});
									 });
								   //no radio buttons was checked
								   noFieldsBlank = 'False';
								}
						  }else{  
							  $('#radio'+$(this).attr('name')).slideUp( 1000, function(){ 	
								$('#radio'+$(this).attr('name')).remove();
							});
								  
						  }
					}
					
					//checkbox button check
					if ($(this).is(':checkbox')) {
						//NEEDS WORK 
						if (! ($("."+ $(this).attr('class') +":checked").length > 0)) {
						   //no checkbox buttons was checked
						   //from bootstrap
						$( "<div class='checkboxErrors errors' id='checkbox"+ $(this).attr('name')+"'>Please choose at least one option</div>" ).insertBefore('label[for="'+$(this).attr('id')+'"]');
						   noFieldsBlank = 'False';
					  }
					  
					  
					  
					}
					
					
					//all other inputs
					if(!$(this).val() || $(this).val() == "doNotPassErrorCheck")
					{
						
						$(this).addClass('input-error');
						noFieldsBlank = 'False';
						
					}else{
						$(this).removeClass('input-error');
					}
					
					
				});
			
				if(noFieldsBlank == 'True'){
					//$(idOfElementWithChildrenToValidate).find('.errors').slideUp(1000);	
					return true
				}else{
					// $(idOfElementWithChildrenToValidate).find('.errors').slideDown( 1000, function(){ 	
					// 	$(idOfElementWithChildrenToValidate).find('.errors').delay(4000).slideUp(1000);	
					// });
					window.scrollTo(0, 0);	
					
					$(idOfElementWithChildrenToValidate + ' .mustValidate:first').each(function(currentEl){
						$(this).before( "<div class='errors' id='forFeildsBlankError' style='display:none;'><i class='fa fa-exclamation-triangle'></i> Please fill out all mandatory feilds</div>" )
					 });
					 $('#forFeildsBlankError').slideDown( 1000, function(){ 	
						$('#forFeildsBlankError').delay(4000).slideUp( 1000, function(){ 	
							$('#forFeildsBlankError').remove();
						});
					 });
					 event.preventDefault();
					 return false;
				}
				
				
				
				
			};//END form validation check mandetory feilds not blank
	
	//confirm passwords
	
	function checkPasswords(feild1, field2)
{
	
    //Store the password field objects into variables ...
    var pass1 = document.getElementById(feild1);
    var pass2 = document.getElementById(field2);
    //Store the Confimation Message Object ...
    var message = document.getElementById('confirmMessage');
    //Set the colors we will be using ...
    var goodColor = "#5CB85C";
    var badColor = "#eacece";
    //Compare the values in the password field 
    //and the confirmation field
	if (pass1.value != ''){
		if(pass1.value == pass2.value ){
			
		}else{
			//The passwords do not match.
			//Set the color to the bad color and
			//notify the user.
			pass2.style.backgroundColor = badColor;
			pass1.value = ('');
			showDialog('Error with chosen passwords','The passwords that you entered do not match')
	
			return false;
		}
	}
}
		