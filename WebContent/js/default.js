/* jTweetsAnywhere settings - enter your username. */
/*---------------------------------------------------------------------*/
var twitter_user_name = 'nemos_';


/* Change slide in Default Slider */
/*-----------------------------------------------------------------------*/
function prettyPhoto_settings(){
	jQuery("a[rel^='prettyPhoto']").prettyPhoto({
		animation_speed: 'fast', /* fast/slow/normal */
		slideshow: 5000, /* false OR interval time in ms */
		autoplay_slideshow: false, /* true/false */
		opacity: 0.60, /* Value between 0 and 1 */
		show_title: true, /* true/false */
		allow_resize: true, /* Resize the photos bigger than viewport. true/false */
		default_width: 500,
		default_height: 344,
		counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
		theme: 'pp_default', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
		horizontal_padding: 20, /* The padding on each side of the picture */
		hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
		wmode: 'opaque', /* Set the flash wmode attribute */
		autoplay: true, /* Automatically start videos: True/False */
		modal: false, /* If set to true, only the close button will close the window */
		deeplinking: true, /* Allow prettyPhoto to update the url to enable deeplinking. */
		overlay_gallery: false, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
		keyboard_shortcuts: true, /* Set to false if you open forms inside prettyPhoto */
		changepicturecallback: function(){}, /* Called everytime an item is shown/changed */
		callback: function(){}, /* Called when prettyPhoto is closed */
		ie6_fallback: true
	});
}


/* Change slide in Default Slider */
/*-----------------------------------------------------------------------*/
function change_slide(in_id, out_id){
	jQuery("ul#default_slider > li:nth-child(" + out_id + ")").fadeOut('slow', function(){
		jQuery("ul#default_slider > li:nth-child(" + in_id + ")").fadeIn('fast')
	});
	
	jQuery(".control_nav > li:nth-child("+ out_id +") a").removeClass();
	jQuery(".control_nav > li:nth-child("+ in_id +") a").addClass('active_slide');
}


/* Auto Rotate slides in Default Slider */
/*-----------------------------------------------------------------------*/
function auto_rotate(){
    rotate = setInterval(function(){
        var out_id = jQuery(".control_nav a.active_slide").attr("data-id");
        var in_id = parseInt(out_id) + 1;
        var last_slide_id = jQuery(".control_nav li:last a").attr("data-id");
        
        if(out_id == last_slide_id){ in_id = 1 };
        
        change_slide(in_id, out_id);
    }, 7000); /* Rotator interval in milliseconds */
}


/* Portfolio image hover */
/*---------------------------------------------------------------------*/
function hover_size(){
	jQuery('.img_hover').each(function(){
		img_width = jQuery(this).find("img").width();
		img_height = jQuery(this).find("img").height();
		
		jQuery("span",this).width(img_width);
		jQuery("span",this).height(img_height);
	});
}

function portfolio_img_hover(){
	jQuery(".img_hover").hover(
		function () {
			jQuery("span", this).not(':animated').fadeTo(300, 1);
		}, 
		function () {
			jQuery("span", this).fadeTo(50, 0);
		}
	);
}


/* Regular expression to validate email address */
/*---------------------------------------------------------------------*/
function validateEmail(emailValue){  
	var emailPattern = /^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/;
	return emailPattern.test(emailValue); 
}


/* Validate Form fields */
/*---------------------------------------------------------------------*/
function validateForm(bName, bEmail, bMessage){
	var fields_valid = true;
	
	if (bName && jQuery("input#name").val().length < 1) {
		jQuery("input#name").next().not(':animated').fadeIn('fast');
		fields_valid = false;
    }
	if (bEmail && !validateEmail(jQuery("input#email").val())) {
		if(!bMessage) {
			jQuery("label#email_error").fadeIn('slow');
			jQuery("input#email").focus();
		} else {
			jQuery("input#email").next().not(':animated').fadeIn('fast');
		}
		fields_valid = false;
    }
	if (bMessage && jQuery("textarea#message").val().length < 1) {
		jQuery("textarea#message").next().not(':animated').fadeIn('fast');
		fields_valid = false;
    }
	return fields_valid;
}


