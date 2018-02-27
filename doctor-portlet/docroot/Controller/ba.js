$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({
		 html:true
	});
	 
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
	$("#employee_list_content").show();
	 
	$('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        todayBtn: true,
        language: 'th',             
        thaiyear: true        
    }).datepicker("setDate", "0");  
	
	$('.dropify').dropify();
	$('#case_stage_notification').multiselect({
        includeSelectAllOption: false,
        maxHeight: 200
    });

});
