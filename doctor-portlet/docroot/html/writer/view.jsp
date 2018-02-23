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
#file {
	width: 100%;
	height: 100%;
}
#fileForm {
	width: 100%;
	height: 100%;
}
#fileFormWorkflow {
	width: 100%;
	height: 100%;
}
.ui-autocomplete {
	z-index:1099 !important
}
.aui .cus_information_area label{
	margin-bottom: 1px;
}

</style>
<!-- <style>
@media ( min-width : 1200px) {
	.modal.large {
		width: 80%;
		margin-left: -40%;
		top: 0px;
	}
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
.aui .modal-header .close {
	font-size: 1.4em !important;
	margin-top: 4px !important;
	padding-top: 5px !important;
}

.aui .ui-autocomplete {
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
	top: 2%;
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
 -->
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
				<div class="ibox-title" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<h5>ค้นหา</h5>
				</div>
				<div class="ibox-content breadcrumbs2"
					style="border-color: rgb(0, 206, 215);">
					
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3">
							<label class="label-control" for="">ชื่อผู้เขียน</label>
							<input data-toggle="tooltip" title="ชื่อ Case"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อผู้เขียน" id="search_article" name="search_article"
								type="text">
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">หัตถการ</label>
							<select data-toggle="tooltip" title="หัตถการ" data-placement="top"
								class="input span12 m-b-n" id="search_procedure"
								name="search_procedure">
							</select>
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">ชื่อแพทย์</label>
							<input data-toggle="tooltip" title="ชื่อแพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="แพทย์" id="search_doctor" name="search_doctor"	type="text">
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">จากวันที่</label>
							<input data-toggle="tooltip" title="จากวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="จากวันที่" id="search_start_date" name="search_start_date"
								type="text">
						</div>
					</div>
					
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3">
							<label class="label-control" for="">ถึงวันที่</label>
							<input data-toggle="tooltip" title="ถึงวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ถึงวันที่" id="search_end_date" name="search_end_date"
								type="text">
						</div>
						<div class="form-group text-right span9" style=" margin-top: 25px;">
							<button type="button" name="btn_search" id="btn_search"	class="btn btn-info input-sm">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
						</div>
					</div>
										
<!-- 					<div class="row-fluid p-t-xxs"> -->
<!-- 						<div class="form-group pull-left span2" style="margin-left: 5px;"> -->
<!-- 							<input data-toggle="tooltip" title="ชื่อผู้เขียน" -->
<!-- 								data-placement="top" class="span12 m-b-n ui-autocomplete-input" -->
<!-- 								placeholder="ชื่อผู้เขียน" id="search_article" name="search_article" -->
<!-- 								type="text"> -->
<!-- 						</div> -->
<!-- 						<div class="form-group pull-left span2" style="margin-left: 5px;"> -->
<!-- 								<select data-toggle="tooltip" title="หัตถการ" data-placement="top"  -->
<!-- 								class="span12" id="search_procedure" name="search_procedure"> -->
<!-- 								</select> -->
<!-- 						</div> -->
<!-- 						<div class="form-group pull-left span2" style="margin-left: 5px;"> -->
<!-- 							<input data-toggle="tooltip" title="แพทย์" -->
<!-- 								data-placement="top" class="span12 m-b-n ui-autocomplete-input" -->
<!-- 								placeholder="แพทย์" id="search_doctor" name="search_doctor" -->
<!-- 								type="text"> -->
<!-- 						</div> -->
<!-- 						<div class="form-group pull-left span2" style="margin-left: 5px;"> -->
<!-- 							<input data-toggle="tooltip" title="จากวันที่" -->
<!-- 								data-placement="top" class="span12 m-b-n ui-autocomplete-input" -->
<!-- 								placeholder="จากวันที่" id="search_start_date" name="search_start_date" -->
<!-- 								type="text"> -->
<!-- 						</div> -->
<!-- 						<div class="form-group pull-left span2" style="margin-left: 5px;"> -->
<!-- 							<input data-toggle="tooltip" title="ถึงวันที่" -->
<!-- 								data-placement="top" class="span12 m-b-n ui-autocomplete-input" -->
<!-- 								placeholder="ถึงวันที่" id="search_end_date" name="search_end_date" -->
<!-- 								type="text"> -->
<!-- 						</div> -->
<!-- 						<div class="form-group pull-right m-b-none "> -->
<!-- 							<button type="button" name="btn_search" id="btn_search" -->
<!-- 								class="btn btn-info input-sm " style="margin-left: 5px;"> -->
<!-- 								<i class="fa fa-search"></i>&nbsp;ค้นหา -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
				</div>
			</div>
			<!-- content end -->
		</div>
	</div>
</div>

<div class="row-fluid">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
			<h5>สถานะของ content
			 	<button type="button" name="btn_add" id="btn_add" class="btn btn-success input-sm" data-target=#ModalWriter data-toggle='modal' style="margin-left: 5px;">
			 	<i class="fa fa-plus"></i>&nbsp;เพิ่ม
				</button>
			</h5>
		</div>
		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
<!-- 			<!-- pagination start -->
<!-- 				<div class="row-fluid"> -->
<!-- 					<div id="width-100-persen" class="span9 m-b-xs"> -->
<!-- 						<span class="pagination_top m-b-none pagination"></span> -->
<!-- 					</div> -->
<!-- 					<div class="span3 object-right ResultsPerPageTop"> -->
<!-- 						<div class='pagingDropdown'> -->
<!-- 		                	<select  id='countPaginationTop'  class="form-control input-sm countPagination"> -->
<!-- 						        <option>10</option> -->
<!-- 						        <option>20</option> -->
<!-- 						        <option>50</option> -->
<!-- 						        <option>100</option> -->
<!-- 					        </select>           		 -->
<!-- 		                </div> -->
<!-- <!-- 						<div class='pagingText'>Results per page</div>                       -->
<!-- 		        	</div> -->
<!-- 				</div> -->
<!-- 			<!-- pagination end -->
			<!-- start table -->
			<div class="row-fluid" style="overflow: auto;">
				<table class="table table-striped" id="">
					<thead>
						<tr>
							<th style='width: auto'><strong>ชื่อบทความ</strong></th>
							<th style='width: auto'><strong>ผู้เขียน</strong></th>
							<th style='width: auto'><strong>หัตถการ</strong></th>
							<th style='width: auto'><strong>แพทย์</strong></th>
							<th style='width: auto'><strong>วันที่เริ่มเขียน</strong></th>
							<th style='width: auto'><strong>วันที่เขียนเสร็จ</strong></th>
							<th style='width: auto'><strong>กำหนดส่ง</strong></th>
							<th style='width: auto'><strong>ประเภทบทความ</strong></th>
							<th style='width: auto'><strong>สถานะงาน</strong></th>
							<th style='width: auto' colspan='3'></th>
						</tr>
					</thead>
					<tbody id="result_search_writer">
<!-- 						<tr> -->
<!-- 							<td style="vertical-align: middle;">เสร้มจมูกซิลิโคน</td> -->
<!-- 							<td style="vertical-align: middle;">โซ</td> -->
<!-- 							<td style="vertical-align: middle;">จมูกซิลิโคน</td> -->
<!-- 							<td style="vertical-align: middle;">หมอต้น</td> -->
<!-- 							<td style="vertical-align: middle;">11/10/2017</td> -->
<!-- 							<td style="vertical-align: middle;">16/10/2017</td> -->
<!-- 							<td style="vertical-align: middle;">30/10/2016</td> -->
<!-- 							<td style="vertical-align: middle;">New Review</td> -->
<!-- 							<td style="vertical-align: middle;">Approve content</td> -->
<!-- 							<td style="vertical-align: middle;"> -->
<!-- 								<button type="button" name="btn_result_download" id="btn_result_download" -->
<!-- 									class="btn btn-info input-sm" data-toggle="tooltip" title="ดาวห์โหลด" -->
<!-- 								data-placement="top"><i class="fa fa-download"></i> -->
<!-- 								</button> -->
<!-- 								<button type="button" name="btn_result_upload" id="btn_result_upload" -->
<!-- 									class="btn btn-success input-sm" data-target="#ModalImport" -->
<!-- 									data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i> -->
<!-- 								</button> -->
<!-- 								<button type="button" name="btn_result_edit" id="btn_result_edit" -->
<!-- 									class="btn btn-warning input-sm" data-target=#ModalWriter data-toggle='modal' title="แก้ไข" -->
<!-- 								data-placement="top"><i class="fa fa-cog"></i> -->
<!-- 								</button> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
			</div>
			<!-- end table -->
			
<!-- 				pagination start -->
<!-- 				<div class="row-fluid"> -->
<!-- 					<div id="width-100-persen" class="span9 m-b-xs "> -->
<!-- 						<span class="pagination_bottom m-b-none pagination"></span> -->
<!-- 					</div> -->
<!-- 					<div class="span3 object-right ResultsPerPageBottom"> -->
<!-- 		            	<div class='pagingDropdown'> -->
<!-- 		                <select  id='countPaginationBottom'  class="form-control input-sm countPagination"> -->
<!-- 					       <option>10</option> -->
<!-- 					                                     <option>20</option> -->
<!-- 					                                     <option>50</option> -->
<!-- 					                                     <option>100</option> -->
<!-- 					                                 </select>  -->
<!-- 			                                 	</div> -->
<!-- 												<div class='pagingText'>Results per page</div> -->
<!-- 		                        </div> -->
<!-- 							</div> -->
<!-- 							pagination end -->
		</div>
		<!-- content end -->
	</div>
</div>

<!-- Modal Start -->
<div aria-hidden="true" role="dialog" class="modal inmodal large"
	tabindex="-1" id="ModalWriter" class="modal inmodal"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content bounceInRight">
			<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
				<button data-dismiss="modal" class="close" type="button" style="padding-top: 5px">
					<span aria-hidden="true"><i class='fa fa-times'></i></span>
					<span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="modalTitleRole">Add/Edit Writer</h4>
			</div>
			
			<div class="modal-body">
				<!-- content start -->
				<!-- form start -->
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ชื่อบทความ :</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									name="article_name" id="article">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ประเภทบทความ :</label>
							<div class="controls">
								<select class="form-control input-sm span12" id="article_type" name="article_type">
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">หัตถการ :</label>
							<div class="controls">
								<select class="form-control input-sm span12" id="procedure_name" name="procedure_name">
								</select>
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">แพทย์ :</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="form_doctor" id="form_doctor">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ผู้เขียน :</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="author" id="author">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">วันที่เริ่มเขียน : </label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="start_date" id="start_date">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">กำหนดส่ง : </label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="plan_date" id="plan_date">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">แนบบทความ: </label>
							<div class="controls">
								<button type="button" name="btn_upload_form" id="btn_upload_form" class="btn btn-success input-sm" data-target="#ModalImportForm" data-toggle="modal" title="อัพโหลด" data-placement="top">
								<i class="fa fa-upload"></i>&nbsp; เลือก</button> <span class="countFileTargetForm"></span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row-fluid">
					<p class="lead">Workflow</p>
					<div class="row-fluid">
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">จากขั้นตอน :</label>
								<div class="controls">
									<select class="form-control input-sm span12" id="by_step" name="by_step">
									<option value="1">ร้องขอบทความ</option>
								</select>
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">ไปขั้นตอน :</label>
								<div class="controls">
									<select class="form-control input-sm span12" id="to_step" name="to_step">
									<input type="hidden" id="to_step_status" name="to_step_status">
								</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">ส่งถึง :</label>
								<div class="controls">
									<input type="text" class="form-control input-sm span12"
										placeholder="" name="send_to" id="send_to">
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">วันที่เสร็จ :</label>
								<div class="controls">
									<input type="text" class="form-control input-sm span12"
										placeholder="" name="complete_date" id="complete_date">
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">วันครบกำหนด :</label>
								<div class="controls">
									<input type="text" class="form-control input-sm span12"
										placeholder="" name="deadline_date" id="deadline_date">
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">แจ้งเตือน :</label>
								<div class="controls">
									<select class="form-control input-sm span12" id="alert_multi" name="alert_multi" multiple="multiple">
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">หมายเหตุ : </label>
								<div class="controls">
									<textarea class="form-control span12" rows="4" id="remark"></textarea>
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">แนบเอกสาร: </label>
								<div class="controls">
									<button type="button" name="btn_upload_form_workflow" id="btn_upload_form_workflow" class="btn btn-primary input-sm" data-target="#ModalImportFormWorkflow" data-toggle="modal" title="อัพโหลด" data-placement="top">
									<i class="fa fa-upload"></i>&nbsp; เลือก</button> <span class="countFileTargetFormWorkflow"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="alert alert-warning information" id="information_errors" style="display: none;height:120px; overflow-y: scroll; position:relative;">
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<p class="lead">Workflow History</p>
					<div class="row-fluid" style="overflow: auto;">
						<table class="table table-striped" id="">
							<thead>
								<tr>
									<th style='width: auto' rowspan='2'><strong><p class='text-center'>วัน/เวลา</p></strong></th>
									<th style='width: auto' colspan='2'><strong><div class='text-center'>จาก</div></strong></th>
									<th style='width: auto' colspan='2'><strong><div class='text-center'>ถึง</div></strong></th>
									<th style='width: auto' rowspan='2'><strong><p class='text-center'>หมายเหตุ</p></strong></th>
									<th style='width: auto' rowspan='2'><strong><p class='text-center'>แจ้งเตือน</p></strong></th>
									<th style='width: auto' rowspan='2'><strong><p class='text-center'>เอกสารแนบ</p></strong></th>
								</tr>
								<tr>
									<th style='width: auto'><strong><p class='text-center'>งาน</p></strong></th>
									<th style='width: auto'><strong><p class='text-center'>ผู้รับผิดชอบ</p></strong></th>
									<th style='width: auto'><strong><p class='text-center'>งาน</p></strong></th>
									<th style='width: auto'><strong><p class='text-center'>ผู้รับผิดชอบ</p></strong></th>
								</tr>
							</thead>
							<tbody id="workflow_history">
							</tbody>
						</table>
					</div>
				</div>
				<!-- form End -->
				<div class="modal-footer">
					<button class="btn btn-success" type="submit" id="btn_modal_submit">Submit</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
						<div class="alert alert-warning information" id="information"
						style="display: none;height:120px; overflow-y: scroll; position:relative;"></div>
				</div>
				<!-- content end -->
			</div>
		</div>
	</div>
</div>
<!-- Modal End Edit -->

<!-- Modal Import file -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="ModalImport"
		class="modal inmodal portlet-frame" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only"></span>
					</button>
					<!-- <i class="fa fa-laptop modal-icon"></i> -->
					<h4 class="modal-title" id="">อัพโหลด</h4>
					<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->      
				</div>
				<div class="modal-body">
					<!-- content start -->
					<!-- form start -->
					<div class="form-group">
					<form id="fileUploadWriter">
							<h4>File Upload</h4>
							<div class="fileImport">
								<input type="file" id="file" class="dropify fileUpload" accept=".xls, .xlsx, .pdf, .docx" multiple/><span></span>
							</div>
							<h6 class="label-content-import-export">
							</h6>
					</form>
						<!-- start table -->
					</div>
					<!-- form End -->
					<!-- content end -->
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" type="submit" id="importsubmit" form="fileUploadWriter">Upload</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
						<div class="alert alert-warning information" id="information"
						style="display: none;height:120px; overflow-y: scroll; position:relative;"></div>
				</div>
			</div>
		</div>
	</div>
<!-- Modal End  -->

<!-- Modal Import file form -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="ModalImportForm"
		class="modal inmodal portlet-frame" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only"></span>
					</button>
					<!-- <i class="fa fa-laptop modal-icon"></i> -->
					<h4 class="modal-title" id="">แนบบทความ</h4>
					<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->      
				</div>
				<div class="modal-body">
					<!-- content start -->
					<!-- form start -->
					<div class="form-group">
					<form id="fileUploadWriterForm">
							<h4>File Upload</h4>
							<div class="fileImport">
								<input type="file" id="fileForm" class="dropify fileUpload" accept=".xls, .xlsx, .pdf, .docx" multiple/><span></span>
							</div>
							<h6 class="label-content-import-export">
							</h6>
					</form>
						<!-- start table -->
					</div>
					<!-- form End -->
					<!-- content end -->
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" type="submit" id="importsubmitForm" form="fileUploadWriterForm">Upload</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
<!-- 						<div class="alert alert-warning information" id="information" -->
<!-- 						style="display: none;height:120px; overflow-y: scroll; position:relative;"></div> -->
				</div>
			</div>
		</div>
	</div>
<!-- Modal End  -->

<!-- Modal Import file form -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="ModalImportFormWorkflow"
		class="modal inmodal portlet-frame" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only"></span>
					</button>
					<!-- <i class="fa fa-laptop modal-icon"></i> -->
					<h4 class="modal-title" id="">แนบเอกสาร</h4>
					<!-- 
                <small class="font-bold">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</small>
                 -->      
				</div>
				<div class="modal-body">
					<!-- content start -->
					<!-- form start -->
					<div class="form-group">
					<form id="fileUploadWriterFormWorkflow">
							<h4>File Upload</h4>
							<div class="fileImport">
								<input type="file" id="fileFormWorkflow" class="dropify fileUpload" accept=".xls, .xlsx, .pdf, .docx" multiple/><span></span>
							</div>
							<h6 class="label-content-import-export">
							</h6>
					</form>
						<!-- start table -->
					</div>
					<!-- form End -->
					<!-- content end -->
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" type="submit" id="importsubmitFormWorkflow" form="fileUploadWriterFormWorkflow">Upload</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
<!-- 						<div class="alert alert-warning information" id="information" -->
<!-- 						style="display: none;height:120px; overflow-y: scroll; position:relative;"></div> -->
				</div>
			</div>
		</div>
	</div>
<!-- Modal End  -->



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
<!-- 						<div id="inform_on_confirm" class='information'></div> -->
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
<!-- 				<div class="alert alert-warning information" id="information" -->
<!-- 					style="display: none;"></div> -->
			</div>
		</div>
	</div>
</div>
<!-- Modal Confirm End -->

<input type="hidden" name="id" id="id" value="">
<input type="hidden" name="action" id="action" value="add">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
// var restfulURL="";
// var serviceName="";

// /*#######Office#######*/

// /*#######Localhost#######*/
// restfulURL="http://localhost";
// serviceName="master_piece/public";
</script>





<script>
/* for portlet*/
// var tokenID= [];
// var roles = [];
// var userId = null;
// var screenName = null;

// $(document).ready(function() {
// 	$('[data-toggle="tooltip"]').css({	"cursor":"pointer"});
// 	$('[data-toggle="tooltip"]').tooltip({	html:true	});
// 	$('[data-toggle="popover"]').popover();   
// 	$(".app_url_hidden").show();
// });


// function checkSession(paramTokenID){
// 	$chk = true;
// 	tokenID = paramTokenID == undefined || paramTokenID == ""  ? tokenID : paramTokenID ;
// 	tokenID = eval("("+tokenID+")");
// 	if(tokenID==null){
// 		callFlashSlide("login failed.");
// 		$chk = false;
// 	}
// 	$.ajax({
// 		url:restfulURL+"/"+serviceName+"/session",
// 		type:"GET",
// 		dataType:"json",
// 		headers:{Authorization:"Bearer "+tokenID.token},
// 		async:false,
// 		success:function(data){
// 			//console.log(data)
// 			if(data.status == "200"){
// 				$chk = true;
// 				userId = data.userID;
// 				screenName = data.screenName;
// 				roles = data.roles;
// 			}else{
// 				callFlashSlide("login failed."); 
// 				sessionStorage.clear();
// 				$chk = false;
// 		    	setTimeout(function(){
// 		    		window.location.href = "../login.html"; 
// 				},500);
// 			}
// 		},
// 		error: function(jqXHR, textStatus, errorThrown) {
// 		    if('error'==textStatus){
// 		    	callFlashSlide("login failed."); 
// 		    	console.log("Error is "+textStatus);
// 		    	$chk = false;
// 		    	setTimeout(function(){
// 		    		window.location.href = "../login.html"; 
// 				},500);
// 		    }
// 		}
		
// 	});
// 	return $chk;
//  }
 
//  var connectionServiceFn = function(username,password,plid){
// 	$chk = true;
// 	$.ajax({
// 		url:restfulURL+"/"+serviceName+"/session",
// 		type:"POST",
// 		dataType:"text",
// 		data:{"username":username,"password":password,"plid":plid},
// 		async:false,
// 		error: function(jqXHR, textStatus, errorThrown) {
// 			 sessionStorage.clear();
// 			 $chk = false;
// 		    	setTimeout(function(){
// 		    		window.location.href = "../login.html"; 
// 				},500);
// 		},
// 		success:function(data){
// 			sessionStorage.setItem("tokenID",data);
// 			tokenID = eval("("+ sessionStorage.getItem("tokenID")+")");
// 			console.log(data);
// 			if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
// 				$(".aui body *").css({'font-weight':400});
// 			} 
// 			if(checkSession(data)){
// 				$chk = true;
// 			}
// 		}
// 	});	
// 	return $chk;
// }

// var flashSLideUp=function(){
// 	$("#slide_status").slideUp();
// }

// var flashSlideInModalSlideUp=function(){
// 	$(".information").slideUp();
// }
// $(document).on("click","#btnCloseSlide",function(){
// 	flashSLideUp();
// });
// $(document).on("click",".btnModalClose",function(){
// 	flashSlideInModalSlideUp();
// });

// function callFlashSlide(text,flashType){
// 	if(flashType=="error"){
// 		$("#slide_status_area").css("color","red");
// 		$("#slide_status_area").html(text);
// 	}else if(flashType=="success"){
// 		$("#slide_status_area").css("color","lightgreen");
// 		$("#slide_status_area").html(text);
// 	}else{
// 		$("#slide_status_area").html(text);
// 	}

// 	$("#slide_status").slideDown("slow");
// 	setTimeout(function(){
// 		$("#slide_status").slideUp();
// 	},5000);
// }

// var callFlashSlideInModal =function(text,id,flashType){
// 	var btnClose="<div class=\"btnModalClose\">×</div>";
// 	if(flashType=="error"){
// 		if(id!=undefined){
// 			$(id).html(btnClose+""+text).show();
			
// 		}else{
			
// 			$("#information").html(btnClose+""+text).show();
// 		}
		
// 	}else{
		
// 		if(id!=undefined){
// 			$(id).html(btnClose+""+text).show();
// 		}else{
// 			$("#information").html(btnClose+""+text).show();
// 		}
// 		setTimeout(function(){
// 			if(id!=undefined){
// 				$(id).hide("slow");
// 			}else{
// 				$("#information").hide("slow");
// 			}
// 		},3000);
// 	}
// }


// var logoutFn = function(){
// 	$.ajax({
// 		url:restfulURL+"/"+serviceName+"/session",
// 		type:"DELETE",
// 		dataType:"json",
// 		headers:{Authorization:"Bearer "+tokenID.token},
// 		success:function(data){
// 			if(data['status']=="200"){
// 				window.location.href = "../login.html"; 
// 				sessionStorage.setItem("tokenID","{}");
// 			}
// 		},
// 		error: function(jqXHR, textStatus, errorThrown) {
// 		    if('error'==textStatus){
// 		    	window.location.href = "../login.html"; 
// 		    }
// 		}
// 	});
// }

// $("#logOut").click(function(){
// 	logoutFn();
// });
 
// /*ajax */
// function getAjax(url,type,data,callback){
// 	if(checkSession(JSON.stringify(tokenID))){
// 		$.ajax({
// 			url:url,
// 			type : type,
// 			dataType : "json",
// 			data : data,
// 			async:false,
// 			headers:{Authorization:"Bearer "+tokenID.token},
// 			success : function(data,status) {
// 				if(status == 'success'){
// 					callback(data);
// 				}else{
// 					callFlashSlide(status,'error');
// 				}
// 			}
// 		});
// 	}
// }

// /*clear field in modal*/
// function clearModal(){
// 	$(".modal input[type='text'],.modal select,.modal textarea").val('');
// 	$('.modal select').val('');
// 	$(".modal input[type='radio'],.modal input[type='checkbox']").prop('checked', false);
// }

// /*get pagenation*/
// function getPagenation(target,data){
// 	$prev_dis = data.prev_page_url?'':'disabled' ;
// 	$next_dis = data.next_page_url?'':'disabled';
// 	$next = data.current_page+1 <= data.last_page?data.current_page+1:'';
// 	$html = '<li data-lp="1" class="first '+$prev_dis+'">'
// 		+'<a href="javascript:void(0);"><<</a> </li>'
// 		+'<li data-lp="1" class="prev '+$prev_dis+'"> <a href="javascript:void(0);">prev</a></li>';
// 		for($i=1;$i<=data.last_page;$i++){
// 			$active = data.current_page == $i ? "active":"";
// 			$html+='<li data-lp="'+$i+'" class="'+$active+'"><a href="javascript:void(0);">'+$i+'</a></li>';
// 		}
// 	$html+= '<li data-lp="'+$next+'" class="next '+$next_dis+'" ><a href="javascript:void(0);">next</a></li>'
// 		+'<li data-lp="'+data.last_page+'" class="last '+$next_dis+'"><a href="javascript:void(0);">>></a></li>';
// 	$(target).html($html);
// }

// function formatDateYMD(input) {
// 	if(input == "") {
// 		return null;
// 	} else {
// 	    var datePart = input.match(/\d+/g);
// 	    var day = datePart[0];
// 	    var month = datePart[1];
// 	    var year = datePart[2];
// 	    return year + '-' + month + '-' + day;
// 	}
// }

// function formatDateDMY(input) {
//     var datePart = input.split("-");
//     var day = datePart[2];
//     var month = datePart[1];
//     var year = datePart[0];
//     return day + '-' + month + '-' + year;
// }

// var paginationSetUpFn = function(pageIndex,pageButton,pageTotal){
	
// 	if(pageTotal==0){
// 		pageTotal=1
// 	}
// 	$('.pagination_top,.pagination_bottom').off("page");
// 	$('.pagination_top,.pagination_bottom').bootpag({
// 	    total: pageTotal,//page Total
// 	    page: pageIndex,//page index
// 	    maxVisible: 5,//จำนวนปุ่ม
// 	    leaps: true,
// 	    firstLastUse: true,
// 	    first: '←',
// 	    last: '→',
// 	    wrapClass: 'pagination',
// 	    activeClass: 'active',
// 	    disabledClass: 'disabled',
// 	    nextClass: 'next',
// 	    prevClass: 'prev',
// 	    next: 'next',
// 	    prev: 'prev',
// 	    lastClass: 'last',
// 	    firstClass: 'first'
// 	}).on("page", function(event, num){
// 		var rpp=10;
// 		if($("#rpp").val()==undefined){
// 			rpp=10;
// 		}else{
// 			rpp=$("#rpp").val();
// 		}
		
// 		getData(num,rpp);
		
// 	    $(".pagingNumber").remove();
// 	    var htmlPageNumber= "<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='"+num+"'>";
// 	    $("body").append(htmlPageNumber);
	   
// 	}); 

// 	$(".countPagination").off("change");
// 	$(".countPagination").on("change",function(){

// 		$("#countPaginationTop").val($(this).val());
// 		$("#countPaginationBottom").val($(this).val());
		
// 		getData(1,$(this).val());
		
// 		$(".rpp").remove();
// 		$(".pagingNumber").remove();
// 		var htmlRrp="";
// 			htmlRrp+= "<input type='hidden' id='rpp' name='rpp' class='rpp' value='"+$(this).val()+"'>";
// 	        htmlRrp+="<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='1'>";
// 	    $("body").append(htmlRrp);
// 	});
// }
//set paginate end 

</script>






<script>
// $(document).ready(function(){
// 	 var username = $('#user_portlet').val();
// 	 var password = $('#pass_portlet').val();
// 	 var plid = $('#plid_portlet').val();
// 	 if(username!="" && username!=null & username!=[] && username!=undefined ){
// 		 if(connectionServiceFn(username,password,plid)==true){
			 
// 			var GlobalWriterID;
// 			var GlobalStageID;
// 			var GlobalDataWriter;
// 			var InsertUpdateForCheck = "";
// 			$('.dropify').dropify();
			
// 			function validatetorWriter(data) {
// 				var errorData="";
// 				$.each(data, function(key, value) {
// 					errorData += stripJsonToString(value);
// 				});
// 				console.log(errorData);
// 				return errorData;
// 			}
			
// 			var stripJsonToString= function(json){
// 			    return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "<br>").replace(/\"/g,'');
// 			}
			
// 			function validatetorInformation(data) {
// 				$("#information_errors").show();
// 				$("#information_errors").html(data);
// 			}
			 
// 			 var generateDropDownList = function(url,type,request,initValue){
// 				 	var html="";
// 				 	if(initValue!=undefined){
// 				 		html+="<option value=''>"+initValue+"</option>";
// 					}
// 				 	$.ajax ({
// 				 		url:url,
// 				 		type:type ,
// 				 		dataType:"json" ,
// 				 		data:request,
// 				 		headers:{Authorization:"Bearer "+tokenID.token},
// 				 		async:false,
// 				 		success:function(data){
// 				 			try {
// 				 			    if(Object.keys(data[0])[0] != undefined && Object.keys(data[0])[0] == "item_id"){
// 				 			    	galbalDataTemp["item_id"] = [];
// 				 			    	$.each(data,function(index,indexEntry){
// 				 			    		galbalDataTemp["item_id"].push(indexEntry[Object.keys(indexEntry)[0]]);
// 				 		 			});	
// 				 			    }
// 				 			}
// 				 			catch(err) {
// 				 			    console.log(err.message);
// 				 			}

// 				 			$.each(data,function(index,indexEntry){
// 				 				html+="<option value="+indexEntry[Object.keys(indexEntry)[0]]+">"+indexEntry[Object.keys(indexEntry)[1] == undefined  ?  Object.keys(indexEntry)[0]:Object.keys(indexEntry)[1]]+"</option>";	
// 				 			});
// 				 		}
// 				 	});	
// 				 	return html;
// 			}
			 
// 			function DropDownToStep() {
// 					$.ajax({
// 						url:restfulURL+"/"+serviceName+"/writer/action_to",
// 						type:"get",
// 						dataType:"json",
// 						async:false,
// 						data:{"stage_id":$("#by_step").val()},
// 						headers:{Authorization:"Bearer "+tokenID.token},
// 						success:function(data){
// 							var htmlOption="";
// 							var htmlOption2="";
// 							$.each(data,function(index,indexEntry) {
// 								htmlOption+="<option value="+indexEntry['stage_id']+">"+indexEntry['stage_name']+"</option>";
// 								htmlOption2=indexEntry['status'];
// 							});
							
// 							$("#to_step_status").val(htmlOption2);
// 							$("#to_step").html(htmlOption);
// 						}
// 					});
// 			}
// 			DropDownToStep();
				
// 			function getData(page,rpp) {
// 				var article_ID = $("#search_article").val().split("-");
// 				article_ID = (article_ID == '') ? '' : article_ID[0];
					
// 				var doctor_id = $("#search_doctor").val().split("-");
// 				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
					
// 				var procedure_id = $("#search_procedure").val();
// 				var writing_start_date = formatDateYMD($("#search_start_date").val());
// 				var writing_end_date = formatDateYMD($("#search_end_date").val());
					
// 				$.ajax({
// 					url:restfulURL+"/"+serviceName+"/writer/search_writer",
// 					type:"get",
// 					dataType:"json",
// 					async:false,
// 					headers:{Authorization:"Bearer "+tokenID.token},
// 					data:{
// 						"article_id":article_ID,
// 						"procedure_id":procedure_id,
// 						"doctor_id":doctor_id,
// 						"writing_start_date":writing_start_date,
// 						"writing_end_date":writing_end_date,
// 						"page":page,
// 						"rpp":rpp
// 					},
// 					success:function(data) {
// 						console.log(data);
// 						list_data_template(data);
						
// 						GlobalDataWriter=data;
// 						paginationSetUpFn(GlobalDataWriter['current_page'],GlobalDataWriter['last_page'],GlobalDataWriter['last_page']);
// 					}
// 				});
// 			};
				
// 			function InsertWriter() {
// 					var doctor_id = $("#form_doctor").val().split("-");
// 					doctor_id = (doctor_id == '') ? '' : doctor_id[0];
// 					var writer = $("#author").val().split("-");
// 					writer = (writer == '') ? null : writer[0];
// 					var writer_start_date = formatDateYMD($("#start_date").val());
// 					var plan_date = formatDateYMD($("#plan_date").val());
// 					var complete_date = formatDateYMD($("#complete_date").val());
// 					var actual_date = formatDateYMD($("#deadline_date").val());
// 					var user_id = {
// 							"user_id":$("#alert_multi").val()
// 					}
					
// 					var data_value = {
// 							"article_name":$("#article").val(),
// 							"article_type_id":$("#article_type").val(),
// 							"procedure_id":$("#procedure_name").val(),
// 							"doctor_id":doctor_id,
// 							"from_user_id":writer,
// 							"writing_start_date":writer_start_date,
// 							"plan_date":plan_date,
							
// 							"file":datafile,
// 							"alert":user_id,
							
// 							"from_stage_id":$("#by_step").val(),
// 							"to_stage_id":$("#to_step").val(),
// 							"to_user_id":$("#send_to").val(),
// 							"writing_end_date":complete_date,
// 							"actual_date":actual_date,
// 							"status":$("#to_step_status").val(),
// 							"remark":$("#remark").val()
// 					}
					
// 					var datafile = new FormData();
// 					if(filesForm!=undefined) {
// 						$.each(filesForm, function(key, value) {
// 							console.log(value,'filesform');
// 							datafile.append('article_doc-'+key, value);
// 						});
// 					}
					
// 					//var datafileWorkflow = new FormData();
// 					if(filesFormWorkflow!=undefined) {
// 						$.each(filesFormWorkflow, function(key, value) {
// 							console.log(value,'fileformworkflow');
// 							datafile.append('article_stage_doc-'+key, value);
// 						});
// 					}
					
// 					datafile.append('formdata', JSON.stringify(data_value));
	
// 					$.ajax({
// 						url:restfulURL+"/"+serviceName+"/writer/cu",
// 						type:"post",
// 						dataType:"json",
// 						//async:false,
// 						processData: false, // Don't process the files
// 						contentType: false, // Set content type to false as jQuery will tell the server its a query string request
// 						headers:{Authorization:"Bearer "+tokenID.token},
// 						data:datafile,
// 						success:function(data){
// 							console.log(data)
// 							if(data.status==200) {
// 								callFlashSlide('Insert Success!','success')
// 	 							$("#ModalWriter").modal('hide');
// 							} else if (data.status==400) {
// 								console.log(data)
// 								validatetorInformation(validatetorWriter(data['errors'][0]));
// 							}
// 						}
// 					})
// 			};
				
// 			function GetDataEdit(article_id) {
// 					console.log("GetDataEdit")
// 					$.ajax({
// 						url:restfulURL+"/"+serviceName+"/writer/show",
// 						type:"get",
// 						dataType:"json",
// 						async:false,
// 						headers:{Authorization:"Bearer "+tokenID.token},
// 						data:{"article_id":article_id},
// 						success:function(data){
// 							console.log(data);
// 							$("#article").val(data.article.article_name);
// 							$("#article_type").val(data.article.article_type_id);
// 							//$("#").val(data.article_type_name);
// 							$("#procedure_name").val(data.article.procedure_id);
// 							//$("#").val(data.procedure_name);
// 							$("#form_doctor").val(data.article.doctor_id+'-'+data.article.doctor_name);
// 							//$("#").val(data.doctor_name);
// 							$("#author").val(writer_id+'-'+data.article.writer_name);
// 							$("#start_date").val(formatdateDMY(data.article.writing_start_date));
// 							$("#complete_date").val(formatdateDMY(data.article.writing_end_date));
// 							$("#plan_date").val(formatdateDMY(data.article.plan_date));
// 							$("#to_step_status").val(data.article.status);
// 							list_article_history(data.article_hitory);
// 							//$("#").val(data.article_path);
// 						}
// 					})
// 			}
			
// 			function list_article_history(data) {
// 				var TRTDHTML = "";
// 				var TRTDClass = "style=\"vertical-align: middle;\"";
// 				$.each(data, function (key,value) {
// 						TRTDHTML += 
// 			                '<tr>'+
// 			                '<td "'+TRTDClass+'">' + value.created_dttm +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.from_stage_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.from_user_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.to_stage_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.to_user_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.remark +'</td>'+
// 			                '<td "'+TRTDClass+'">' +  +'</td>'+
// 			                '<td "'+TRTDClass+'"><button type="button" id="downloadfileWorkflowHistory-' + value.article_stage_id +'" class="btn btn-primary input-sm getfileWorkflow" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
// 			                '</td>'+
// 			                '</tr>';
// 			    });
// 				$('#workflow_history').html(TRTDHTML);
// 			} 
				
// 			function UpdateWriter() {
// 				var article_id = $("#article").val().split("-");
// 				article_id = (article_id == '') ? '' : article_id[0];
// 				var doctor_id = $("#form_doctor").val().split("-");
// 				doctor_id = (doctor_id == '') ? '' : doctor_id[0];
// 				var writer = $("#author").val().split("-");
// 				writer = (writer == '') ? null : writer[0];
// 				var writer_start_date = formatDateYMD($("#start_date").val());
// 				var plan_date = formatDateYMD($("#plan_date").val());
// 				var complete_date = formatDateYMD($("#complete_date").val());
// 				var actual_date = formatDateYMD($("#deadline_date").val());
// 				var user_id = {
// 						"user_id":$("#alert_multi").val()
// 				}
				
// 				var data_value = {
// 						"article_id":article_id,
// 						"article_name":$("#article").val(),
// 						"article_type_id":$("#article_type").val(),
// 						"procedure_id":$("#procedure_name").val(),
// 						"doctor_id":doctor_id,
// 						"from_user_id":writer,
// 						"writing_start_date":writer_start_date,
// 						"plan_date":plan_date,
						
// 						"file":datafile,
// 						"alert":user_id,
						
// 						"from_stage_id":$("#by_step").val(),
// 						"to_stage_id":$("#to_step").val(),
// 						"to_user_id":$("#send_to").val(),
// 						"writing_end_date":complete_date,
// 						"actual_date":actual_date,
// 						"status":$("#to_step_status").val(),
// 						"remark":$("#remark").val()
// 				}
				
// 				var datafile = new FormData();
// 				$.each(filesForm, function(key, value) {
// 					console.log(value);
// 					datafile.append(key, value);
// 				});
// 				datafile.append('formdata', JSON.stringify(data_value));

// 				$.ajax({
// 					url:restfulURL+"/"+serviceName+"/writer/cu",
// 					type:"post",
// 					dataType:"json",
// 					//async:false,
// 					processData: false, // Don't process the files
// 					contentType: false, // Set content type to false as jQuery will tell the server its a query string request
// 					headers:{Authorization:"Bearer "+tokenID.token},
// 					data:datafile,
// 					success:function(data){
// 						if(data.status==200) {
// 							callFlashSlide('Update Success!','success')
//  							$("#ModalWriter").modal('hide');
// 						} else if (data.status==400) {
// 							console.log(data)
// 							validatetorInformation(validatetorWriter(data['errors'][0]));
// 						}
// 					}
// 				})
// 			};
			
// 			function uploadFiles(event) {
				
// 					event.stopPropagation();
// 					event.preventDefault();
					
// 					var datafile = new FormData();
// 					$.each(files, function(key, value) {
// 						datafile.append(key, value);
// 					});
					
// 					$("body").mLoading();
// 					$.ajax({
// 						url:restfulURL+"/"+serviceName+"/writer/import/"+GlobalWriterID,
// 						type:'POST',
// 						data:datafile,
// 						cache: false,
// 						dataType: 'json',
// 						processData: false, // Don't process the files
// 						contentType: false, // Set content type to false as jQuery will tell the server its a query string request
// 						headers:{Authorization:"Bearer "+tokenID.token},
// 						success: function(data, textStatus, jqXHR)
// 						{
// 							console.log(data);
// 							if(data['status']==200){
// 								callFlashSlide("Upload Success!");
// 								//getDataFn();
// 								$("body").mLoading('hide');
// 								$('#file').val("");
// 								$('#ModalImport').modal('hide');
								
// 							}else{
// 								//listErrorFn(data['errors']);
// 								callFlashSlide('errors','No Files Data');
// 								//getDataFn();
// 								$("body").mLoading('hide');
// 							}
// 						},
// 						error: function(jqXHR, textStatus, errorThrown)
// 						{
// 							callFlashSlide('Format Error : ' + textStatus);
// 						}
// 					});
// 					return false;
// 			};
			
// 			function downloadfileFN(aricleID) {
// 				console.log("downloadna")
// 				$.ajax({
// 					url:restfulURL+"/"+serviceName+"/writer/download/"+aricleID,
// 					type:'get',
// 					cache: false,
// 					dataType: 'json',
// 					headers:{Authorization:"Bearer "+tokenID.token},
// 					success: function(data, textStatus, jqXHR)
// 					{
// 						console.log(data);
// 					},
// 					error: function(jqXHR, textStatus, errorThrown)
// 					{
// 						callFlashSlide('Format Error : ' + textStatus);
// 					}
// 				});
// 				return false;
// 			}
			
// 			function downloadfileWorkflowFN(stageid) {
// 				console.log("downloadnaworkflow")
// 				$.ajax({
// 					url:restfulURL+"/"+serviceName+"/writer/download_article_stage_doc/"+stageid,
// 					type:'get',
// 					cache: false,
// 					dataType: 'json',
// 					headers:{Authorization:"Bearer "+tokenID.token},
// 					success: function(data, textStatus, jqXHR)
// 					{
// 						console.log(data);
// 					},
// 					error: function(jqXHR, textStatus, errorThrown)
// 					{
// 						callFlashSlide('Format Error : ' + textStatus);
// 					}
// 				});
// 				return false;
// 			}
			
// 			function list_data_template(data) {
// 				var TRTDHTML = "";
// 				var TRTDClass = "style=\"vertical-align: middle;\"";
// 				$.each(data, function (key,value) {
// 						TRTDHTML += 
// 			                '<tr>'+
// 			                '<td "'+TRTDClass+'">' + value.article_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.writer +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_start_date) +'</td>'+
// 			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_end_date) +'</td>'+
// 			                '<td "'+TRTDClass+'">' + formatDateDMY(value.plan_date) +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
// 			                '<td "'+TRTDClass+'">' + value.status +'</td>'+
// 			                '<td "'+TRTDClass+'"><button type="button" id="downloadfile-' + value.article_ID +'" class="btn btn-primary input-sm getfile" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
// 			                '&nbsp;<button type="button" id="uploadfile-' + value.article_ID +'" class="btn btn-success input-sm getfile" data-target="#ModalImport" data-toggle="modal" title="อัพโหลด" data-placement="top"><i class="fa fa-upload"></i></button>'+
// 			                '&nbsp;<button type="button" id="edit-' + value.article_ID +'" class="btn btn-warning input-sm getfile" data-target="#ModalWriter" data-toggle="modal" title="แก้ไข" data-placement="top">แก้ไข</button></td>'+
// 			                '</tr>';
// 			    });
// 				$('#result_search_writer').html(TRTDHTML);
// 			}
				
// 			//Autocomeplete
// 			$("#search_article").autocomplete({
// 					source: function (request, response) {
// 			        	$.ajax({
// 							 url:restfulURL+"/"+serviceName+"/writer/list_article",
// 							 type:"get",
// 							 dataType:"json",
// 							 headers:{Authorization:"Bearer "+tokenID.token},
// 							 //data:{"emp_name":request.term},
// 							 data:{"article_name":request.term},
// 							 //async:false,
// 			                 error: function (xhr, textStatus, errorThrown) {
// 			                        console.log('Error: ' + xhr.responseText);
// 			                    },
// 							 success:function(data){
// 									response($.map(data, function (item) {
// 			                            return {
// 			                                label: item.article_ID+"-"+item.article_name,
// 			                                value: item.article_ID+"-"+item.article_name,
// 			                            };
// 			                        }));
// 							},
// 							beforeSend:function(){
// 								$("body").mLoading('hide');	
// 							}
							
// 						});
// 			        }
// 			});
				
// 			$("#search_doctor").autocomplete({
// 					source: function (request, response) {
// 			        	$.ajax({
// 							 url:restfulURL+"/"+serviceName+"/writer/list_doctor",
// 							 type:"get",
// 							 dataType:"json",
// 							 headers:{Authorization:"Bearer "+tokenID.token},
// 							 //data:{"emp_name":request.term},
// 							 data:{"doctor_name":request.term},
// 							 //async:false,
// 			                 error: function (xhr, textStatus, errorThrown) {
// 			                        console.log('Error: ' + xhr.responseText);
// 			                    },
// 							 success:function(data){
// 									response($.map(data, function (item) {
// 			                            return {
// 			                                label: item.doctor_id+"-"+item.doctor_name,
// 			                                value: item.doctor_id+"-"+item.doctor_name,
// 			                            };
// 			                        }));
// 							},
// 							beforeSend:function(){
// 								$("body").mLoading('hide');	
// 							}
							
// 						});
// 			        }
// 			});
				
// 			$("#form_doctor").autocomplete({
// 					source: function (request, response) {
// 			        	$.ajax({
// 							 url:restfulURL+"/"+serviceName+"/writer/list_doctor",
// 							 type:"get",
// 							 dataType:"json",
// 							 headers:{Authorization:"Bearer "+tokenID.token},
// 							 //data:{"emp_name":request.term},
// 							 data:{"doctor_name":request.term},
// 							 //async:false,
// 			                 error: function (xhr, textStatus, errorThrown) {
// 			                        console.log('Error: ' + xhr.responseText);
// 			                    },
// 							 success:function(data){
// 									response($.map(data, function (item) {
// 			                            return {
// 			                                label: item.doctor_id+"-"+item.doctor_name,
// 			                                value: item.doctor_id+"-"+item.doctor_name,
// 			                            };
// 			                        }));
// 							},
// 							beforeSend:function(){
// 								$("body").mLoading('hide');	
// 							}
							
// 						});
// 			        }
// 			});
			
// 			$("#search_procedure").html(generateDropDownList(
// 					restfulURL+"/"+serviceName+"/writer/list_medical_procedure",
// 					"GET"
// 			));
			
// 			$("#procedure_name").html(generateDropDownList(
// 					restfulURL+"/"+serviceName+"/doctor_profile/list_medical_procedure",
// 					"GET"
// 			));
			
// 			$("#article_type").html(generateDropDownList(
// 					restfulURL+"/"+serviceName+"/writer/list_article_type",
// 					"GET"
// 			));
			
// 			$("#alert_multi").html(generateDropDownList(
// 					restfulURL+"/"+serviceName+"/writer/list_article_type",
// 					"GET"
// 			));
				
// 			$('#alert_multi').multiselect({
// 			  allSelectedText: 'No option left ...',
// 			  maxHeight: 200,
// 			  onChange: function() {
// 				  console.log($('#alert_multi').val());
// 			  }
// 			});
				
// 			$("#search_start_date,#search_end_date,#start_date,#plan_date,#complete_date,#deadline_date").datepicker({
// 				dateFormat: 'dd/mm/yy'
// 			});
				
// 			$("#btn_search").click(function(){
// 				if($("#search_start_date").val()=='') {
// 					$("#search_start_date").focus();
// 					callFlashSlide('โปรดระบุจากวันที่!','warning')
// 				}else if($("#search_end_date").val()=='') {
// 					$("#search_end_date").focus();
// 					callFlashSlide('โปรดระบุถึงวันที่!','warning')
// 				} else {
// 					getData();
// 				}
// 			});
				
// 			$("#btn_add").click(function(){
// 				$("#author").val(userId+'-'+screenName);
// 				$("#information_errors").hide();
// 				InsertUpdateForCheck = "insert";
// 			});
				
// 			$("#btn_result_edit").click(function () {
// 				$("#information_errors").hide();
// 				InsertUpdateForCheck = "update";
// 				GetDataEdit();
// 			});
				
// 			$("#btn_modal_submit").click(function() {
// 				if(InsertUpdateForCheck=="insert") {
// 					InsertWriter();
// 				} else {
// 					UpdateWriter();
// 				}
// 			});
				
// 			$("#result_search_writer").on("click",'.getfile',function() {
// 				var ufile = $(this).attr('id').split("-");
// 				//var ufile = $(this).attr('id');
// 				GlobalWriterID = null;
// 				GlobalStageID = null;
// 				$('#file').val("");
// 				$(".btnModalClose").click();
// 				$(".dropify-clear").click();
// 				GlobalWriterID = ufile[1];
// 				if(ufile[0]=='downloadfile') {
// 					downloadfileFN(GlobalWriterID);
// 				} else if(ufile[0]=='edit') {
// 					GetDataEdit(GlobalWriterID);
// 				}
				
// 				if(ufile[0]=='downloadfileWorkflowHistory') {
// 					GlobalStageID
// 				}
// 			});
			
// 			$("#workflow_history").on("click",'.getfileWorkflow',function() {
// 				var ufile = $(this).attr('id').split("-");
// 				GlobalStageID = null;
// 				GlobalStageID = ufile[1];
// 				if(ufile[0]=='downloadfileWorkflowHistory') {
// 					downloadfileWorkflowFN(GlobalStageID);
// 				}
// 			});
				
// 			var files;
// 			$('#file').on('change', prepareUpload);
// 			function prepareUpload(event) {
// 				 files = event.target.files;
// 			};
			
// 			var filesForm;
// 			var filesLength;
// 			$('#fileForm').on('change', prepareUpload2);
// 			function prepareUpload2(event) {
// 				filesForm = event.target.files;
// 				if(event.target.files.length!=undefined){
// 					filesLength = event.target.files.length;
// 					console.log(filesForm)
// 				}
// 			};
			
// 			var filesFormWorkflow;
// 			var filesLengthWorkflow;
// 			$('#fileFormWorkflow').on('change', prepareUpload3);
// 			function prepareUpload3(event) {
// 				filesFormWorkflow = event.target.files;
// 				if(event.target.files.length!=undefined){
// 					filesLengthWorkflow = event.target.files.length;
// 					console.log(filesForm)
// 				}
// 			};
				
// 			$('form#fileUploadWriter').on('submit', uploadFiles);
// 			$('form#fileUploadWriterForm').on('submit',function(){
// 				showHideFileuploadform('.countFileTargetForm',filesLength);
// 				$("#ModalImportForm").modal('hide');
// 				return false;
// 			});
// 			$('form#fileUploadWriterFormWorkflow').on('submit',function(){
// 				showHideFileuploadform('.countFileTargetFormWorkflow',filesLengthWorkflow);
// 				$("#ModalImportFormWorkflow").modal('hide');
// 				return false;
// 			});
			
// 			$(".dropify-clear").click(function(){
// 				filesLength = 0;
// 				filesLengthWorkflow = 0;
// 			});
			
// 			function showHideFileuploadform(classtextFiles,filelength) {
// 				if(filelength>0) {
// 					$(""+classtextFiles+"").text(''+filelength+' Files');
// 				} else {
// 					$(""+classtextFiles+"").text('');
// 				}
// 			}
			
// 		 }// end if
// 	 }// end if
// });// end document
</script>


<!-- Mainly scripts -->
<!-- <script type="text/javascript">var jQuery_1_1_3 = $.noConflict(true);</script> -->