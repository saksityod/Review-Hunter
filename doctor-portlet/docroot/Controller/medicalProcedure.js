$(document).ready(function() {
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "medical_procedure";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 
		getList($perpage,1);
		
		/*action add */
		$('#btn_submit_add_'+$appName).on('click',function(){
			$elm = $('#add_'+$appName+'_name');
			$name = $.trim($elm.val());
			$is_active = $('#add_is_active').is(":checked") == true?1:0;
			if($name != ''){
				$url = $plRoute+'/new';
				$data = {procedure_name:$name,is_active:$is_active};
				$callback = function(data,status){
					if(data.status == 200){
						getList($perpage,1);
						callFlashSlide(data.message,'success');
					}else{	
						callFlashSlide(data.message,'error');
					}
					$("#modalAdd").modal('hide');
					clearModal();
				}
				getAjax($url,"post",$data,$callback);
			}else{
				callFlashSlide(data.message,'error');
			}
		});
		
		/*	get  data to modal for edit*/
		$('#table_'+$appName).on('click','.edit', function(e){
			$id = $(this).attr('data-id');
			$url = $plRoute+"/getOne/"+$id;
			$callback = function(data){
				if(data.status==200){
					$('#edit_'+$appName+'_name').val(data.data.procedure_name).attr('data-id',data.data.procedure_id);
					if(data.data.is_active == 1){
						$("#edit_is_active").prop('checked', true);
					}else{
						$("#edit_is_active").prop('checked', false);
					}
				}
			};
			getAjax($url,'get','',$callback);
		});
		
		/*  action edit   */
		$("#btn_submit_edit_"+$appName).on('click',function(){
			$name = $.trim($('#edit_'+$appName+'_name').val());
			$is_active = $('#edit_is_active').is(":checked") == true?1:0;
			if($name != ''){
				$id = $('#edit_'+$appName+'_name').attr('data-id');
				$data = {procedure_name:$name,is_active:$is_active};
				$url = $plRoute+"/update/"+$id;
				$callback = function(data){
					if(data.status==200){
						getList($perpage,1);
						callFlashSlide(data.message,'success');
					}else{
						callFlashSlide(data.message,'error');
					}
				};
				getAjax($url,"post",$data,$callback);
				$("#modalEdit").modal('hide');
				clearModal();
				$('#edit_'+$appName+'_name').removeAttr('data-id');
			}else{
				callFlashSlide("กรึณากรอกข้อมูลให้ครบถ้วน",'error');
			}
		});
		
		/*	get  data to modal for delete*/
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
					callFlashSlide(data.message,'success');
				}else{
					callFlashSlide(data.message,'error');
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
					+'<td style="vertical-align: middle;">'+this.procedure_name+'</td>'
						+'<td style="vertical-align: middle; text-align:center">'
							+'<input type=checkbox '+$is_active+' disabled>'
						+'</td>'
						+'<td style="vertical-align: middle; text-align: center;">'
						+'<i class="fa fa-cog font-gear popover-edit-del"'
							+'data-trigger="focus" tabindex="0" data-html="true"'
							+'data-toggle="popover" data-placement="top"'
							+'data-content="'
								+'<button class=\'btn btn-warning btn-xs btn-gear edit\' data-target=#modalEdit data-toggle=\'modal\' data-id=\''+this.procedure_id+'\'>Edit</button>'
								+'<button class=\'btn btn-danger btn-xs btn-gear del\' data-target=#confrimModal data-toggle=\'modal\' data-id=\''+this.procedure_id+'\' style=\'margin-left: 15px\'>Delete</button>">'
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
