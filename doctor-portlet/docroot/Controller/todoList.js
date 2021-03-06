$(document).ready(function(){
	var username = $('#user_portlet').val();
	var password = $('#pass_portlet').val();
	var plid = $('#plid_portlet').val();
	if(username!="" && username!=null & username!=[] && username!=undefined ){
		 if(connectionServiceFn(username,password,plid)==true){
			 
			var GlobalDataTodolist;
			
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
			
			var paginationSetUpFn = function(pageIndex,pageButton,pageTotal){
				 
				 if(pageTotal==0){
				  pageTotal=1
				 }
				 $('.pagination_bottom').off("page");
				 $('.pagination_bottom').bootpag({
				     total: pageTotal,//page Total
				     page: pageIndex,//page index
				     maxVisible: 5,//จำนวนปุ่ม
				     leaps: true,
				     firstLastUse: true,
				     first: '←',
				     last: '→',
				     wrapClass: 'pagination',
				     activeClass: 'active',
				     disabledClass: 'disabled',
				     nextClass: 'next',
				     prevClass: 'prev',
				     next: 'next',
				     prev: 'prev',
				     lastClass: 'last',
				     firstClass: 'first'
				 }).on("page", function(event, num){
				  var rpp=10;
				  if($("#rpp").val()==undefined){
				   rpp=10;
				  }else{
				   rpp=$("#rpp").val();
				  }
				  
				  getData(num,rpp);
				  
				     $(".pagingNumber").remove();
				     var htmlPageNumber= "<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='"+num+"'>";
				     $("body").append(htmlPageNumber);
				    
				 }); 

				 $(".countPagination").off("change");
				 $(".countPagination").on("change",function(){

				  //$("#countPaginationTop").val($(this).val());
				  $("#countPaginationBottom").val($(this).val());
				  
				  getData(1,$(this).val());
				  
				  $(".rpp").remove();
				  $(".pagingNumber").remove();
				  var htmlRrp="";
				   htmlRrp+= "<input type='hidden' id='rpp' name='rpp' class='rpp' value='"+$(this).val()+"'>";
				         htmlRrp+="<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='1'>";
				     $("body").append(htmlRrp);
				 });
			}
			
			var list_data_template = function(data) {
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";
				$.each(data.data, function (key,value) {
						TRTDHTML += 
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + value.patient_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.article_code +'</td>'+
			                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.status +'</td>'+
			                '<td "'+TRTDClass+'">' + value.pic_name +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.as_actual_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.plan_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.vn_no +'</td>'+
			                '</tr>';
			    });
				$('#list_job_status').html(TRTDHTML);
			}
			
			var check_user = function() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/todo/check_user",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data) {
						if(data.status==400) {
							$("#responsible").val(data.data[0]['userId']+"-"+data.data[0]['pic_name']);
							$("#responsible").attr("disabled",true);
						}
					}
				});
			}
			
			function DropDownMedicalProcedure() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/todo/procedure_list",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						htmlOption+="<option value=''>All</option>";
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['procedure_id']+">"+indexEntry['procedure_name']+"</option>";
						});
						$("#medical_procedure").html(htmlOption);
					}
				});
			}
			
			function DropDownJobStatus() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/todo/status_list",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						htmlOption+="<option value=''>All</option>";
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['status']+">"+indexEntry['status']+"</option>";
						});
						$("#job_status").html(htmlOption);
					}
				});
			}
			
			$("#result_search_writer").on("click",'.getfile',function() {
				var ufile = $(this).attr('id').split("-");
			});
			
			$("#btn_search").click(function() {
				getData();
			});
			
			check_user();
			DropDownMedicalProcedure();
			DropDownJobStatus();
			
			$("#case_name").autocomplete({
					minLength: 3,
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
				minLength: 3,
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
				minLength: 3,
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