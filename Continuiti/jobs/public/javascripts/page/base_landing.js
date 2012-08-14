jQuery(document).ready(function($) {

  $("BODY").bgStretcher({

    images: ['/images/site_images/landing-bg.jpg'],

    imageWidth: 1600,

    imageHeight: 1050

  });



	//SETTING UP OUR POPUP SIGNUP

	//0 means disabled; 1 means enabled;

		$('.button_1').click(function(){

		$(".form_1").animate({"left": "-70%","opacity":0.3},800);

		$(".form_2").animate({"left": "10%","opacity":1},800);

		 });

		 

	var popupSignup = 0;



	//loading popup with jQuery magic!

	function loadPopup_signUp(){

		//loads popup only if it is disabled

		if(popupSignup==0){

			$("#backgroundSignup").css({

				"opacity": "0.7"

			});

			$("#backgroundSignup").fadeIn("slow");

			$("#popupSignup").fadeIn("slow");

			popupSignup = 1;

		}

	}



	//disabling popup with jQuery magic!

	function disablePopup_signUp(){

		//disables popup only if it is enabled

		if(popupSignup==1){

			$("#backgroundSignup").fadeOut("slow");

			$("#popupSignup").fadeOut("slow");

			popupSignup = 0;

		}

	}



	//centering popup

	function centerPopup_signUp(){

		//request data for centering

		var windowWidth = document.documentElement.clientWidth;

		var windowHeight = document.documentElement.clientHeight;

		var popupHeight = $("#popupSignup").height();

		var popupWidth = $("#popupSignup").width();

		//centering

		$("#popupSignup").css({

			"position": "absolute",

			"top": windowHeight/2-popupHeight/2,

			"left": windowWidth/2-popupWidth/2

		});

		//only need force for IE6

		

		$("#backgroundSignup").css({

			"height": windowHeight

		});

		

	}

	

		//LOADING POPUP

		//Click the button event!

		$("#signup").click(function(){

			//centering with css

			centerPopup_signUp();

			//load popup

			loadPopup_signUp();

			//move popup

			movePopup_signUp();

		});

		

			//CLOSING POPUP

		//Click the x event!

		$("#popupSignupClose").click(function(){

			disablePopup_signUp();

		});

		//Click out event!

		$("#backgroundSignup").click(function(){

			disablePopup_signUp();

		});

		//Press Escape event!

		$(document).keypress(function(e){

			if(e.keyCode==27 && popupSignup==1){

				disablePopup_signUp();

			}

		});

		

		

		

		

	//SETTING UP OUR POPUP LOGIN

	//0 means disabled; 1 means enabled;

	var popupLogin = 0;



	//loading popup with jQuery magic!

	function loadPopup(){

		//loads popup only if it is disabled

		if(popupLogin==0){

			$("#backgroundPopup").css({

				"opacity": "0.7"

			});

			$("#backgroundPopup").fadeIn("slow");

			$("#popupContact").fadeIn("slow");

			popupLogin = 1;

		}

	}



	//disabling popup with jQuery magic!

	function disablePopup(){

		//disables popup only if it is enabled

		if(popupLogin==1){

			$("#backgroundPopup").fadeOut("slow");

			$("#popupContact").fadeOut("slow");

			popupLogin = 0;

		}

	}



	//centering popup

	function centerPopup(){

		//request data for centering

		var windowWidth = document.documentElement.clientWidth;

		var windowHeight = document.documentElement.clientHeight;

		var popupHeight = $("#popupContact").height();

		var popupWidth = $("#popupContact").width();

		//centering

		$("#popupContact").css({

			"position": "absolute",

			"top": windowHeight/2-popupHeight/2,

			"left": windowWidth/2-popupWidth/2

		});

		//only need force for IE6

		

		$("#backgroundPopup").css({

			"height": windowHeight

		});

		

	}

		

		//LOADING POPUP

		//Click the button event!

		$("#login_popup").click(function(){

			//centering with css

			centerPopup();

			//load popup

			loadPopup();

			//move popup

			movePopup();

		});

					

		//CLOSING POPUP

		//Click the x event!

		$("#popupContactClose").click(function(){

			disablePopup();

		});

		//Click out event!

		$("#backgroundPopup").click(function(){

			disablePopup();

		});

		//Press Escape event!

		$(document).keypress(function(e){

			if(e.keyCode==27 && popupLogin==1){

				disablePopup();

			}

		});

		





		//Button Functions

		$("#fb").hover(function() {

		$(this).attr("src","images/popup/fb2.jpg");

			}, function() {

			$(this).attr("src","images/popup/fb1.jpg");

		});

			$("#fb").click(function () { 

			$(this).attr("src","images/popup/fb3.jpg");

		});

		

		$("#twitter").hover(function() {

		$(this).attr("src","images/popup/twitter2.jpg");

			}, function() {

			$(this).attr("src","images/popup/twitter1.jpg");

		});

			$("#twitter").click(function () { 

			$(this).attr("src","images/popup/twitter3.jpg");

		});

		



});