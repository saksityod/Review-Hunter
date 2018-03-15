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
			 
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});

	 		$("#doctor").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/report/case_list_doctor",
				"GET"
			));
	 		
	 		$("#btn_search").click(function() {
	 			var parameter = {
	 				param_doctor_id: $("#doctor").val(),
	 				param_start_date: formatDateYMD($("#start_date").val()),
	 				param_end_date: formatDateYMD($("#end_date").val())
	 			}
	 			
	 			var url_report_jasper = restfulURL+"/"+serviceName+"/report/api_report?template_name=report-3&template_format=pdf&used_connection=1&inline=1&data="+JSON.stringify(parameter);
	 			$('#iFrame_report').attr('src',url_report_jasper);
	 		});
	 		
	 		$("#time").click(function() {
	 			swapFN(this.id);
	 			generateStartEndDate($(this).val());
	 		});
	 		$("#start_date").click(function(){swapFN(this.id)});
	 		$("#end_date").click(function(){swapFN(this.id)});
	 		
	 		$("#time").click();
		}
	}
});