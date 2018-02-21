$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({
		 html:true
	});
	 
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
	$("#employee_list_content").show();
	
	$('#alert_multi').multiselect({
        allSelectedText: 'No option left ...',
        maxHeight: 200,
        onChange: function() {
            console.log($('#alert_multi').val());
        }
    });
	
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "doctor_target";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 
		onload(); 
		
		/* click pagination */
		$("#"+$appName+"_pagination").on('click','li:not(.disabled,.active) a',function(){
			getList($perpage,$(this).parent().attr("data-lp"),getDataToAjax());
		});
		
		/* perpage change */
		$("#countPaginationBottom").on('change',function(){
			$perpage = $("#countPaginationBottom").val();	getList($perpage,1,getDataToAjax());	
		});
		
		$('#doctor_name').autocomplete({
			minLength: 3,
			delay: 100,
			source: function (request, response) {
		        getAjax($plRoute+"/list_doctor",'get',{doctor_name:$("#doctor_name").val()},function(rs){
		        	response( $.map( rs, function( item ) {
		                var object = new Object();
		                  object.value = item.doctor_name;
		                  return object 
		              }));
		        });    
		    }
		});
		$('#from_doctor_name').autocomplete({
			minLength: 3,
			delay: 100,
			source: function (request, response) {
				console.log($("#from_doctor_name").val());
		        getAjax($plRoute+"/list_doctor_all",'get',{doctor_name:$("#from_doctor_name").val()},function(rs){
		        	response( $.map( rs, function( item ) {
		                var object = new Object();
		                  object.id = item.doctor_id;
		                  object.value = item.doctor_name;
		                  return object ;
		            }));
		        });    
		    },
		    select: function (event, ui) {
		    	$(this).data('doctor_id',ui.item.id);
		    	$(this).data('doctor_name',ui.item.value);
		    }

		});
		$('#from_doctor_name').focusout(function(){
	    	$(this).val($(this).data('doctor_name'));
	    });	
		
		$("#btn_search").click(function(){ getList($perpage,1,getDataToAjax()); });
		$("#btn_add").click(function(){ 
			$("#from_year").html(getyear($current_year,$current_year+20));	
		});
		
		$('#btn_submit_next_case_category').click(function(){
			$callback = function(rs){
				if(rs.status == 200){
					get_procedure_list();
					get_year_ontarget();
					clearModal();
					$('#form-case-month1,#form-case-month2,#form-case-month3,#form-case-month4').val(0);
					$('#form-case-month5,#form-case-month6,#form-case-month7,#form-case-month8').val(0);
					$('#form-case-month9,#form-case-month10,#form-case-month11,#form-case-month12').val(0);
					$(this).data('target_id','');
					$('#from_doctor_name').data('doctor_id','').data('doctor_name','');	
					getList($perpage,1,getDataToAjax());
					callFlashSlide("บันทึกข้อมูลสำเร็จ",'success');
				}else{
					callFlashSlide("ไม่สามารถบันทึกข้อมูลได้",'error');
				}
			};
		 	store_doctor_target($callback);
		});
		$('#btn_submit_doctor_target').click(function(){
			$callback = function(rs){
				if(rs.status == 200){
					get_procedure_list();
					get_year_ontarget();
					$('#ModalEdit').modal('hide');
					getList($perpage,1,getDataToAjax());
					callFlashSlide("บันทึกข้อมูลสำเร็จ",'success');
				}else{
					callFlashSlide("ไม่สามารถบันทึกข้อมูลได้",'error');
				}
			};
		 	store_doctor_target($callback);
		});
		$('#table_doctor_target').on("click", ".del", function(){ 
			$id = $(this).data('target_id');
			console.log($id);
			$('#confrimModal').one('click', '#btnConfirmOK', function(e) {
				getAjax($plRoute+"/destroy_one",'post',{id : $id },function(rs){
					console.log(rs);
					if(rs.status == 200){
		 				getList($perpage,1,getDataToAjax());
		 				callFlashSlide("ลบข้อมูล สำเร็จ.",'success');
					}else{
						callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
					}
	 				$('#confrimModal').modal('hide');
				});
			});
		    
		});
		$("html").on('click','.edit',function(){
			getAjax($plRoute+"/get_target",'get',{doctor_target_id:$(this).data('target_id')},function(rs){
				$('#ModalEdit').data('target_id',rs.data.doctor_target_id);
				if(rs.status == 200){
					$("#from_doctor_name").val(rs.data.doctor.doctor_name).data('doctor_id',rs.data.doctor.doctor_id).data('doctor_name',rs.data.doctor.doctor_name);
					$("#case_category").val(rs.data.case_type_id);
					$("#from_medical_procedure").val(rs.data.procedure_id);
					$("#from_year").html(getyear($current_year-10,$current_year+10)).val(rs.data.year);
					$('#form-case-month1').val(rs.data.target_month1);
					$('#form-case-month2').val(rs.data.target_month2);
					$('#form-case-month3').val(rs.data.target_month3);
					$('#form-case-month4').val(rs.data.target_month4);
					$('#form-case-month5').val(rs.data.target_month5);
					$('#form-case-month6').val(rs.data.target_month6);
					$('#form-case-month7').val(rs.data.target_month7);
					$('#form-case-month8').val(rs.data.target_month8);
					$('#form-case-month9').val(rs.data.target_month9);
					$('#form-case-month10').val(rs.data.target_month10);
					$('#form-case-month11').val(rs.data.target_month11);
					$('#form-case-month12').val(rs.data.target_month12);
					//$('#alert_multi').val(rs.data.target_month12);
				}
				
			});
		});
		
		/* Clear modal when hide */
		$('#ModalEdit').on('hide', function(e){ 
			$(this).data('target_id','');
			$('#from_doctor_name').data('doctor_id','').data('doctor_name','');	
			clearModal(); 
			$('#form-case-month1,#form-case-month2,#form-case-month3,#form-case-month4').val(0);
			$('#form-case-month5,#form-case-month6,#form-case-month7,#form-case-month8').val(0);
			$('#form-case-month9,#form-case-month10,#form-case-month11,#form-case-month12').val(0);
		});
		
		function get_procedure_list(){
			getAjax($plRoute+"/list_medical_procedure",'get','',function(rs){
				$html = '';
				$.each(rs,function(k,v){	$html += "<option value= "+v.procedure_id+">"+v.procedure_name+"</option>";	});
				$("#medical_procedure").html($html);
			});
		}
		function get_year_ontarget(){
			getAjax($plRoute+"/list_year",'get','',function(rs){
				$html = '';
				$.each(rs,function(k,v){	$html += "<option value= "+v.year+">"+v.year+"</option>";	});
				$("#year").html($html);
			});
		}
		function onload(){
			get_procedure_list();
			get_year_ontarget();
			getAjax($plRoute+"/list_medical_procedure_all",'get','',function(rs){
				$html = '';
				$.each(rs,function(k,v){	$html += "<option value= "+v.procedure_id+">"+v.procedure_name+"</option>";	});
				$("#from_medical_procedure").html($html);
			});
			getAjax($plRoute+"/list_case",'get','',function(rs){
				$html = '';
				$.each(rs,function(k,v){	$html += "<option value= "+v.case_type_id+">"+v.case_type+"</option>";	});
				$("#case_category").html($html);
			});
			
			getAjax($plRoute+"/get_current_date",'get','',function(rs){
				if(rs) $current_year = parseInt(rs.split("-")[2])+543;	
			});
			
			$html_month = 	"<option value='1'>มกราคม</option><option value='2'>กุมภาพันธ์</option><option value='3'>มีนาคม</option>"
							+"<option value='4'>เมษายน</option><option value='5'>พฤษภาคม</option><option value='6'>มิถุนายน</option>"
							+"<option value='7'>กรกฎาคม</option><option value='8'>สิงหาคม</option><option value='9'>กันยายน</option>"
							+"<option value='10'>ตุลาคม</option><option value='11'>พฤศจิกายน</option><option value='12'>ธันวาคม</option>";
			$('#month').html($html_month);
			$('html').fadeIn();
			
		}
		
		function store_doctor_target(callback){
			if(validation('#ModalEdit .validate')){
				$data = {
							formdata:{
							"doctor_target_id": $('#ModalEdit').data('target_id')?$('#ModalEdit').data('target_id'):'',
							"doctor_id": $('#from_doctor_name').data('doctor_id'),
							"case_type_id": $('#case_category').val(),
							"procedure_id": $('#from_medical_procedure').val(),
							"year": $('#from_year').val(),
							"target_month1": $('#form-case-month1').val(),
							"target_month2": $('#form-case-month2').val(),
							"target_month3": $('#form-case-month3').val(),
							"target_month4": $('#form-case-month4').val(),
							"target_month5": $('#form-case-month5').val(),
							"target_month6": $('#form-case-month6').val(),
							"target_month7": $('#form-case-month7').val(),
							"target_month8": $('#form-case-month8').val(),
							"target_month9": $('#form-case-month9').val(),
							"target_month10": $('#form-case-month10').val(),
							"target_month11": $('#form-case-month11').val(),
							"target_month12": $('#form-case-month12').val()
						  },
						  alert: $('#alert_multi').val()
				}
				console.log($data);
				getAjax($plRoute+"/cru",'post',$data,callback);
				
			}else{
				callFlashSlide("กรุณากรอกข้อมูลให้ครบถ้วน",'error');
			}
		}
		
		function validation(selector){
			$stat = true;
			$(selector).each(function(){
	    		if($.trim($(this).val()) == ''){
	    			$(this).focus();
	    			$stat = false; 
	    			return false;
	    		}
			});
			return $stat;
		}
		
		function getDataToAjax(){
			var data = {
						doctorName	:$.trim($("#doctor_name").val()),
						procedure	:$("#medical_procedure").val(),
						year 		:$('#year').val(),
						month		:$('#month').val()
					};
			console.log(data);
			return data;
		}
		
		function getyear(min,max){
			var html_year ='';
			for($i = min; $i < max;$i++ ){	html_year +="<option value="+($i-543)+">"+$i+"</option>";	}
			return html_year;
		}
		
		/*get all list */
		function getList($perpage,$page,data){
			$url = $plRoute+"/search_target?page="+$page;
			$data = data!=''?$.extend({perpage:$perpage},data):{perpage:$perpage};
			getAjax($url,'get',$data,function(rs){
				console.log(rs);
				$html=''; 
				if(rs.data.length > 0){
					$.each(rs.data,function(i,v){
						$temp_arr =[0,v.target_month1,v.target_month2,v.target_month3,v.target_month4,
									v.target_month5,v.target_month6,v.target_month7,v.target_month8,
									v.target_month9,v.target_month10,v.target_month11,v.target_month12];
						$i = (rs.per_page*(rs.current_page-1))+(i+1);
						$temp = '<tr>'
							/* +'<td style="vertical-align: middle;">'+$i+'</td>' */
							+'<td style="vertical-align: middle;">'+v.doctor.doctor_name+'</td>'
							+'<td style="vertical-align: middle;">'+v.doctor_procedure.medical_procedure.procedure_name+'</td>'
							+'<td style="vertical-align: middle;">'+v.year+'</td>'
							+'<td style="vertical-align: middle;text-align:right">'+$temp_arr[$data.month]+'</td>'
							+'<td style="padding-left:18px">'
								+'<i class="fa fa-cog font-gear popover-edit-del"'
									+'data-trigger="focus" tabindex="0" data-html="true"'
									+'data-toggle="popover" data-placement="top"'
									+'data-content=" '
										+'<button class=\'btn btn-warning btn-xs btn-gear edit\'data-target_id=\''+v.doctor_target_id+'\' data-target=#ModalEdit data-toggle=\'modal\' style=\'z-index:9999 \'>แก้ไข</button> '
										+'<button class=\'btn btn-danger btn-xs btn-gear del\'data-target_id=\''+v.doctor_target_id+'\' data-target=#confrimModal data-toggle=\'modal\' style=\'z-index:9999;margin-left: 15px\'>ลบ</button>""'
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
