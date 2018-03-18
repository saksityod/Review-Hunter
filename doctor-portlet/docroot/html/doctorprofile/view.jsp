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
String password = (String)request.getSession().getAttribute(WebKeys.USER_PASSWORD);
layout = themeDisplay.getLayout();
plid = layout.getPlid();
//out.print(username);
//out.print("password2="+password);
%>
<input type="hidden" id="user_portlet" name="user_portlet" value="<%=username%>">
<input type="hidden" id="pass_portlet" name="pass_portlet" value="<%=password%>">
<input type="hidden" id="url_portlet" name="url_portlet" value="<%= renderRequest.getContextPath() %>">
<input type="hidden" id="plid_portlet" name="plid_portlet" value="<%= plid %>">

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


						<div class="form-group pull-left span6">
						<label>ชื่อแพทย์</label>	
							<input data-toggle="tooltip"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อแพทย์" id="doctor_name" name="doctor_name"
								type="text">
						</div>
						<div id="drop_down_organization"
							class="form-group pull-left span4">
						<label>หัตถการ</label>	
							<select data-toggle="tooltip"
								class="input span12 m-b-n" id="medical_procedure"
								name="search_org">
								<option selected value="">-- ทั้งหมด  --</option>
							</select>

						</div>

						<div class="form-group pull-right m-b-none ">
						<label>&nbsp;</label>
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

<div class="row-fluid " id="doctor_list_content">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
			<h5>รายชื่อแพทย์  
				<span type="button" name="btn_add" id="btn_add" class="btn btn-success input-sm "
					style="margin-left: 5px;" data-target=#ModalEditDetail data-toggle='modal' data-backdrop="static" data-keyboard="false">
					<i class="fa fa-plus"></i>&nbsp;เพิ่ม
				</span>
			</h5>
			
		</div>


		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
			<div class="row-fluid">
				<div class="height-32-px"></div>
			</div>
			
			<!-- start table -->
			<div class="row-fluid" style="overflow: auto;">
				<table class="table table-striped" id="table_doctor_profile">
					<thead>
						<tr>
							<th style='width: auto text-align:center;'><strong>ลำดับ</strong></th>
							<th style='width: auto'><strong>ชื่อแพทย์</strong></th>
							<th style='width: auto'><strong>หัตถการ</strong></th>
							<th style='width: auto'><strong>ระดับการศึกษา</strong></th>
							<th style='width: auto'><strong>สถาบันการศึกษา</strong></th>
							<th style='width: auto; text-align: center;' class='objectCenter'><strong>จัดการ</strong></th>
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
						<ul class="pagination bootpag" id="doctor_profile_pagination"></ul>
					</span>

				</div>
				<div class="span3 object-right ResultsPerPageBottom">
					<div class='pagingDropdown'>
						<select id='countPaginationBottom'
							class="form-control input-sm countPagination">
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

