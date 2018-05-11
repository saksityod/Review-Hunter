$(document).ready(function() {
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	$roles = "rh_co";
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "ba";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName;

		var n_id = 0;
		var d = new Date();
	    var toDay = d.getDate() + '/'+ (d.getMonth() + 1) + '/'+ (d.getFullYear() + 543);
	    
		getAjax($plRoute+'/getOnLoad','get',{userId:$('#userId_portlet').val()},function(rs){
			console.log(rs);
			setCssTableRespornsive();
			$host = rs.host;
			$current_year = parseInt(rs.currentDate.split("-")[2])+543;
			$current_date = rs.currentDate.split("-")[0]+'/'+rs.currentDate.split("-")[1]+'/'+$current_year;
			$('#case_stage_actualDate').text($current_date);
			getDatePicker('.datepicker');
	
			var html_temp = '';
			$.each(rs.province,function(){
				html_temp +='<option value="'+this.province_id+'">'+this.province_name+'</option>';
			}); $('#patient_province').append(html_temp);
			
			$html_procedure = '';
			$.each(rs.medicalProcedure,function(){
				$html_procedure +='<option value="'+this.procedure_id+'">'+this.procedure_name+'</option>';
			}); $('.procedure').append($html_procedure);

			$html_doctor = '';
			$.each(rs.doctor,function(){
				$html_doctor +='<option value="'+this.doctor_id+'">'+this.doctor_name+'</option>';
			}); $('.doctor').append($html_doctor );
			
			$html_social = '';
			$.each(rs.socialMedia,function(){
				$html_social +='<option value="'+this.social_media_id+'">'+this.social_media_name+'</option>';
			}); $('.social').append($html_social);
			
			$html_caseType = '';
			$.each(rs.caseType,function(){
				$html_caseType +='<option value="'+this.case_type_id+'">'+this.case_type+'</option>';
			}); $('.casetype').append( $html_caseType);
			
			$html_caseGroup = '';
			$.each(rs.casegroup,function(){
				$html_caseGroup +='<option value="'+this.case_group_id+'">'+this.case_group+'</option>';
			}); $('.caseGroup').append( $html_caseGroup);
			
			$html_discountType = '';
			$.each(rs.discountType,function(){
				$html_discountType +='<option value="'+this.discount_type_id+'">'+this.discount_type_name+'</option>';
			}); $('.discount').append( $html_discountType );
			
			html_temp = '';
			$.each(rs.nationality,function(){
				html_temp +='<option value="'+this.nationality_id+'">'+this.nationality_name+'</option>';
			}); $('.nationality').append( html_temp );
			
			$html_pr = '';
			$.each(rs.pr,function(){
				$html_pr +='<option value="'+this.pr_id+'">'+this.pr_desc+'</option>';
			}); $('.pr').append( $html_pr );
			
			$html_appointment = '';
			$.each(rs.appointmentType,function(){
				$html_appointment +='<option value="'+this.appointment_type_id+'">'+this.appointment_type_name+'</option>';
			}); $('.appointment').append( $html_appointment );

			html_temp = '';
			$.each(rs.usageType,function(k,v){
				html_temp += "<div class='span5 coordinate_group dump-multiselect'><label>"+v.usage_type_name+"</label><select data-usageType_id='"+v.usage_type_id+"' class='multiple case_coordinate' multiple='multiple'>";
				$.each(v.usage_item,function(){
					html_temp +='<option value="'+this.usage_id+'">'+this.usage_name+'</option>';
				});	html_temp +="</select></div>"	;	
			}); 
			
			$html_articleType = '';
			$.each(rs.articleType,function(){
				$html_articleType +='<option value="'+this.article_type_id+'">'+this.article_type_name+'</option>';
			}); $('.article').append( $html_articleType );
			
			$html_temp = '';
			$.each(rs.getUserAlert,function(){
				$html_temp +='<option data-email="'+this.emailAddress+'" value="'+this.userId+'">'+this.screenName+'</option>';
			});	$('#case_stage_notification').append( $html_temp );
			
			$('#case_coordinate .content_field').append( html_temp );
			$('.multiple').multiSelect();
			$('.datepicker').keydown(function(e){e.preventDefault();});
			$('#case_stage_notification').multiselect({
		        includeSelectAllOption: false,
		        maxHeight: 200
		    });
		});
		
		$('#btn_search').click(function(){	getList(1);  });
		$('#countPaginationBottom').change(function(){	getList(1);  });
		
		$('body').on('click','.add_procedure', function () {
			clearAll();
			$('#modalAdd').modal({	backdrop: 'static', keyboard: false	});
			$.ajax({
				url:$plRoute+'/getOnePatient',
				type : 'GET',
				dataType : "json",
				data : {patient_id:$(this).data('patient_id')},
				async:true,
				headers:{Authorization:"Bearer "+tokenID.token},
				success : function(rs) {
					console.log(rs,'.add_procedure');
					if(rs){
						pushData_patient(rs);
						if(rs.social) pushData_socialMedia(rs.social);
						if(rs.surgery) pushData_sugery(rs.surgery);
						$('#case_stage').data('stage_id',1);
						getNewCaseStage();
						$('.btn-action').hide();
						checkRoleAuthurize(1,function(){ 
							$('#case_file').find('.btn-action').hide(); 
							$('#patient_case').find('.btn-collapse').not('.open').click();
							$('.patientSubmit').removeClass('show');
						});
					}
				}
			});
		}); 
		
		$('body').on('click','#addCase', function () {
			clearAll();
			$('#modalAdd').modal({	backdrop: 'static', keyboard: false	});
			$('#case_stage').data('stage_id',1);
			getNewCaseStage();
			$('.btn-action').hide();
			checkRoleAuthurize(1,function(){ 
				$('#case_file').find('.btn-action').hide(); 
				$('#patient_case').find('.btn-collapse').not('.open').click();
				$('.patientSubmit').addClass('show');
			});
		});
		
		/* edit case */
		$('body').on('click','.edit-list',function(){		
			clearAll();
			$('#modalAdd').modal({	backdrop: 'static', keyboard: false	});
			$.ajax({
				url:$plRoute+'/getOneCase',
				type:"GET",
				dataType:"json",
				data:{case_id:$(this).closest('.case_list').data('id')},
				headers:{Authorization:"Bearer "+tokenID.token},
				async:true,
				success:function(rs){
					console.log(rs,'.edit');
					if(rs){
						if(rs.patient){
							pushData_patient(rs.patient);
							pushData_patientCase(rs);
							$('#review_image img').attr('src',$host+rs.patient.image_path);
							if(rs.patient.social) 	pushData_socialMedia(rs.patient.social);
							if(rs.patient_surgery) 	pushData_sugery(rs.patient_surgery);
							
							if(rs.case_social_media)pushData_caseSocialMedia(rs.case_social_media);
							if(rs.case_follow_up) 	pushData_caseFollowup(rs.case_follow_up);
							if(rs.case_price)		pushData_casePrice(rs.case_price);
							if(rs.case_coordinate)	pushData_caseCoordinate(rs.case_coordinate);
							if(rs.case_appointment)	pushData_caseAppointment(rs.case_appointment);
							if(rs.case_contract)	pushData_caseContact(rs.case_contract);
							if(rs.case_pr)			pushData_casePr(rs.case_pr);
							if(rs.folder)			getFolder(rs.folder);
							if(rs.case_article)		pushData_caseArticle(rs.case_article);
							if(rs.caseStageHistory)	pushData_workFlow(rs.caseStageHistory);
							if(rs.case_stage) {
								console.log(rs.case_stage,'rs.caseStage');
								$('#case_stage').data('id',rs.case_stage.case_stage_id).data('stage_id',rs.case_stage.to_stage_id);
								getCurrentStage(rs.case_stage.case_stage_id,'#case_stage_fromStage');
								getToStage(rs.case_stage.to_stage_id);
							}
						}
					}
					$('.case_coordinate').attr('disabled','disabled').multiselect("refresh");
					$('.input_control').attr('disabled','disabled');
					$('.btn-action').hide();
					checkRoleAuthurize(rs.case_stage.to_stage_id);
				},error : function(rs){
					console.log(rs,'edit error');	
				}
			});
		});

		
		function getNewCaseStage(){
			$.ajax({
				url:$plRoute+'/getNewCaseStage',
				type:"GET",
				dataType:"json",
				data:'',
				headers:{Authorization:"Bearer "+tokenID.token},
				async:true,
				success:function(rs){
					console.log(rs);
					if(rs)  $('#case_stage_fromStage,#case_stage_toStage').html('<option selected data-status="'+rs.stage_name+'" value="'+rs.stage_id+'">'+rs.stage_name+'</option>');
				}
			});
		}
		
		function checkRoleAuthurize(stage_id,callback){
			$.ajax({
				url: $plRoute+'/sectionRole',
				type : 'GET',
				dataType : "json",
				data : {stage_id : stage_id},
				async:true,
				headers:{Authorization:"Bearer "+tokenID.token},
				success : function(rs) {
					console.log(rs,'checkRoleAuthurize');
					$.each(rs.section,function(){
						if(this.section_id == 'patient' || this.section_id == 'patient_case' || this.section_id == 'case_coordinate'){
							if(this.add_flag == 1 && this.edit_flag == 1){
								$('#'+this.section_id).find('.input_control').removeAttr('disabled');
								$('#'+this.section_id).find('.case_coordinate').removeAttr('disabled').multiselect("refresh");
							}
						}
						if(this.add_flag == 1)		$('#'+this.section_id).find('.modal-add,.btn-other').show();
						if(this.edit_flag == 1)		$('#'+this.section_id).find('.modal-edit,.btn-edit').show();
						if(this.delete_flag == 1)	$('#'+this.section_id).find('.btn-delete').show();
						
						if(this.upload_flag == 1)	$('#'+this.section_id).find('.btn-upload').show();
						if(this.download_flag == 1)	$('#'+this.section_id).find('.btn-download').show();
						
						if(this.add_flage == 1 || this.edit_flag == 1 || this.delete_flag == 1){
							$('#'+this.section_id).find('.btn-collapse').not('.open').click();
						}
						
					});
					$('body .notHide').show();
					if(!$.isEmptyObject(rs.stageRole)){
						if($.inArray(rs.stageRole.role_id, rs.userRole)!= -1){
							$('#case_stage').find('.input_control').removeAttr('disabled');
						}else{
							$('#case_stage').find('.input_control').attr('disabled',true);
						}
					} 
					 
					 /* check -> MP Social Media role(22312)*/
					if($.inArray(22312, rs.userRole)== -1){
						$('#case_social_media').find('.case_social_media_username,.case_social_media_password').hide();
						$('#case_social_media').find('.modal-add,.modal-edit,.btn-edit').hide();
						$('#case_social_media').find('.btn-collapse.open').click();
					}
					$('#case_stage_notification').multiselect("refresh");
					if(callback) callback();
				}
			});
		}
		
		$('.num').keydown(function(e){
			 if ($.inArray(e.key, ['0','1','2','3','4','5','6','7','8','9'])== -1){e.preventDefault()};
		});
		
		$('#followupSubmit').click(function(){
			var followup = [];
			$('#case_followup table tbody tr').each(function(i,v){
				followup.push({
					followup_id		:$(this).data('id')?$(this).data('id'):'',
					case_id			:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
					procedure_id	:$(this).find('.case_followup_procedure').val(),
					followup_year 	:$(this).find('.case_followup_year').val(),
					remark 			:$(this).find('.case_followup_remark').val()
				});
			});
			console.log(followup,'data followup');
			$.ajax({
				url: $plRoute+'/cuFollowup',
				type : 'POST',
				dataType : "json",
				data : {case_id:$("#patient_case").data('id'),case_followup:followup},
				async:false,
				headers:{Authorization:"Bearer "+tokenID.token},
				success : function(rs) {
					console.log(rs,'followup');
					if(rs.status = 200){
						pushData_caseFollowup(rs.data);
						$("#case_followup").find('.del_rec').show();
						$("#case_followup").find('.modal-edit').trigger('click');
			    		callFlashSlide('สำเร็จ!!  บันทึกข้อมูลเรียบร้อย','success');
					}else{
						callFlashSlide('เกิดข้อผิดพลาด !!  ไม่สามารถบันทึกข้อมูลได้','error');
					}
			    }
			});
		});
		
		$('.btnModalSubmit').click(function(){
			var FormAllData = new FormData();
			$data = [];
			$case_id = $('#case_stage').data('id');
			getData_patient();
			getData_patientCase();
			getData_patientSocial();
			getData_patientSurgery();
			getData_caseFollowup();
			getData_casePrice();
			getData_caseSocial();
			getData_caseCoordinate();
			getData_caseAppointment();
			getData_caseContact();
			getData_casePr();
			getData_caseArticle();
			getData_caseStage(); 

			$('.storeFile').each(function() {
				var id = this.id;
				if(this.files){
					$.each(this.files,function(i,v){
						console.log(this);
						FormAllData.append(id+'[]',this);
					});
				}
			});
			FormAllData.append('formdata', JSON.stringify($data));

			console.log($data,'data');
			$.ajax({
			    url:$plRoute+'/cu',
			    type:'POST',
			    data: FormAllData,
			    cache: false,
			    dataType: 'json',
			    content:"application/json",
			    processData: false, // Don't process the files
			    contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			    headers:{Authorization:"Bearer "+tokenID.token},
			    success: function(rs) {
			    	console.log(rs,'rs cu');
			    	if(rs.status==200){
			    		callFlashSlide('บันทึกข้อมูลสำเร็จ','success');
			    		getList(1);
			    		$('#modalAdd').modal('hide');
			    	}else if(rs.status==400){
			    		callFlashSlide('ไม่สามารถบันทึกข้อมูลได้!!  กรุณาตรวจสอบข้อมูล','error');
			    		validatetorInformation(validatetor(rs.errors));
			    	}
			    },
			    error:function(rs){
			    	console.log('error',rs);
			    }
			}); 
		});
		
		$('#case_stage_toStage').change(function(){
			var html_send_to = '<option value="">-- เลือกส่งถึง --</option>';
			if($(this).val()!=''){
				getAjax($plRoute+'/sendTo','get',{stage_id:$(this).val()},function(rs){
					console.log(rs,'action #case_stage_toStage');
					if(rs.length > 0){
						$.each(rs,function(){
							html_send_to +='<option data-email="'+this.emailAddress+'" value="'+this.userId+'">'+this.screenName+'</option>';
						}); 
					}
				})
			}else{
				html_send_to ='<option data-email="'+'mail'+'" value="'+userId+'">'+screenName+'</option>';
			}
			$('#case_stage_toUser').html(html_send_to);
		});
		
		$('body').on('change','.surgery_year',function(){
			$(this).closest('tr').find('.surgery_lengthYear').text($current_year-($(this).find('option:selected').text()));
		});
		
		$('body').on('click','.stage_upload_img',function(){
			if($(this).hasClass('active')){
				$(this).removeClass('active');
			}else{
				$(this).addClass('active');
			}
		});
		$('#btn_case_stage_upload').click(function(){
			$('#addImage .wrap,#case_stage_upload').html('');
			getAjax($plRoute+'/getCaseFile','get',{case_id:$('#patient_case').data('id')},function(rs){
				console.log(rs);
				var html = '<ul class="thumbnails">';
				if(rs){
					$.each(rs,function(){
						var fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
						if(fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg'){
			  				html +='<li class="span6">'
							    +'<a onclick="return false;" data-imagepath="'+this.image_path+'" data-name="'+this.file_name+'" class="stage_upload_img thumbnail">'
							      +'<img src="'+$host+this.image_path+'" alt=""></a></li>';
						}
					});
				}	$('#addImage .wrap').html(html+'</ul>');
			});
		});
		$('#btnSubmitAddImage').on('click',function(){
			$('#addImage .stage_upload_img.active').each(function(i,v){
				//console.log(this.data('imagePath'));
				$('#case_stage_upload').append('<div class="case_stage_upload_img" data-imagepath ="'+$(this).data('imagepath')+'">'+$(this).data('name')+'</div>');
			})
			$('#addImage .wrap').html('');
			$('#addImage').modal('hide');
		});

		$('body').on('click','.type-png,.type-jpg,.type-jpeg',function(){
			$('#review_image img').attr('src',$host+$(this).data('path'));
		});
		
		function timeHour() {
			var hrmlHour = '';
				hrmlHour +='<option value="00">00</option>';
				hrmlHour +='<option value="01">01</option>';
				hrmlHour +='<option value="02">02</option>';
				hrmlHour +='<option value="03">03</option>';
				hrmlHour +='<option value="04">04</option>';
				hrmlHour +='<option value="05">05</option>';
				hrmlHour +='<option value="06">06</option>';
				hrmlHour +='<option value="07">07</option>';
				hrmlHour +='<option value="08">08</option>';
				hrmlHour +='<option value="09">09</option>';
				hrmlHour +='<option value="10">10</option>';
				hrmlHour +='<option value="11">11</option>';
				hrmlHour +='<option value="12">12</option>';
				hrmlHour +='<option value="13">13</option>';
				hrmlHour +='<option value="14">14</option>';
				hrmlHour +='<option value="15">15</option>';
				hrmlHour +='<option value="16">16</option>';
				hrmlHour +='<option value="17">17</option>';
				hrmlHour +='<option value="18">18</option>';
				hrmlHour +='<option value="19">19</option>';
				hrmlHour +='<option value="20">20</option>';
				hrmlHour +='<option value="21">21</option>';
				hrmlHour +='<option value="22">22</option>';
				hrmlHour +='<option value="23">23</option>';
			return hrmlHour;
		}
		
		function timeMinute() {
			var htmlHour = '';
				htmlHour +='<option value="00">00</option>';
				htmlHour +='<option value="01">01</option>';
				htmlHour +='<option value="02">02</option>';
				htmlHour +='<option value="03">03</option>';
				htmlHour +='<option value="04">04</option>';
				htmlHour +='<option value="05">05</option>';
				htmlHour +='<option value="06">06</option>';
				htmlHour +='<option value="07">07</option>';
				htmlHour +='<option value="08">08</option>';
				htmlHour +='<option value="09">09</option>';
				htmlHour +='<option value="10">10</option>';
				htmlHour +='<option value="11">11</option>';
				htmlHour +='<option value="12">12</option>';
				htmlHour +='<option value="13">13</option>';
				htmlHour +='<option value="14">14</option>';
				htmlHour +='<option value="15">15</option>';
				htmlHour +='<option value="16">16</option>';
				htmlHour +='<option value="17">17</option>';
				htmlHour +='<option value="18">18</option>';
				htmlHour +='<option value="19">19</option>';
				htmlHour +='<option value="20">20</option>';
				htmlHour +='<option value="21">21</option>';
				htmlHour +='<option value="22">22</option>';
				htmlHour +='<option value="23">23</option>';
				htmlHour +='<option value="24">24</option>';
				htmlHour +='<option value="25">25</option>';
				htmlHour +='<option value="26">26</option>';
				htmlHour +='<option value="27">27</option>';
				htmlHour +='<option value="28">28</option>';
				htmlHour +='<option value="29">29</option>';
				htmlHour +='<option value="30">30</option>';
				htmlHour +='<option value="31">31</option>';
				htmlHour +='<option value="32">32</option>';
				htmlHour +='<option value="33">33</option>';
				htmlHour +='<option value="34">34</option>';
				htmlHour +='<option value="35">35</option>';
				htmlHour +='<option value="36">36</option>';
				htmlHour +='<option value="37">37</option>';
				htmlHour +='<option value="38">38</option>';
				htmlHour +='<option value="39">39</option>';
				htmlHour +='<option value="40">40</option>';
				htmlHour +='<option value="41">41</option>';
				htmlHour +='<option value="42">42</option>';
				htmlHour +='<option value="43">43</option>';
				htmlHour +='<option value="44">44</option>';
				htmlHour +='<option value="45">45</option>';
				htmlHour +='<option value="46">46</option>';
				htmlHour +='<option value="47">47</option>';
				htmlHour +='<option value="48">48</option>';
				htmlHour +='<option value="49">49</option>';
				htmlHour +='<option value="50">50</option>';
				htmlHour +='<option value="51">51</option>';
				htmlHour +='<option value="52">52</option>';
				htmlHour +='<option value="53">53</option>';
				htmlHour +='<option value="54">54</option>';
				htmlHour +='<option value="55">55</option>';
				htmlHour +='<option value="56">56</option>';
				htmlHour +='<option value="57">57</option>';
				htmlHour +='<option value="58">58</option>';
				htmlHour +='<option value="59">59</option>';
			return htmlHour;
		}
		
		
		function getCurrentStage(case_stage_id,target){
			$.ajax({
				url: $plRoute+'/getStage',
				type : 'GET',
				dataType : "json",
				data : {case_stage_id:case_stage_id},
				async:true,
				headers:{Authorization:"Bearer "+tokenID.token},
				success : function(rs) {
					console.log(rs,'current Stage');
					$(target).html('<option selected data-status="'+rs.to_stage.stage_name+'" value="'+rs.to_stage.stage_id+'">'+rs.to_stage.stage_name+'</option>');
				},error:function(){ console.log('error -> getCurrentStage'); }		
			});
		}
		
		function getToStage(current_stage){
			$.ajax({
				url: $plRoute+'/action_to',
				type : 'GET',
				dataType : "json",
				data : {stage_id:current_stage},
				async:true,
				headers:{Authorization:"Bearer "+tokenID.token},
				success : function(rs) {
					console.log(rs,'getStage');
					var html_stage_to = '<option data-status="" value="">บันทึกฉบับร่าง</option>';
					if(rs.length > 0){
						$.each(rs,function(){
							html_stage_to +='<option data-status="'+this.status+'" value="'+this.stage_id+'">'+this.stage_name+'</option>';
						}); 
						//$('#case_stage').find('.input_control').removeAttr('disabled');
						$('#case_stage_toStage').html(html_stage_to);
					}
				}
			})
		}
		
		function pushData_patient(data){
			$('#profileImage').attr('src',$host+data.image_path);
			$('#patient').data('id',data.patient_id);
			$('#patient_hnNo').val(data.hn_no);
			$('#patient_name').val(data.patient_name);
			$('#patient_nickName').val(data.nick_name);
			$('#patient_birthDate').val(paresDateToDate(data.birthday)).change();
			$('#patient_nationality').val(data.nationality_id);
			$('#patient_gender').val(data.gender);
			$('#patient_idCard').val(data.id_card);
			$('#patient_homeNo').val(data.home_no);
			$('#patient_moo').val(data.moo);
			$('#patient_career').val(data.career);
			$('#patient_soi').val(data.soi);
			$('#patient_road').val(data.road);
			$('#patient_mobile').val(data.mobile_no);
			$('#patient_telNo').val(data.telephone_no);
			$('#patient_province').val(data.province_id).change();
			$('#patient_amphur').val(data.amphur_id).change();
			$('#patient_district').val(data.district_id).change();
		}
		function pushData_socialMedia(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.patient_media_id+'">'
					+'<td><select class="patient_social_media_type social input_control">'
						+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_social+'</select></td>'
					+'<td><input type="text" value="'+this.user_link+'" class="patient_social_media_link input_control"><a href="'+this.user_link+'" target="_blank" class="pull-right">ลิงค์</a></td>'
					+'<td><input type="number" value="'+this.n_of_follwer+'" class="patient_social_media_follow input_control"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" style="display:none"><i class="fa fa-trash"></i></button></td></tr>';
				$('#patient_social_media tbody').append($html);
				getBasicData($('#patient_social_media tbody'));
				$('#patient_social_media tbody tr:last-child').find('.social').val(this.social_media_id);
			});
		};
		function pushData_sugery(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.history_id+'">'
					+'<td><select class="surgery_year reverse_year input_control">'
						+'<option value=""> ---- เลือกปี ---- </option>'+getyear($current_year-30,$current_year+1)+'</select></td>' 
					+'<td><div class="surgery_lengthYear">0</div></td>' 
					+'<td><input type="text" class="surgery_clinic input_control" value="'+this.clinic_name+'"></td>'
					+'<td><input class="surgery_doctor input_control"  value="'+this.doctor_name+'"></td>'
					+'<td><input class="surgery_procedure input_control" value="'+this.history_name+'"></td>'
					+'<td><input type="text" class="surgery_remark input_control" value="'+this.remark+'"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" style="display:none" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#surgery_history tbody').append($html);
				getBasicData($('#surgery_history tbody'));
				$('#surgery_history tbody tr:last-child').find('.surgery_year').val(this.surgery_year);
				$('#surgery_history tbody tr:last-child').find('.surgery_lengthYear').text($current_year-(this.surgery_year+543));
			});
		};
		function pushData_patientCase(data){
			$('#patient_case').data('id',data.case_id);	
			$('#patient_case_suggesGroup').val(data.suggest_group);
			$('#patient_case_suggestedBy').val(data.suggested_by);	
			$('#patient_case_caseType').val(data.case_type.case_type_id);
			$('#patient_case_caseGroup').val(data.case_group.case_group_id);
			$('#patient_case_vn').val(data.vn_no);
			$('#patient_case_procedure').val(data.procedure.procedure_id);	
			$('#patient_case_doctor').val(data.doctor.doctor_id);
			$('#patient_case_isGood').prop('checked',data.is_good_case);
			$('#patient_case_isBad').prop('checked',data.is_bad_case);
			$('#patient_case_isGoodReview').prop('checked',data.is_good_review);
			$('#patient_case_remark').val(data.remark);
			$html = '';
			$.each(data.case_supervised,function(){
				$html  += '<div data-user="'+this.supervised_id+'" class="bubble patient_case_supervisedBy alert-info">'
							+this.user.firstName+'  '+this.user.lastName
							+'<a onclick="return false;" class="fa fa-times-circle remove_bubble btn-delete btn-action  remove_supervisedBy"></a>'
							+'</div>';
			});
			$('.view_supervisedBy').append($html);
		};
		function pushData_caseFollowup(data){
			$('#case_followup tbody').html('');
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.followup_id+'">'
						+'<td><select class="case_followup_procedure procedure input_control">'
							+'<option value=""> ---- เลือกหัตถการ ---- </option>'+$html_procedure+'</select></td>'
						+'<td><select class="case_followup_year next_year input_control">'
							+'<option value=""> ---- เลือกปี ---- </option>'+getyear($current_year,$current_year+10)+'</select></td>'
						+'<td><input type="text" class="case_followup_remark input_control" value="'+this.remark+'" placeholder="หมายเหตุ"></td>'
						+'<td><button class="btn btn-danger del_rec btn-delete btn-action"  style="display:none"><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_followup tbody').append($html);
				getBasicData($('#case_followup tbody'));
				$('#case_followup tbody tr:last-child').find('.case_followup_procedure').val(this.procedure_id);
				$('#case_followup tbody tr:last-child').find('.case_followup_year').val(this.followup_year);
			});
		};
		function pushData_casePrice(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.price_id+'">'
							+'<td><select class="case_price_type discount input_control">'
								+'<option value=""> ---- เลือกประเภทส่วนลด ---- </option>'+$html_discountType+'</select></td>'
							+'<td><input type="number" class="case_price_offer input_control" value="'+this.offer_price+'"></td>'
							+'<td><input type="number" class="case_price_accept input_control" value="'+this.accept_price+'"></td>'
							+'<td><div class="case_price_percent input_control">0</div></td>'
							+'<td><div class="case_price_value input_control">0</div></td>'
							+'<td><input type="text" class="case_price_remark input_control" value="'+this.remark+'"></td>'
							+'<td><button class="btn btn-danger del_rec btn-delete btn-action" style="display:none" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_price tbody').append($html);
				getBasicData($('#case_price tbody'));
				$('#case_price tbody tr:last-child').find('.case_price_accept').keyup()
				$('#case_price tbody tr:last-child').find('.case_price_type').val(this.discount_type_id);
			});
		};
		
		function pushData_caseSocialMedia(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.case_media_id+'"> '
					+'<td><select class="case_social_media_social social input_control"> '
						+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_social+'</select></td> '
					+'<td><input type="text" class="case_social_media_link input_control" value="'+this.link+'"><a href="'+this.link+'" target="_blank" class="pull-right">ลิงค์</a></td>'
					+'<td><input type="text" class="case_social_media_username input_control" value="'+this.usr_name+'"></td>'
					+'<td><input type="text" class="case_social_media_password input_control" value="'+this.pwd+'"></td>'
					+'<td><input type="text" class="case_social_media_remark input_control" value="'+this.note+'"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action"  style="display:none"><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_social_media tbody').append($html);
				getBasicData($('#case_social_media tbody'));
				$('#case_social_media tbody tr:last-child').find('.case_social_media_social').val(this.social_media_id);
			});
		};
		
		function pushData_caseCoordinate(data){
			var coordinate  = [];
			$.each(data,function(){
				coordinate.push(this.usage_id);
			});
			$('.case_coordinate').val(coordinate).multiselect("refresh");
			
		};
		
		function pushData_caseAppointment(data){
			$.each(data,function(){
				console.log(paresDateToDate(this.appointment_date.split(' ')[0])+' '+this.appointment_date.split(' ')[1],'pushData_caseAppointment');
				$html = '<tr data-id="'+this.appointment_id+'"></td> '
					+'<td><select class="case_appointment_type appointment input_control">'
						+'<option value=""> ---- เลือก ---- </option>'+$html_appointment+'</select></td> '
					+'<td><input type="text" class="case_appointment_date datetimepicker input_control" value="'+paresDateToDate(this.appointment_date.split(' ')[0])+'" style="width:30%;"> เวลา <select class="case_appointment_timeH input_control" style="width: 22% !important;">"'+timeHour+'"</select> : <select class="case_appointment_timeM input_control" style="width: 22% !important;">"'+timeMinute+'"</select></td>'
					+'<td><select class="case_appointment_doctor doctor input_control">'
						+'<option value=""> ---- เลือกหมอ ---- </option>'+$html_doctor+'</select></td>'
					+'<td><input class="case_appointment_supervised  input_control" type="text" ></td>'
					+'<td><label class="label-control"><input class="case_appointment_isVdoProduct" type="checkbox"> ถ่าย VDO</label>'
						+'<label class="label-control"><input class="case_appointment_isVdoRh" type="checkbox"> RH VDO</label>'
						+'<label class="label-control"><input class="case_appointment_isPictureProduct" type="checkbox"> ถ่ายภาพ</label>'
						+'<label class="label-control"><input class="case_appointment_isPictureRh" type="checkbox"> RH ถ่ายภาพ</label>'
						+'<label class="label-control"><input class="case_appointment_isMeetDoctor" type="checkbox"> พบแพทย์</label></td>'
					+'<td><input class="case_appointment_remark input_control" type="text" value="'+this.remark+'"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" style="display:none" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_appointment tbody').append($html);
				getBasicData($('#case_appointment tbody'));
				getDateTimePicker('#case_appointment tbody tr:last-child .datetimepicker');
				$('#case_appointment tbody tr:last-child').find('.case_appointment_timeH').val(this.appointment_date.split(' ')[1].substr(0, 2));
				$('#case_appointment tbody tr:last-child').find('.case_appointment_timeM').val(this.appointment_date.split(':')[1]);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_type').val(this.appointment_type_id);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_doctor').val(this.doctor_id);
				if(this.supervised_by){
					$('#case_appointment tbody tr:last-child').find('.case_appointment_supervised').val(this.supervised_by.firstName+'  '+this.supervised_by.lastName).data('user',this.supervised_by.userId);
				}
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isVdoProduct').prop('checked',this.is_vdo_product);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isVdoRh').prop('checked',this.is_vdo_rh);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isPictureProduct').prop('checked',this.is_picture_product);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isPictureRh').prop('checked',this.is_picture_rh);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isMeetDoctor').prop('checked',this.is_meet_doctor);
				
			});
		};
		function getDatePicker(selector){
			$(selector).datepicker({
				format: 'dd/mm/yyyy',
	            language: 'th',            
	            thaiyear: true              
	        }).keydown(function(e){e.preventDefault();});
		}
		function getDateTimePicker(selector){
			$(selector).datepicker({
				format: 'dd/mm/yyyy',
	            language: 'th',            
	            thaiyear: true              
	        }).keydown(function(e){e.preventDefault();});
		}
		function pushData_caseContact(data){	
			$.each(data,function(i,v){
				$html = '<tr data-id="'+this.contract_id+'">'
					+'<td><div class="case_contract_no no">'+(i+1)+'</div></td>'
					+'<td><select class="case_contract_procedure procedure input_control">'
						+'<option value=""> ---- เลือกหัตถการ ---- </option>'+$html_procedure+'</select></td>'
					+'<td><input type="text" class="case_contract_startDate datepicker input_control"  value="'+paresDateToDate(this.contract_start_date)+'" readonly></td>'
					+'<td><input type="text" class="case_contract_endDate datepicker input_control" value="'+paresDateToDate(this.contract_end_date)+'" readonly>'
						+'<hr class="hr1"><div class="text-center">เหลือเวลา <span class="remaining_days">0</span> วัน</div></td>'
					+'<td><label class="label-control"><input class="case_contract_isPost" type="checkbox"> 		โพสรีวิว				</label>'
						+'<label class="label-control"><input class="case_contract_isUsage"	type="checkbox"> 		อนุญาตให่้่ใช้รูปภาพและVDO	</label>'
						+'<label class="label-control"><input class="case_contract_isPicture_vdo" type="checkbox"> 	ถ่ายภาพและVDO		</label>'
						+'<label class="label-control"><input class="case_contract_isReview" type="checkbox"> 		เขียนReview		</label>'
						+'<label class="label-control"><input class="case_contract_isPr" type="checkbox">				 ช่วยประชาสัมพันธ์ข่าว		</label>'
						+'<label class="label-control"><input class="case_contract_isGroupPost" type="checkbox"> 		โพสรีวิวในกลุ่มศัลยกรรม		</label>'
						+'<label class="label-control"><input class="case_contract_isSendPicture" type="checkbox"> 	ส่งรูปภาพ			</label>'
						+'<label class="label-control"><input class="case_contract_isOther" 	type="checkbox"> 		อื่นๆ				</label></td>'
					+'<td><input class="case_contract_upload storeFile input_control" multiple type="file" ></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" style="display:none"><i class="fa fa-trash"></i></button></td>'
					+'<input class="case_contract_file_name_check" type="hidden"></tr>';
				$('#case_contract tbody').append($html);
				getBasicData($('#case_contract tbody'));
				getDatePicker('#case_contract tbody tr:last-child .datepicker');
				$('#case_contract tbody tr:last-child').find('.case_contract_procedure').val(this.procedure_id);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPost')		.prop('checked',this.is_post);
				$('#case_contract tbody tr:last-child').find('.case_contract_isUsage')		.prop('checked',this.is_usage);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPicture_vdo').prop('checked',this.is_picture_vdo);
				$('#case_contract tbody tr:last-child').find('.case_contract_isReview')		.prop('checked',this.is_review);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPr')			.prop('checked',this.is_pr);
				$('#case_contract tbody tr:last-child').find('.case_contract_isGroupPost')	.prop('checked',this.is_group_post);
				$('#case_contract tbody tr:last-child').find('.case_contract_isSendPicture').prop('checked',this.is_send_picture);
				$('#case_contract tbody tr:last-child').find('.case_contract_isOther')		.prop('checked',this.is_other);
				$('#case_contract tbody tr:last-child').find('.case_contract_endDate').change();
				if(this.case_contract_doc!=null){
					$.each(this.case_contract_doc,function(){
						var fileName = '';
						if(this.contract_path)  fileName = this.contract_path.split("/").slice(-1)[0];
						$html = '<div data-id="'+this.case_contract_doc_id+'" style="width:max-content;padding:3px;margin-top:10px" class="bg-info file_download">'
							+'<a href="'+$host+this.contract_path+'" target="_blank" class="fa fa-file ">  '+fileName+'</a> '
							+'<a href="#" onclick="return false;" class="fa fa-times-circle remove_file btn-action btn-delete"></a></div>';
						$('#case_contract tbody tr:last-child').find('.case_contract_upload').parent().append($html);
					});
				}
			});
		};
		
		function pushData_casePr(data){	
			$.each(data,function(){
				$html = '<tr  data-id="'+this.case_pr_id+'">'
							+'<td><select class="case_pr_pr pr input_control">'
								+'<option value=""> ---- เลือกรายการประชาสัมพันธ์ ---- </option>'+$html_pr+'</select></td>'
							+'<td><input type="text" class="case_pr_planDate datepicker input_control" value="'+paresDateToDate(this.pr_plan_date)+'" readonly></td>'
							+'<td><label><input type="checkbox" class="case_pr_isPicture input_control"> รูปภาพ</label> 		  ' 
								+'<label class="label-control"><input type="checkbox" class="case_pr_isVdo input_control"> วีดีโอ(selfie)</label>'
								+'<label class="label-control"><input type="checkbox" class="case_pr_isInstragram input_control"> live Instragram</label> '   
								+'<label class="label-control"><input type="checkbox" class="case_pr_isFacebook input_control"> live Facebook</label></td>'
							+'<td><input type="text" class="case_pr_actualDate datepicker input_control" value="'+paresDateToDate(this.pr_actual_date)+'" readonly></td>'
							+'<td><button class="btn btn-danger del_rec btn-delete btn-action"  style="display:none"><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_pr tbody').append($html);
				getBasicData($('#case_pr tbody'));
				getDatePicker('#case_pr tbody tr:last-child .datepicker');
				$('#case_pr tbody tr:last-child').find('.case_pr_pr').val(this.pr_id);
				$('#case_pr tbody tr:last-child').find('.case_pr_isPicture').prop('checked',this.is_picture);
				$('#case_pr tbody tr:last-child').find('.case_pr_isVdo').prop('checked',this.is_vdo);
				$('#case_pr tbody tr:last-child').find('.case_pr_isInstragram').prop('checked',this.is_instragram);
				$('#case_pr tbody tr:last-child').find('.case_pr_isFacebook').prop('checked',this.is_facebook);
				
			});
		};
		
		function pushData_caseArticle(data){	
			$.each(data,function(){
				var writing_end_date = this.writing_end_date?paresDateToDate(this.writing_end_date):'';
				$html = '<tr data-id="'+this.case_article_id+'">'
							+'<td><input class="case_article_name input_control" type="text"  value="'+this.article_name+'"></td>'
							+'<td><select class="case_article_type_id article input_control">'
								+'<option value=""> ---- เลือกรีวิว ---- </option>'+$html_articleType+'</select></td>'
							+'<td><input class="case_article_writer user input_control" type="text" data-user="'+this.writer.userId+'" value="'+this.writer.firstName+' '+this.writer.lastName+'"></td>'
							+'<td><input type="text" class="case_article_writingStartDate datepicker input_control" value="'+paresDateToDate(this.writing_start_date)+'" readonly></td>'
							+'<td><input type="text" class="case_article_writingEndDate datepicker input_control" value="'+writing_end_date+'" readonly></td>'
							+'<td><input type="text" class="case_article_planDate datepicker input_control" value="'+paresDateToDate(this.plan_date)+'" readonly></td>'
							+'<td><input class="case_article_upload storeFile input_control" multiple type="file"></td>'
							+'<td>'
								+'<button class="btn btn-danger del_rec btn-delete btn-action"  style="display:none"><i class="fa fa-trash"></i></button>'
							+'<input class="case_contract_file_name_check" type="hidden"></td></tr>';
				$('#case_article tbody').append($html);
				getBasicData($('#case_article tbody'));
				getDatePicker('#case_article tbody tr:last-child .datepicker');
				$('#case_article tbody tr:last-child').find('.case_article_type_id').val(this.article_type_id);
				console.log(this.case_article_doc);
				if(this.case_article_doc!=null){
					$.each(this.case_article_doc,function(){
						var fileName = '';
						if(this.article_path) fileName = this.article_path.split("/").slice(-1)[0];
						$html = '<div data-id="'+this.case_article_doc_id+'" style="width:max-content;padding:3px;margin-top:10px" class="bg-info file_download">'
							+'<a href="'+$host+this.article_path+'" target="_blank" class="fa fa-file ">  '+fileName+'</a> '
							+'<a href="#" onclick="return false;" class="fa fa-times-circle remove_file"></a></div>';
						$('#case_article tbody tr:last-child').find('.case_article_upload').parent().append($html);
					});
				} 
			});
		};
		
		function pushData_workFlow(data){	
			$.each(data,function(){
				var html_alert = '';
				if(this.alerts.length > 0){
					$.each(this.alerts,function(){
						html_alert +='<div>'+this.screenName+'</div>';
					})
				}
				var to_user_name = this.to_user_name?this.to_user_name:'';
				$html = '<tr data-id="'+this.case_stage_id+'">'
							+'<td><label class="label-control"> &nbsp;'+formatDateDMY(this.created_dttm.split(' ')[0])+' '+this.created_dttm.split(' ')[1]+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+this.from_stage_name	+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+this.from_user_name	+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+this.to_stage_name		+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+to_user_name			+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+this.remark			+'</label></td>'
							+'<td><label class="label-control"> &nbsp;'+html_alert				+'</label></td>'
							+'<td>&nbsp;';
				if(this.docs.length > 0){
					$html += '<center><button type="button" class="btn btn-primary input-sm downloadfileCaseHistory" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
	                '</center></td>';
				}
				$html += '</tr>'
				$('#workflow tbody').append($html);
			});
		};
		
		function clearAll(){
			clearModal();
			$('#list >li > ul,#case_stage_upload').html('');
			$('#case_stage_toUser').html('<option data-email="'+'mail'+'" value="'+userId+'">'+screenName+'</option>');
			$('.bubble').remove();
			$('.wrap').removeData('id').find('tbody').html('');
			$('.btn-action,#information_errors').hide();
			$('.patientSubmit').removeClass('show');
			$('.btn-collapse.open').click();
			$('.input_control').attr('disabled','disabled');
			$('#profileImage,#review_image img').attr('src','');
			$('#case_stage_notification').val('').multiselect("refresh");
			$('.storeFile').val('');
			$('.case_coordinate').attr('disabled','disabled').multiselect("refresh");
			$('#patient_amphur,#patient_district').html('');
		}
		
		/* save patient */
		
		function getData_patient(){
			$data = {
				"patient":{
					"patient_id"	: $("#patient").data("id")?$("#patient").data("id"):'',
				    "hn_no"			: $.trim($("#patient_hnNo").val()),
				    "patient_name"	: $.trim($("#patient_name").val()),
				    "nick_name"		: $.trim($("#patient_nickName").val()),
				    "birthday"		: formatDateYMD($.trim($("#patient_birthDate").val())),
				    "nationality_id": $("#patient_nationality").val(),
				    "gender"		: $("#patient_gender").val(),
				    "id_card"		: $.trim($("#patient_idCard").val()),
				    "home_no"		: $.trim($("#patient_homeNo").val()),
				    "moo"			: $.trim($("#patient_moo").val()),
				    "soi"			: $.trim($("#patient_soi").val()),
				    "road"			: $.trim($("#patient_road").val()),
				    "province_id"	: $("#patient_province").val(),
				    "amphur_id"		: $("#patient_amphur").val(),
				    "district_id"	: $("#patient_district").val(),
				    "mobile_no"		: $.trim($("#patient_mobile").val()),
				    "telephone_no"	: $.trim($("#patient_telNo").val()),
				    "career"		: $.trim($("#patient_career").val()),
			   	}
			}
		}
		function getData_patientSocial(){
			var social = [];
			$('#patient_social_media table tbody tr').each(function(i,v){
				social.push({
					patient_media_id:$(this).data("id")?$(this).data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					social_media_id	:$(this).find('.patient_social_media_type').val(),
					user_link		:$.trim($(this).find('.patient_social_media_link').val()),
					n_of_follwer	:$.trim($(this).find('.patient_social_media_follow').val()),
				});
			});
			$data['social_media'] = social; 
		}
		function getData_patientSurgery(){	
			var surgery = [];
			$('#surgery_history table tbody tr').each(function(i,v){
				surgery.push({
					history_id		:$(this).data("id")?$(this).data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					surgery_year 	:$(this).find('.surgery_year').val(),
					clinic_name		:$.trim($(this).find('.surgery_clinic').val()),
					doctor_name		:$.trim($(this).find('.surgery_doctor').val()),
					history_name	:$.trim($(this).find('.surgery_procedure').val()),
					remark			:$.trim($(this).find('.surgery_remark').val()),
				});
			});
			$data['surgery_history'] = surgery; 
		}
		function getData_patientCase(){
			var supervised = '';
			$('#patient_case .patient_case_supervisedBy').each(function(){
				supervised+='|'+$(this).data('user');
			});
			
			$data['patient_case'] ={
				case_id 		:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
				patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
				procedure_id	:$('#patient_case_procedure').val(),
				case_type_id	:$('#patient_case_caseType').val(),
				case_group_id	:$('#patient_case_caseGroup').val(),
				doctor_id		:$('#patient_case_doctor').val(),
				vn_no			:$.trim($('#patient_case_vn').val()),
				suggest_group	:$.trim($('#patient_case_suggesGroup').val()),
				suggested_by	:$.trim($('#patient_case_suggestedBy').val()),
				supervised_by	:supervised,
				is_good_case	:$('#patient_case_isGood').prop('checked')?1:0,
				is_bad_case		:$('#patient_case_isBad').prop('checked')?1:0,
				is_good_review	:$('#patient_case_isGoodReview').prop('checked')?1:0,
				remark			:$.trim($('#patient_case_remark').val()),
                //stage_id 		:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage').val():$('#case_stage_toStage').val(),
                status 			:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage option:selected').text():$("#case_stage_toStage option:selected").data('status')
			}
		}
		function getData_caseFollowup(){		 
			var followup = [];
			$('#case_followup table tbody tr').each(function(i,v){
				followup.push({
					followup_id		:$(this).data('id')?$(this).data('id'):'',
					case_id			:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
					procedure_id	:$(this).find('.case_followup_procedure').val(),
					followup_year 	:$(this).find('.case_followup_year').val(),
					remark 			:$(this).find('.case_followup_remark').val()
				});
			});
			$data['case_followup'] =followup;
		}
		function getData_casePrice(){		
			var price = [];
			$('#case_price table tbody tr').each(function(i,v){
				price.push({
					price_id 			:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					discount_type_id 	:$(this).find('.case_price_type').val(),
					offer_price 		:$.trim($(this).find('.case_price_offer').val()),
					accept_price 		:$.trim($(this).find('.case_price_accept').val()),
					remark				:$.trim($(this).find('.case_price_remark').val())
				});
			});
			$data['case_price'] =price; 
		}
		function getData_caseSocial(){	
			var channel = [];
			$('#case_social_media table tbody tr').each(function(i,v){
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
			$data['case_social_media'] = channel; 
		}
		function getData_caseCoordinate(){	
			var arr_coordinate = [];
			$.each($('#case_coordinate .case_coordinate'),function(){
				if($(this).val()){
					$.each($(this).val(),function(k,v){ arr_coordinate.push(v);});
				}
			});
			var coordinate = [];
			$.each(arr_coordinate,function(i,v){
				coordinate.push({	
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					usage_id 			:v
				}); 
			});
			$data['case_coordinate'] = coordinate;
		}
		function getData_caseAppointment(){
			var appointment = [];
			$('#case_appointment table tbody tr').each(function(i,v){
				var ori_date = $(this).find(".case_appointment_date").val();
				var ori_timeH = $(this).find(".case_appointment_timeH").val();
				var ori_timeM = $(this).find(".case_appointment_timeM").val();
				var appoint_dateTime = formatDateYMD(ori_date)+' '+ori_timeH+':'+ori_timeM;
				
//				var ori_date = $(this).find(".case_appointment_date").val().split(' ');
//				var appoint_dateTime = formatDateYMD(ori_date[0])+' '+ori_date[1];
				
				appointment.push({
					appointment_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					appointment_type_id :$(this).find(".case_appointment_type").val(),
					appointment_date 	:appoint_dateTime,
					doctor_id 			:$(this).find(".case_appointment_doctor").val(),
					supervised_by		:$(this).find(".case_appointment_supervised").data("user")?$(this).find(".case_appointment_supervised").data("user"):'',
					is_vdo_product 		:$(this).find(".case_appointment_isVdoProduct").prop("checked"),
					is_vdo_rh 			:$(this).find(".case_appointment_isVdoRh").prop("checked"),
					is_picture_product 	:$(this).find(".case_appointment_isPictureProduct").prop("checked"),
					is_picture_rh 		:$(this).find(".case_appointment_isPictureRh").prop("checked"),
					is_meet_doctor 		:$(this).find(".case_appointment_isMeetDoctor").prop("checked"),
					remark 				:$.trim($(this).find('.case_appointment_remark').val())
				});
			});
			$data['case_appointment'] =appointment; 
		}
		function getData_caseContact(){		
			var contract = [];
			$('#case_contract table tbody tr').each(function(i,v){
				contract.push({
					contract_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					procedure_id 		:$(this).find(".case_contract_procedure").val(), 
					contract_start_date	:formatDateYMD($(this).find(".case_contract_startDate").val()), 
					contract_end_date	:formatDateYMD($(this).find(".case_contract_endDate").val()), 
					is_post 			:$(this).find(".case_contract_isPost").prop("checked")==true?1:0,
					is_usage 			:$(this).find(".case_contract_isUsage").prop("checked")==true?1:0,
					is_picture_vdo 		:$(this).find(".case_contract_isPicture_vdo").prop("checked")==true?1:0,
					is_review 			:$(this).find(".case_contract_isReview").prop("checked")==true?1:0,
					is_pr 				:$(this).find(".case_contract_isPr").prop("checked")==true?1:0,
					is_group_post 		:$(this).find(".case_contract_isGroupPost").prop("checked")==true?1:0,
					is_send_picture 	:$(this).find(".case_contract_isSendPicture").prop("checked")==true?1:0,
					is_other 			:$(this).find(".case_contract_isOther").prop("checked")==true?1:0,
					file_name_check 	:$(this).find(".case_contract_file_name_check").val()
				});
			});
			$data['case_contract'] =contract;
		}
		function getData_casePr(){		
			var pr = [];
			$('#case_pr table tbody tr').each(function(i,v){
				pr.push({
					case_pr_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 		:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					pr_id 			:$(this).find(".case_pr_pr").val(), 
					pr_plan_date 	:formatDateYMD($(this).find(".case_pr_planDate").val()), 
					is_picture		:$(this).find(".case_pr_isPicture").prop("checked")==true?1:0,
					is_vdo			:$(this).find(".case_pr_isVdo").prop("checked")==true?1:0,
					is_instragram 	:$(this).find(".case_pr_isInstragram").prop("checked")==true?1:0,
					is_facebook 	:$(this).find(".case_pr_isFacebook").prop("checked")==true?1:0,
					pr_actual_date 	:formatDateYMD($(this).find(".case_pr_actualDate").val()), 
				});
			});
			$data['case_pr'] =pr;
		}
		function getData_caseArticle(){	
			var article = [];
			$('#case_article table tbody tr').each(function(i,v){
				article.push({
					case_article_id 	:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					article_name 		:$.trim($(this).find('.case_article_name').val()),
					article_type_id 	:$(this).find('.case_article_type_id').val(),
					writer				:$(this).find('.case_article_writer').data('user'),
					writing_start_date	:formatDateYMD($(this).find('.case_article_writingStartDate').val()),
					writing_end_date 	:formatDateYMD($(this).find('.case_article_writingEndDate').val()),
					plan_date 			:formatDateYMD($(this).find('.case_article_planDate').val()),
					file_name_check 	:$(this).find(".case_contract_file_name_check").val()
				});
			});
			$data['case_article'] =article;
		}
		function getData_caseStage(){		
			$data['case_stage'] = {
				case_id			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
				from_stage_id	:$('#case_stage_fromStage').val(),
				from_user_id	:userId,
				to_user_id		:$('#case_stage_toUser').val(),
				to_stage_id		:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage').val():$('#case_stage_toStage').val(),
				plan_date		:formatDateYMD($('#case_stage_planDate').val()),
				actual_date		:formatDateYMD($('#case_stage_actualDate').text()),
				status			:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage option:selected').text():$("#case_stage_toStage option:selected").data('status'),
				remark			:$.trim($('#case_stage_remark').val())
			}
			
			var attach_img = [];
			$('body .case_stage_upload_img').each(function(){
				attach_img.push({image_path:$(this).data('imagepath')});
			});
			$data['case_stage']['attach_img'] = attach_img;
			$data['case_stage']['alerts'] = $('#case_stage_notification').val();
		}	
		
		$('body').on('click','.btn-collapse', function(event){
			console.log('click collapse');
			$(this).toggleClass("open");
			$(this).closest('.wrap').find('.content_field').toggleClass("collapse");
		});
		
		$('body').on('click','.del_rec',function(){
			$('#confrimModal').modal('show');
			var thiss = $(this);
			$('#btnConfirmOK').one('click',function(){
				getAjax($plRoute+'/delRec','post',{id:thiss.closest('tr').data('id'),method:thiss.closest('.wrap').attr('id')},function(rs){
					console.log(rs,'del_rec');
					$('#confrimModal').modal('hide');
					if(rs.status == 200){
						thiss.closest('tr').remove();
						callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
					}else{
						callFlashSlide('ไม่สามารถลบไฟล์ได้!!','error');
					}
				});
			});
		});
		
		$('body').on('click','.remove_file', function () {
			var elm_file = $(this).parent();
			$('#confrimModal').modal('show');
			$('#btnConfirmOK').one('click',function(){
				getAjax($plRoute+'/deleteFile','post',{method:elm_file.closest('.wrap').attr('id'),file_id:elm_file.data('id')},function(rs){
					console.log(rs);
					$('#confrimModal').modal('hide');
					if(rs.status == 200){
						elm_file.remove();
						callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
					}else{
						callFlashSlide('ไม่สามารถลบไฟล์ได้!!','error');
					}
				});
			});
		});
		
		$('body').on("click", ".del-tr", function(){ this.closest('tr').remove(); });
			
		$('body').on('click','.modal-edit',function(){
			var elm_parent = $(this).closest('.wrap'); 
			elm_parent.find('.modal-cancel').show();
			$(this).hide();
			elm_parent.find('.input_control').removeAttr('disabled');
			
		});
		$('body').on('click','.modal-cancel',function(){
			var elm_parent = $(this).closest('.wrap'); 
			elm_parent.find('.modal-edit').show();
			$(this).hide();
			elm_parent.find('.input_control').attr('disabled','disabled');
		});
		
		$('#importsubmitForm').on('click',function(){
			var formData = new FormData();
			$.each($('#fileForm').prop('files'),function(i,v){
				formData.append('file[]',this);
			});
			formData.append('folder_id',$('#ModalImportForm .folderList').val());
			formData.append('case_id',$('#patient_case').data('id'));
			$.ajax({
			    url:$plRoute+'/importFile',
			    type:'POST',
			    data: formData,
			    cache: false,
			    dataType: 'json',
			    content:"application/json",
			    processData: false, // Don't process the files
			    contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			    headers:{Authorization:"Bearer "+tokenID.token},
			    success: function(rs) {
			    	console.log(rs);
		    		$('#ModalImportForm').modal('hide');
			    	$('#fileForm').val('');
			    	if(rs.status==200){
			    		callFlashSlide('บันทึกข้อมูลสำเร็จ','success');
			    		getFolder(rs.data);
			    	}else if(rs.status==400){
			    		callFlashSlide('ไม่สามารถบันทึกข้อมูลได้!!  กรุณาตรวจกรอกข้อมูลให้ครบถ้วน','Error');
			    		validatetorInformation(validatetor(rs.errors));
			    	}
			    }
			});  
		});
		
		$('body').on('click','.downloadfileCaseHistory',function(){
			var case_stage_id = $(this).closest('tr').data('id');
							
			$.ajax({
				url:$plRoute+'/downloadCaseStageDoc/'+case_stage_id,
				type:'get',
				cache: false,
				dataType: 'json',
				headers:{Authorization:"Bearer "+tokenID.token},
				success: function(rs){
					console.log(rs);
					if(rs['status']==200){
						window.open($host+rs.file_path,"_self");
					}
					if(rs['status']==400){
						callFlashSlide("No file Data!",'errors');
					}
				},
				error: function(jqXHR, textStatus, errorThrown)
				{
					console.log(textStatus);
					callFlashSlide("No file Data!",'errors');
				}
			});
		});
		
		$('#patient_birthDate').on('change',function(){	
			var today = new Date(($current_date.split('/')[2]),$current_date.split('/')[1],$current_date.split('/')[0]);
			var bDate = new Date($(this).val().split('/')[2],$(this).val().split('/')[1],$(this).val().split('/')[0]);
			var age = Math.floor((today - bDate) / (365.25 * 24 * 60 * 60 * 1000));
			$('.yearOld').text(age);	
		})
	    
		$('body').on('change','.case_contract_endDate,.case_contract_startDate',function(){	
			var arr_today 		= $current_date.split('/');
			var arr_startDate= $(this).closest('tr').find('.case_contract_startDate').val().split('/');
			var arr_endDate	= $(this).closest('tr').find('.case_contract_endDate').val().split('/');
			var todayDate 	= new Date(arr_today[2],arr_today[1],arr_today[0]);
			var startDate 	= new Date(arr_startDate[2],arr_startDate[1],arr_startDate[0]);
			var endDate 	= new Date(arr_endDate[2],arr_endDate[1],arr_endDate[0]);
			var remaining_days = 0;
			if(todayDate > startDate){
				remaining_days = Math.floor((endDate-todayDate) / (24 * 60 * 60 * 1000));
			}else{
				remaining_days = Math.floor((endDate-startDate) / (24 * 60 * 60 * 1000));
			}
			remaining_days = remaining_days >= 0 ?remaining_days:0;
			var label = (remaining_days == 0)?' label label-important' :(remaining_days < 4 ?' label label-warning':'');
			$(this).closest('tr').find('.remaining_days').text(remaining_days).closest('div').removeClass('label-important label-warning').addClass(label);	
		})
		
		$('#patient_province').change(function(){
			$('#patient_zipcode,#patient_district,#patient_amphur').html('');
			getAjax($plRoute+'/getAmphur','get',{province_id:$(this).val()},function(rs){
				var html_amphur = '<option> --เลือกอำเภอ -- </option>';
				$.each(rs,function(){
					html_amphur +='<option value="'+this.amphur_id+'">'+this.amphur_name+'</option>';
				}); 
				$('#patient_amphur').html(html_amphur);
			})
		});
		$('#patient_amphur').change(function(){
			$('#patient_zipcode,#patient_district').html('');
			getAjax($plRoute+'/getDistrict','get',{amphur_id:$(this).val()},function(rs){
				var html_district = '<option> --เลือกตำบล -- </option>';
				$.each(rs,function(){
					html_district +='<option data-zipcode="'+this.zipcode.zipcode+'" value="'+this.district_id+'">'+this.district_name+'</option>';
				}); 
				$('#patient_district').html(html_district);
			})
		});
		$('#patient_district').change(function(){	$('#patient_zipcode').text($('#patient_district option:selected').data('zipcode'));	});
		
		$('.modal-add').click(function(){	
			$(this).closest('.wrap').find('table tbody').append($(this).data('tr'));
			getBasicData($(this));   
		});
		
		$('body').on('keyup','.user',function(){
			var search =  $(this).val();
			$(this).autocomplete({
				minLength: 3,
				delay: 100,
				source: function (request, response) {
			        getAjax($plRoute+"/getUser",'get',{search:search,user:''},function(rs){
			        	response( $.map( rs, function( item ) {
			                var object = new Object();
			                  object.id = item.userId;
			                  object.value = item.firstName +' '+ item.lastName;
			                  return object ;
			            }));
			        });    
			    },
			    select: function (event, ui) {
			    	$(this).data('user',ui.item.id);
			    	$(this).data('userName',ui.item.value);
			    }
			});
		});
		
		$('body').on('keyup','.case_appointment_supervised',function(){
			var search =  $(this).val();
			$(this).autocomplete({
				minLength: 3,
				delay: 100,
				source: function (request, response) {
			        getAjax($plRoute+"/getSupervisedUser",'get',{search:search,case_id:$('#patient_case').data('id')},function(rs){
			        	console.log(rs,'supervised');
			        	response( $.map( rs, function( item ) {
			                var object = new Object();
			                  object.id = item.userId;
			                  object.value = item.firstName +' '+ item.lastName;
			                  return object ;
			            }));
			        });    
			    },
			    select: function (event, ui) {
			    	$(this).data('user',ui.item.id);
			    	$(this).data('userName',ui.item.value);
			    }
			});
		});
		
		$('body').on('focusout','.user',function(){	
			$.trim($(this).val()) != ''? $(this).val($(this).data('userName')) : $(this).val('').data('userName','').data('user','');
		});
		
		$('body').on('keyup','.case_price_offer,.case_price_accept',function(){
			$(this).closest('tr').find('.case_price_value').text(($(this).closest('tr').find(".case_price_offer").val()-$(this).closest('tr').find('.case_price_accept').val()).toFixed(2));
			$(this).closest('tr').find('.case_price_percent').text((100-($(this).closest('tr').find('.case_price_accept').val()*100)/$(this).closest('tr').find(".case_price_offer").val()).toFixed(2));
		});
		
		$('#patient_case_supervisedBy').autocomplete({
			minLength: 3,
			delay: 100,
			source: function (request, response) {
				var supervisedBy = '';
				$('.patient_case_supervisedBy').each(function(){
					supervisedBy+='|'+$(this).data('user');
				})
		        getAjax($plRoute+"/getUser",'get',{search:$('#patient_case_supervisedBy').val(),user:supervisedBy,method:'admin'},function(rs){
		        	response( $.map( rs, function( item ) {
		                var object = new Object();
		                  object.id = item.userId;
		                  object.value = item.firstName +' '+ item.lastName;
		                  return object ;
		            }));
		        });    
		    },
		    select: function (event, ui) {
		    	$('.view_supervisedBy').append('<div data-user="'+ui.item.id+'" class="bubble patient_case_supervisedBy alert-info">'+ui.item.value+'<a href="#" onclick="return false;" class="fa fa-times-circle remove_supervisedBy"></a></div>');
		    	$(this).val(''); return false;
		    }
		});
		$('body').on('click','.remove_supervisedBy',function(){$(this).parent().remove();});
		
		$('#btnAddFolder').click(function(){
			$('#folderName').val('')
			getAjax($plRoute+"/getFolder/"+$('#patient_case').data('id'),'get','',function(rs){
		        var html_temp ='<option value="" >แฟ้มหลัก</option>';
		        $.each(rs,function(){
					html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">'+this.folder_screen_name+'</option>';
				}); 
				$('#addFolder .main_folder').html( html_temp );
			}); 
		});
		$('#btnSubmitAddFolder').on("click", function( e ) {
			var folder ={
					folder_screen_name	:	$.trim($('#folderName').val()),
					folder_parent_id	:	$('#addFolder .main_folder').val(),
					case_id				:	$('#patient_case').data('id'),
			}
			getAjax($plRoute+"/makeDirectory",'post',folder,function(rs){
				console.log(rs);
				if(rs.status == 200){
					callFlashSlide('สร้างแฟ้มข้อมูลสำเร็จ' ,'success');
					getFolder(rs.data);
					$('#addFolder').modal('hide');
					$('#folderName').val('');
				}else	callFlashSlide('เกิดข้อผิดพลาด','Error');
			});
		});
		
		$('#btnUploadFile').click(function(){
			getAjax($plRoute+"/getFolder/"+$('#patient_case').data('id'),'get','',function(rs){
		        console.log(rs);
		        var html_temp ='';
		        if(rs){
			        $.each(rs,function(){
						html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">'+this.folder_screen_name+'</option>';
						if(this.sub_folder){
							$.each(this.sub_folder,function(){
								if(this.case_folder)
								html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">&nbsp;&nbsp;&nbsp;&nbsp;'+this.folder_screen_name+'</option>';
							});
						}
			        }); 
		        }
				$('#ModalImportForm .folderList').html( html_temp );
			}); 
		});
		
		$('#btndeleteFolder').click(function(){
			getAjax($plRoute+"/getFolder/"+$('#patient_case').data('id'),'get','',function(rs){
		        console.log(rs);
		        var html_temp = '';
				$.each(rs,function(){
					
					html_temp +='<ul class="wrap_folder"><li class="folder parent" data-folder_id="'+this.folder_id+'">'
					+'<div href="#" onclick="return false;" class="folder_toggle folder_name" title="'+this.folder_screen_name+'">'+this.folder_screen_name+'</div>'
					+'<div style="float:right;"class="wrap_option"></div>'
					+'<button class=" btn btn-danger del-folder btn-delete btn-action pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button></div></li>';
					
					if(this.sub_folder){
						html_temp +='<ul class="wrap_folder">';
						$.each(this.sub_folder,function(){
								isNotHide = this.user_id == userId?'notHide':'';
								var isPass = this.is_pass==1?'checked':'';
								html_temp 	+='<li class="folder" data-folder_id="'+this.folder_id+'" >'
								+'<div href="#" onclick="return false;" class="folder_name" title="'+this.folder_screen_name+'">'+this.folder_screen_name+'</div>'
								+'<div style="float:right;"class="">'
								+'<button class=" btn btn-danger del-folder btn-delete btn-action pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button></div>';		
								
						});	html_temp +='</ul>';
					}	html_temp +='</li></ul>';
				}); 
				$('#deleteFolderForm .folderList >li > ul').html( html_temp );
			}); 
		});
		

		$("body").on('click','.btnIsOpen:not(.active)',function(e){
			var thiss = $(this);
			getAjax($plRoute+"/updateFolder",'post',{case_id:$('#patient_case').data('id'),folder_id:$(this).closest('li.folder').data('folder_id'),is_open:$(this).data('value')},function(rs){
				console.log(rs);
				if(rs.status == 200){
					thiss.closest('li').find('.wrap_volume').toggle();
				}else{
					e.preventDefault();
				}
			});
		});
		
		$("body").on('click','.btn_editFolder',function(e){
			var thiss = $(this);
			$('#edit_folderName').val('');
			$('#btnSubmitEditFolder').one('click',function(){
				var folder_name =  $.trim($('#edit_folderName').val());
				console.log($.trim($('#edit_folderName').val()));
				if(folder_name != ''){
					var folder_id =  thiss.closest('li.folder').data('folder_id');
					var case_id =  $('#patient_case').data('id');
					getAjax($plRoute+"/updateFolder",'post',{case_id:case_id,folder_id:folder_id,folder_name:folder_name},function(rs){
						console.log(rs,'updateFolder');
						if(rs.status == 200){
							callFlashSlide('แก้ไขแฟ้มข้อมูลสำเร็จ' ,'success');
							thiss.closest('li.folder').find('.folder_name').text(rs.data);
						}else	callFlashSlide(rs.error ,'error');
					});
				}else{
					callFlashSlide('ไม่สามารถแก้ไขแฟ้มข้อมูลได้ !! กรุณากรอก ชื่อแฟ้มข้อมูล ' ,'error');
				}
				$('#editFolder').modal('hide');
			});
		});
		
		function getFolderSummary(folder_id,thiss,case_id){
			var total = 0;
			$.ajax({
				url:$plRoute+"/getFolderSummary",
				type:"GET",
				dataType:"json",
				data:{folder_id:folder_id,case_id:case_id},
				async:false,
				headers:{Authorization:"Bearer "+tokenID.token},
				success: function(rs) {
					console.log(rs,'getFolderSummary');
					if(rs.status == 200){
						var f_pass = rs.data[0].f_pass!==null?rs.data[0].f_pass:0;
						var f_all = rs.data[0].f_all!==null?parseInt(rs.data[0].f_all):0;
						if(f_pass == 0 && f_all == 0) total = (0).toFixed(2);
						else total = ((f_pass*100)/f_all).toFixed(2);
					}
					console.log(total,'total');
					thiss.closest('.wrap_folder_parent').find('.volume').text(total);
					console.log(thiss.closest('.wrap_folder_parent').find('.volume'));
				}
			});
		}
		
		$("body").on('click','.isPass',function(e){
			var thiss = $(this);
			var folder_id = $(this).closest('li.folder').data('folder_id');
			getAjax($plRoute+"/updateFolder",'post',{case_id:$('#patient_case').data('id'),folder_id:folder_id,is_pass:$(this).prop('checked')?1:0},function(rs){
				console.log(rs,'updateFolder');
				if(rs.status == 200){
					getFolderSummary(folder_id,thiss,$('#patient_case').data('id'));
				}else{
					e.preventDefault();
				}
			});
		});
		
		$("body").on('click','.del-folder',function(e){
			var thiss = $(this);
			console.log(thiss);
			
//			$('#btnConfirmOK').one("click", function( e ) {
//				getAjax($plRoute+"/destoryFolder",'post',{folder_id:thiss.closest('li').data('folder_id'),case_id:$('#patient_case').data('id')},function(rs){
//					console.log(rs,'del-folder');
//					if(rs.status==200){ 
//						$('[data-folder_id="'+thiss.closest('li').data('folder_id')+'"]').remove();
//						thiss.closest('ul.wrap_folder').remove();
//						callFlashSlide('ลบไฟล์สำเร็จ' ,'success');
//					}else if(rs.status==400){
//						callFlashSlide(rs.message ,'error');
//					}
//					$('#confrimModal').modal('hide');
//				});
//			});
		});
		
		$("body").on('click','.del-file',function(e){
			var thiss = $(this);
			$('#btnConfirmOK').one("click", function( e ) {
				getAjax($plRoute+"/deleteFile",'post',{file_id:thiss.closest('li').data('file_id'),method:thiss.closest('.wrap').attr('id')},function(rs){
					console.log(rs,'deleteFile');
					if(rs.status==200){ 
						callFlashSlide('ลบไฟล์สำเร็จ' ,'success');
						thiss.closest('li').remove();
					}else{
						callFlashSlide('เกิดข้อผิดพลาด !! ไม่สามารถลบไฟล์ได้' ,'error');
					}
					$('#confrimModal').modal('hide');
				});
			});
		});
		
		function setCssTableRespornsive(){
			$css = '<style>@media  only screen and (max-width: 979px){'
				+'table, thead, tbody, th, td, tr { display: block; border-radius: 0 !important;}'
				+'thead tr { position: absolute;top: -9999px;left: -9999px;}'
				+'tr { border-bottom: 15px solid transparent; }'
				+'td { border-top: 1px solid #eee !important; border: none;border-bottom: 1px solid #eee; position: relative;padding: 5px !important; padding-left: 50% !important; }'
				+'td:before { position: absolute;top: 6px;left: 6px;width: 45%; padding-right: 10px; white-space: nowrap;}';
				$('.responsive-table:not(.none) table').each(function(){
					var thiss = $(this);
					$(this).find('thead > tr > th').each(function(i,v){
						$css += '#'+thiss.closest('.wrap').attr('id')+' tbody tr td:nth-of-type('+(i+1)+'):before { content: "'+$(v).text()+'"; }';
					});
				});
				$css +='#workflow tbody tr td:nth-of-type(1):before { content: "วันเวลา"; }'
					+'#workflow tbody tr td:nth-of-type(2):before { content: "จาก"; }'
					+'#workflow tbody tr td:nth-of-type(3):before { content: "ผู้รับผิดชอบ"; }'
					+'#workflow tbody tr td:nth-of-type(4):before { content: "ถึง"; }'
					+'#workflow tbody tr td:nth-of-type(5):before { content: "ผู้รับผิดชอบ"; }'
					+'#workflow tbody tr td:nth-of-type(6):before { content: "หมายเหตุ"; }'
					+'#workflow tbody tr td:nth-of-type(7):before { content: "แจ้งเตือน"; }'
					+'#workflow tbody tr td:nth-of-type(8):before { content: "เอกสารแนบ"; }';
				$css +='</style>';
				$('head').append($css);
		}
		
		function getBasicData(selector){
			var last_tr = selector.closest('.wrap').find('tr.dump_tr').last();
			last_tr.find('.caseType').append($html_caseType);
			last_tr.find('.doctor').append($html_doctor);
			last_tr.find('.procedure').append($html_procedure);
			last_tr.find('.discount').append($html_discountType);
			last_tr.find('.social').append($html_social);
			last_tr.find('.pr').append($html_pr);
			last_tr.find('.article').append($html_articleType);
			last_tr.find('.next_year').append(getyear($current_year,$current_year+10));
			last_tr.find('.reverse_year').append(getyear($current_year-30,$current_year+1));
			last_tr.find('.appointment').append($html_appointment);
			last_tr.find('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
	            language: 'th',            
	            thaiyear: true              
	        }).keydown(function(e){e.preventDefault();});
			
			last_tr.find('.datetimepicker').datepicker({
				format: 'dd/mm/yyyy',
	            language: 'th',            
	            thaiyear: true              
	        }).keydown(function(e){e.preventDefault();});
			
			last_tr.find('.case_appointment_timeH').append(timeHour());
			last_tr.find('.case_appointment_timeM').append(timeMinute());
			
			last_tr.find('.no').text(last_tr.closest("tbody").children('tr').length);
			
			// new files
			n_id ++;
			last_tr.find('.storeFile').attr('id','storeFile-'+n_id);
			last_tr.find('.case_contract_file_name_check').attr('value','storeFile-'+n_id);
			// end new files
		}
		
		function beToad(text){
			var t = text.split("/");
			return t[0]+"/"+t[1]+"/"+(t[2]-543);
		}

		function getFolder(data){
			console.log(data,'getFolder');
			var html_temp = '';
			$.each(data,function(){
				var isOpen = this.is_open==1?'active':'';
				var isClose = this.is_open==0?'active':'';
				var volume_tik = this.is_open==1?'block':'none';
				var isNotHide = this.user_id == userId?'notHide':'';
				html_temp +='<ul class="wrap_folder wrap_folder_parent"><li class="folder parent" data-folder_id="'+this.folder_id+'">'
				+'<div href="#" onclick="return false;" class="folder_toggle folder_name" title="'+this.folder_screen_name+'">'+this.folder_screen_name+'</div>'
				+'<a href="#" onclick="return false;" class="fa fa-edit btn-edit btn-action btn_editFolder" data-target="#editFolder" data-toggle="modal" ></a>'
				+'<div style="float:right;"class="wrap_option">'
					+'<div class="wrap_volume " style="display:'+volume_tik+'"><span class="volume_title">ปริมาณรูป&nbsp;&nbsp;</span><span class="volume">0.00</span>&nbsp;%</div>'
					+'<div class="btn-group " data-toggle="buttons-radio">'
						+'<button type="button" data-value="1" class="btnIsOpen btn btn-other btn-action '+isOpen+' ">เปิด</button>'
						+'<button type="button" data-value="0" class="btnIsOpen btn btn-other btn-action '+isClose+' ">ปิด</button>'
					+'</div></div></li>';
				if(this.caseFile){
					html_temp +='<ul>';
					$.each(this.caseFile,function(){
						var fileType = '';
						isNotHide = this.user_id == userId?'notHide':'';
						if(this.file_name)	fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
						html_temp 	+='<li class="file type-'+fileType+'" data-file_id="'+this.file_id+'" data-path="'+this.image_path+'" >'
						+'<div href="#" class="file_name" onclick="return false;" title="'+this.file_name+'">'+this.file_name+'</div>'
						+'<a target="_blank" href="'+$host+this.image_path+'" download class="fa fa-download btn-download btn-action" download ></a>'
						+'<div style="float:right;"class=""><button class=" btn btn-danger del-file btn-delete btn-action pull-right '+isNotHide+'"  data-target="#confrimModal" data-toggle="modal">ลบ</button></div>';		
					});	html_temp +='</ul>';
				}
				if(this.subFolder){
					html_temp +='<ul class="wrap_folder">';
					$.each(this.subFolder,function(){
							isNotHide = this.user_id == userId?'notHide':'';
							var isPass = this.is_pass==1?'checked':'';
							html_temp 	+='<li class="folder" data-folder_id="'+this.folder_id+'" >'
							+'<div href="#" onclick="return false;" class="folder_name" title="'+this.folder_screen_name+'">'+this.folder_screen_name+'</div>'
							+'<a href="#" onclick="return false;" class="fa fa-edit btn-edit btn-action btn_editFolder" data-target="#editFolder" data-toggle="modal"></a>'
							+'<div style="float:right;"class="">'
							+'<label class="control-label wrap_isPass"><input type="checkbox" '+isPass+' class="isPass btn-action btn-other">&nbsp;&nbsp;ผ่าน</label></div></li>';		
							
							if(this.caseFile){
								html_temp +='<ul>';
								$.each(this.caseFile,function(){
									var fileType = '';
									isNotHide = this.user_id == userId?'notHide':'';
									if(this.file_name)	fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
									html_temp 	+='<li class="file  type-'+fileType+'" data-file_id="'+this.file_id+'" data-path="'+this.image_path+'" >'
									+'<div href="#" class="file_name" onclick="return false;"  title="'+this.file_name+'">'+this.file_name+'</div>'
									+'<a target="_blank" href="'+$host+this.image_path+'" class="fa fa-download btn-download btn-action" download ></a>'
									+'<div style="float:right;"class=""><button class=" btn btn-danger del-file btn-delete btn-action pull-right '+isNotHide+'"  data-target="#confrimModal" data-toggle="modal">ลบ</button></div></li>';		
								});	html_temp +='</ul>';
							}
						
					});	html_temp +='</ul>';
				}	html_temp +='</li></ul>';
			
			}); 
			$('#list >li > ul').html(html_temp);
			$('.volume').each(function(){
				getFolderSummary($(this).closest('li.parent').data('folder_id'),$(this),$('#patient_case').data('id'));
			});
		}
		
		function validatetor(data) {
		    var errorData="";
		    $.each(data, function(key, value) {
		    	$.each(value, function(k, v) {
		     		errorData += stripJsonToString(v);
		    	});
		    });
		    return errorData;
		}
		   
		var stripJsonToString= function(json){
		       return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "</br>").replace(/\"/g,'');
		}
		function validatetorInformation(data) {
		    $("#information_errors").show();
		    $("#information_errors").html(data);
		}
		
		function getyear(min,max){
			var html_year ='';
			for($i = min; $i < max;$i++ ){	html_year +="<option value="+($i-543)+">"+$i+"</option>";	}
			return html_year;
		}
		
		function paresDateToDate(date){
			$date = date.split("-");
			$str_date = $date[2]+'/'+$date[1]+'/'+(parseInt($date[0])+543);
			return $str_date;
		}
		
		function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      $('#profileImage').attr('src', e.target.result);
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		}

		$("#btnUpload_profileImage").change(function() {	readURL(this);	});
		/* click pagination */
		$("#"+$appName+"_pagination").on('click','li:not(.disabled,.active) a',function(){
			getList($(this).parent().attr("data-lp"));
		});
		function getList(page){
			$data = { 	search		:$.trim($('#search_caseName').val()),
						caseType	:$('#search_caseType').val(),
						procedure	:$('#search_procedure').val(),
						social		:$('#search_social').val(),
						hn			:$.trim($('#search_hn').val()),
						review		:$('#search_review').val(),
						expDate		:$('#search_expireDate').val(),
						followup	:$('#search_followup').val(),
						case_group	:$('#search_case_group').val(),
						vn			:$('#search_vn').val(),
						perpage    	:$('#countPaginationBottom').val(),
						
					}
			getAjax($plRoute+"/getCaseList?page="+page,'get',$data,function(rs){
				console.log(rs);
				 var html_temp = '';
				 if(rs.data.length >0){
					 $.each(rs.data,function(i,v){
						var html_social = '';
						$.each(v.patient_social_media,function(){
							html_social += this.social_media.social_media_name+', ';
						});
						var is_good_case = v.is_good_case==1?'checked':'';
						var is_good_review = v.is_good_review==1?'checked':'';
						if(i%2==0) html_temp += '<div class="row-fluid">';
						html_temp += '<div class="span6 case_list" data-id="'+v.case_id+'">'
							+'<div class="span6"> '
								+'<img src="'+$host+v.patient.image_path+'"> '
								+'</div> <div class="span6" ><br> '
							+'<div> <span>ชื่อ : </span><span>'+v.patient.patient_name+'</span> </div> '
							+'<div> <span>VN no : </span><span>'+v.vn_no+'</span> </div> '
							+'<div> <span>หัตถการ : </span><span>'+v.procedure.procedure_name+'</span> </div> '
							+'<div> <span>ประเภท : </span><span>'+v.case_type.case_type+'</span> </div>' 
							+'<div> <span>ช่องทางลงสื่อ : </span><span>'+html_social+'</span> </div>' 
							+'<div > <input type="checkbox" '+is_good_case+' disabled=""> <span>Case ติดดาว</span> </div> '
							+'<div > <input type="checkbox" '+is_good_review+' disabled=""> <span>Review ติดดาว</span> </div> '
							+'<div> <span>สถานะงาน:</span><span>'+v.status+'</span> </div> '
							+'<div> <div class="wrap_button"><button data-patient_id="'+v.patient.patient_id+'" class="btn btn-success add_procedure" data-keyboard="false">เพิ่มหัตถการ</button> '
								+'<button class="btn btn-warning edit-list" data-type="edit" data-backdrop="static" data-keyboard="false">แก้ไข</button> </div> </div> </div> </div>';
						if(i%2==1) html_temp += '</div>';
					}); 

				 }else{
					 html_temp += '<div class="row-fluid"><div class="span12 text-center">ไม่พบข้อมูล</div></div>';
				 }

					$('#show_list').html(html_temp);
					getPagenation('#ba_pagination',rs);
			});
		}
	}
});