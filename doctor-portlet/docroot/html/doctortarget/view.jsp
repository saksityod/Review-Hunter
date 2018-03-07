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


<style>
	.ui-autocomplete{ z-index:1099 !important}
	html{display:none}
</style>

<div id="container1">
	<!--  nav bar -->
	<div class='row-fluid'>

		<div class='col-xs-12'>
			<div id="slide_status" class="span12" style="z-index: 9000;">

				<div id="btnCloseSlide">
					<i class='fa fa-times'></i>
				</div>
				<div id="slide_status_area"></div>
			</div>
		</div>

	</div>


	<div class="row-fluid app_url_hidden">
		<!-- start--row-fluid -->

		<div class="col-lg-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title"
					style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<h5>ค้นหา</h5>
				</div>

				<div class="ibox-content breadcrumbs2"
					style="border-color: rgb(0, 206, 215);">
					<div class="row-fluid p-t-xxs">

						<div class="form-group pull-left span3" style="margin-left: 5px;">
						<label class="">ชื่อแพทย์</label>
							<input class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อแพทย์" id="doctor_name" name="doctor_name"
								type="text">
						</div>
						<div id="drop_down_organization"
							class="form-group pull-left span2" style="margin-left: 5px;">
							<label class="">หัตถการ</label>
							<select class="input span12 m-b-n" id="medical_procedure"
								name="search_org">
							</select>

						</div>
						<div id="drop_down_organization"
							class="form-group pull-left span2" style="margin-left: 5px;">
							<label class="">ปี</label>
							<select class="input span12 m-b-n" id="year" name="year">
							</select>

						</div>
						<div id="drop_down_organization"
							class="form-group pull-left span2" style="margin-left: 5px;">
							<label class="">เดือน</label>
							<select class="input span12 m-b-n" id="month" name="month">
							</select>

						</div>

						<div class="form-group pull-right m-b-none ">
						<label class=""></label>
							<button type="button" name="btn_search" id="btn_search"
								class="btn btn-info input-sm " style="margin-left: 5px;">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
						</div>

					</div>

					
				</div>

			</div>
			<!-- content end -->
		</div>

	</div>


</div>

<div class="row-fluid " id="doctor_target_list_content">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215)">
			<h5>เป้าหมายของแพทย์ <button type="button" name="btn_add" id="btn_add"
							class="btn btn-success input-sm " style="margin-left: 5px;"
							data-target=#ModalEdit data-toggle='modal'>
							<i class="fa fa-plus"></i>&nbsp;เพิ่ม
						</button></h5>
			
						
		</div>


		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
			<div class="row-fluid">
				<div class="height-32-px"></div>
			</div>
			
			<!-- start table -->
			<div class="row-fluid" style="overflow: auto;">
				<table class="table table-striped" id="table_doctor_target">
					<thead>
						<tr>
							<th style='width: auto text-align:center;'><strong>ชื่อแพทย์</strong></th>
							<th style='width: auto'><strong>หัตถการ</strong></th>
							<th style='width: auto'><strong>ปี</strong></th>
							<th style='width: 120px '><strong>เป้าหมาย(Case)</strong></th>
							<th style='width: auto;' class='objectCenter'><strong>แก้ไข</strong></th>
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

					<span class="pagination_top m-b-none pagination" id="">
						<ul class="pagination bootpag" id="doctor_profile_target"></ul>
					</span>

				</div>
				<div class="span3 object-right ResultsPerPageBottom">

					<div class='pagingDropdown'>
						<select id='countPaginationBottom' class="form-control input-sm countPagination">
							<option>10</option>
							<option>20</option>
							<option>50</option>
							<option>100</option>
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

