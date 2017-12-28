$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({
		 html:true
	});
	 
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
	$("#employee_list_content").show();
	$('#example-getting-started').multiselect({
        includeSelectAllOption: true,
        maxHeight: 200,
        buttonWidth: '100%'
    });
	
	
	$(".btn-add-edu").click(function() {
		$(".btn-add-edu").css("display", "none");
		$(".btn-submit-edu").removeAttr("style");
		$(".add-edu-doctor-detail").removeAttr("style");
		$(".btn-cancel-add-edu").removeAttr("style");
	});
	
	$(".btn-submit-edu").click(function() {
		$(".btn-submit-edu").css("display", "none");
		$(".btn-add-edu").removeAttr("style");
		$(".add-edu-doctor-detail").css("display", "none");
		$(".btn-cancel-add-edu").css("display", "none");
	});
	
	$(".btn-add-exp").click(function() {
		$(".btn-add-exp").css("display", "none");
		$(".btn-submit-exp").removeAttr("style");
		$(".add-exp-doctor-detail").removeAttr("style");
		$(".btn-cancel-add-exp").removeAttr("style");
		
	});
	
	$(".btn-submit-exp").click(function() {
		$(".btn-submit-exp").css("display", "none");
		$(".btn-add-exp").removeAttr("style");
		$(".add-exp-doctor-detail").css("display", "none");
		$(".btn-cancel-add-exp").css("display", "none");

	});
	
	$(".btn-cancel-add-edu").click(function() {
		$(".btn-submit-edu").css("display", "none");
		$(".btn-add-edu").removeAttr("style");
		$(".add-edu-doctor-detail").css("display", "none");
		$(".btn-cancel-add-edu").css("display", "none");
	});
	
	$(".btn-cancel-add-exp").click(function() {
		$(".btn-submit-exp").css("display", "none");
		$(".btn-add-exp").removeAttr("style");
		$(".add-exp-doctor-detail").css("display", "none");
		$(".btn-cancel-add-exp").css("display", "none");
	});
	
	$(".btn-edit-edu").click(function() {
		$(".btn-submit-edit-edu").removeAttr("style");
		$(".btn-edit-edu").css("display", "none");
		$(".span-text-doctor-edu").css("display", "none");
		$(".input-edit-doctor-edu").css("display","");
		$(".btn-cancel-edit-edu").removeAttr("style");
	});
	
	$(".btn-submit-edit-edu").click(function() {
		$(".btn-edit-edu").removeAttr("style");
		$(".btn-submit-edit-edu").css("display", "none");
		$(".input-edit-doctor-edu").css("display", "none");
		$(".span-text-doctor-edu").removeAttr("style");
		$(".btn-cancel-edit-edu").css("display", "none");
	});
	
	$(".btn-cancel-edit-edu").click(function() {
		$(".btn-edit-edu").removeAttr("style");
		$(".btn-submit-edit-edu").css("display", "none");
		$(".input-edit-doctor-edu").css("display", "none");
		$(".span-text-doctor-edu").removeAttr("style");
		$(".btn-cancel-edit-edu").css("display", "none");
	});
	
	
	
	$(".btn-edit-exp").click(function() {
		$(".btn-submit-edit-exp").removeAttr("style");
		$(".btn-edit-exp").css("display", "none");
		$(".span-text-doctor-exp").css("display", "none");
		$(".input-edit-doctor-exp").css("display","");
		$(".btn-cancel-edit-exp").removeAttr("style");
	});
	
	$(".btn-submit-edit-exp").click(function() {
		$(".btn-edit-exp").removeAttr("style");
		$(".btn-submit-edit-exp").css("display", "none");
		$(".input-edit-doctor-exp").css("display", "none");
		$(".span-text-doctor-exp").removeAttr("style");
		$(".btn-cancel-edit-exp").css("display", "none");
	});
	
	$(".btn-cancel-edit-exp").click(function() {
		$(".btn-edit-exp").removeAttr("style");
		$(".btn-submit-edit-exp").css("display", "none");
		$(".input-edit-doctor-exp").css("display", "none");
		$(".span-text-doctor-exp").removeAttr("style");
		$(".btn-cancel-edit-exp").css("display", "none");
	});
});
