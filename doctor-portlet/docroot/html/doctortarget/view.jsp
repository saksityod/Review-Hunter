<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui"%>
<%@ page import="javax.portlet.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
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
<style>
@media (min-width: 1200px){
	.modal.large {
	    width: 80%;
	    margin-left: -40%;
	    top: 0px;
	}
}
.tr-table-case input{
	text-align:right;
}
.aui .breadcrumbs2 {
	background: rgba(0, 0, 0, 0)
		linear-gradient(to bottom, #fff 0px, #f6f6f6 47%, #ededed 100%) repeat
		scroll 0 0;
	border-radius: 0;
	margin-bottom: 0;
	padding-bottom: 0px
}

.aui #breadcrumbs {
	margin-bottom: 0px;
}

.portlet-content, .portlet-minimized .portlet-content-container {
	background-color: #fafafa;
}

.aui .countPagination {
	width: 70px;
	margin-bottom: 0px:
}

.popover {
	width: 150px;
}

.aui .pagination {
	margin: 5px 0;
}

.pagingDropdown {
	float: right;
	padding-top: 5px;
}

.aui .btn {
	font-size: 14px;
	padding: 5px 12px;
	width: auto;
	margin-top: 0px;
	display: inline;
}

.aui input[type="color"], .aui input[type="date"], .aui input[type="datetime"],
	.aui input[type="datetime-local"], .aui input[type="email"], .aui input[type="month"],
	.aui input[type="number"], .aui input[type="password"], .aui input[type="search"],
	.aui input[type="tel"], .aui input[type="text"], .aui input[type="time"],
	.aui input[type="url"], .aui input[type="week"], .aui select, .aui textarea,
	.aui .input-prepend .add-on, .aui .navbar-search .search-query, .aui .uneditable-input
	{
	font-size: 14px;
	height: auto;
	line-height: normal;
}

.p-t-xxs {
	padding-top: 5px;
}

.p-t-xs {
	padding-top: 10px;
}

.p-b-xxs {
	padding-bottom: 5px;
}

.p-b-xs {
	padding-bottom: 10px;
}

.aui .form-horizontal .form-group {
	margin-left: 0px;
	margin-right: 0px;
}

.aui .form-horizontal .checkbox, .aui .form-horizontal .checkbox-inline,
	.aui .form-horizontal .radio, .aui .form-horizontal .radio-inline {
	margin-bottom: 0;
	margin-top: 0;
	padding-top: 0px;
}

.aui #ui-datepicker-div, .aui .ui-datepicker {
	z-index: 99999 !important;
}

.aui .from_data_role, .aui  .selectEmpCheckbox {
	cursor: pointer;
	height: 17px;
	width: 17px;
}

.aui .checkbox label, .aui .radio label {
	cursor: default;
}

/* new */
.aui .modal-header .close{
	font-size: 1.4em !important;
    margin-top: 4px !important;
    padding-top: 5px !important;
}
.aui .ui-autocomplete{
	z-index: 1300;
}
.aui #from_emp_type {
	width: 170px;
}

.aui #employee_list_content {
	display: none;
}

.aui .form-group {
	margin-bottom: 5px;
}

.aui .control-label {
	cursor: default;
}

.aui input[type="radio"], .aui  input[type="checkbox"] {
	margin: 1px 0 0;
}

.ibox-title {
	padding: 1px 10px;
}

.ibox-content {
	background-color: #fff;
	border: 1px solid #ffe57f;
	color: inherit;
	margin-bottom: 5px;
	padding-left: 15px;
	padding-right: 15px;
}

.aui h5 {
	margin: 7px 0;
}

.gray-bg {
	background-color: #f3f3f4;
}

#objectCenter {
	text-align: center;
	vertical-align: middle;
}

.aui .checkbox input[type="checkbox"] {
	opacity: 1;
	z-index: 1;
}

#table_Sql {
	border-left-width: 1px;
}

