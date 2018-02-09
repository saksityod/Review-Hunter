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

						<div class="form-group pull-left span2" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="ชื่อผู้เขียน"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อผู้เขียน" id="search_article" name="search_article"
								type="text">
						</div>
						<div class="form-group pull-left span2" style="margin-left: 5px;">
								<select data-toggle="tooltip" title="หัตถการ" data-placement="top" 
								class="span12" id="search_procedure" name="search_procedure">
								</select>
						</div>
						<div class="form-group pull-left span2" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="แพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="แพทย์" id="search_doctor" name="search_doctor"
								type="text">
						</div>
						<div class="form-group pull-left span2" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="จากวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="จากวันที่" id="search_start_date" name="search_start_date"
								type="text">
						</div>
						<div class="form-group pull-left span2" style="margin-left: 5px;">
							<input data-toggle="tooltip" title="ถึงวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ถึงวันที่" id="search_end_date" name="search_end_date"
								type="text">
						</div>
						<div class="form-group pull-right m-b-none ">
							<button type="button" name="btn_search" id="btn_search"
								class="btn btn-info input-sm " style="margin-left: 5px;">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
							<button type="button" name="btn_add" id="btn_add"
								class="btn btn-success input-sm" data-target=#ModalWriter data-toggle='modal' style="margin-left: 5px;">
								<i class="fa fa-plus"></i>&nbsp;เพิ่ม
							</button>
						</div>
					</div>
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
			<h5>สถานะของ content</h5>
		</div>
		<div class="ibox-content" style="border-color: rgb(0, 206, 215);">
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
			<!-- pagination start -->

			<div class="row-fluid">
				<div id="width-100-persen" class="span9 m-b-xs">

					<span class="pagination_top m-b-none pagination"
						id="yui_patched_v3_11_0_1_1514185894268_841"><ul
							class="pagination bootpag"
							id="yui_patched_v3_11_0_1_1514185894268_840">
							<li data-lp="1" class="first disabled"><a
								href="javascript:void(0);">←</a></li>
							<li data-lp="1" class="prev disabled"><a
								href="javascript:void(0);">prev</a></li>
							<li data-lp="1" class="active"><a href="javascript:void(0);">1</a></li>
							<li data-lp="2" id="yui_patched_v3_11_0_1_1514185894268_839"><a
								href="javascript:void(0);"
								id="yui_patched_v3_11_0_1_1514185894268_838">2</a></li>
							<li data-lp="3"><a href="javascript:void(0);">3</a></li>
							<li data-lp="4"><a href="javascript:void(0);">4</a></li>
							<li data-lp="5"><a href="javascript:void(0);">5</a></li>
							<li data-lp="2" class="next"><a href="javascript:void(0);">next</a></li>
							<li data-lp="6" class="last"><a href="javascript:void(0);">→</a></li>
						</ul></span>

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
									placeholder="" name="doctor" id="doctor">
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
									placeholder="" name="end_date" id="end_date">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label"> </label>
							<div class="controls">
								<input id="fileupload" type="file" name="files[]" data-url="" multiple>
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
								</select>
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">ไปขั้นตอน :</label>
								<div class="controls">
									<select class="form-control input-sm span12" id="to_step" name="to_step">
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
										<option value="1">1</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
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
									<textarea class="form-control span12" rows="4"></textarea>
								</div>
							</div>
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
							<tbody>
								<tr>
									<td style="vertical-align: middle; text-align: center;">เสร้มจมูกซิลิโคน</td>
									<td style="vertical-align: middle; text-align: center;">โซ</td>
									<td style="vertical-align: middle; text-align: center;">จมูกซิลิโคน</td>
									<td style="vertical-align: middle; text-align: center;">หมอต้น</td>
									<td style="vertical-align: middle; text-align: center;">11/10/2017</td>
									<td style="vertical-align: middle; text-align: center;">16/10/2017</td>
									<td style="vertical-align: middle; text-align: center;">11/10/2017</td>
									<td style="vertical-align: middle; text-align: center;">16/10/2017</td>
								</tr>
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

<!-- Modal Import Assignment -->
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
								<input type="file" id="file" class="dropify" accept=".xls, .xlsx, .pdf, .docx" multiple/><span></span>
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
					<button class="btn btn-success" type="submit" id="importsubmit" form="fileUploadWriter">Import</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
						<div class="alert alert-warning information" id="information"
						style="display: none;height:120px; overflow-y: scroll; position:relative;"></div>
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

