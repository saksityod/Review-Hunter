$(document).ready(function(){
	var username = $('#user_portlet').val();
	var password = $('#pass_portlet').val();
	var plid = $('#plid_portlet').val();
	if(username!="" && username!=null & username!=[] && username!=undefined ){
		 if(connectionServiceFn(username,password,plid)==true){
			 var GlobalDataTodolist;
			 var generateDropDownList = function(url,type,request,initValue){
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
			 
			var getData = function(page,rpp) {
				var case_id = $("#case_name").val().split("-");
				var job_status = $("#job_status").val();
				var medical_procedure = $("#medical_procedure").val();
				var doctor_id = $("#doctor_name").val().split("-");
				var responsible = $("#responsible").val().split("-");
			
				case_id = case_id[0];
				doctor_id = doctor_id[0];
				responsible = responsible[0];
				
				$.ajax({
					url:restfulURL+"/"+serviceName+"/todo/search",
					type:"get",
					dataType:"json",
					async:false,
					headers:{Authorization:"Bearer "+tokenID.token},
					data:{
						"patient_id":case_id,
						"status":job_status,
						"procedure_id":medical_procedure,
						"doctor_id":doctor_id,
						"user_id":responsible,
						"page":page,
						"rpp":rpp
					},
					success:function(data) {
						console.log(data);
						list_data_template(data);
						
						GlobalDataTodolist=data;
						paginationSetUpFn(GlobalDataTodolist['current_page'],GlobalDataTodolist['last_page'],GlobalDataTodolist['last_page']);
					}
				});
			}
			
			var list_data_template = function(data) {
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";
				$.each(data, function (key,value) {
						TRTDHTML += 
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + value.article_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.writer +'</td>'+
			                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_start_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_end_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
			                '</tr>';
			    });
				$('#list_job_status').html(TRTDHTML);
			}
			
			$("#result_search_writer").on("click",'.getfile',function() {
				var ufile = $(this).attr('id').split("-");
			});
			
			$("#btn_search").click(function() {
				getData();
			});
			
			$("#countPaginationBottom").change(function() {
				getData();
			});
			
			$("#medical_procedure").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/todo/procedure_list",
				"GET"
			));
			
			$("#job_status").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/todo/status_list",
				"GET"
			));
			
			$("#case_name").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/todo/auto_patient",
							 type:"get",
							 dataType:"json",
							 headers:{Authorization:"Bearer "+tokenID.token},
							 //data:{"emp_name":request.term},
							 data:{"patient_name":request.term},
							 //async:false,
			                 error: function (xhr, textStatus, errorThrown) {
			                        console.log('Error: ' + xhr.responseText);
			                    },
							 success:function(data){
									response($.map(data, function (item) {
			                            return {
			                                label: item.patient_id+"-"+item.patient_name,
			                                value: item.patient_id+"-"+item.patient_name,
			                            };
			                        }));
							},
							beforeSend:function(){
								$("body").mLoading('hide');	
							}
							
						});
			        }
			});
			
			$("#doctor_name").autocomplete({
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/todo/auto_doctor",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"doctor_name":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                    },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.doctor_id+"-"+item.doctor_name,
		                                value: item.doctor_id+"-"+item.doctor_name,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
						
					});
		        }
			});
			
			$("#responsible").autocomplete({
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/todo/auto_user",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"pic_name":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                 },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.userId+"-"+item.pic_name,
		                                value: item.userId+"-"+item.pic_name,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
						
					});
		        }
			});
		 } //end if
	} //end if
}); //end document