<!-- Modal Start View -->
<div aria-hidden="true" role="dialog" class="modal inmodal  large" tabindex="-1" id="ModalView" class="modal inmodal"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content bounceInRight">
			<div class="modal-header"
				style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
				<button data-dismiss="modal" class="close" type="button"
					style="padding-top: 5px">
					<span aria-hidden="true"><i class='fa fa-times'></i></span><span
						class="sr-only">Close</span>
				</button>
				<!-- <i class="fa fa-laptop modal-icon"></i> -->
				<h4 class="modal-title" id="modalTitleRole">เป้าหมายของแพทย์</h4>
				<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->
			</div>
			<div class="modal-body">
				<div class="row-fluid">
					<div class="span12 form-horizontal p-t-xxs">
						<div class="row-fluid p-t-xxs">


							<div class="form-group pull-left span3" style="margin-left: 5px;">
								<label class="">ชื่อแพทย์ (Auto complate):</label>
								<input class=" m-b-n ui-autocomplete-input view-disabled" placeholder="ชื่อแพทย์" id="from_doctor_namee"
									name="from_doctor_namee" type="text"
									data-doctor_id="" data-doctor_name="">
							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">ประเภท Case:</label>
								<input class=" m-b-n ui-autocomplete-input view-disabled" id="case_categoryy"
									name="case_categoryy" type="text"
									data-doctor_id="" data-doctor_name="">

							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">หัตถการ:</label>
								<input class=" m-b-n ui-autocomplete-input view-disabled" id="from_medical_proceduree"
									name="from_medical_proceduree" type="text"
									data-doctor_id="" data-doctor_name="">

							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">ปี</label>
								<select class="input span12 m-b-n view-disabled" id="from_yearr" name="from_yearr">
								</select>
							</div>


							<!-- <div class="form-group pull-right m-b-none ">
								<button type="button" name="from_btn_search"
									id="from_btn_search" class="btn btn-info input-sm "
									style="margin-left: 5px;">
									<i class="fa fa-search"></i>&nbsp;ค้นหา
								</button>
							</div> -->

						</div>
						<br /> <strong style="font-size: 15px;">เป้าจำนวน Case</strong>
						<table class="table table-bordered" style="margin-top: 15px;">
							<thead>
								<tr>
									<th style='width: auto; text-align: center;'><strong>ม.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.พ.</strong></th>
									<th style='width: auto; text-align: center;'><strong>มี.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>เม.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>พ.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>มิ.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ส.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ต.ค</strong></th>
									<th style='width: auto; text-align: center;'><strong>พ.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ธ.ค.</strong></th>
								</tr>
							</thead>
							<tbody>
								<tr class="tr-table-case">

									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month11" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month22" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month33" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month44" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month55" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month66" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month77" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month88" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month99" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month100" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month111" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="view-disabled" id="form-case-month122" style="width: 85%;" min="0"/>
									</td>

								</tr>

							</tbody>
						</table>
					</div>
				</div>

				<!-- form End -->
				<!-- content end -->
			</div>

		</div>
	</div>
</div>
<!-- Modal End View -->


