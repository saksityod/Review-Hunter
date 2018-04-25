$(document).ready(function() {
	 var username = $('#user_portlet').val();
	 var password = $('#pass_portlet').val();
	 var plid = $('#plid_portlet').val();
	 if(username!="" && username!=null & username!=[] && username!=undefined ) {
		 if(connectionServiceFn(username,password,plid)==true) {
			 
			var swapFN = function(input) {
				if(input==$("#time").attr('id')) {
					$("#start_date").attr('readonly',true);
					$("#end_date").attr('readonly',true);
					$("#time").attr('readonly',false);
				} else {
					 $("#start_date").attr('readonly',false);
					$("#end_date").attr('readonly',false);
					$("#time").attr('readonly',true);
				}
			}
			
			var generateStartEndDate = function(time) {
				$.ajax ({
					url:restfulURL+"/"+serviceName+"/report/list_selector_time",
					type:"get",
					dataType:"json",
			 		data:{"time":time},
			 		headers:{Authorization:"Bearer "+tokenID.token},
			 		async:false,
			 		success:function(data){
			 			if(data.status==200) {
			 				$("#start_date").val(formatDateDMY(data.data));
			 				$("#end_date").val(getDateNow());
			 			}
			 		}
			 	});
			}
			
			function DropDownUsers() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/report/case_supervised_list_user",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						htmlOption+="<option value=''>All</option>";
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['userId']+">"+indexEntry['screenName']+"</option>";
						});
						$("#user_id").html(htmlOption);
					}
				});
			}
			
			function DropDownCaseType() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/report/case_followup_case_type",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						htmlOption+="<option value=''>All</option>";
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['case_type_id']+">"+indexEntry['case_type']+"</option>";
						});
						$("#case_type_id").html(htmlOption);
					}
				});
			}
			 
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});
	 		
	 		$("#btn_search").click(function() {
	 			
	 			var sub_string_user = ($("#user_id").val()=='') ? 'All' : $("#user_id").val();
	 			var sub_string_case = ($("#case_type_id").val()=='') ? 'All' : $("#case_type_id").val();
	 			
	 			var parameter = {
	 					param_start_date: formatDateYMD($("#start_date").val()),
		 				param_end_date: formatDateYMD($("#end_date").val()),
	 					param_sup_id: sub_string_user,
		 				param_case_type_id: sub_string_case
		 		}
	 			
	 			var url_report_jasper = restfulURL+"/"+serviceName+"/report/api_report?template_name=report-9&template_format=pdf&used_connection=1&inline=1&data="+JSON.stringify(parameter);
	 			
	 			$('#iFrame_report').attr('src',url_report_jasper);
	 		});
	 		
	 		$("#time").click(function() {
	 			swapFN(this.id);
	 			generateStartEndDate($(this).val());
	 		});
	 		
	 		$("#start_date").click(function(){swapFN(this.id)});
	 		$("#end_date").click(function(){swapFN(this.id)});
	 		
	 		$("#time").click();
	 		DropDownUsers();
	 		DropDownCaseType();
		}
	}
});