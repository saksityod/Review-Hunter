$(document).ready(function() {
	 var username = $('#user_portlet').val();
	 var password = $('#pass_portlet').val();
	 var plid = $('#plid_portlet').val();
	 if(username!="" && username!=null & username!=[] && username!=undefined ) {
		 if(connectionServiceFn(username,password,plid)==true) {
			 
			 var generateDropDownList = function(url,type,request,initValue) {
				 	var html="";
				 	if(initValue!=undefined){
				 		html+="<option value=''>"+initValue+"</option>";
					}
				 	$.ajax ({
				 		url:url,
				 		type:type ,
				 		dataType:"json" ,
				 		data:request,
				 		headers:{Authorization:"Bearer "+tokenID.token},
				 		async:false,
				 		success:function(data){
				 			try {
				 			    if(Object.keys(data[0])[0] != undefined && Object.keys(data[0])[0] == "item_id"){
				 			    	galbalDataTemp["item_id"] = [];
				 			    	$.each(data,function(index,indexEntry){
				 			    		galbalDataTemp["item_id"].push(indexEntry[Object.keys(indexEntry)[0]]);
				 		 			});	
				 			    }
				 			}
				 			catch(err) {
				 			    console.log(err.message);
				 			}

				 			$.each(data,function(index,indexEntry){
				 				html+="<option value="+indexEntry[Object.keys(indexEntry)[0]]+">"+indexEntry[Object.keys(indexEntry)[1] == undefined  ?  Object.keys(indexEntry)[0]:Object.keys(indexEntry)[1]]+"</option>";	
				 			});
				 		}
				 	});	
				 	return html;
			}
			 
			function DropDownCaseType() {
					$.ajax({
						url:restfulURL+"/"+serviceName+"/report/case_followup_case_type",
						type:"get",
						dataType:"json",
						async:false,
						headers:{Authorization:"Bearer "+tokenID.token},
						success:function(data) {
							var htmlOption="";
							$.each(data,function(index,indexEntry) {
								htmlOption+="<option value="+indexEntry['case_type_id']+">"+indexEntry['case_type']+"</option>";
							});
							$("#case_type").html(htmlOption);
						}
					});
			}
			DropDownCaseType();
			 
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
			 
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});
			
			$("#year").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/report/case_followup_year",
					"GET"
			));
			
			$("#case_group").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/report/case_followup_case_group",
					"GET"
			));
	 		
	 		$("#btn_search").click(function() {
	 				
	 			var case_type_id = $("#case_type").val();
	 			
	 			var parameter = {
	 				param_year: $("#year").val(),
	 				param_case_type: case_type_id,
	 				param_case_group: $("#case_group").val()
	 			}
	 			
	 			//console.log(parameter,'parameter')
	 			
	 			var url_report_jasper = restfulURL+"/"+serviceName+"/report/api_report?template_name=report-8&template_format=pdf&used_connection=1&inline=1&data="+JSON.stringify(parameter);
	 			$('#iFrame_report').attr('src',url_report_jasper);
	 		});
	 		
	 		if($("#year").val()==null) {
	 			$("#btn_search").attr('disabled',true);
	 		}
		}
	}
});