<!-- Modal Start Edit -->
<div aria-hidden="true" role="dialog" class="modal inmodal  large" tabindex="-1" id="ModalEdit" class="modal inmodal"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content bounceInRight">
			<div class="modal-header"
				style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
				<button data-dismiss="modal" class="close" type="button"
					style="padding-top: 5px">
					<span aria-hidden="true"><i class='fa fa-times'></i></span><span
						class="sr-only">Close</span>
				</button>
				<!-- <i class="fa fa-laptop modal-icon"></i> -->
				<h4 class="modal-title" id="modalTitleRole">เป้าหมายของแพทย์</h4>
				<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->
			</div>
			<div class="modal-body">
				<div class="row-fluid">
					<div class="span12 form-horizontal p-t-xxs">
						<div class="row-fluid p-t-xxs">


							<div class="form-group pull-left span3" style="margin-left: 5px;">
								<label class="">ชื่อแพทย์ (Auto complate):</label>
								<input class=" m-b-n ui-autocomplete-input validate" placeholder="ชื่อแพทย์" id="from_doctor_name"
									name="from_doctor_name" type="text"
									data-doctor_id="" data-doctor_name="">
							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">ประเภท Case:</label>
								<select class="input span12 m-b-n validate" id="case_category" name="case_category">
								</select>

							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">หัตถการ:</label>
								<select class="input span12 m-b-n validate" id="from_medical_procedure" name="from_medical_procedure">
								</select>

							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">ปี</label>
								<select class="input span12 m-b-n validate" id="from_year" name="from_year">
								</select>
							</div>
							<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
								<label class="">แจ้งเตือน</label>
								<select class="input span12 m-b-n validate" id="alert_multi" name="alert_multi" multiple="multiple">
									
								</select>
							</div>


							<!-- <div class="form-group pull-right m-b-none ">
								<button type="button" name="from_btn_search"
									id="from_btn_search" class="btn btn-info input-sm "
									style="margin-left: 5px;">
									<i class="fa fa-search"></i>&nbsp;ค้นหา
								</button>
							</div> -->

						</div>
						<br /> <strong style="font-size: 15px;">เป้าจำนวน Case</strong>
						<table class="table table-bordered" style="margin-top: 15px;">
							<thead>
								<tr>
									<th style='width: auto; text-align: center;'><strong>ม.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.พ.</strong></th>
									<th style='width: auto; text-align: center;'><strong>มี.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>เม.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>พ.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>มิ.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ส.ค.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ก.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ต.ค</strong></th>
									<th style='width: auto; text-align: center;'><strong>พ.ย.</strong></th>
									<th style='width: auto; text-align: center;'><strong>ธ.ค.</strong></th>
								</tr>
							</thead>
							<tbody>
								<tr class="tr-table-case">

									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month1" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month2" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month3" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month4" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month5" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month6" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month7" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month8" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month9" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month10" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month11" style="width: 85%;" min="0"/>
									</td>
									<td style="vertical-align: middle;">
										<input type="number" value="0" class="validate" id="form-case-month12" style="width: 85%;" min="0"/>
									</td>

								</tr>

							</tbody>
						</table>
						<div class="modal-footer">
							<button class="btn btn-info" type="button"
								id="btn_submit_doctor_target">บันทึก</button>
							<button class="btn btn-info" type="button"
								id="btn_submit_next_case_category">บันทึก และไปต่อ</button>
							<button data-dismiss="modal" class="btn btn-danger btnCancle"
								type="button">ยกเลิก</button>

						</div>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="alert alert-warning information" id="information_errors" style="display: none;height:60px; overflow-y: scroll; position:relative;">
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
				<!-- <h2><i class="fa fa fa-pencil-square-o icon-title"></i> ADD NEW GRADE</h2>
                <hr>
                 -->
				<!-- form start -->
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">

						<label>ยืนยันจะลบข้อมูลนี้หรือไม่?</label>
						<div id="inform_on_confirm" class='information'></div>
					</div>
				</div>

				<!-- form start -->
				<!-- content end -->
			</div>
			<div class="modal-footer">
				<div align="center">
					<button class="btn btn-success" id="btnConfirmOK" type="button">
						&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;ตกลง&nbsp;&nbsp;
					</button>
					&nbsp;&nbsp;
					<button data-dismiss="modal" class="btn btn-danger" type="button">
						<i class="fa fa-times-circle"></i>&nbsp;ยกเลิก
					</button>
				</div>
				<div class="alert alert-warning information" id="information"
					style="display: none;"></div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Confirm End -->


<!-- Modal Confirm Start -->
<div aria-hidden="true" role="dialog" tabindex="-1" id="confrimModalSaveTarget"
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
				<!-- content start -->
				<!-- <h2><i class="fa fa fa-pencil-square-o icon-title"></i> ADD NEW GRADE</h2>
                <hr>
                 -->
				<!-- form start -->
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">

						<label>มีเป้าหมายของแพทย์ท่านนี้อยู่แล้ว ต้องการที่จะอัพเดทหรือไม่?</label>
						<div id="" class='information'></div>
					</div>
				</div>

				<!-- form start -->
				<!-- content end -->
			</div>
			<div class="modal-footer">
				<div align="center">
					<button class="btn btn-success" id="btn_confirm_update" type="button">
						&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Yes&nbsp;&nbsp;
					</button>
					&nbsp;&nbsp;
					<button data-dismiss="modal" class="btn btn-danger" type="button">
						<i class="fa fa-times-circle"></i>&nbsp;Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Confirm End -->

<input type="hidden" name="id" id="id" value="">
<input type="hidden" name="action" id="action" value="add">