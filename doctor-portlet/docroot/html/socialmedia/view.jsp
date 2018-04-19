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

<div class="row-fluid " id="">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215)">
			<h5>Social Media</h5>
		</div>


		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
			<div class="row-fluid">
				<div class="height-32-px"></div>
			</div>
			<!-- pagination start -->
			<div class="row-fluid">
				<div id="width-100-persen" class=" m-b-xs">
					<br>
					<button class="btn btn-success" data-type="add" id="btn_add">
						<i class="fa fa-plus"></i>  เพิ่ม
					</button>
					<br><br>
					<!-- start table -->
					<div class="row-fluid" style="overflow: auto;">
						<table class="table table-striped" id="table_social_media">
							<thead>
								<tr>
									<th style='width: auto;'><strong>ชื่อช่องทางลงสื่อ</strong></th>
									<th style='width: 100px; text-align: center;'><strong>Active</strong></th>
									<th style='width: 120px; text-align: center;'><strong>จัดการ</strong></th>
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
								<ul class="pagination bootpag" id="social_media_pagination">
									
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
					<h4 class="modal-title" id="modalTitleRole">ช่องทางลงสื่อ</h4>
				</div>
				<div class="modal-body">
					<br />
					<div class="row-fluid">
						<div class="span12 form-horizontal p-t-xxs">
							<div class="row-fluid p-t-xxs">
								<form class="form-inline" >
									<div class="form-group span12"
										style="margin-left: 5px;">
										<label for=add_social_media class=" control-label">
											ชื่อ <span class="red">*</span>
										</label>
										<div class="span6">
											<input data-toggle="tooltip" title="Name" data-placement="top"
												id="add_social_media_name"
												placeholder="Social Media Name" 
												type="text">
												<!-- <span class="required">asdads</span> -->
										</div>
									</div>
									<div class="form-group" style="margin-left: 5px;">
										<label for="is_active" class="control-label">Active</label>
										<div class="span3">
											<input data-toggle="tooltip"
												title="is active" data-placement="top" 
												id="add_is_active"
												placeholder="is active"
												type="checkbox">
										</div>
									</div>
								</form>
							</div>
							
							<div class="row-fluid">
								<div class="alert alert-warning information" id="information_errors" style="display: none;height:60px; overflow-y: scroll; position:relative;">
								</div>
							</div>

							<div class="modal-footer">
								<button class="btn btn-success" type="button" id="btn_submit_add_social_media">Save</button>
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
	
	
	<!-- Modal Start Edit -->
	<div aria-hidden="true" role="dialog" class="modal inmodal"
		tabindex="-1" id="modalEdit" class="modal inmodal"
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
					<h4 class="modal-title" id="modalTitleRole">ช่องทางลงสื่อ</h4>
				</div>
				<div class="modal-body">
					<br />
					<div class="row-fluid">
						<div class="span12 form-horizontal p-t-xxs">
							<div class="row-fluid p-t-xxs">
								<form class="form-inline">
									<div class="form-group span12"
										style="margin-left: 5px;">
										<label for="edit_social_media_name" class=" control-label">
											ชื่อ <span class="red">*</span>
										</label>
										<div class="span6">
											<input data-toggle="tooltip" title="Name" data-placement="top"
												id="edit_social_media_name" data-id=""
												placeholder="Social Media Name" 
												type="text">
										</div>
									</div>
									<div class="form-group" style="margin-left: 5px;">
										<label for="is_active" class=" control-label">Active</label>
										<div class="span3">
											<input data-toggle="tooltip"
												title="is active" data-placement="top" 
												id="edit_is_active"
												placeholder="is active" 
												type="checkbox">
										</div>
									</div>
								</form>
							</div>
							
							<div class="row-fluid">
								<div class="alert alert-warning information" id="information_errors_update" style="display: none;height:60px; overflow-y: scroll; position:relative;">
								</div>
							</div>

							<div class="modal-footer">
								<button class="btn btn-success" type="button" id="btn_submit_edit_social_media">Update</button>
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
	<!-- Modal End Edit -->
	

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
					<h5 class="modal-title">ยืนยันการลบข้อมูล</h5>
				</div>
				<div class="modal-body">
					<!-- content start -->
					
					<!-- form start -->
					<div class="form-kpi-mangement">
						<div class="form-kpi-label" align="center">

							<label>คุณต้องการลบข้อมูลนี้หรือไม่?</label>
							<div id="inform_on_confirm" class='information'></div>
						</div>
					</div>

					<!-- form start -->
					<!-- content end -->
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

	<input type="hidden" name="id" id="id" value=""> 
	<input type="hidden" name="action" id="action" value="add">