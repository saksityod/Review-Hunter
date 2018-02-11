<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui"%>
<%@ page import="javax.portlet.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ page import="com.liferay.portal.kernel.util.WebKeys"%>
<liferay-theme:defineObjects />
<portlet:defineObjects />
<%
	/*
	PortletSession portletSession1 = renderRequest.getPortletSession();
	portletSession1.setAttribute("password", "authenticated", PortletSession.APPLICATION_SCOPE);
	String pwd = (String) portletSession1.getAttribute("password", PortletSession.APPLICATION_SCOPE);
	out.print(pwd);
	String password=PortalUtil.getUser(request).getPassword();
	*/

	String username = themeDisplay.getUser().getScreenName();
	String password = (String) request.getSession().getAttribute(WebKeys.USER_PASSWORD);
	layout = themeDisplay.getLayout();
	plid = layout.getPlid();
	//out.print(username);
	//out.print("password2="+password);
%>

<input type="hidden" id="user_portlet" name="user_portlet"
	value="<%=username%>">
<input type="hidden" id="pass_portlet" name="pass_portlet"
	value="<%=password%>">
<input type="hidden" id="url_portlet" name="url_portlet"
	value="<%=renderRequest.getContextPath()%>">
<input type="hidden" id="plid_portlet" name="plid_portlet"
	value="<%=plid%>">

<div class='row-fluid '>
 <div class='col-xs-12'>
  <div id="slide_status" class="span12" style="z-index: 9000;">
   <div id="btnCloseSlide"><i class='fa fa-times'></i></div>
   <div id="slide_status_area"></div>
  </div>
 </div>
</div>

<style>
	body{ display:none}
</style>
<div class="row-fluid " id="">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215)">
			<h5>Case Group</h5>
		</div>

		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
			<div class="row-fluid">
				<div class="height-32-px"></div>
			</div>
			<!-- pagination start -->
			<div class="row-fluid">
				<div id="width-100-persen" class=" m-b-xs">
					<br>
					<button class="btn btn-success" data-target=#modalAdd data-toggle='modal' data-type="add">
						<i class="fa fa-plus"></i> Add Case Group
					</button>
					<br><br>
					<!-- start table -->
					<div class="row-fluid" style="overflow: auto;">
						<table class="table table-striped" id="table_case_group">
							<thead>
								<tr>
									<th style='width: auto;'><strong>Case
											Group Name</strong></th>
									<th style='width: 100px; text-align: center;'><strong>is_active</strong></th>
									<th style='width: 120px; text-align: center;'><strong>Manage</strong></th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>

					<!-- end table -->
					<!-- pagination start -->

					<div class="row-fluid">
						<div id="width-100-persen" class="span9 m-b-xs">

							<span class="pagination_top m-b-none pagination"
								id="yui_patched_v3_11_0_1_1514185894268_841">
								<ul class="pagination bootpag" id="case_group_pagination">
									
								</ul>
							</span>

						</div>
						<div class="span3 object-right ResultsPerPageBottom">

							<div class='pagingDropdown'>
								<select id='countPaginationBottom'
									class="form-control input-sm countPagination">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
							</div>
							<div class='pagingText'>Results per page</div>
						</div>
					</div>
					<!-- pagination end -->

				</div>
				<!-- content end -->
			</div>
		</div>

	</div>
	
	
	<!-- Modal Start Add -->
	<div aria-hidden="true" role="dialog" class="modal inmodal"
		tabindex="-1" id="modalAdd" class="modal inmodal"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content bounceInRight">
				<div class="modal-header"
					style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button"
						style="padding-top: 5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span
							class="sr-only"></span>
					</button>
					<h4 class="modal-title" id="modalTitleRole">New Case Group</h4>
				</div>
				<div class="modal-body">
					<br />
					<div class="row-fluid">
						<div class="span12 form-horizontal p-t-xxs">
							<div class="row-fluid p-t-xxs">
								<form class="form-inline" >
									<div class="form-group span12"
										style="margin-left: 5px;">
										<label for="case_group_name" class=" control-label">
											Name <span class="red">*</span>
										</label>
										<div class="span6">
											<input
												id="from_case_group_name"
												placeholder="Case group name" 
												type="text">
												<!-- <span class="required">asdads</span> -->
										</div>
									</div>
									<div class="form-group span12" style="margin-left: 5px;">
										<label for="is_active" class="control-label">is Active</label>
										<div class="span6">
											<input
												data-placement="top" 
												id="from_is_active"
												placeholder="is active"
												type="checkbox">
										</div>
									</div>
								</form>
							</div>

							<div class="modal-footer">
								<button class="btn btn-success" type="button" id="btn_submit_from_case_group">Save</button>
								<button data-dismiss="modal" class="btn btn-danger btnCancle" type="button">Cancel</button>
							</div>
						</div>
					</div>

					<!-- form End -->
					<!-- content end -->
				</div>

			</div>
		</div>
	</div>
	<!-- Modal End Add -->
	
	
	<!-- Modal Confirm Start -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="confrimModal"
		class="modal inmodal in"
		style="width: 400px; left: calc; display: none;">
		<div class="modal-dialog">
			<div class="modal-content  bounceInRight">
				<div class="modal-header"
					style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button"
						style="padding-top: 3px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span
							class="sr-only">Close</span>
					</button>
					<h5 class="modal-title">Confirm Dialog</h5>
				</div>
				<div class="modal-body">
					<div class="form-kpi-mangement">
						<div class="form-kpi-label" align="center">
							<label>Confirm to Delete Data?</label>
							<div id="inform_on_confirm" class='information'></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div align="center">
						<button class="btn btn-success" id="btnConfirmOK" type="button">
							&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Yes&nbsp;&nbsp;
						</button>
						&nbsp;&nbsp;
						<button data-dismiss="modal" class="btn btn-danger" type="button">
							<i class="fa fa-times-circle"></i>&nbsp;Cancel
						</button>
					</div>
					<div class="alert alert-warning information" id="information"
						style="display: none;"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Confirm End -->

	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "case_group";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName; 
		$('body').fadeIn('slow');
		getList($perpage,1);
		
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
			getAjax($plRoute+"/cu",'post',data,function(rs){
				if(rs.status == 200){
					$('#modalAdd').modal('hide');
					getList($perpage,1);
	 				callFlashSlide("สร้างข้อมูลสำเร็จ.",'success');
				}else{
	 				callFlashSlide("ไม่สามารถเพิ่มข้อมูลได้.",'error');
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
					}else{
						callFlashSlide("ไม่สามารถลบข้อมูลได้",'error');
					}
	 				$('#confrimModal').modal('hide');
				});
			});
		})
		
		
		$('body').on('click','.edit',function(){
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
										+'<button class=\'btn btn-warning btn-xs btn-gear edit\' data-target=#modalAdd data-toggle=\'modal\' data-id=\''+this.case_group_id+'\'>Edit</button>'
										+'<button class=\'btn btn-danger btn-xs btn-gear del\' data-target=#confrimModal data-toggle=\'modal\' data-id=\''+this.case_group_id+'\' style=\'margin-left: 15px\'>Delete</button>">'
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

	

</script>