/* jQuery MAIN */
/*=====================================================================*/
jQuery(function(){
	
	/* Minor fixes for IE7 */
	/*-----------------------------------------------------------------------*/
	if ($.browser.msie && $.browser.version.substr(0,1)<8) {
		jQuery("form#search").width(134);
		jQuery("ul.toggles_slider li span").css('padding','3px 0px');
		jQuery("hr").css({'height':'1px','color':'#ddd'});
	}
    

    /* Function Calls */
	/*-----------------------------------------------------------------------*/
    if (jQuery("#default_slider").length){
		auto_rotate();
	}

	if (jQuery(".img_hover").length){
		jQuery(window).load(function(){hover_size()});
		portfolio_img_hover();
	}

	if (jQuery("a[rel^='prettyPhoto']").length){
		prettyPhoto_settings();
	}

    
    /* Drop-down Top Navigation */
	/*-----------------------------------------------------------------------*/
	jQuery("#top_nav li ul li").has("ul").children("a").addClass('arrow_sub_menu');

	jQuery("#top_nav li").hover(
		function () {
			sub_navigation = jQuery(this).children('ul');
			sub_navigation.not(':animated').slideDown(100);
		}, 
		function () {
			jQuery("ul", this).slideUp(100);
		}
	);


	/* Scroll To Top */
    /*---------------------------------------------------------------------*/
    jQuery(window).scroll(function() {
		if(jQuery(this).scrollTop() != 0) {
			jQuery('#toTop').fadeIn();	
		} else {
			jQuery('#toTop').fadeOut();
		}
	});
 
	jQuery('#toTop').click(function() {
		jQuery("html:not(:animated), body:not(:animated)").animate({ scrollTop: 0}, 400 );
	});

	
	/* Default Header Slider - PNG */
	/*-----------------------------------------------------------------------*/
	var control_nav = jQuery("#slider_wrapper .control_nav");
	control_nav.css('margin-left', -(control_nav.width()/2-6));

	jQuery("#default_slider > li:first").show();

	jQuery(".control_nav li a").hover(
		function () { clearInterval(rotate); }, 
		function () { auto_rotate(); }
	);
	
	jQuery(".control_nav li a").click(
		function () {
			if (!jQuery(this).hasClass('active_slide') && !jQuery("ul#default_slider > li").is(':animated')) {
				slide_id_in = jQuery(this).attr('data-id');
				slide_id_out = jQuery(".control_nav a.active_slide").attr('data-id');
				
				change_slide(slide_id_in, slide_id_out);
				
				jQuery(".control_nav a").removeClass();
				jQuery(this).addClass('active_slide');
			}
			return false;
	})

	
	/* Toggles slider */
	/*-----------------------------------------------------------------------*/
	jQuery("ul.toggles_slider li span.selected + div").show();
	
	jQuery("ul.toggles_slider li span").click(function() {
		var parent = jQuery(this).parent();
		
		if(!jQuery(this).hasClass('selected')){
			parent.siblings().children(".selected").removeClass('selected');
			jQuery(this).addClass('selected');
			
			parent.siblings().children(".expand:visible").slideUp('fast');
			jQuery(this).next(".expand").slideToggle('fast');
		}
	});


	/* Testimonials slider */
	/*-----------------------------------------------------------------------*/
	if (jQuery(".testimonials").length){
		var testimonials_list = jQuery(".testimonials .mask > ul");

		var li_margin = testimonials_list.children("li").css('marginRight');
		li_margin = parseInt(li_margin.substring(0, li_margin.length - 2));

		var li_width = testimonials_list.children("li").width() + li_margin;
		var li_count = testimonials_list.children("li").size();
		var ul_width = li_count * li_width;

		testimonials_list.width(ul_width);
	    
	    jQuery(".testimonials").hover(
	        function () {
	            jQuery(".btn_left").not(':animated').show();
	            jQuery(".btn_right").not(':animated').show();
	        }, 
	        function () {
	            jQuery(".btn_left").not(':animated').hide();
	            jQuery(".btn_right").not(':animated').hide();
	        }
	    );

	    jQuery(".btn_left").click(function(){
	        if(testimonials_list.position().left < 0){
	        	testimonials_list.not(':animated').animate(
	            	{ left: '+=' + li_width }, 
	            	{ duration: 'slow', easing: 'easeOutExpo' });
	        }
	        return false;
	    });
	}
    
    jQuery(".btn_right").click(function(){
    	var current_position = ul_width - (-testimonials_list.position().left) - 3*li_width;

        if(current_position > 0){
            testimonials_list.not(':animated').animate(
            	{ left: '-=' + li_width }, 
            	{ duration: 'slow', easing: 'easeOutExpo' });
        }
        return false;
    });


    /* Tab boxes */
	/*---------------------------------------------------------------------*/
	jQuery(".tabs_container .tab_content").hide();
	jQuery(".tabs_container ul.tabs").find("li:first").addClass("active").show();
	jQuery(".tabs_container").find(".tab_content:first").show();

	jQuery("ul.tabs li").click(function() {
		var tabs_container = jQuery(this).parent().parent();
		var tabs = tabs_container.children(".tabs");
		var tabs_contents = tabs_container.children(".tabs_contents");
		
		tabs.children("li").removeClass("active");
		jQuery(this).addClass("active");
		
		var clicked_li_id = tabs.children("li").index(this);
		var tab_content = tabs_contents.children("div").eq(clicked_li_id);
		
		tabs_contents.children(".tab_content").hide();
		jQuery(tab_content).fadeIn();
		return false;
	});


	/* QuickSand plugin */
	/*---------------------------------------------------------------------*/
	var galleryData = jQuery(".portfolio_content").clone();
	
	jQuery(".portfolio_filter li a").click(function() {
		jQuery(".portfolio_filter li a").removeClass("selected");
		jQuery(this).addClass('selected');
		
		var filterClass = jQuery(this).attr('id');
		
		if (filterClass == 'all') {
			var filteredData = galleryData.find('.item');
		} else {
			var filteredData = galleryData.find('.item[data-type~=' + filterClass + ']');
		}
		jQuery(".portfolio_content").quicksand(filteredData, {
			adjustHeight: 'dynamic',
			duration: 700,
			easing: 'easeInOutQuad',
			useScaling: true,
			enhancement: function() {
				hover_size();
				portfolio_img_hover();
				prettyPhoto_settings();
			}
		});
		return false;
	});


    /* jTweetsAnywhere */
    /*---------------------------------------------------------------------*/
	jQuery(".tweetsFeed").jTweetsAnywhere({
		username: twitter_user_name,
		count: 1
	});


	/* Subscribe Form on fly validation */
    /*---------------------------------------------------------------------*/
    jQuery("input#email").bind("keyup focusout", function(){
		if(validateEmail(jQuery(this).val())){
			jQuery("label#email_error").not(':animated').fadeOut('fast');
        } else if(jQuery(this).val()){
			jQuery("label#email_error").fadeIn('fast'); 
        } else {
            jQuery(".placeholder").fadeIn('fast');
			jQuery(".error").hide();
        }
	});


	/* Submitting Subscribe Form using AJAX */
    /*---------------------------------------------------------------------*/
	jQuery("form#subscribe").submit(function() {
        
		var dataString = jQuery(this).serialize();
        
		if(validateForm(0,1,0)){
			jQuery.ajax({
			type: "POST",
			url: "php/subscribe.php",
			data: dataString,
			success: function() {
				jQuery('#subscribe').slideUp('slow', function(){
                    jQuery(this).html("<div id='confirmation'></div>");
                    jQuery('#confirmation').html("Request Submitted Successfully! Thank you.")
					.addClass('request_success');
                    jQuery(this).slideDown('fast');
                })
			}
			});
		}
		return false;
	});


	/* Contact Form - remove cross sign on focus */
    /*---------------------------------------------------------------------*/
    jQuery("#contact input, #contact textarea").focus(function(){
    	jQuery(this).next().not(':animated').fadeOut('fast');
	});


	/* Submitting Contact Form using AJAX */
    /*---------------------------------------------------------------------*/
	jQuery("form#contact").submit(function() {
        
		var dataString = jQuery(this).serialize();
        
		if(validateForm(1,1,1)){
			jQuery.ajax({
			type: "POST",
			url: "php/send_mail.php",
			data: dataString,
			success: function() {
				jQuery('#contact').slideUp('slow', function(){
                    jQuery(this).html("<div id='confirmation'></div>");
                    jQuery('#confirmation').html("<h3>Message Submitted Successfully!</h3>")
				    .append("<p>Thank you for contacting us. We will be in touch with you very soon.</p>");
                    jQuery(this).slideDown('slow');
                })
			}
			});
		}
		return false;
	});
})