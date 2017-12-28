$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({
		 html:true
	});
	 
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
	$("#employee_list_content").show();
});
