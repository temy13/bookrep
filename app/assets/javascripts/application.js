// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//


//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require rails-ujs
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require bootstrap
//= require bootstrap-tagsinput
//= require d3.v3.min
//= require env

//= require_tree .

jQuery.fn.exists = function(){return Boolean(this.length > 0);}


$.extend($.ui.autocomplete.prototype.options, {
	open: function(event, ui) {
		$(this).autocomplete("widget").css({
            "width": ($(this).width() + "px")
        });
    }
});

$.extend($.validator.messages, {
		required: "このフィールドは必須です。",
		//required: "{1}を入力してください。",
});


var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

// $('.owl-carousel').owlCarousel({
//     loop:true,
//     margin:10,
//     // nav:true,
//     responsive:{
//         0:{
//             items:1
//         }//,
//         // 600:{
//         //     items:3
//         // },
//     }
// })

// exports.getBounds = function (node) {
//
// 							 var rect = node.getBoundingClientRect();
// 							 console.log(rect.top, rect.left);
//
// 							 if (node.getBoundingClientRect) {
// 									 var clientRect = node.getBoundingClientRect();
// 									 var width = node.offsetWidth == null ? clientRect.width : node.offsetWidth;
// 									 return {
// 											 //top: clientRect.top,
// 											 top: rect.top,
// 											 bottom: clientRect.bottom || (clientRect.top + clientRect.height),
// 											 right: clientRect.left + width,
// 											 //left: clientRect.left,
// 											 left: rect.left,
// 											 width: width,
// 											 height: node.offsetHeight == null ? clientRect.height : node.offsetHeight
// 									 };
// 							 }
// 							 return {};
// 					 };
//

// input.addEventListener 'invalid', ((e) ->
//   if input.validity.valueMissing
// 		$('input[type=submit]').css 'opacity': 1.0
//   else if !input.validity.valid
// 		$('input[type=submit]').css 'opacity': 1.0
//   return
// ), false
//= require serviceworker-companion