.aui .modal {
	top: 10%;
}

#container {
	width: 93.5%;
}

.aui #file {
	width: 100%;
	height: 100%;
}
/* Large desktop */
@media ( max-width : 1310px) {
	.aui [class*="span"], .aui  .uneditable-input[class*="span"], .aui .row-fluid [class*="span"]
		{
		display: block;
		float: none;
		width: 100%;
		margin-left: 0;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
		box-sizing: border-box;
	}
}
@media ( min-width : 1200px) {
	.aui #confrimModal {
		left: 55%;
	}
}

/* Portrait tablet to landscape and desktop */
@media ( min-width : 980px) and (max-width: 1199px) {
	.aui #confrimModal {
		left: 57%;
	}
}

@media ( min-width : 768px) and (max-width: 979px) {
	.aui #confrimModal {
		left: 58.5%;
	}
	.aui .ResultsPerPageTop {
		position: absolute;
		left: -20px;
		top: 46px;
	}
	.aui .ResultsPerPageBottom {
		position: relative;
		top: -40px;
	}
	.aui [class*="span"], .aui  .uneditable-input[class*="span"], .aui .row-fluid [class*="span"]
		{
		display: block;
		float: none;
		width: 100%;
		margin-left: 0;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
		box-sizing: border-box;
	}
	.aui #widthPersenTop {
		width: 10.1%;
	}
	.aui #widthPersenBottom {
		width: 11%;
	}
	.aui .txtCountPaginationTop {
		position: absolute;
		left: -14.9%;
		top: 51px;
		width: 41.66666667%;
	}
	.aui .selectCountPaginationTop {
		position: absolute;
		left: 86.5%;
		top: 51px;
		width: 24%;
	}
	.aui .txtCountPaginationBottom {
		left: -11.5%;
		top: -45px;
		width: 43.96666667%;
		position: relative;
	}
	.aui .selectCountPaginationBottom {
		left: 90.1%;
		top: -75px;
		width: 25%;
		position: relative;
	}
}

/* Landscape phone to portrait tablet */
@media ( max-width : 767px) {
	.aui #confrimModal {
		left: 23.5%;
	}
	.aui .ResultsPerPageTop {
		position: absolute;
		left: -20px;
		top: 46px;
	}
	.aui .ResultsPerPageBottom {
		position: relative;
		top: -40px;
	}
	@media ( min-width : 481px) and (max-width: 615px) {
		.aui .height-32-px {
			height: 42px
		}
		.aui #confrimModal {
			left: 16.5%;
		}
		.aui .ResultsPerPageTop {
			position: absolute;
			left: -20px;
			top: 46px;
		}
		.aui .ResultsPerPageBottom {
			position: static;
		}
	}
	.aui #width-100-persen {
		
	}
	.aui #widthPersenTop {
		width: 10.3%;
	}
	#widthPersenBottom {
		width: 11.2%;
	}
	.aui .txtCountPaginationTop {
		position: absolute;
		left: -14.9%;
		top: 51px;
		width: 41.66666667%;
	}
	.aui .selectCountPaginationTop {
		position: absolute;
		left: 86.5%;
		top: 51px;
		width: 24%;
	}
	.aui .txtCountPaginationBottom {
		left: -11.5%;
		top: -45px;
		width: 43.96666667%;
		position: relative;
	}
	.aui .selectCountPaginationBottom {
		left: 90.1%;
		top: -75px;
		width: 25%;
		position: relative;
	}
}