<!-- Modal Start Edit -->
<div aria-hidden="true" role="dialog" class="modal inmodal  large"
	tabindex="-1" id="ModalEditDetail" class="modal inmodal"
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
				<h4 class="modal-title" id="modalTitleRole">ข้อมูลแพทย์</h4>
				<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->
			</div>
			<div class="modal-body">
				<div class="row-fluid">
					<div class="span12 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ชื่อแพทย์:<span
								class='redFont'>*</span></label>
							<div class="controls">
								<input type="text" class="form-control input-sm validation"
									placeholder="" name="from_doctor_name" id="from_doctor_name">
							</div>
						</div>
						<div class="form-group p-xxs">
							<label class="control-label">เพศ:<span class='redFont '>*</span></label>
							<div class="controls">
								<select class="input span12 m-b-n" style="width: 70px"
									name="from_doctor_sex validation" id="from_doctor_sex">
									<option value="male">ชาย</option>
									<option value="female">หญิง</option>
								</select>
							</div>
						</div>
						<div class="form-group p-xxs"
							style="margin-top: 15px; margin-bottom: 15px;">
							<label class="control-label">หัตถการ:<span class='redFont'>*</span></label>
							<div class="controls">
								<select class="validation" id="from_medical_procedure" name="from_medical_procedure " multiple="multiple"></select> 
								<span style="margin-left:20px">
									<input type="checkbox" id="from_active" name="from_active"/>
									Active
								</span>
							</div>
						</div>


						<div class="form-group p-xxs">
							<label class="control-label">ความเชี่ยวชาญ:<span class='redFont'>*</span></label>
							<div class="controls">
								<textarea rows="4" cols="50" class="form-control input-sm validation" 
									name="from_doctor_exp" id="from_doctor_exp"></textarea>
							</div>
						</div>
						<div class="wrap">
							<strong style="font-size: 15px">การศึกษา</strong> <br />
							<div style="margin-left: 20px; padding-top: 0.5rem; padding-bottom: 0.5rem;">
								<button data-method='edu' style='display:none' class=" btn btn-success btn-add-edu btn-add" type="button"
										data-elm='<tr class="edit-edu tr-dump" data-id="">
													<td></td>
													<td><input type="text" class=" edu-inst validation"  /></td>
													<td><input type="text" class=" edu-level validation"  /></td>
													<td><input type="text" class=" edu-degree validation" /></td>
													<td><input type="checkbox" class="edu-is-use" /></td>
													<td><a class="btn btn-danger del_tr" ><i class="fa fa-times-circle"></i></a></td>
												</tr>' 
										>เพิ่ม</button>
								<button style='display:none' class=" btn btn-warning btn-edit-edu btn-edit" type="button">แก้ไข</button>
								<button style='display:none' class=" btn btn-danger btn-cancel btn-cancel-edit-edu" type="button">ยกเลิก</button>
								<button style='display:none' class=" btn btn-danger btn-del" data-method="edu" type="button">ลบ</button>
							</div>
	
							<table class="table table-striped edu-table">
								<thead>
									<tr>
										<th style='width: 20px; text-align:center;'><strong><span class="clickSelector">เลือก</span></strong></th>
										<th style='width: auto;'><strong>สถาบันการศึกษา</strong></th>
										<th style='width: auto'><strong>ระดับการศึกษา</strong></th>
										<th style='width: auto'><strong>วุฒิการศึกษา</strong></th>
										<th style='width: 60px;text-align:center'><strong>ใช้แสดง</strong></th>
										<th style='width: 20px'><strong></strong></th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<br/>
						<div class="wrap">
						
							<strong style="font-size: 15px;">ประสบการณ์การทำงาน</strong> <br />
							<div style="margin-left: 20px; padding-top: 0.5rem; padding-bottom: 0.5rem;">
								<button data-method='work' style='display:none' class="btn btn-success btn-add-exp btn-add" type="button"
									data-elm = '<tr class="edit-exp tr-dump" data-id="">
										<td></td>
										<td><select class=" exp-start build-work-datepicker validation" type="text"></select></td>
										<td><select class=" exp-end build-work-datepicker validation" type="text" ></select></td>
										<td><input class=" exp-comp validation" type="text"></td>
										<td ><a class="btn btn-danger del_tr"><i class="fa fa-times-circle"></i></a></td>
									</tr>'>เพิ่ม</button>
								<button style='display:none' class=" btn btn-warning btn-edit btn-edit-exp " type="button">แก้ไข</button>
								<button style='display:none' class=" btn btn-danger btn-cancel btn-edit-exp-cancel " type="button">ยกเลิก</button>
								<button style='display:none' class=" btn btn-danger btn-del" data-method="work" type="button">ลบ</button>
							</div>
	
							<table class="table table-striped work-table">
							<thead>
								<tr>
									<th style='width: 20px; text-align:center;'><strong><span class="clickSelector">เลือก</span></strong></th>
									<th style='max-width: 60px; text-align:center;'><strong>เริ่มปี</strong></th>
									<th style='max-width: 60px; text-align:center;'><strong>ถึงปี</strong></th>
									<th style='width: auto'><strong>คลินิก/บริษัท</strong></th>
									<th style='width: 20px'><strong></strong></th>
								</tr>
							</thead>
							<tbody>								
							</tbody>
						</table>
						</div>
						
						<div class="modal-footer">
							<button class="btn btn-info" type="button" id="btnLvSubmit">บันทึก</button>
							<!-- <button class="btn btn-info" type="button" id="btnLvSubmit">บันทึก
								และไปต่อ</button> -->
							<button data-dismiss="modal" class="btn btn-danger btnCancle"
								type="button">ยกเลิก</button>

						</div>
					</div>
				</div>	<!-- form End -->
				
			</div><!-- modal body -->

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
				<h5 class="modal-title">Confirm Dialog</h5>
			</div>
			<div class="modal-body">
				
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">
						<label>Confirm to Delete Data?</label>
						<div id="inform_on_confirm" class='information'></div>
					</div>
				</div>

			</div><!-- modal body -->
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