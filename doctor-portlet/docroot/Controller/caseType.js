$(document).ready(function() {
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "case_type";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 
		getList($perpage,1);
		
		//clear modal
		$("#btn_add").click(function(){
			$('#modalAdd').modal({backdrop: 'static', keyboard: false});
			clearModal();
			$("#add_is_active").prop('checked',true);
			$("#information_errors").hide();
		});

		/*action add*/
		$('#btn_submit_add_'+$appName).on('click',function(){
			$elm = $('#add_'+$appName+'_name');
			$name = $.trim($elm.val());
			$is_active = $('#add_is_active').is(":checked") == true?1:0;

				$url = $plRoute+'/new';
				$data = {caseTypeName:$name,is_active:$is_active};
				$callback = function(data,status){
					if(data.status == 200){
						//console.log(data);
						$("#modalAdd").modal('hide');
						getList($perpage,1);
						callFlashSlide('บักทึกข้อมูลสำเร็จ!','success');
						clearModal();
					}else{
						validatetorInformation(validatetor(data['errors'][0]));
					}
				}
				getAjax($url,"post",$data,$callback);
		});
		
		/*	get data to modal for edit*/
		$('#table_'+$appName).on('click','.edit', function(e){
			$("#information_errors_update").hide();
			$('#modalAdd').modal({backdrop: 'static', keyboard: false});
			
			$id = $(this).attr('data-id');
			$url =$plRoute+"/getOne/"+$id;
			$callback = function(data){
				if(data.status==200){
					$('#edit_'+$appName+'_name').val(data.data.case_type).attr('data-id',data.data.case_type_id);
					if(data.data.is_active == 1){
						$("#edit_is_active").prop('checked', true);
					}else{
						$("#edit_is_active").prop('checked', false);
					}
				}
			};
			getAjax($url,'get','',$callback);
		});
		
		/*  action edit  */
		$("#btn_submit_edit_"+$appName).on('click',function(){
			$name = $.trim($('#edit_'+$appName+'_name').val());
			$is_active = $('#edit_is_active').is(":checked") == true?1:0;

				$id = $('#edit_'+$appName+'_name').attr('data-id');
				$data = {caseTypeName:$name,is_active:$is_active};
				$url = $plRoute+"/update/"+$id;
				$callback = function(data){
					if(data.status==200){
						getList($perpage,1);
						callFlashSlide('บักทึกข้อมูลสำเร็จ!','success');
						$("#modalEdit").modal('hide');
						clearModal();
						$('#edit_'+$appName+'_name').removeAttr('data-id');
					}else{
						//console.log(data);
						validatetorInformationUpdate(validatetor(data['errors'][0]));
					}
				};
				getAjax($url,'post',$data,$callback);
		});
		
		/*	get data to modal for delete*/
		$('#table_'+$appName).on('click','.del', function(e){
			$("#btnConfirmOK").attr('data-id',$(this).attr('data-id'));
		});
		
		/*action delete*/
		$("#btnConfirmOK").on('click',function(){
			$id = $(this).attr("data-id");
			$url = $plRoute+"/delete/"+$id;
			$callback = function(data){
				if(data.status==200){
					getList($perpage,1);
					callFlashSlide('ลบข้อมูลสำเร็จ!','success');
				} else if(data.status == 400) {
					callFlashSlide(data.data,'error');
				} else {
					callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
				}
			};
			getAjax($url,'post','',$callback);
			$("#confrimModal").modal('hide');
			clearModal();
			$(this).removeAttr('data-id');
		});	
		
		/* click pagination */
		$("#"+$appName+"_pagination").on('click','li:not(.disabled,.active) a',function(){
			getList($perpage,$(this).parent().attr("data-lp"));
		});
		
		/* perpage change */
		$("#countPaginationBottom").on('change',function(){
			$perpage = $("#countPaginationBottom").val();
			getList($perpage,1);
		});
	}
});


/*get all list */
function getList($perpage,$page){
	$url = $plRoute+"/getAll?page="+$page;
	$data = {perpage:$perpage};
	$callback = function(data){
		$html='';
		$.each(data.data,function(){
			$is_active = this.is_active == 1?"checked":"";
			$temp = '<tr>'
					+'<td style="vertical-align: middle;">'+this.case_type+'</td>'
						+'<td style="vertical-align: middle; text-align:center">'
							+'<input type=checkbox '+$is_active+' disabled>'
						+'</td>'
						+'<td style="vertical-align: middle; text-align: center;">'
						+'<i class="fa fa-cog font-gear popover-edit-del"'
							+'data-trigger="focus" tabindex="0" data-html="true"'
							+'data-toggle="popover" data-placement="top"'
							+'data-content="'
								+'<button class=\'btn btn-warning btn-xs btn-gear edit\' data-id=\''+this.case_type_id+'\'>แก้ไข</button>'
								+'<button class=\'btn btn-danger btn-xs btn-gear del\' data-target=#confrimModal data-toggle=\'modal\' data-id=\''+this.case_type_id+'\' style=\'margin-left: 15px\'>ลบ</button>">'
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