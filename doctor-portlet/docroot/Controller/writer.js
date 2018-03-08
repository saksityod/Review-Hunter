$(document).ready(function(){
	 var username = $('#user_portlet').val();
	 var password = $('#pass_portlet').val();
	 var plid = $('#plid_portlet').val();
	 if(username!="" && username!=null & username!=[] && username!=undefined ){
		 if(connectionServiceFn(username,password,plid)==true){
			 
			var GlobalWriterID;
			var GlobalStageID;
			var GlobalCurrentStageID;
			var GlobalDataWriter;
			var InsertUpdateForCheck = "";
			$('.dropify').dropify();
			
			var perPagePaganation = 10;
			
			//pagination
			var $pagination = $('#pg'),
		      totalRecords = 0,
		      records = [],
		      displayRecords = [],
		      recPerPage = perPagePaganation,
		      page = 1,
		      totalPages = 0;
			
			function apply_pagination(data) {
				//console.log('apply_pagination');
			      $pagination.twbsPagination({
			        totalPages: totalPages,
			        visiblePages: 6,
			        onPageClick: function (event, page) {
			          displayRecordsIndex = Math.max(page - 1, 0) * recPerPage;
			          endRec = (displayRecordsIndex) + recPerPage;

			          displayRecords = records.slice(displayRecordsIndex, endRec);
			          //generate_table();
			          list_data_template_pagination(data);
			        }
			      });
			}
			
			function getDateNow() {
				var today = new Date();
				var dd = today.getDate();
				var mm = today.getMonth()+1; //January is 0!

				var yyyy = today.getFullYear();
				yyyy += 543;
				if(dd<10){
				    dd='0'+dd;
				} 
				if(mm<10){
				    mm='0'+mm;
				} 
				var today = dd+'/'+mm+'/'+yyyy;
				return today;
			}

//			function validatetor(data) {
//				var errorData="";
//				$.each(data, function(key, value) {
//					errorData += stripJsonToString(value);
//				});
//				console.log(errorData);
//				return errorData;
//			}
			
//			var stripJsonToString= function(json){
//			    return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "<br>").replace(/\"/g,'');
//			}
			
//			function validatetorInformation(data) {
//				$("#information_errors").show();
//				$("#information_errors").html(data);
//			}
			 
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
				 			//console.log(data)
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
			 
			function DropDownCurrentStep() {
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/current_action",
						type:"get",
						dataType:"json",
						async:false,
						data:{"stage_id":GlobalCurrentStageID},
						headers:{Authorization:"Bearer "+tokenID.token},
						success:function(data){
							//console.log(data,'DropDownCurrentStep');
							var htmlOption="";
							var checkrolesIDbtn = null;
							$.each(data,function(index,indexEntry) {
								htmlOption+="<option value="+indexEntry['stage_id']+">"+indexEntry['stage_name']+"</option>";
								checkrolesIDbtn = indexEntry['role_id'];
							});
							$("#by_step").html(htmlOption);
							
							BTNcheckSubmitForm(checkrolesIDbtn);
						}
					});
			}
			
			function DropDownToStep() {
				var current_stage_id = (GlobalCurrentStageID == null) ? $("#by_step").val() : GlobalCurrentStageID;
				
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/action_to",
					type:"get",
					dataType:"json",
					async:false,
					data:{"stage_id":current_stage_id},
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						console.log(data,'action_to')
						var htmlOption="";
						//var htmlOption3="";
						
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['stage_id']+"-"+indexEntry['status']+">"+indexEntry['stage_name']+"</option>";
							//htmlOption3=indexEntry['to_user'];
						});
						
						//$("#send_to").val(htmlOption3);
						$("#to_step").html(htmlOption);
					}
				});
			}
			
			function DropDownSendToStage() {
				
				var stage_id = $("#to_step").val().split("-");
				stage_id = (stage_id == '') ? '' : stage_id[0];
				
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/send_to_stage",
					type:"get",
					dataType:"json",
					async:false,
					data:{"stage_id":stage_id},
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						
						console.log(data,'DropDownSendToStage');
						var htmlOption="";
						
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['userId']+"-"+indexEntry['emailAddress']+"-"+indexEntry['screenName']+">"+indexEntry['screenName']+"</option>";
						});
						$("#send_to").html(htmlOption);
					}
				});
			}
			
			function DropDownAlertMulti() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/list_user_alert",
					type:"get",
					dataType:"json",
					async:false,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						$.each(data,function(index,v) {
							htmlOption+="<option value="+v.userId+"|"+v.emailAddress+">"+v.screenName+"</option>";
						});
						$("#alert_multi").html(htmlOption);
					}
				});
			}
				
			function searchFN() {
				var search_writer = $("#search_writer").val().split("-");
				search_writer = (search_writer == '') ? '' : search_writer[0];
					
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
						"writer":search_writer,
						"procedure_id":procedure_id,
						"doctor_id":doctor_id,
						
						"writing_start_date":writing_start_date,
						"writing_end_date":writing_end_date
					},
					success:function(data) {
						//console.log(data);
						GlobalDataWriter=data;
						
						//set pagination
						//console.log(data.length)
						if(data.length > 0) {
							if(data.length <= 10) {
								list_data_template(data);
							} else {
								records = data;
							    totalRecords = records.length;
							    totalPages = Math.ceil(totalRecords / recPerPage);
							    apply_pagination(data);
							}
						} else {
							callFlashSlide('ไม่พบข้อมูลการค้นหา!','warning')
						}
					}
				});
			};
			//getData();
				
			function InsertWriter() {
					var doctor_id = $("#form_doctor").val().split("-");
					doctor_id = (doctor_id == '') ? '' : doctor_id[0];
					
					var writer = $("#author").val().split("-");
					
					writer = (writer == '') ? null : writer[0];
					var writer_start_date = formatDateYMD($("#start_date").val());
					var plan_date = formatDateYMD($("#plan_date").val());
					var writing_end_date = formatDateYMD($("#writing_end_date").val());
					var actual_date = formatDateYMD($("#actual_date").val());
					
					//console.log(actual_date,'actual_date');
					
					var user_id = {
							"user_id":$("#alert_multi").val()
					}
					
					if($("#send_to").val()==null) {

						var send_to = 0;
						var send_to_email = "";
						var send_to_name = "";
						
					} else {
						
						var send_to = $("#send_to").val().split("-");
						send_to = (send_to == '') ? '' : send_to[0];
						
						var send_to_email = $("#send_to").val().split("-");
						send_to_email = (send_to_email == '') ? '' : send_to_email[1];
						
						var send_to_name = $("#send_to").val().split("-");
						send_to_name = (send_to_name == '') ? '' : send_to_name[2];
					}
					
					var to_stage_id = $("#to_step").val().split("-");
					to_stage_id = (to_stage_id == '') ? '' : to_stage_id[0];
					
					var to_stage_status = $("#to_step").val().split("-");
					to_stage_status = (to_stage_status == '') ? '' : to_stage_status[1];
					
					var data_value = {
							"article_name":$("#article_name").val(),
							"article_type_id":$("#article_type").val(),
							"procedure_id":$("#procedure_name").val(),
							"doctor_id":doctor_id,
							"from_user_id":writer,
							"writing_start_date":writer_start_date,
							"plan_date":plan_date,
							
							"file":datafile,
							"alert":user_id,
							
							"from_stage_id":$("#by_step").val(),
							"to_stage_id":to_stage_id,
							
							"to_user_id":send_to,
							"to_user_email":send_to_email,
							"to_user_name":send_to_name,
							
							"writing_end_date":writing_end_date,
							"actual_date":actual_date,
							"status":to_stage_status,
							"remark":$("#remark").val()
					}
					
					var datafile = new FormData();
					if(filesForm!=undefined) {
						$.each(filesForm, function(key, value) {
							//console.log(value,'filesform');
							datafile.append('article_doc-'+key, value);
						});
					}
					
					//var datafileWorkflow = new FormData();
					if(filesFormWorkflow!=undefined) {
						$.each(filesFormWorkflow, function(key, value) {
							//console.log(value,'fileformworkflow');
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
							//console.log(data)
							if(data.status==200) {
								$("#btn_modal_submit").attr('disabled',false);
								callFlashSlide('Insert Success!','success')
	 							$("#ModalWriter").modal('hide');
								//searchFN();
							} else if (data.status==400) {
								//console.log(data)
								$("#btn_modal_submit").attr('disabled',false);
								validatetorInformation(validatetor(data['errors'][0]));
							}
						}
					})
			};
			
			function UpdateWriter() {
				//console.log(GlobalWriterID,'GlobalWriterID');
				var article_id = GlobalWriterID;
				var article_name = $("#article_name").val().split("-");
				article_name = (article_name == '') ? '' : article_name[0];
				
				var doctor_id = $("#form_doctor").val().split("-");
				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
				
				var writer = $("#author").val().split("-");
				writer = (writer == '') ? null : writer[0];
				
				var writer_start_date = formatDateYMD($("#start_date").val());
				var plan_date = formatDateYMD($("#plan_date").val());
				var writing_end_date = formatDateYMD($("#writing_end_date").val());
				var actual_date = formatDateYMD($("#actual_date").val());
				
				var user_id = {
						"user_id":$("#alert_multi").val()
				}
				
				if($("#send_to").val()==null) {

					var send_to = 0;
					var send_to_email = "";
					var send_to_name = "";
					
				} else {
					
					var send_to = $("#send_to").val().split("-");
					send_to = (send_to == '') ? '' : send_to[0];
					
					var send_to_email = $("#send_to").val().split("-");
					send_to_email = (send_to_email == '') ? '' : send_to_email[1];
					
					var send_to_name = $("#send_to").val().split("-");
					send_to_name = (send_to_name == '') ? '' : send_to_name[2];
				}
				
				var to_stage_id = $("#to_step").val().split("-");
				to_stage_id = (to_stage_id == '') ? '' : to_stage_id[0];

				var to_stage_status = $("#to_step").val().split("-");
				to_stage_status = (to_stage_status == '') ? '' : to_stage_status[1];
				
				var data_value = {
						"article_id":article_id,
						"article_name":$("#article_name").val(),
						"article_type_id":$("#article_type").val(),
						"procedure_id":$("#procedure_name").val(),
						"doctor_id":doctor_id,
						"from_user_id":writer,
						"writing_start_date":writer_start_date,
						"plan_date":plan_date,
						
						"file":datafile,
						"alert":user_id,
						
						"from_stage_id":$("#by_step").val(),
						"to_stage_id":to_stage_id,
						
						"to_user_id":send_to,
						"to_user_email":send_to_email,
						"to_user_name":send_to_name,
						
						"writing_end_date":writing_end_date,
						"actual_date":actual_date,
						"status":to_stage_status,
						"remark":$("#remark").val()
				}
				
				var datafile = new FormData();
				if(filesForm!=undefined) {
					$.each(filesForm, function(key, value) {
						//console.log(value,'filesform');
						datafile.append('article_doc-'+key, value);
					});
				}
				
				//var datafileWorkflow = new FormData();
				if(filesFormWorkflow!=undefined) {
					$.each(filesFormWorkflow, function(key, value) {
						//console.log(value,'fileformworkflow');
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
						//console.log(data)
						if(data.status==200) {
							$("#btn_modal_submit").attr('disabled',false);
							callFlashSlide('Update Success!','success')
							$("#ModalWriter").modal('hide');
							//searchFN();
						} else if (data.status==400) {
							//console.log(data)
							$("#btn_modal_submit").attr('disabled',false);
							validatetorInformation(validatetor(data['errors'][0]));
						}
					}
				})
			};
				
			function GetDataEdit(article_id) {
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/show",
						type:"get",
						dataType:"json",
						async:false,
						headers:{Authorization:"Bearer "+tokenID.token},
						data:{"article_id":article_id},
						success:function(data){
							
							//console.log(data['article'][0]['workflow_actual_date'],'datetestww');
							
							$("#article_name").val(data['article'][0]['article_name']);
							$("#article_type").val(data['article'][0]['article_type_id']);
							$("#procedure_name").val(data['article'][0]['procedure_id']);
							$("#form_doctor").val(data['article'][0]['doctor_id']+'-'+data['article'][0]['doctor_name']);
							$("#author").val(data['article'][0]['writer_id']+'-'+data['article'][0]['writer_name']);
							$("#start_date").val(formatDateDMY(data['article'][0]['writing_start_date']));
							$("#plan_date").val(formatDateDMY(data['article'][0]['plan_date']));
							
							//get to_stage_id
							GlobalCurrentStageID = data['article'][0]['to_stage_id'];

							$("#writing_end_date").val(formatDateDMY(data['article'][0]['writing_end_date']));
							//$("#send_to").val(data['article'][0]['to_user_id']+'-'+data['article'][0]['to_user_name']);
							$("#send_to").val(data['article'][0]['to_user_id']);
							$("#workflow_actual_date").val(formatDateDMY(data['article'][0]['workflow_actual_date']));
							$("#remark").val(data['article'][0]['remark']);

							list_article_history(data['article_history']);
						}
					})
			}
			
			function list_article_history(data) {
				
				if(data.length==undefined) {
					return false;
				} else {
					var TRTDHTML = "";
					$.each(data, function (key,value) {
							var date_split = value.created_dttm.split(" ");
							//console.log(date_split);
							
							TRTDHTML += 
				                '<tr>'+
				                '<td><center>' + formatDateDMY(date_split[0]) +" "+ date_split[1] +'</center></td>'+
				                '<td><center>' + value.from_stage_name +'</center></td>'+
				                '<td><center>' + value.from_user_name +'</center></td>'+
				                '<td><center>' + value.to_stage_name +'</center></td>'+
				                '<td><center>' + value.to_user_name +'</center></td>'+
				                '<td><center>' + value.remark +'</center></td>'+
				                '<td><center>' + value.remark +'</center></td>'+
				                '<td><center><button type="button" id="downloadfileWorkflowHistory-' + value.article_stage_id +'" class="btn btn-primary input-sm getfileWorkflow" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
				                '</center></td>'+
				                '</tr>';
				    });
					$('#workflow_history').html(TRTDHTML);
				}
			} 
			
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
							//console.log(data);
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
/*  				console.log(aricleID,'downloadfileFN')
				window.open(restfulURL+"/"+serviceName+"/writer/download_article_doc/"+aricleID,"_self");
				return false; */
				
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/download_article_doc/"+aricleID,
					type:'get',
					cache: false,
					dataType: 'json',
					headers:{Authorization:"Bearer "+tokenID.token},
					success: function(data){
						if(data['status']==400){
							callFlashSlide("No file Data!",'errors');
						}
					},
					error: function(jqXHR, textStatus, errorThrown)
					{
						window.open(restfulURL+"/"+serviceName+"/writer/download_article_doc/"+aricleID,"_self");
		 				return false;
					}
				});
			}
			
			function downloadfileWorkflowFN(stageid) {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/download_article_stage_doc/"+stageid,
					type:'get',
					cache: false,
					dataType: 'json',
					headers:{Authorization:"Bearer "+tokenID.token},
					success: function(data){
						if(data['status']==400){
							callFlashSlide("No file Data!",'errors');
						}
					},
					error: function(jqXHR, textStatus, errorThrown)
					{
						window.open(restfulURL+"/"+serviceName+"/writer/download_article_stage_doc/"+stageid,"_self");
		 				return false;
					}
				});
			}
			
			function list_data_template_pagination(data) {
				//console.log('list_data_template_pagination');
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";
				
				for (var i = 0; i < displayRecords.length; i++) {
				//$.each(data, function (key,value) {
						TRTDHTML +=
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].article_name +'</td>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].writer +'</td>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].procedure_name +'</td>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].doctor_name +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(displayRecords[i].writing_start_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(displayRecords[i].writing_end_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(displayRecords[i].plan_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].article_type_name +'</td>'+
			                '<td "'+TRTDClass+'">' + displayRecords[i].status +'</td>'+
			                '<td "'+TRTDClass+'"><button type="button" id="downloadfile-' + displayRecords[i].article_id +'" class="btn btn-primary input-sm getfile" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
			                '&nbsp;<button type="button" id="uploadfile-' + displayRecords[i].article_id +'" class="btn btn-success input-sm getfile" data-target="#ModalImport" data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i></button>'+
			                '&nbsp;<button type="button" id="edit-' + displayRecords[i].article_id +'" class="btn btn-warning input-sm getfile" data-target="#ModalWriter" data-toggle="modal" title="แก้ไข" data-placement="top">แก้ไข</button></td>'+
			                '</tr>';
			    //});
				}
				$('#result_search_writer').html(TRTDHTML);
			}
			
			function list_data_template(data) {
				//console.log(data);
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
			                '<td "'+TRTDClass+'"><button type="button" id="downloadfile-' + value.article_id +'" class="btn btn-primary input-sm getfile" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
			                '&nbsp;<button type="button" id="uploadfile-' + value.article_id +'" class="btn btn-success input-sm getfile" data-target="#ModalImport" data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i></button>'+
			                '&nbsp;<button type="button" id="edit-' + value.article_id +'" class="btn btn-warning input-sm getfile" data-target="#ModalWriter" data-toggle="modal" title="แก้ไข" data-placement="top">แก้ไข</button></td>'+
			                '</tr>';
			    });

				$('#result_search_writer').html(TRTDHTML);
			}
			
			function setDataAddAndEdit() {
				$("#information_errors").hide();
				
				$("#article_type").html(generateDropDownList(
						restfulURL+"/"+serviceName+"/writer/list_article_type",
						"GET"
				));
				
				$("#procedure_name").html(generateDropDownList(
						restfulURL+"/"+serviceName+"/doctor_profile/list_medical_procedure",
						"GET"
				));
				
				DropDownAlertMulti();
				
				$('#alert_multi').multiselect({
				  //allSelectedText: 'No option left ...',
				  maxHeight: 200,
				  onChange: function() {
					  //console.log($('#alert_multi').val());
				  }
				});
				
				$('#alert_multi').multiselect('refresh');
				
				DropDownCurrentStep();
				DropDownToStep();
				DropDownSendToStage();
				
				var val_by_step = $("#by_step").val();
				if(val_by_step>203) {
					$("#article_name,#article_type,#procedure_name,#form_doctor,#author,#start_date,#plan_date").attr("disabled",true);
				} else {
					$("#article_name,#article_type,#procedure_name,#form_doctor,#author,#start_date,#plan_date").attr("disabled",false);
				}
			}
			
			function clearDataIsEmpty() {
				GlobalCurrentStageID = null;
				$('#file').val("");
				$(".btnModalClose").click();
				$(".dropify-clear").click();
				
				$(".modal input[type='text'],.modal textarea").val('');
				$(".modal input[type='radio'],.modal input[type='checkbox']").prop('checked', false);
				
				$(".countFileTargetForm").empty();
				$(".countFileTargetFormWorkflow").empty();
				
				$("#workflow_history").empty();
				
			}
			
			function BTNcheckSubmitForm(checkrolesIDbtn) {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/check_disabled",
					type:"get",
					dataType:"json",
					async:false,
					data:{"role_id":checkrolesIDbtn},
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						if(data.status==200) {
							$("#btn_modal_submit").attr('disabled',false);
						} else {
							$("#btn_modal_submit").attr('disabled',true);
						}
					}
				});
			}
				
			//Autocomeplete
			$("#search_writer").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/writer/list_writer",
							 type:"get",
							 dataType:"json",
							 headers:{Authorization:"Bearer "+tokenID.token},
							 //data:{"emp_name":request.term},
							 data:{"writer":request.term},
							 //async:false,
			                 error: function (xhr, textStatus, errorThrown) {
			                        console.log('Error: ' + xhr.responseText);
			                    },
							 success:function(data){
									response($.map(data, function (item) {
			                            return {
			                                label: item.writer+"-"+item.screenName,
			                                value: item.writer+"-"+item.screenName,
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
					restfulURL+"/"+serviceName+"/doctor_profile/list_medical_procedure",
					"GET",{},'All'
			));
			
			$("#to_step").change(function(){
				DropDownSendToStage();
			});
			
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});
				
			$("#btn_search").click(function(){
				if($("#search_start_date").val()=='') {
					$("#search_start_date").focus();
					callFlashSlide('โปรดระบุจากวันที่!','warning')
				}else if($("#search_end_date").val()=='') {
					$("#search_end_date").focus();
					callFlashSlide('โปรดระบุถึงวันที่!','warning')
				} else {
					searchFN();
				}
			});
				
			$("#btn_add").click(function(){
				clearDataIsEmpty();
				
				$("#author").val(userId+'-'+screenName);
				InsertUpdateForCheck = "insert";
				
				setDataAddAndEdit();

				$("#writing_end_date").val(getDateNow());	
			});
			
			$("#btn_modal_submit").click(function() {
				$("#btn_modal_submit").attr('disabled',true);
				if(InsertUpdateForCheck=="insert") {
					InsertWriter();
				} else {
					UpdateWriter();
				}
			});
			
			$("#plan_date").change(function() {
				$("#actual_date").val($(this).val());
			});
				
			$("#result_search_writer").on("click",'.getfile',function() {
				var ufile = $(this).attr('id').split("-");
				//console.log(ufile);
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
					clearDataIsEmpty();
					
					InsertUpdateForCheck = "update";
					GetDataEdit(GlobalWriterID);
					setDataAddAndEdit();
				}
			});
			
			$("#countPaginationBottom").change(function() {
				perPagePaganation = $(this).val();
				searchFN();
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
					//console.log(filesForm)
				}
			};
			
			var filesFormWorkflow;
			var filesLengthWorkflow;
			$('#fileFormWorkflow').on('change', prepareUpload3);
			function prepareUpload3(event) {
				filesFormWorkflow = event.target.files;
				if(event.target.files.length!=undefined){
					filesLengthWorkflow = event.target.files.length;
					//console.log(filesForm)
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