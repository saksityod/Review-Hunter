$(document).ready(function() {
	
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "doctor_profile";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 

		onload();
		$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
		$('[data-toggle="tooltip"]').tooltip({
			 html:true
		});
		 
		$('[data-toggle="popover"]').popover();   
		$(".app_url_hidden").show();
		$("#employee_list_content").show();
		
		$('#from_medical_procedure').multiselect({
	        includeSelectAllOption: false,
	        maxHeight: 200
	    });
		
		
		/* click pagination */
		$("#"+$appName+"_pagination").on('click','li:not(.disabled,.active) a',function(){
			getList($perpage,$(this).parent().attr("data-lp"),getDataToAjax());
		});
		
		/* perpage change */
		$("#countPaginationBottom").on('change',function(){
			$perpage = $("#countPaginationBottom").val();
			getList($perpage,1,getDataToAjax());
		});
		
		$("#btn_search").click(function(){
			getList($perpage,1,getDataToAjax());
		});
		
		
		$('#btn_add').click(function() {
			$('.btn-edit,.btn-del,.btn-cancel').hide();
			$('.btn-add').show();
			$("#from_active").prop("checked",true);
			$('.clickSelector').hide();
			//addcheckboxDefault('btn_add');
		});
		
		$('.btn-add').click(function(){
			$('.'+$(this).data('method')+'-table tbody').append($(this).data('elm')); 
			if($(this).data('method')=="work"){
				$(".edit-exp").last().find('.build-work-datepicker').html($html_year);
			} else {
				//addcheckboxDefault('add');
			}
			
		});
		$('.btn-edit').click(function(){ 
			$(this).hide();
			$(this).closest('.wrap').find('.input,.btn-cancel').show(); 
			$(this).closest('.wrap').find('.display').hide();
			
		});
		$('.btn-cancel').click(function(){ 
			$(this).hide();
			$(this).closest('.wrap').find('.input').each(function(){
				$(this).val($(this).data('default'));
			});
			$(this).closest('.wrap').find('.input').hide(); 
			$(this).closest('.wrap').find('.display,.btn-edit').show();
		});
		
		$('body').on("click", ".del_tr", function() {
			if($(this).closest('tr').find('.edu-is-use').length==1) {
				if($(this).closest('tr').find('.edu-is-use').prop('checked')==false) {
 					this.closest('tr').remove();
 				}
				
			} else {
				this.closest('tr').remove();
			}
			
		});
		
		/* del-edu,work */
		$('.btn-del').click(function(){
			$btn_del = $(this);
			if($btn_del.closest('.wrap').find('.checkbox:checked').length > 0){
				$('#confrimModal').modal({
			    	backdrop: 'static',
			      	keyboard: false
			    }).one('click', '#btnConfirmOK', function(e) {
					$arr=[];
					$btn_del.closest('.wrap').find('.checkbox:checked').each(function(){
						$arr.push($(this).closest('tr').data('id'));
					});
					if($arr.length > 0 ){
						$method = $btn_del.data("method")
						$url = $plRoute+"/destroy_"+$method;
						$data = {arr : JSON.stringify($arr)};
						getAjax($url,'post',$data,function(rs){
							if(rs.status == 200){
				 				$.each(jQuery.parseJSON(rs.data),function(i,v){
				 					$("table."+$method+"-table tr[data-id='"+v+"']").remove();
				 				});
				 				callFlashSlide("ลบข้อมูลสำเร็จ",'success');
				 				validateCheckedIsUse();
							} else {
								callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
							}
			 				$('#confrimModal').modal('hide');
						});
					}
			    });
			}
		});
		
		/* Clear modal when hide */
		$('#ModalEditDetail').on('hidden', function(){ 
			$('#from_medical_procedure').val('').multiselect("refresh");
			$(this).data('id','');
			$('.tr-dump').remove();
			clearModal();
		});
		
		
		$('#table_doctor_profile').on("click", ".del", function(){ 
			$id = $(this).closest('tr').data('id');
			$('#confrimModal').one('click', '#btnConfirmOK', function(e) {
				$url = $plRoute+"/destroy_doctor";
				$data = {id : $id };
				console.log($data);
				getAjax($url,'post',$data,function(rs){
					if(rs.status == 200){
		 				getList($perpage,1,getDataToAjax());
		 				callFlashSlide("ลบข้อมูล  Doctor สำเร็จ.",'success');
					} else if(rs.status == 400) {
						callFlashSlide(rs.data,'error');
					} else {
						callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
					}
	 				$('#confrimModal').modal('hide');
				});
			});
		});
		
		function validateCheckedIsUse() {
			var eChecked = false;
			$('body .edu-is-use').each(function(i,v){
				if($(this).prop('checked')==true) {
					eChecked = true;
					return false;
				}
			});

			if(eChecked==false) {
				$('body .edu-is-use').last().prop('checked',true);
			}
		}
		
		function getyear(min,max) {
			var maxx = parseInt(max) + 20;
			var year_min = parseInt(min) + 543;
			var year_max = parseInt(maxx) + 543;
			var html_year ='';
			for($i = year_min; $i < year_max;$i++ ) {
				html_year +="<option value="+($i-543)+">"+$i+"</option>";
			}
			return html_year;
		}
		
		$('body').on('click','.btn-add-edu', function() {
			validateCheckedIsUse();
		});
		
		$('body').on('change','.exp-start', function() {
			console.log($(this).val());
			$(this).closest('tr').find('.exp-end').html(getyear($(this).val(),$(this).val()));
		});
		
		/* edit doctor data in table list */
		$('body').on("click", ".edit", function(){
			console.log('edit doctor data in table list');
			$('.clickSelector').show();
			//addcheckboxDefault('btn_edit');
			$('.btn-cancel').hide(); 
			$('.btn-edit,.btn-del,.btn-add').show(); 
			$id = $(this).closest('tr').data('id');
			$url = $plRoute+"/get_doctor";	
			$data = {doctor_id:$id};
			getAjax($url,'get',$data,function(rs){
				console.log(rs);
				 if(rs.status == 200){
					$procedure =[];
					$('#ModalEditDetail').data('id',$id);
					if(rs.data.doctor_procedure.length > 0){
						$.each(rs.data.doctor_procedure,function(k,v){
							$procedure.push(v.procedure_id);
						});
					} 
					$('#from_doctor_name').val(rs.data.doctor_name);
					$('#from_doctor_sex').val(rs.data.gender);
					$('#from_medical_procedure').val($procedure).multiselect("refresh");
					$('#from_active').prop('checked', rs.data.is_active == 1?true:false);
					$('#from_doctor_exp').val(rs.data.expertise);
					$html ='';
					$.each(rs.data.doctor_education,function(k,v){
						$is_use = v.is_use == 1?"checked='checked'":"";
						$html += '<tr class="edit-edu tr-dump" data-id="'+v.doctor_education_id+'"> '
									+'<td ><input type="checkbox" class="checkbox"> </td> '
									+'<td><div class="display">'+v.education_institution+'</div>'
										+'<input style="display:none" class="input edu-inst validation" type="text" data-default="'+v.education_institution+'" value="'+v.education_institution+'"></td> '
									+'<td><div class="display">'+v.education_level+'</div>'
										+'<input style="display:none" class="input edu-level validation" type="text" data-default="'+v.education_level+'" value="'+v.education_level+'"></td> '
									+'<td><div class="display">'+v.education_degree+'</div>'
										+'<input style="display:none" class="input edu-degree validation" type="text" data-default="'+v.education_degree+'" value="'+v.education_degree+'"></td> '
									+'<td><input type="checkbox" class="edu-is-use"  '+$is_use+' /></td>' 
									+'<td > </td></tr>';
					});
					$(".edu-table tbody").html($html);
					$html='';
					$.each(rs.data.doctor_work,function(k,v){
						$html += '<tr class="edit-exp tr-dump" data-id="'+v.doctor_work_id+'"> '
									+'<td ><input type="checkbox" class="checkbox"> </td> '
									+'<td><div class="display" style="text-align:center">'+(v.start_year+543)+'</div>'
										+'<select style="display:none" class="input exp-start work-datepicker validation" type="text" data-default="'+v.start_year+'">'+$html_year+'</select></td> '
									+'<td><div class="display" style="text-align:center">'+(v.end_year+543)+'</div>'
										+'<select style="display:none" class="input exp-end work-datepicker validation" type="text" data-default="'+v.end_year+'">'+$html_year+'</select></td> '
									+'<td><div class="display">'+v.company_name+'</div>'
										+'<input style="display:none" class="input exp-comp validation" type="text" data-default="'+v.company_name+'" value="'+v.company_name+'"></td> '
									+'<td style="" > </td> '
										+'</tr>';
						
					});
					$(".work-table tbody").html($html);
					
					$(".work-datepicker").each(function(){ $(this).val($(this).data('default')); });
				}else{
					callFlashSlide("ไม่สามารถโหลดข้อมูลได้",'error');
				}
			});
			
		});
		
		

		$html_year='';
		$url = $plRoute+"/get_current_date";
		getAjax($url,'get','',function(rs){
			if(rs){
				$bc_year =parseInt(rs.split("-")[2]);
				$year = $bc_year+543;
				for($i = $year-20; $i <= $year;$i++ ){
					$html_year +="<option value="+($i-543)+">"+$i+"</option>";
				}
			}
		});
		
		
		$('body').on('click','.edu-is-use',function(){
			$('.edu-is-use').prop('checked', false);
			$(this).prop('checked', true);
		});
		$("#btnLvSubmit").on('click',function(){
			if(validation()){
				$id = $('#ModalEditDetail').data('id');
				$name = $.trim($('#from_doctor_name').val());
				$gender = $('#from_doctor_sex').val();
				$expertise = $.trim($('#from_doctor_exp').val());
				$is_active = $('#from_active').is(':checked')?1:0;
				$arr_proc = []; $arr_edu = []; $arr_work = [];
				if($('#from_medical_procedure').val()){
					$.each($('#from_medical_procedure').val(),function(i,v){
						$arr_proc.push({"procedure_id":v});
					});
				} 
				if($('.edit-edu').length > 0){
					$('.edit-edu').each(function(i,v){
						$arr_edu.push({
								"doctor_education_id"	:$(this).data('id'),
								"education_institution"	:$.trim($(this).find('.edu-inst').val()),
								"education_level"		:$.trim($(this).find('.edu-level').val()),
								"education_degree"		:$.trim($(this).find('.edu-degree').val()),
								"is_use"				:$(this).find('.edu-is-use').prop('checked')?1:0
						});
					});
				}
				if($('.edit-exp').length > 0){
					$('.edit-exp').each(function(i,v){
						$arr_work.push(	{
								"doctor_work_id"	:$(this).data('id'),
								"start_year"		:$(this).find('.exp-start').val(),
								"end_year"			:$(this).find('.exp-end').val(),
								"company_name"		:$.trim($(this).find('.exp-comp').val())
						});
					});
				}
				$data = {	formdata:{	
								doctor :{ 	
									doctor_id:$id,
									doctor_name:$name,
									gender:$gender,
									expertise:$expertise,
									is_active:$is_active 
								},
								doctor_procedure : $arr_proc,
								doctor_education : $arr_edu,
								doctor_work		 : $arr_work
							}
						};
				getAjax($plRoute+"/crud",'post',$data,function(rs){
					console.log(rs);
					if(rs.status == 200){
						$('#ModalEditDetail').modal('hide');
						getList($perpage,1,getDataToAjax());
						callFlashSlide("ทำรายการสำเร็จ",'success');
					}else{
						callFlashSlide("เกิดข้อผิดพลาดในการทำรายการ",'error');
					}
				});
			}else{
				callFlashSlide("กรุณากรอกข้อมูลให้ครบถ้วน",'error');
			}
		})
		
		function validation(){
			$stat = true;
			$('.validation').each(function(){
	    		if($.trim($(this).val()) == ''){
	    			$(this).focus();
	    			$stat = false; 
	    			return false;
	    		}
			});
			return $stat;
		}
		
		function getDataToAjax(){
			$data = {search:$.trim($("#doctor_name").val()),procedure:$("#medical_procedure").val()};
			return $data;
		}
		
// 		$('#doctor_name').autocomplete({
// 			minLength: 3,
// 			delay: 100,
// 			source: function (request, response) {
// 		        getAjax($plRoute+"/list_doctor",'get',{doctor_name:$("#doctor_name").val()},function(rs){
// 		        	response( $.map( rs, function( item ) {
// 		                var object = new Object();
// 		                  object.value = item.doctor_name;
// 		                  return object 
// 		              }));
// 		        });    
// 		    }
// 		});

		//Autocomeplete
			$("#doctor_name").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/doctor_profile/list_doctor_name",
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
								 //console.log(data);
									response($.map(data, function (item) {
			                            return {
			                                label: item.doctor_name,
			                                value: item.doctor_name,
			                            };
			                        }));
							},
							beforeSend:function(){
								$("body").mLoading('hide');	
							}
							
						});
			        }
		});
		
		function onload(){
			$url = $plRoute+"/list_medical_procedure";
			getAjax($url,'get','',function(rs){
				$html = '';
				$.each(rs,function(k,v){
					$html += "<option value= "+v.procedure_id+">"+v.procedure_name+"</option>";
				});
				$("#medical_procedure").append($html);
				$("#from_medical_procedure").append($html);
				getList($perpage,1,getDataToAjax());
			});
			
		}
		
		/*get all list */
		function getList($perpage,$page,data){
			$url = $plRoute+"/list_doctor?page="+$page;
			$data = data!=''?$.extend({perpage:$perpage},data):{perpage:$perpage};
			getAjax($url,'get',$data,function(rs){
				console.log(rs);
				$html='';
				if(rs.data.length > 0){
					$.each(rs.data,function(i){
						$i = (rs.per_page*(rs.current_page-1))+(i+1);
						$is_active = this.is_active == 1?"checked":"";
						$procedure ='';
						$edu_lvl = '';
						$edu_inti = '';
						if(this.doctor_education.length > 0){
							$edu_lvl = this.doctor_education[0].education_level;
							$edu_inti = this.doctor_education[0].education_institution;
						}
						if(this.doctor_procedure.length > 0 ){
							$.each(this.doctor_procedure,function(k,v){
								$procedure += v.medical_procedure.procedure_name+'<br/>';
							});
						}
						$temp = '<tr data-id=\''+this.doctor_id+'\'>'
							+'<td style="vertical-align: middle;">'+$i+'</td>'
							+'<td style="vertical-align: middle;">'+this.doctor_name+'</td>'
							+'<td style="vertical-align: middle;">'+$procedure+'</td>'
							+'<td style="vertical-align: middle;">'+$edu_lvl+'</td>'
							+'<td style="vertical-align: middle;">'+$edu_inti+'</td>'
							+'<td style="vertical-align: middle; text-align: center;">'
								+'<i class="fa fa-cog font-gear popover-edit-del"'
									+'data-trigger="focus" tabindex="0" data-html="true"'
									+'data-toggle="popover" data-placement="top"'
									+'data-content=" '
									+'<button class=\'btn btn-warning btn-xs btn-gear edit\' data-target=#ModalEditDetail data-toggle=\'modal\' style=\'z-index:9999 \' data-backdrop=\'static\' data-keyboard=\'false\'>แก้ไข</button> '
									+'<button class=\'btn btn-danger btn-xs btn-gear del\' data-target=#confrimModal data-toggle=\'modal\' style=\'margin-left: 15px;z-index:9999 \'>ลบ</button>">'
									+'</i></td></tr>';
						$html+= $temp;
					});
				}else{
					$html="<tr><td colspan='6'> -- ไม่พบข้อมูล --</td></tr>"
				}
				$("#table_"+$appName+" tbody").html($html);
				getPagenation("#"+$appName+"_pagination",rs);
				$('[data-toggle="popover"]').popover();
			});
		}
	
	}
});