$(document).ready(function(){
	 var username = $('#user_portlet').val();
	 var password = $('#pass_portlet').val();
	 var plid = $('#plid_portlet').val();
	 if(username!="" && username!=null & username!=[] && username!=undefined ){
		 if(connectionServiceFn(username,password,plid)==true){
			 
			var GlobalWriterID;
			var GlobalStageID;
			var GlobalDataWriter;
			var InsertUpdateForCheck = "";
			$('.dropify').dropify();
			
			function validatetorWriter(data) {
				var errorData="";
				$.each(data, function(key, value) {
					errorData += stripJsonToString(value);
				});
				console.log(errorData);
				return errorData;
			}
			
			var stripJsonToString= function(json){
			    return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "<br>").replace(/\"/g,'');
			}
			
			function validatetorInformation(data) {
				$("#information_errors").show();
				$("#information_errors").html(data);
			}
			 
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
			 
			function DropDownToStep() {
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/action_to",
						type:"get",
						dataType:"json",
						async:false,
						data:{"stage_id":$("#by_step").val()},
						headers:{Authorization:"Bearer "+tokenID.token},
						success:function(data){
							var htmlOption="";
							var htmlOption2="";
							$.each(data,function(index,indexEntry) {
								htmlOption+="<option value="+indexEntry['stage_id']+">"+indexEntry['stage_name']+"</option>";
								htmlOption2=indexEntry['status'];
							});
							
							$("#to_step_status").val(htmlOption2);
							$("#to_step").html(htmlOption);
						}
					});
			}
			DropDownToStep();
				
			function getData(page,rpp) {
				var article_ID = $("#search_article").val().split("-");
				article_ID = (article_ID == '') ? '' : article_ID[0];
					
				var doctor_id = $("#search_doctor").val().split("-");
				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
					
				var procedure_id = $("#search_procedure").val();
				var writing_start_date = formatDateYMD($("#search_start_date").val());
				var writing_end_date = formatDateYMD($("#search_end_date").val());
					
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/search_writer",
					type:"get",
					dataType:"json",
					async:false,
					headers:{Authorization:"Bearer "+tokenID.token},
					data:{
						"article_id":article_ID,
						"procedure_id":procedure_id,
						"doctor_id":doctor_id,
						"writing_start_date":writing_start_date,
						"writing_end_date":writing_end_date,
						"page":page,
						"rpp":rpp
					},
					success:function(data) {
						console.log(data);
						list_data_template(data);
						
						GlobalDataWriter=data;
						paginationSetUpFn(GlobalDataWriter['current_page'],GlobalDataWriter['last_page'],GlobalDataWriter['last_page']);
					}
				});
			};
				
			function InsertWriter() {
					var doctor_id = $("#form_doctor").val().split("-");
					doctor_id = (doctor_id == '') ? '' : doctor_id[0];
					var writer = $("#author").val().split("-");
					writer = (writer == '') ? null : writer[0];
					var writer_start_date = formatDateYMD($("#start_date").val());
					var plan_date = formatDateYMD($("#plan_date").val());
					var complete_date = formatDateYMD($("#complete_date").val());
					var actual_date = formatDateYMD($("#deadline_date").val());
					var user_id = {
							"user_id":$("#alert_multi").val()
					}
					
					var data_value = {
							"article_name":$("#article").val(),
							"article_type_id":$("#article_type").val(),
							"procedure_id":$("#procedure_name").val(),
							"doctor_id":doctor_id,
							"from_user_id":writer,
							"writing_start_date":writer_start_date,
							"plan_date":plan_date,
							
							"file":datafile,
							"alert":user_id,
							
							"from_stage_id":$("#by_step").val(),
							"to_stage_id":$("#to_step").val(),
							"to_user_id":$("#send_to").val(),
							"writing_end_date":complete_date,
							"actual_date":actual_date,
							"status":$("#to_step_status").val(),
							"remark":$("#remark").val()
					}
					
					var datafile = new FormData();
					if(filesForm!=undefined) {
						$.each(filesForm, function(key, value) {
							console.log(value,'filesform');
							datafile.append('article_doc-'+key, value);
						});
					}
					
					//var datafileWorkflow = new FormData();
					if(filesFormWorkflow!=undefined) {
						$.each(filesFormWorkflow, function(key, value) {
							console.log(value,'fileformworkflow');
							datafile.append('article_stage_doc-'+key, value);
						});
					}
					
					datafile.append('formdata', JSON.stringify(data_value));
	
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/cu",
						type:"post",
						dataType:"json",
						//async:false,
						processData: false, // Don't process the files
						contentType: false, // Set content type to false as jQuery will tell the server its a query string request
						headers:{Authorization:"Bearer "+tokenID.token},
						data:datafile,
						success:function(data){
							console.log(data)
							if(data.status==200) {
								callFlashSlide('Insert Success!','success')
	 							$("#ModalWriter").modal('hide');
							} else if (data.status==400) {
								console.log(data)
								validatetorInformation(validatetorWriter(data['errors'][0]));
							}
						}
					})
			};
				
			function GetDataEdit(article_id) {
					console.log("GetDataEdit")
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/show",
						type:"get",
						dataType:"json",
						async:false,
						headers:{Authorization:"Bearer "+tokenID.token},
						data:{"article_id":article_id},
						success:function(data){
							console.log(data);
							$("#article").val(data.article.article_name);
							$("#article_type").val(data.article.article_type_id);
							//$("#").val(data.article_type_name);
							$("#procedure_name").val(data.article.procedure_id);
							//$("#").val(data.procedure_name);
							$("#form_doctor").val(data.article.doctor_id+'-'+data.article.doctor_name);
							//$("#").val(data.doctor_name);
							$("#author").val(writer_id+'-'+data.article.writer_name);
							$("#start_date").val(formatdateDMY(data.article.writing_start_date));
							$("#complete_date").val(formatdateDMY(data.article.writing_end_date));
							$("#plan_date").val(formatdateDMY(data.article.plan_date));
							$("#to_step_status").val(data.article.status);
							list_article_history(data.article_hitory);
							//$("#").val(data.article_path);
						}
					})
			}
			
			function list_article_history(data) {
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";
				$.each(data, function (key,value) {
						TRTDHTML += 
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + value.created_dttm +'</td>'+
			                '<td "'+TRTDClass+'">' + value.from_stage_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.from_user_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.to_stage_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.to_user_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.remark +'</td>'+
			                '<td "'+TRTDClass+'">' +  +'</td>'+
			                '<td "'+TRTDClass+'"><button type="button" id="downloadfileWorkflowHistory-' + value.article_stage_id +'" class="btn btn-primary input-sm getfileWorkflow" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
			                '</td>'+
			                '</tr>';
			    });
				$('#workflow_history').html(TRTDHTML);
			} 
				
			function UpdateWriter() {
				var article_id = $("#article").val().split("-");
				article_id = (article_id == '') ? '' : article_id[0];
				var doctor_id = $("#form_doctor").val().split("-");
				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
				var writer = $("#author").val().split("-");
				writer = (writer == '') ? null : writer[0];
				var writer_start_date = formatDateYMD($("#start_date").val());
				var plan_date = formatDateYMD($("#plan_date").val());
				var complete_date = formatDateYMD($("#complete_date").val());
				var actual_date = formatDateYMD($("#deadline_date").val());
				var user_id = {
						"user_id":$("#alert_multi").val()
				}
				
				var data_value = {
						"article_id":article_id,
						"article_name":$("#article").val(),
						"article_type_id":$("#article_type").val(),
						"procedure_id":$("#procedure_name").val(),
						"doctor_id":doctor_id,
						"from_user_id":writer,
						"writing_start_date":writer_start_date,
						"plan_date":plan_date,
						
						"file":datafile,
						"alert":user_id,
						
						"from_stage_id":$("#by_step").val(),
						"to_stage_id":$("#to_step").val(),
						"to_user_id":$("#send_to").val(),
						"writing_end_date":complete_date,
						"actual_date":actual_date,
						"status":$("#to_step_status").val(),
						"remark":$("#remark").val()
				}
				
				var datafile = new FormData();
				$.each(filesForm, function(key, value) {
					console.log(value);
					datafile.append(key, value);
				});
				datafile.append('formdata', JSON.stringify(data_value));

				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/cu",
					type:"post",
					dataType:"json",
					//async:false,
					processData: false, // Don't process the files
					contentType: false, // Set content type to false as jQuery will tell the server its a query string request
					headers:{Authorization:"Bearer "+tokenID.token},
					data:datafile,
					success:function(data){
						if(data.status==200) {
							callFlashSlide('Update Success!','success')
 							$("#ModalWriter").modal('hide');
						} else if (data.status==400) {
							console.log(data)
							validatetorInformation(validatetorWriter(data['errors'][0]));
						}
					}
				})
			};
			
			function uploadFiles(event) {
				
					event.stopPropagation();
					event.preventDefault();
					
					var datafile = new FormData();
					$.each(files, function(key, value) {
						datafile.append(key, value);
					});
					
					$("body").mLoading();
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/import/"+GlobalWriterID,
						type:'POST',
						data:datafile,
						cache: false,
						dataType: 'json',
						processData: false, // Don't process the files
						contentType: false, // Set content type to false as jQuery will tell the server its a query string request
						headers:{Authorization:"Bearer "+tokenID.token},
						success: function(data, textStatus, jqXHR)
						{
							console.log(data);
							if(data['status']==200){
								callFlashSlide("Upload Success!");
								//getDataFn();
								$("body").mLoading('hide');
								$('#file').val("");
								$('#ModalImport').modal('hide');
								
							}else{
								//listErrorFn(data['errors']);
								callFlashSlide('errors','No Files Data');
								//getDataFn();
								$("body").mLoading('hide');
							}
						},
						error: function(jqXHR, textStatus, errorThrown)
						{
							callFlashSlide('Format Error : ' + textStatus);
						}
					});
					return false;
			};
			
			function downloadfileFN(aricleID) {
				console.log("downloadna")
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/download/"+aricleID,
					type:'get',
					cache: false,
					dataType: 'json',
					headers:{Authorization:"Bearer "+tokenID.token},
					success: function(data, textStatus, jqXHR)
					{
						console.log(data);
					},
					error: function(jqXHR, textStatus, errorThrown)
					{
						callFlashSlide('Format Error : ' + textStatus);
					}
				});
				return false;
			}
			
			function downloadfileWorkflowFN(stageid) {
				console.log("downloadnaworkflow")
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/download_article_stage_doc/"+stageid,
					type:'get',
					cache: false,
					dataType: 'json',
					headers:{Authorization:"Bearer "+tokenID.token},
					success: function(data, textStatus, jqXHR)
					{
						console.log(data);
					},
					error: function(jqXHR, textStatus, errorThrown)
					{
						callFlashSlide('Format Error : ' + textStatus);
					}
				});
				return false;
			}
			
			function list_data_template(data) {
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
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.plan_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.status +'</td>'+
			                '<td "'+TRTDClass+'"><button type="button" id="downloadfile-' + value.article_ID +'" class="btn btn-primary input-sm getfile" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
			                '&nbsp;<button type="button" id="uploadfile-' + value.article_ID +'" class="btn btn-success input-sm getfile" data-target="#ModalImport" data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i></button>'+
			                '&nbsp;<button type="button" id="edit-' + value.article_ID +'" class="btn btn-warning input-sm getfile" data-target="#ModalWriter" data-toggle="modal" title="แก้ไข" data-placement="top">แก้ไข</button></td>'+
			                '</tr>';
			    });
				$('#result_search_writer').html(TRTDHTML);
			}
				
			//Autocomeplete
			$("#search_article").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/writer/list_article",
							 type:"get",
							 dataType:"json",
							 headers:{Authorization:"Bearer "+tokenID.token},
							 //data:{"emp_name":request.term},
							 data:{"article_name":request.term},
							 //async:false,
			                 error: function (xhr, textStatus, errorThrown) {
			                        console.log('Error: ' + xhr.responseText);
			                    },
							 success:function(data){
									response($.map(data, function (item) {
			                            return {
			                                label: item.article_ID+"-"+item.article_name,
			                                value: item.article_ID+"-"+item.article_name,
			                            };
			                        }));
							},
							beforeSend:function(){
								$("body").mLoading('hide');	
							}
							
						});
			        }
			});
				
			$("#search_doctor").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/writer/list_doctor",
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
				
			$("#form_doctor").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/writer/list_doctor",
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
			
			$("#search_procedure").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/writer/list_medical_procedure",
					"GET"
			));
			
			$("#procedure_name").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/doctor_profile/list_medical_procedure",
					"GET"
			));
			
			$("#article_type").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/writer/list_article_type",
					"GET"
			));
			
			$("#alert_multi").html(generateDropDownList(
					restfulURL+"/"+serviceName+"/writer/list_article_type",
					"GET"
			));
				
			$('#alert_multi').multiselect({
			  allSelectedText: 'No option left ...',
			  maxHeight: 200,
			  onChange: function() {
				  console.log($('#alert_multi').val());
			  }
			});
				
			$("#search_start_date,#search_end_date,#start_date,#plan_date,#complete_date,#deadline_date").datepicker({
				dateFormat: 'dd/mm/yy'
			});
				
			$("#btn_search").click(function(){
				if($("#search_start_date").val()=='') {
					$("#search_start_date").focus();
					callFlashSlide('โปรดระบุจากวันที่!','warning')
				}else if($("#search_end_date").val()=='') {
					$("#search_end_date").focus();
					callFlashSlide('โปรดระบุถึงวันที่!','warning')
				} else {
					getData();
				}
			});
				
			$("#btn_add").click(function(){
				$("#author").val(userId+'-'+screenName);
				$("#information_errors").hide();
				InsertUpdateForCheck = "insert";
			});
				
			$("#btn_result_edit").click(function () {
				$("#information_errors").hide();
				InsertUpdateForCheck = "update";
				GetDataEdit();
			});
				
			$("#btn_modal_submit").click(function() {
				if(InsertUpdateForCheck=="insert") {
					InsertWriter();
				} else {
					UpdateWriter();
				}
			});
				
			$("#result_search_writer").on("click",'.getfile',function() {
				var ufile = $(this).attr('id').split("-");
				//var ufile = $(this).attr('id');
				GlobalWriterID = null;
				GlobalStageID = null;
				$('#file').val("");
				$(".btnModalClose").click();
				$(".dropify-clear").click();
				GlobalWriterID = ufile[1];
				if(ufile[0]=='downloadfile') {
					downloadfileFN(GlobalWriterID);
				} else if(ufile[0]=='edit') {
					GetDataEdit(GlobalWriterID);
				}
				
				if(ufile[0]=='downloadfileWorkflowHistory') {
					GlobalStageID
				}
			});
			
			$("#workflow_history").on("click",'.getfileWorkflow',function() {
				var ufile = $(this).attr('id').split("-");
				GlobalStageID = null;
				GlobalStageID = ufile[1];
				if(ufile[0]=='downloadfileWorkflowHistory') {
					downloadfileWorkflowFN(GlobalStageID);
				}
			});
				
			var files;
			$('#file').on('change', prepareUpload);
			function prepareUpload(event) {
				 files = event.target.files;
			};
			
			var filesForm;
			var filesLength;
			$('#fileForm').on('change', prepareUpload2);
			function prepareUpload2(event) {
				filesForm = event.target.files;
				if(event.target.files.length!=undefined){
					filesLength = event.target.files.length;
					console.log(filesForm)
				}
			};
			
			var filesFormWorkflow;
			var filesLengthWorkflow;
			$('#fileFormWorkflow').on('change', prepareUpload3);
			function prepareUpload3(event) {
				filesFormWorkflow = event.target.files;
				if(event.target.files.length!=undefined){
					filesLengthWorkflow = event.target.files.length;
					console.log(filesForm)
				}
			};
				
			$('form#fileUploadWriter').on('submit', uploadFiles);
			$('form#fileUploadWriterForm').on('submit',function(){
				showHideFileuploadform('.countFileTargetForm',filesLength);
				$("#ModalImportForm").modal('hide');
				return false;
			});
			$('form#fileUploadWriterFormWorkflow').on('submit',function(){
				showHideFileuploadform('.countFileTargetFormWorkflow',filesLengthWorkflow);
				$("#ModalImportFormWorkflow").modal('hide');
				return false;
			});
			
			$(".dropify-clear").click(function(){
				filesLength = 0;
				filesLengthWorkflow = 0;
			});
			
			function showHideFileuploadform(classtextFiles,filelength) {
				if(filelength>0) {
					$(""+classtextFiles+"").text(''+filelength+' Files');
				} else {
					$(""+classtextFiles+"").text('');
				}
			}
			
		 }// end if
	 }// end if
});// end document