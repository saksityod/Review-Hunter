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
			var rolesArray = [];
			
			for (var i = 0;  i < roles.length; i++ ) {
				rolesArray.push(roles[i]['roleId']);
			}
			
			$('.dropify').dropify();
			
			$html_articleSocialMedia = '';
			$.ajax({
				url:restfulURL+"/"+serviceName+"/writer/getSocialMedia",
				type:"get",
				dataType:"json",
				async:true,
				data:'',
				headers:{Authorization:"Bearer "+tokenID.token},
				success:function(rs){
					//console.log(rs);
					if(rs.status==200) {
						if(rs.articleSocialMedia){
							$.each(rs.articleSocialMedia,function(){
								$html_articleSocialMedia +='<option value="'+this.social_media_id+'">'+this.social_media_name+'</option>';
							});
						}
					}
				}
			});
			
			function onload() {
				$("#author").val(userId+'-'+screenName);
				$("#article_code").val("ระบบจะทำการเพิ่มให้อัตโนมัติ");
				$("#start_date").val(getDateNow());
				$("#writing_end_date").val("");
				$("#plan_date").val("");
				$("#actual_date").val("");
				GlobalWriterID = null;
				
			}
			 
			function DropDownCurrentStep(trueOrfalse) {
					$.ajax({
						url:restfulURL+"/"+serviceName+"/writer/current_action",
						type:"get",
						dataType:"json",
						async:trueOrfalse,
						data:{"stage_id":GlobalCurrentStageID},
						headers:{Authorization:"Bearer "+tokenID.token},
						success:function(data) {
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
						var htmlOption="";
						$.each(data,function(index,indexEntry) {
							htmlOption+="<option value="+indexEntry['stage_id']+"-"+indexEntry['status']+">"+indexEntry['stage_name']+"</option>";
						});
						$("#to_step").html(htmlOption);
					}
				});
			}
			
			function DropDownSendToStage() {
				
				if($("#to_step").val()==null) {
					return false;
				}
				
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
					async:true,
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
			
			function DropDownArticleType() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/list_article_type",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						$.each(data,function(index,v) {
							htmlOption+="<option value="+v.article_type_id+">"+v.article_type_name+"</option>";
						});
						$("#article_type").html(htmlOption);
					}
				});
			}
			
			function DropDownProcedureName() {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/doctor_profile/list_medical_procedure",
					type:"get",
					dataType:"json",
					async:true,
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						var htmlOption="";
						$.each(data,function(index,v) {
							htmlOption+="<option value="+v.procedure_id+">"+v.procedure_name+"</option>";
						});
						$("#search_procedure,#procedure_name").append(htmlOption);
					}
				});
			}
			
			var paginationSetUpFn = function(pageIndex,pageButton,pageTotal) {
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
			
			function getData(page,rpp) {
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
						"article_code":$("#search_article_code").val(),
						"writing_start_date":writing_start_date,
						"writing_end_date":writing_end_date,
						"page":page,
						"rpp":rpp
					},
					success:function(data) {
						GlobalDataWriter=data;
						list_data_template(data.data);
						paginationSetUpFn(GlobalDataWriter['current_page'],GlobalDataWriter['last_page'],GlobalDataWriter['last_page']);
					}
				});
			};
			
			function UpdateWriter() {
				
				var article_id = (GlobalWriterID == '' || GlobalWriterID == null) ? null : GlobalWriterID;
				
				var doctor_id = $("#form_doctor").val().split("-");
				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
				
				var writer = $("#author").val().split("-");
				writer = (writer == '') ? null : writer[0];
				
				var writer_name = $("#author").val().split("-");
				writer_name = (writer_name == '') ? null : writer_name[1];
				
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
				
				var social_media = [];
				$('#article_social_media table tbody tr').each(function(){
					social_media.push({
						article_social_media_id : $(this).data('id')?$(this).data('id'):null,
						article_id 				: article_id,
						social_media_id 		: $(this).find('.article_social_media_social').val(),
//						user_link 				: $(this).find('.article_social_media_link').val() !=''?$(this).find('.article_social_media_link').val():null,
//						n_of_follower 			: $(this).find('.article_social_media_follow').val(),
						
						link 				:$(this).find('.article_social_media_link').val(),
						usr_name 			:$.trim($(this).find('.article_social_media_username').val()),
						pwd					:$.trim($(this).find('.article_social_media_password').val()),
						note 				:$(this).find('.article_social_media_remark').val(),
					});
				});
				
				var data_value = {
						"article_id":article_id,
						"article_name":$("#article_name").val(),
						"article_type_id":$("#article_type").val(),
						"procedure_id":$("#procedure_name").val(),
						"doctor_id":doctor_id,
						"from_user_id":writer,
						"from_user_name":writer_name,
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
						"remark":$("#remark").val(),
						"social_media":social_media
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
						//console.log(data,'cu');
						if(data.status==200) {
							callFlashSlide('บักทึกข้อมูลสำเร็จ!','success');
							$("#ModalWriter").modal('hide');
							clearDataIsEmpty();
						} else if (data.status==400) {
							validatetorInformation(validatetor(data['errors'][0]));
						}
					}
				});
				$("#btn_modal_submit").attr('disabled',false);
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
							//console.log(data,'GetDataEdit')
							
							//console.log(data['article'][0]['workflow_actual_date'],'datetestww');
							$("#article_code").val(data['article'][0]['article_code']);
							$("#article_name").val(data['article'][0]['article_name']);
							$("#article_type").val(data['article'][0]['article_type_id']);
							$("#procedure_name").val(data['article'][0]['procedure_id']);
							
							if(data['article'][0]['doctor_id']!=null) {
								$("#form_doctor").val(data['article'][0]['doctor_id']+'-'+data['article'][0]['doctor_name']);
							}
							
							$("#author").val(data['article'][0]['writer_id']+'-'+data['article'][0]['writer_name']);
							$("#start_date").val(formatDateDMY(data['article'][0]['writing_start_date']));
							$("#plan_date").val(formatDateDMY(data['article'][0]['plan_date']));
							
							//get to_stage_id
							GlobalCurrentStageID = data['article'][0]['to_stage_id'];
							//console.log(GlobalCurrentStageID,'to_stage_id');

							$("#writing_end_date").val(formatDateDMY(data['article'][0]['writing_end_date']));
							//$("#send_to").val(data['article'][0]['to_user_id']+'-'+data['article'][0]['to_user_name']);
							$("#send_to").val(data['article'][0]['to_user_id']);
							$("#actual_date").val(formatDateDMY(data['article'][0]['workflow_actual_date']));
							$("#remark").val(data['article'][0]['remark']);
							
							list_doc_file(data['article']);
							list_article_history(data['article_history']);
							get_social_list(data['social']);
						}
					})
			}
			function get_social_list(data){
				$('#article_social_media table tbody').html('');
				var encriptValue = ($.inArray(22309, rolesArray) != -1) ? "text" : "password";
				//console.log(encriptValue,'encriptValue')
				$.each(data,function(){
					$html = '<tr class="" data-id="'+this.article_social_media_id+'"> '
						+'<td><select class="article_social_media_social social form" disabled> '
							+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_articleSocialMedia+'</select></td> '
						+'<td><input type="text" class="article_social_media_link form" value="'+this.link+'" disabled><a href="'+this.link+'" target="_blank" class="pull-right">ลิงค์</a></td>'
						+'<td><input type="'+encriptValue+'" class="article_social_media_username form_encript" value="'+this.usr_name+'" disabled></td>'
						+'<td><input type="'+encriptValue+'" class="article_social_media_password form_encript" value="'+this.pwd+'" disabled></td>'
						+'<td><input type="text" class="article_social_media_remark form" value="'+this.note+'" disabled></td>'
						+'<td><button class="btn btn-danger del_rec btn-action form" disabled><i class="fa fa-trash"></i></button></td></tr>';
					$('#article_social_media table tbody').append($html);
					$('#article_social_media table tbody tr').last().find('.article_social_media_social').val(this.social_media_id);
				});
				
//				$.each(data,function(){
//					$html ='<tr class="" data-id="'+this.article_social_media_id+'">'
//								+'<td><select class="article_social_media_social social form" disabled> <option value=""> ---- เลือกสื่อ ---- </option>'+$html_articleSocialMedia+'</select></td>' 
//								+'<td><input type="text" class="article_social_media_link form" placeholder="ลิงค์" value="'+this.user_link+'" disabled></td>'
//								+'<a href="'+this.user_link+'" target="_blank" class="pull-right">ลิงค์</a>'
//								+'<td><input type="number" class="article_social_media_follow form" placeholder="จำนวน Follow" value="'+this.n_of_follwer+'" disabled></td>'
//								+'<td><button class="btn btn-danger del_rec btn-action form" disabled><i class="fa fa-trash"></i></button></td></tr>';
//					$('#article_social_media table tbody').append($html);
//					$('#article_social_media table tbody tr').last().find('.article_social_media_social').val(this.social_media_id);
//				});
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
			
			function list_doc_file(data) {
				$('#span_doc_path').empty();
					var doc_path_file = "";
					$.each(data, function (key,value) {
						if(value['doc_file']!=null) {
							var doc_file = (value['doc_file'].length>25) ? value['doc_file'].substring(0,25) + "..." : value['doc_file'];
							//console.log(doc_file,'doc_file')
							doc_path_file += '<span title="'+value['doc_file']+'">'+doc_file+'</span> <span id="'+value['article_doc_id']+'" class="doc_file_del"><a href="#" style="color:red;" title="ลบ">x</a></span><br/>';
						}
				    });
					$('#span_doc_path').html(doc_path_file);
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
								callFlashSlide("อัพโหลดสำเร็จ!",'success');
								//getDataFn();
								$("body").mLoading('hide');
								$('#file').val("");
								$('#ModalImport').modal('hide');
								
							}else{
								//listErrorFn(data['errors']);
								callFlashSlide('ไม่มีไฟล์ข้อมูล','error');
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
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/download_article_doc/"+aricleID,
					type:'get',
					cache: false,
					dataType: 'json',
					headers:{Authorization:"Bearer "+tokenID.token},
					success: function(data){
						if(data['status']==400){
							callFlashSlide('ไม่มีไฟล์ข้อมูล','error');
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
							callFlashSlide('ไม่มีไฟล์ข้อมูล','error');
						}
					},
					error: function(jqXHR, textStatus, errorThrown)
					{
						window.open(restfulURL+"/"+serviceName+"/writer/download_article_stage_doc/"+stageid,"_self");
		 				return false;
					}
				});
			}
			
			function list_data_template(data) {
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";

				$.each(data, function (key,value) {
						TRTDHTML +=
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + value.article_code +'</td>'+
			                '<td "'+TRTDClass+'">' + value.writer.split("-")[1]+'</td>'+
			                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_start_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_end_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.plan_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.status +'</td>'+
			                '<td "'+TRTDClass+'"><button style="margin-top:4px;" type="button" id="downloadfile-' + value.article_id +'" class="btn btn-primary btn-small getfile" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
			                '&nbsp;<button style="margin-top:4px;" type="button" id="uploadfile-' + value.article_id +'" class="btn btn-success btn-small getfile" data-target="#ModalImport" data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i></button>'+
			                '&nbsp;<button style="margin-top:4px;" type="button" id="edit-' + value.article_id +'" class="btn btn-warning btn-small getfile" data-target="#ModalWriter" data-toggle="modal" data-backdrop="static" data-keyboard="false" title="แก้ไข" data-placement="top"><i class="fa fa-wrench"></i></button></td>'+
			                '</tr>';
			    });

				$('#result_search_writer').html(TRTDHTML);
			}
			
			function setDataAddAndEdit(trueOrfalse) {
				$('#alert_multi').multiselect({
					  enableFiltering: true,
					  maxHeight: 200
				});
				
				$('#alert_multi').val("").multiselect('rebuild');
				
				DropDownCurrentStep(trueOrfalse);
				DropDownToStep();
				DropDownSendToStage();
				
				if(GlobalCurrentStageID>203) {
					$("#article_name,#article_type,#procedure_name,#form_doctor,#author,#start_date,#plan_date").attr("disabled",true);
				} else {
					$("#article_name,#article_type,#procedure_name,#form_doctor,#author,#start_date,#plan_date").attr("disabled",false);
				}
			}
			
			function clearDataIsEmpty() {
				$('.btn-action').hide();
				GlobalCurrentStageID = null;
				$('#file').val("");
				$(".btnModalClose").click();
				$(".dropify-clear").click();
				
				$(".modal input[type='text'],.modal textarea").val('');
				$(".modal input[type='radio'],.modal input[type='checkbox']").prop('checked', false);
				
				$(".countFileTargetForm").empty();
				$(".countFileTargetFormWorkflow").empty();
				
				$("#workflow_history").empty();
				$('#span_doc_path').empty();
				$("#information_errors").hide();
				$('#article_social_media table tbody').html('');
			}
			
			function BTNcheckSubmitForm(checkrolesIDbtn) {
				if(GlobalCurrentStageID==207) {
					$("#send_to").empty();
					$("#btn_modal_submit").attr('disabled',true);
					return false;
				}
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/check_disabled",
					type:"get",
					dataType:"json",
					async:true,
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
			
			function delDocFile(article_doc_id,article_id) {
				$.ajax({
					url:restfulURL+"/"+serviceName+"/writer/del_doc_file",
					type:"post",
					dataType:"json",
					async:true,
					data:{"article_doc_id":article_doc_id,"article_id":article_id},
					headers:{Authorization:"Bearer "+tokenID.token},
					success:function(data){
						if(data.status==200) {
							callFlashSlide("ลบข้อมูล สำเร็จ.",'success');
							list_doc_file(data.article);
						}
					}
				});
			}
				
			//Autocomeplete
			$("#search_article_code").autocomplete({
				minLength: 3,
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/writer/list_article_code",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"article_code":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                    },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.article_code,
		                                value: item.article_code,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
					});
		        }
			});
			
			$("#search_writer").autocomplete({
					minLength: 3,
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
					minLength: 3,
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
					minLength: 3,
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
			
			$("#author").autocomplete({
				minLength: 3,
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/writer/list_to_user",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"screenName":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                    },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.userId+"-"+item.screenName,
		                                value: item.userId+"-"+item.screenName,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
						
					});
		        }
			});
			
			DropDownAlertMulti();
			DropDownArticleType();
			DropDownProcedureName();
			
			$("#to_step").change(function() {
				DropDownSendToStage();
			});
			
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        });
				
			$("#btn_search").click(function(){
//				if($("#search_start_date").val()=='') {
//					$("#search_start_date").focus();
//					callFlashSlide('โปรดระบุจากวันที่!','warning')
//				}else if($("#search_end_date").val()=='') {
//					$("#search_end_date").focus();
//					callFlashSlide('โปรดระบุถึงวันที่!','warning')
//				} else {
					getData();
//				}
			});
			
			$("#btn_add").click(function() {
				clearDataIsEmpty();
				onload();
				setDataAddAndEdit(false);
				$('.modal-add').show();
			});
			
			$("#btn_modal_submit").click(function() {
				$("#btn_modal_submit").attr('disabled',true);
				UpdateWriter();
			});
			
			$("#plan_date").change(function() {
				$("#actual_date").val($(this).val());
			});
				
			$("#result_search_writer").on("click",'.getfile',function() {
				var ufile = $(this).attr('id').split("-");
				GlobalWriterID = null;
				GlobalStageID = null;
				$('#file').val("");
				$(".btnModalClose").click();
				$(".dropify-clear").click();
				$(".modal-cancel").hide(); 
				GlobalWriterID = ufile[1];
				if(ufile[0]=='downloadfile') {
					downloadfileFN(GlobalWriterID);
				} else if(ufile[0]=='edit') {
					GetDataEdit(GlobalWriterID);
					setDataAddAndEdit(true);
				}
				$('.modal-add,.modal-edit').show();
			});
			
			$('#btnConfirmOK2').click(function() {
				$('#confrimModalCancel').modal('hide');
			    $('#ModalWriter').modal('hide');
			    clearDataIsEmpty();
			});
			
			$('#btnCancelOK2').click(function() {
				$('#confrimModalCancel').modal('hide');
			});
			
			$("#workflow_history").on("click",'.getfileWorkflow',function() {
				var ufile = $(this).attr('id').split("-");
				GlobalStageID = null;
				GlobalStageID = ufile[1];
				if(ufile[0]=='downloadfileWorkflowHistory') {
					downloadfileWorkflowFN(GlobalStageID);
				}
			});
			
			$("#span_doc_path").on("click",'.doc_file_del',function() {
				var doc_id = $(this).attr('id');
				$('#confrimModalDelFile').modal({
			    	backdrop: 'static',
			      	keyboard: false
			    }).one('click', '#btnConfirmDelFile', function(e) {
			    	delDocFile(doc_id,GlobalWriterID);
			    	$('#confrimModalDelFile').modal('hide');
			    });
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
			
			//console.log(rolesArray);
			
			if($.inArray(22312, rolesArray) != -1 || $.inArray(22311, rolesArray) != -1 || $.inArray(22310, rolesArray) != -1) {
				$('#btn_add_social').show();
				$('#btn_edit_social').show();
			} else {
				if($.inArray(22309, rolesArray) != -1) {
					$('#btn_edit_social').show();
				} else {
					$('#btn_edit_social').hide();
				}
				$('#btn_add_social').hide();
			}
			
			 $('.modal-add').click(function(){
					$(this).closest('.wrap').find('table tbody').append($(this).data('tr'));
					$(this).closest('.wrap').find('tr.dump_tr').last().find('.social').html($html_articleSocialMedia);
					if($.inArray(22312, rolesArray) != -1) {
						//show all
					} else if($.inArray(22311, rolesArray) != -1 || $.inArray(22310, rolesArray) != -1) {
						$(this).closest('.wrap').find('tr.dump_tr').last().find('.article_social_media_username').attr('disabled', true);
						$(this).closest('.wrap').find('tr.dump_tr').last().find('.article_social_media_password').attr('disabled', true);
					}
			 });
			 
				$('body').on('click','.modal-edit',function(){
					var elm_parent = $(this).closest('.wrap'); 
					elm_parent.find('.modal-cancel').show();
					$(this).hide();
					
					if($.inArray(22309, rolesArray) != -1) {
						elm_parent.find('.form_encript').removeAttr('disabled');
					}
					
					if($.inArray(22311, rolesArray) != -1 || $.inArray(22310, rolesArray) != -1) {
						elm_parent.find('.form').removeAttr('disabled');
					}
					
					if($.inArray(22312, rolesArray) != -1) {
						elm_parent.find('.form,.form_encript').removeAttr('disabled');
					}
				});
				
				$('body').on('click','.modal-cancel',function(){
					var elm_parent = $(this).closest('.wrap'); 
					elm_parent.find('.modal-edit').show();
					$(this).hide();
					elm_parent.find('.form,.form_encript').attr('disabled','disabled');
				});
				
				$('body').on("click", ".del-tr", function(){ this.closest('tr').remove(); });
				
//				$('body').on('click','.del_rec',function(){
//					$('#confrimModal').modal('show');
//					var thiss = $(this);
//					$('#btnConfirmDelFile').one('click',function(){
//						$.ajax({
//							url:restfulURL+"/"+serviceName+"/writer/delRec",
//							type:"post",
//							data:{id:thiss.closest('tr').data('id')},
//							dataType:"json",
//							async:false,
//							headers:{Authorization:"Bearer "+tokenID.token},
//							success:function(rs){
//								console.log(rs,'del_rec');
//								$('#confrimModal').modal('hide');
//								if(rs.status == 200){
//									thiss.closest('tr').remove();
//									callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
//								}else{
//									callFlashSlide('ไม่สามารถลบไฟล์ได้!!','error');
//								}
//							}
//						});
//					});
//				});
				
				$('body').on('click','.del_rec',function() {
					var thiss = $(this);
					$('#confrimModalDelData').modal({
				    	backdrop: 'static',
				      	keyboard: false
				    }).one('click', '#btnConfirmDelData', function(e) {
				    	$.ajax({
							url:restfulURL+"/"+serviceName+"/writer/delRec",
							type:"post",
							data:{id:thiss.closest('tr').data('id')},
							dataType:"json",
							async:false,
							headers:{Authorization:"Bearer "+tokenID.token},
							success:function(rs){
								//console.log(rs,'del_rec');
								$('#confrimModalDelData').modal('hide');
								if(rs.status == 200){
									thiss.closest('tr').remove();
									callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
								}else{
									callFlashSlide('ไม่สามารถลบไฟล์ได้!!','error');
								}
							}
						});
					});
				});
				
				function pushData_caseSocialMedia(data){	
					$.each(data,function(){
						$html = '<tr class="" data-id="'+this.case_media_id+'"> '
							+'<td><select class="article_social_media_social social input_control"> '
								+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_articleSocialMedia+'</select></td> '
							+'<td><input type="text" class="article_social_media_link input_control" value="'+this.link+'"><a href="'+this.link+'" target="_blank" class="pull-right">ลิงค์</a></td>'
							+'<td><input type="text" class="article_social_media_username input_control" value="'+this.usr_name+'"></td>'
							+'<td><input type="text" class="article_social_media_password input_control" value="'+this.pwd+'"></td>'
							+'<td><input type="text" class="article_social_media_remark input_control" value="'+this.note+'"></td>'
							+'<td><button class="btn btn-danger del_rec btn-delete btn-action"  style="display:none"><i class="fa fa-trash"></i></button></td></tr>';
						$('#article_social_media tbody').append($html);
						$('#article_social_media tbody tr:last-child').find('.article_social_media_social').val(this.social_media_id);
					});
				};
				
				function getData_caseSocial(){	
					var channel = [];
					$('#article_social_media table tbody tr').each(function(i,v){
						channel.push({
							case_media_id 		:$(this).data("id")?$(this).data("id"):'',
							case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
							social_media_id 	:$('.case_social_media_social ').val(),
							link 				:$.trim($(this).find('.case_social_media_link').val()),
							usr_name 			:$.trim($(this).find('.case_social_media_username').val()),
							pwd					:$.trim($(this).find('.case_social_media_password').val()),
							note 				:$.trim($(this).find('.case_social_media_remark').val())
						});
					});
					return channel; 
				}
				
		 }// end if
	 }// end if
	 
	 
});// end document