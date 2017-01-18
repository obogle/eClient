<!---
	Name:				Alyssa Morgan
	Date:				2015-10-08
	Modifications:		
						


--->
	
     <!--- ---><script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> 
     
	 
	 
	 <!---angular
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.0-beta.1/angular-route.min.js"></script>
    --->
	 
	 <!---for bootstrap ---> 
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link href = "../sharedFiles/bootstrap/css/bootstrap.css" rel = "stylesheet">
    <script src = "../sharedFiles/bootstrap/js/bootstrap.min.js"></script>
     <!--- <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.1/ui-bootstrap.min.js"></script>--->
     <!---bootstrap end--->

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<!---password strength--->
    <link rel="stylesheet" href="../sharedFiles/assets/css/strength.css">
    <script src="../sharedFiles/assets/js/strength.js"></script>
    
    <link rel="stylesheet" href="../sharedFiles/assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../sharedFiles/assets/css/form-elements.css">
    <link rel="stylesheet" href="../sharedFiles/assets/css/style.css"> 
    <script src="../sharedFiles/assets/js/jquery.backstretch.min.js"></script>
	<script src="../sharedFiles/assets/js/retina-1.1.0.min.js"></script>
    <script src="../sharedFiles/assets/js/scripts.js"></script>
    <script src="../sharedFiles/assets/js/alyssaFormValidation.js"></script>
    
    <link href="../sharedFiles/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css">  
    <script src="../sharedFiles/bootstrap/js/bootstrap-dialog.min.js"></script>
    
    <link href="../sharedFiles/bootstrap/css/sticky-footer.css" rel="stylesheet">
    
    
    <link rel="stylesheet" href="../sharedFiles/ColorBox/colorbox.css" />
    <script src="../sharedFiles/ColorBox/jquery.colorbox-min.js"></script>
    
    
    

 <script>
 	function getHTTPObject() {
	if (typeof XMLHttpRequest != 'undefined') {
		return new XMLHttpRequest();
	}
	try {
		return new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			return new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}
	}
	return false;
}
 	//bootstrap modal popup
		function showDialog(title,message)
		{
		 
			 BootstrapDialog.show({
				title: ''+title+'',
				message: ''+message+'',
				//to change color same classes as bootstrap buttons
				type: 'type-primary',
				//all buttons here
				buttons: [{
							label: 'Close',
							action: function(dialogItself){
								dialogItself.close();
							}
						}]
			});
		}
		//modal with no close
		function showDialogNoClose(title,message)
		{
		 
			 BootstrapDialog.show({
				title: ''+title+'',
				message: ''+message+'',
				//to change color same classes as bootstrap buttons
				type: 'type-primary'
			});
		}
		
		$( document ).ready(function() {   
		
			//tooltip
			$('[data-toggle="tooltip"]').tooltip(); 
		
			//for colorbox
			$(".iframe").colorbox({iframe:true, width:"100%", height:"100%"});
			
    		//grab source type and code on doc load
			getSource()
			
			////////////////////////setNumSteps dwmalically sets number of steps for formem You are at step 1 of 5//////////////////////////
			setNumSteps()
			
			function setNumSteps(){
				var allSteps = $(".formStep");
				for(var i=0; i<allSteps.length; i++){
					var element = allSteps.eq(i);
					element.append('Step '+(i+1)+' of '+ allSteps.length);
				}
			}
			
			////////////////////////setTitles set all tiles to show user their progress//////////////////////////
			setTitles()
			function setTitles(){
				var allTitles = $(".formStepTitle");
				var percentage= 100/allTitles.length;
				for(var i=0; i<allTitles.length; i++){
					var element = allTitles.eq(i);
					$("#progressTitles table#progressTitlesTable tr").append('<td width="'+percentage+'%">'+(i+1)+': '+element.html()+'</td>');
				}
			}
			
    		/*
			
			
			//////////////////////BEGIN form Next Previous Submit And progress bar JS//////////////////////////////////////////////////////////////
			
			
			*/
			$('.registration-form fieldset:first-child').fadeIn('slow');
			
			$('.registration-form input[type="text"], .registration-form input[type="password"], .registration-form textarea').on('focus', function() {
				$(this).removeClass('input-error');
			});
			
			// next step
			$('.registration-form .btn-next').on('click', function() {
				var parent_fieldset = $(this).parents('fieldset');
				var next_step = true;
				
				
				//validation
				if(validateForm('#'+parent_fieldset.attr("id")))
				{	
					parent_fieldset.fadeOut(400, function() {
						$(this).next().fadeIn();
					});
					
					
					
					
					//for progress bar
					var numSteps = $(".formStep").length;
					var percentageToMoveBy= 100/ numSteps;
					
					var val = parseInt($('.progress-bar').attr('value')) + parseInt(percentageToMoveBy);
					
					$('.progress-bar').each(function(){
						$(this).width(val+ '%').text(val+ '%')
						$(this).attr('value', val)
					});
				}
				
			});
			
			// previous step
			$('.registration-form .btn-previous').on('click', function() {
				
				
				$(this).parents('fieldset').fadeOut(400, function() {
					$(this).prev().fadeIn();
				});
				
				//for progress bar
				var numSteps = $(".formStep").length;
				var percentageToMoveBy= 100/ numSteps;
				
				var val = parseInt($('.progress-bar').attr('value')) - parseInt(percentageToMoveBy);
				
				$('.progress-bar').each(function(){
					$(this).width(val+ '%').text(val+ '%')
					$(this).attr('value', val)
				});
			});
			<!---
			// submit
			$('.registration-form').on('submit', function(e) {
				
				var parent_fieldset = $(this).closest('fieldset');
				
				//validation
				alert('#'+parent_fieldset.attr("id"))
				if(validateForm('#'+parent_fieldset.attr("id")))
				{	
				
				}else{
					alert('eh')
					e.preventDefault();	
				}
				
			});
			
			--->
			
		});<!--- doc ready --->
		
		//get source type from URL
		function getSource(){
			var srcType = 'DR';
			var srcCode = '999';
			if(document.location.search.length){
				
					 var vars = [], hash;
					 var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
					 for(var i = 0; i < hashes.length; i++)
					{
						hash = hashes[i].split('=');
						var desc = hash[0]
						var val= hash[1]
						
						if(desc == "srcType"){
							srcType = val;
							$('#srcType').val(val)
						}
						if(desc == "srcCode"){
							srcCode = val;
							$('#srcCode').val(val)
						}
					}
			}
			return srcType+'-'+srcCode;
		}
		
		
		
	</script>