/* Landscape phones and down */
@media ( max-width : 480px) {
	.aui #from_emp_type {
		width: 100%;
	}
	.aui #confrimModal {
		left: 1%;
	}
	.aui .ResultsPerPageBottom {
		position: static;
	}
	.aui #width-100-persen {
		width: 110%;
	}
	.aui #widthPersenTop {
		width: 17%;
	}
	.aui #widthPersenBottom {
		width: 19.1%;
	}
	.aui .height-32-px {
		height: 42px
	}
	.aui .txtCountPaginationTop {
		position: absolute;
		left: -25%;
		top: 40px;
		width: 41.66666667%;
	}
	.aui .selectCountPaginationTop {
		position: absolute;
		left: 78.5%;
		top: 42px;
		width: 24%;
	}
	.aui .txtCountPaginationBottom {
		left: -21.2%;
		top: -5px;
		width: 43.96666667%;
		position: relative;
	}
	.aui .selectCountPaginationBottom {
		left: 82.9%;
		top: -34px;
		width: 25%;
		position: relative;
	}
}

</style>

<div id="container1" >
				<!--  nav bar -->
				<div class='row-fluid'>

					<div class='col-xs-12'>
						<div id="slide_status" class="span12" style="z-index: 9000;">
						
							<div id="btnCloseSlide"><i class='fa fa-times'></i></div>
							<div id="slide_status_area"></div>
						</div>
					</div>

				</div>
	

				<div class="row-fluid app_url_hidden" >
					<!-- start--row-fluid -->

					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
								<h5>ค้นหา</h5>
							</div>

							<div class="ibox-content breadcrumbs2" style="border-color: rgb(0, 206, 215);">
					<div class="row-fluid p-t-xxs">
				
					
						<div class="form-group pull-left span3" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="ชื่อแพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อแพทย์" id="doctor_name"
								name="doctor_name" type="text">
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="medical_procedure" class="input span12 m-b-n" id="medical_procedure" name="search_org">
								<option selected value="">ศัลยกรรมตา</option>
							</select>
							
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="ปี" class="input span12 m-b-n" id="year" name="year">
								<option selected value="">2017</option>
							</select>
							
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="เดือน" class="input span12 m-b-n" id="month" name="month">
								<option selected value="">พ.ย.</option>
							</select>
							
						</div>
			
						<div class="form-group pull-right m-b-none ">
							<button type="button" name="btn_search"
								id="btn_search" class="btn btn-info input-sm "
								style="margin-left: 5px;">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
						</div>
						
					</div>
	
					<div class="form-group">
							<button type="button" name="btn_add"
								id="btn_add" class="btn btn-success input-sm "
								style="margin-left: 5px;" data-target=#ModalEdit data-toggle='modal'>
								<i class="fa fa-plus"></i>&nbsp;เพิ่ม
							</button>
						</div>
					</div>
					
							</div>
							<!-- content end -->
						</div>

					</div>
					

				</div>
	
				<div class="row-fluid " id="doctor_target_list_content">
					<div class="col-lg-12">
						<div class="ibox-title" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215)">
							<h5>เป้าหมายของแพทย์</h5>
						</div>


						<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
						<div class="row-fluid">
								<div class="height-32-px"></div>
						</div>
						<!-- pagination start -->
							<div class="row-fluid">
								<div id="width-100-persen" class="span9 m-b-xs">
									
									<span class="pagination_top m-b-none pagination" id="yui_patched_v3_11_0_1_1514185894268_841"><ul class="pagination bootpag" id="yui_patched_v3_11_0_1_1514185894268_840"><li data-lp="1" class="first disabled"><a href="javascript:void(0);">←</a></li><li data-lp="1" class="prev disabled"><a href="javascript:void(0);">prev</a></li><li data-lp="1" class="active"><a href="javascript:void(0);">1</a></li><li data-lp="2" id="yui_patched_v3_11_0_1_1514185894268_839"><a href="javascript:void(0);" id="yui_patched_v3_11_0_1_1514185894268_838">2</a></li><li data-lp="3"><a href="javascript:void(0);">3</a></li><li data-lp="4"><a href="javascript:void(0);">4</a></li><li data-lp="5"><a href="javascript:void(0);">5</a></li><li data-lp="2" class="next"><a href="javascript:void(0);">next</a></li><li data-lp="6" class="last"><a href="javascript:void(0);">→</a></li></ul></span>

								</div>
								<div class="span3 object-right ResultsPerPageTop">
		                                    
			                                    <div class='pagingDropdown'>
		                                 			<select  id='countPaginationTop'  class="form-control input-sm countPagination">
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
							<!-- start table -->
							<div class="row-fluid" style="overflow:auto;">
								<table class="table table-striped" id="table_doctor_target">
									<thead>
										<tr>
											<th style='width: auto text-align:center;'><strong>ชื่อแพทย์</strong></th>
											<th style='width: auto'><strong>หัตถการ</strong></th>
											<th style='width: auto'><strong>ปี</strong></th>
											<th style='width: auto'><strong>เดือน</strong></th>
											<th style='width: auto'><strong>เป้าจำนวน Case</strong></th>
											<th style='width: auto;text-align: center;' class='objectCenter'><strong>แก้ไข</strong></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td style="vertical-align: middle;">1</td>
											<td style="vertical-align: middle;">พญ. สาทิสรัตน์ กิจปิลันธ์กรกุล</td>
											<td style="vertical-align: middle;">ศัลยกรรมตา</td>
											<td style="vertical-align: middle;">ปริญญาตรี</td>
											<td style="vertical-align: middle;">มหาวิทยาลัยขอนแก่น</td>
											<td style="vertical-align: middle; text-align:center;">
												<i class="fa fa-cog font-gear popover-edit-del" data-trigger="focus" tabindex="0" data-html="true" data-toggle="popover" 
													data-placement="top" 
													data-content=" 
													<button class='btn btn-warning btn-xs btn-gear edit' data-target=#ModalEdit data-toggle='modal'>แก้ไข</button> 
													<button class='btn btn-danger btn-xs btn-gear del' data-target=#confrimModal data-toggle='modal' style='margin-left: 15px'>ลบ</button>">
												</i>
											</td>
										</tr>
										<tr>
											<td style="vertical-align: middle;">2</td>
											<td style="vertical-align: middle;">พญ. สาทิสรัตน์ กิจปิลันธ์กรกุล</td>
											<td style="vertical-align: middle;">ศัลยกรรมตา</td>
											<td style="vertical-align: middle;">ปริญญาตรี</td>
											<td style="vertical-align: middle;">มหาวิทยาลัยขอนแก่น</td>
											<td style="vertical-align: middle; text-align:center;">
												<i class="fa fa-cog font-gear popover-edit-del" data-trigger="focus" tabindex="1" data-html="true" data-toggle="popover" 
													data-placement="top" 
													data-content=" 
													<button class='btn btn-warning btn-xs btn-gear edit' data-target=#ModalEdit data-toggle='modal'>แก้ไข</button> 
													<button class='btn btn-danger btn-xs btn-gear del' data-target=#confrimModal data-toggle='modal' style='margin-left: 15px'>ลบ</button>">
												</i>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<!-- end table -->
							<!-- pagination start -->
							
							<div class="row-fluid">
								<div id="width-100-persen" class="span9 m-b-xs">
									
									<span class="pagination_top m-b-none pagination" id="yui_patched_v3_11_0_1_1514185894268_841"><ul class="pagination bootpag" id="yui_patched_v3_11_0_1_1514185894268_840"><li data-lp="1" class="first disabled"><a href="javascript:void(0);">←</a></li><li data-lp="1" class="prev disabled"><a href="javascript:void(0);">prev</a></li><li data-lp="1" class="active"><a href="javascript:void(0);">1</a></li><li data-lp="2" id="yui_patched_v3_11_0_1_1514185894268_839"><a href="javascript:void(0);" id="yui_patched_v3_11_0_1_1514185894268_838">2</a></li><li data-lp="3"><a href="javascript:void(0);">3</a></li><li data-lp="4"><a href="javascript:void(0);">4</a></li><li data-lp="5"><a href="javascript:void(0);">5</a></li><li data-lp="2" class="next"><a href="javascript:void(0);">next</a></li><li data-lp="6" class="last"><a href="javascript:void(0);">→</a></li></ul></span>

								</div>
								<div class="span3 object-right ResultsPerPageBottom">
		                                    
		                                    	<div class='pagingDropdown'>
		                                 			<select  id='countPaginationBottom'  class="form-control input-sm countPagination">
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
	<!-- Modal Start Edit -->

	<div aria-hidden="true" role="dialog" class="modal inmodal  large" tabindex="-1" id="ModalEdit"
		class="modal inmodal" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only">Close</span>
					</button>
					<!-- <i class="fa fa-laptop modal-icon"></i> -->
					<h4 class="modal-title" id="modalTitleRole">เป้าหมายของแพทย์</h4>
					<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->
				</div>
				<div class="modal-body">
					<br/>
					<div class="row-fluid">
	                	<div class="span12 form-horizontal p-t-xxs">
	                		<div class="row-fluid p-t-xxs">
				
					
						<div class="form-group pull-left span3" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="ชื่อแพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อแพทย์" id="from_doctor_name"
								name="from_doctor_name" type="text">
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="ประเภท Case" class="input span12 m-b-n" id="case_category" name="case_category">
								<option selected value="">influencer</option>
							</select>
							
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="หัตถการ" class="input span12 m-b-n" id="from_medical_procedure" name="from_medical_procedure">
								<option selected value="">ตาสองชั้น</option>
							</select>
							
						</div>
						<div id="drop_down_organization" class="form-group pull-left span2" style="margin-left: 5px;">
							<select data-toggle="tooltip" title="ปี" class="input span12 m-b-n" id="from_year" name="from_year">
								<option selected value="">2017</option>
							</select>
							
						</div>
					
			
						<div class="form-group pull-right m-b-none ">
							<button type="button" name="from_btn_search"
								id="from_btn_search" class="btn btn-info input-sm "
								style="margin-left: 5px;">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
						</div>
						
					</div>
					<br/>
					
					<strong style="font-size: 15px;">เป้าจำนวน Case</strong>
					<table class="table table-bordered"  style="margin-top: 15px;">
									<thead>
										<tr>
											<th style='width: auto;text-align: center;'><strong>ม.ค.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ก.พ.</strong></th>
											<th style='width: auto;text-align: center;'><strong>มี.ค.</strong></th>
											<th style='width: auto;text-align: center;'><strong>เม.ย.</strong></th>
											<th style='width: auto;text-align: center;'><strong>พ.ค.</strong></th>
											<th style='width: auto;text-align: center;'><strong>มิ.ย.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ก.ค.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ส.ค.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ก.ย.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ต.ค</strong></th>
											<th style='width: auto;text-align: center;'><strong>พ.ย.</strong></th>
											<th style='width: auto;text-align: center;'><strong>ธ.ค.</strong></th>
										</tr>
									</thead>
									<tbody>
										<tr class="tr-table-case">
										
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>

											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
											<td style="vertical-align: middle;">
												<input type="text" value="1" class="input-edit-doctor-edu" style="width: 85%;"/>
											</td>
				
										</tr>
								
									</tbody>
								</table>
	                	<div class="modal-footer">
							<button class="btn btn-info" type="button" id="btn_submit_case_category">บันทึก</button>
							<button class="btn btn-info" type="button" id="btn_submit_next_case_category">บันทึก และไปต่อ</button>
							<button data-dismiss="modal" class="btn btn-danger btnCancle" type="button">ยกเลิก</button>
				
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
		class="modal inmodal in" style="width:400px;left:calc;display: none;">
		<div class="modal-dialog">
			<div class="modal-content  bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:3px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only">Close</span>
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

							<label>Confirm to Delete Data?</label>
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

<!-- Mainly scripts -->
<!-- <script type="text/javascript">var jQuery_1_1_3 = $.noConflict(true);</script> -->

