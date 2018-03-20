$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({
		 html:true
	});
	 
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
	$("#employee_list_content").show();
	

	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "case_group";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 
		$('body').fadeIn('slow');
		getList($perpage,1);
		
		//clear modal
		$("#btn_add").click(function(){
			clearModal();
			$("#from_is_active").prop('checked',true);
			$("#information_errors").hide();
		});
		
		/* click pagination */
		$("#"+$appName+"_pagination").on('click','li:not(.disabled,.active) a',function(){
			getList($perpage,$(this).parent().attr("data-lp"));
		});
		
		/* perpage change */
		$("#countPaginationBottom").on('change',function(){
			$perpage = $("#countPaginationBottom").val();	getList($perpage,1);	
		});
		
		$('#btn_submit_from_case_group').click(function(){
			var data = 	{ 
							case_group_id 	: $('#modalAdd').data('id'),
							case_group 		: $.trim($("#from_case_group_name").val()),
						  	is_active	 	: $('#from_is_active').prop('checked')?1:0						  
						}
			console.log(data);
			getAjax($plRoute+"/cu",'post',data,function(data){
				if(data.status == 200){
					$("#modalAdd").modal('hide');
					getList($perpage,1);
					callFlashSlide('บักทึกข้อมูลสำเร็จ!','success');
					clearModal();
				}else{
					validatetorInformation(validatetor(data['errors'][0]));
				}
			});
		});
		
		$('body').on('click','.del',function(){
			var id = $(this).data('id');
			$('#confrimModal').one('click', '#btnConfirmOK', function(e) {
				getAjax($plRoute+"/delete",'post',{id : id },function(rs){
					console.log(rs);
					if(rs.status == 200){
		 				getList($perpage,1);
		 				callFlashSlide("ลบข้อมูล สำเร็จ.",'success');
					} else if(rs.status == 400) {
						callFlashSlide(rs.data,'error');
					} else {
						callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
					}
	 				$('#confrimModal').modal('hide');
				});
			});
		})
		
		$('body').on('click','.edit',function(){
			$("#information_errors").hide();
			
			var id = $(this).data('id');
			getAjax($plRoute+"/getOne",'get',{id : id},function(rs){
				if(rs.status == 200){
					console.log(rs.data);
					$('#modalAdd').data('id',rs.data.case_group_id);
					$("#from_case_group_name").val(rs.data.case_group);
					$('#from_is_active').prop('checked',rs.data.is_active==1?true:false);
				}else{
	 				callFlashSlide("ไม่พบข้อมูลในระบบ.",'error');
				}
			});
		})
		
		$('#modalAdd').on('hide',function(){
			$(this).data('id','');
			$('#from_case_group_name').val('');
			$('#from_is_active').prop('checked',false);
		});

		/*get all list */
		function getList($perpage,$page){
			$url = $plRoute+"/getAll?page="+$page;
			$data = {perpage:$perpage};
			$callback = function(data){
				console.log(data);
				$html='';
				$.each(data.data,function(){
					$is_active = this.is_active == 1?"checked":"";
					$temp = '<tr>'
							+'<td style="vertical-align: middle;">'+this.case_group+'</td>'
								+'<td style="vertical-align: middle; text-align:center">'
									+'<input type=checkbox '+$is_active+' disabled>'
								+'</td>'
								+'<td style="vertical-align: middle; text-align: center;">'
								+'<i class="fa fa-cog font-gear popover-edit-del"'
									+'data-trigger="focus" tabindex="0" data-html="true"'
									+'data-toggle="popover" data-placement="top"'
									+'data-content="'
										+'<button class=\'btn btn-warning btn-xs btn-gear edit\' data-target=#modalAdd data-toggle=\'modal\' data-id=\''+this.case_group_id+'\'>แก้ไข</button>'
										+'<button class=\'btn btn-danger btn-xs btn-gear del\' data-target=#confrimModal data-toggle=\'modal\' data-id=\''+this.case_group_id+'\' style=\'margin-left: 15px\'>ลบ</button>">'
								+'</i></td>'
							+'</tr>';
					$html+= $temp;
				});
				$("#table_"+$appName+" tbody").html($html);
				getPagenation("#"+$appName+"_pagination",data);
				$('[data-toggle="popover"]').popover();
				
			}
			getAjax($url,'get',$data,$callback);
		}

	}
	
});