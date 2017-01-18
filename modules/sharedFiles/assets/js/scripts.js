
jQuery(document).ready(function() {
	
    /*
        Fullscreen background
   $.backstretch("../sharedFiles/assets/img/backgrounds/clientPortalBG.png");
    $.backstretch("../assets/img/backgrounds/kioskBuilding.png");
     */
	 
	 //../sharedFiles/assets/img/backgrounds/eClientBG2.jpg
	 $.backstretch("../sharedFiles/assets/img/backgrounds/eClientHomepageBG.png");
    $('#top-navbar-1').on('shown.bs.collapse', function(){
    	$.backstretch("resize");
    });
    $('#top-navbar-1').on('hidden.bs.collapse', function(){
    	$.backstretch("resize");
    });
   
    
    
});

