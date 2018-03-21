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

	 		$("#year").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/report/case_list_year",
				"GET"
			));

	 		$("#month").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/report/case_list_month",
				"GET"
			));
	 		
	 		$("#btn_search").click(function() {
	 			var parameter = {
	 				param_year: $("#year").val(),
	 				param_month: $("#month").val()
	 			}
	 			
	 			var url_report_jasper = restfulURL+"/"+serviceName+"/report/api_report?template_name=report-1&template_format=pdf&used_connection=1&inline=1&data="+JSON.stringify(parameter);
	 			$('#iFrame_report').attr('src',url_report_jasper);
	 		});
	 		
	 		if($("#year").val()==null || $("#month").val()==null) {
	 			$("#btn_search").attr('disabled',true);
	 		}
		}
	}
});