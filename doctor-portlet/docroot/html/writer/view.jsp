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
<style>
.redFont{     float: inherit !important; }
</style>

<style>
	select{ width: 96% !important;}
	.case_list{     border: 1px solid darkgray; }
	.edit-list{ margin:10px}
	.row-fluid {	margin-button: 10px;	}
	/* .modal-body > div{margin-top:20px}
	.modal-body > div{display:none;} */
	.aui hr{ margin:10px 0 20px}

.list_tree{ padding-top:15px !important; }
.list_tree, .list_tree ul {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  list-style-type: none;
  margin-left:0;
  padding-left:15px;
}
.list_tree li ul li:before {
    color: orange;
    font-size: 25px;
    padding-right: 10px;
    float: left;
}
.list_tree li ul li.folder:before {
	font-family: FontAwesome;
    content: "\f07b";
    float: left;
}
.list_tree li ul li.file:before {
	font-family: FontAwesome;
    content: "\f15b";
    color: #0aba1d;
    font-size: 20px;
    float: left;
}
.list_tree li ul li.file.type-jpg:before,
.list_tree li ul li.file.type-png:before,
.list_tree li ul li.file.type-jpeg:before {
	font-family: FontAwesome;
    content: "\f1c5";
}
.list_tree > li:before {
    font-family: FontAwesome;
    content: "\f015";
    color:skyblue;
    font-size: 40px;
    padding-right: 10px;
}
.list_tree li {
	font-size: 12px;
	    margin-top: 10px !important;
	    width: 100% !important;
    display: inline-block;
}
.list_tree > li > ul > li > ul > li > ul > li{     display: flex !important;	}

/* UL Layer 1 Rules 
#nestedlist {
  list-style-image:url(http://placehold.it/5x15/ff0000);
  font-size: 20px;
  font-weight:bold;
}

/* UL Layer 2 Rules 
#nestedlist ul {
  list-style-image:url(http://placehold.it/5x15/00ff00);
  font-size: 18px;
  font-weight: normal;
  margin-top: 3px;
}

/* UL Layer 3 Rules 
#nestedlist ul ul {
  list-style-image:url(http://placehold.it/5x15/0000ff);
  font-size: 16px;
}

/* UL 4 Rules 
#nestedlist ul ul ul {
  list-style-image:url(http://placehold.it/5x15/ffff00);
  font-size: 14px;
}
*/

.ms-container .ms-selectable li.ms-elem-selectable, .ms-container .ms-selection li.ms-elem-selection{
	font-size:10px;
    line-height: 1.2;
}
.ms-container .ms-selectable li.ms-elem-selectable:before{
	content: "-";
	padding-right:10px;
	padding-top: 5px;
}
.add_supervisedBy{
	position: absolute;
    margin-left: 10px;
    font-size: 25px;
}
.patient_case_supervisedBy{
    margin-left: 20px;
    margin-bottom: 5px;
    padding: 5px;
    width: max-content;
    float: left;
    padding-right: 10px;
    margin-top: 20px;
}	
.remove_supervisedBy{	margin-left: 5px;	}
#fileForm {
	 width: 100%;
	 height: 100%;
}
.coordinate_group{ margin-bottom:15px}
.ui-autocomplete{ z-index:1099 !important}
.aui li{ margin-top: 5px;}
.aui .btn.active, .aui .btn:active{ background: #0044cc ;color:white  ;}
.case_list {	margin-bottom: 20px;	}
.wrap{	margin-bottom: 20px;	}
.stage_upload_img{	 }
.stage_upload_img.active{filter:opacity(30%);border : 5px solid blue!important}
.redFont{ float:inherit; line-height: initial;}
.hr1{     margin: 5px 0 !important; }
.wrap_option{ display: inline-flex;}
.btn-group { display: inline-flex; padding-right:0px }
.wrap_volume { padding-right: 40px; }
.del-folder,.btn-delete{ padding: 3px 10px !important;}
	.aui .wrap_isPass{ display: inline-flex;    margin-right: 40px; }
	.aui .btn-group, .aui .button-holder{ display: inline-flex; }
.ms-container{ width:auto !important }
.file_name{	float: left;
			    max-width: 250px;
			    white-space: nowrap;
			    overflow: hidden;
			    text-overflow: ellipsis; }
.folder_name{float: left;
			    max-width: 250px;
			    white-space: nowrap;
			    overflow: hidden;
			    text-overflow: ellipsis;}
.wrap_button{    display: flow-root;padding-top:15px}
.file_name:hover{ cursor:pointer}
.ui_tpicker_hour,.ui_tpicker_minute{ width :70px}	
.ui_tpicker_minute_slider,.ui_tpicker_hour_slider{ width :60px}
.aui input[readonly]{ background:white;cursor:pointer}

	.folder a{ padding-left:10px}
	.case_list .btn {	margin-bottom: 10px;	}
	.btn-collapse{
	    padding: 0px 10px;
	    cursor: pointer;
    }
    .btn-collapse.open .icon-chevron-down:before{	content:"\f077";	}
    .wrap h4{
        background: aliceblue;
	    margin: 0px;
	    padding:15px;
	    border-left: 5px solid cadetblue;
	    font-size: 15px;
    }

    .content_field{     padding: 0px 10px;
	    background: rgba(200, 250, 250, 0.1);
	    box-shadow: rgb(170, 170, 170) 0px 0px 4px -1px inset; }
	    
.list_tree li li:hover, .list_tree li ul li:hover {
    background: aliceblue;
}
.responsive-table{ padding-top:15px; padding-bottom:15px; }
@media  only screen and (max-width: 979px){
	td{ border-top:0px !important; }
	.file .file_name,.file .folder_name{ white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
	
	.file_name{	padding-left:0px; max-width: 200px;}
	.folder_name{padding-left:0px;max-width: 205px;}
	.aui body{	padding:0;	}

	.aui button,.aui .btn{
	    font-size: 15px !important;
	    width: auto !important;
    	padding: 5px !important;
    	margin-right:5px;
    	margin-top:0px;
    	display: initial;
	}
	.aui .btnIsOpen{	margin:0px	}
	/* .aui input,.aui select{
	    font-size: 13px !important;
	    width: auto !important;
	    display: inline-block !important;
	} */
	.aui input,.aui select,.aui .input_control{
	    font-size: 13px !important;
    	padding: 5px 5px !important;
	}
	.aui input[type='file']{
	    font-size: 13px !important;
	    width: auto !important;
    	padding: 0 5px !important;
	    display: inline-block !important;
	}
	.aui .case_list{	padding:10px;	}
	.aui .wrap_button{	display:inline-flex;	}
	.aui .responsive-table {
	    width: 100%;
	    margin-bottom: 15px;
	    overflow: hidden;
	}
	.aui .table-bordered{	border:0px !important	}
	.aui .label-control{	width: max-content;	}
	.list_tree, .list_tree ul{ 
		padding-left: 8px;
	    text-indent: 0; 
	}
	.volume_title{ display:none}
	.wrap_volume{ padding-right: 10px; }
	.list_tree {	padding-left:0	}
	.list_tree li {	font-size: 12px;	}
	.list_tree > li:before{     font-size: 15px; }
	.list_tree li ul li:before{ font-size: 15px; }
	.list_tree li ul li.file:before{  font-size: 10px; }
	.btn-group { display: inline-flex; padding-right:5px }
	.aui .wrap_isPass{     margin-right: 20px; }
	.patient_case_supervisedBy{	 margin-top: 0px;	}		
}
@media  only screen and (max-width: 767px){

	.aui .portlet-content .form-group[class*="span"], 
	.aui .portlet-content .form-group.uneditable-input[class*="span"], 
	.aui .portlet-content .row-fluid .form-group[class*="span"], 
	.aui .modal .row-fluid .form-group[class*="span"]{
		float: left !important;
		width: 50% !important;
		padding-right: 5%;
	}
}
.numberNotIcon[type=number]::-webkit-inner-spin-button, 
.numberNotIcon[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}

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
				<div class="ibox-title" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<h5>ค้นหา</h5>
				</div>
				<div class="ibox-content breadcrumbs2"
					style="border-color: rgb(0, 206, 215);">
					
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3">
							<label class="label-control" for="">รหัสบทความ</label>
							<input data-toggle="tooltip" title="รหัสบทความ"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="รหัสบทความ" id="search_article_code" name="search_article_code"
								type="text">
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">ชื่อผู้เขียน</label>
							<input data-toggle="tooltip" title="ชื่อผู้เขียน"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อผู้เขียน" id="search_writer" name="search_writer"
								type="text">
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">หัตถการ</label>
							<select data-toggle="tooltip" title="หัตถการ" data-placement="top"
								class="input span12 m-b-n" id="search_procedure"
								name="search_procedure">
								<option value="">All</option>
							</select>
						</div>
						
						<div class="form-group span3">
							<label class="label-control" for="">ชื่อแพทย์</label>
							<input data-toggle="tooltip" title="ชื่อแพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="แพทย์" id="search_doctor" name="search_doctor"	type="text">
						</div>
						
					</div>
						
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3">
							<label class="label-control" for="">จากวันที่</label>
							<input data-toggle="tooltip" title="จากวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input datepicker"
								placeholder="จากวันที่" id="search_start_date" name="search_start_date"
								type="text">
						</div>
						<div class="form-group span3">
							<label class="label-control" for="">ถึงวันที่</label>
							<input data-toggle="tooltip" title="ถึงวันที่"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input datepicker"
								placeholder="ถึงวันที่" id="search_end_date" name="search_end_date"
								type="text">
						</div>
						<div class="form-group text-right span6" style=" margin-top: 25px;">
							<button type="button" name="btn_search" id="btn_search"	class="btn btn-info input-sm">
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

<div class="row-fluid">
	<div class="col-lg-12">
		<div class="ibox-title"
			style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
			<h5>สถานะของ content
			 	<button type="button" name="btn_add" id="btn_add" class="btn btn-success input-sm" data-target=#ModalWriter data-toggle='modal' data-backdrop="static" data-keyboard="false" style="margin-left: 5px;">
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
							<th style='width: auto'><strong>รหัสบทความ</strong></th>
							<th style='width: auto'><strong>ผู้เขียน</strong></th>
							<th style='width: auto'><strong>หัตถการ</strong></th>
							<th style='width: auto'><strong>แพทย์</strong></th>
							<th style='width: auto'><strong>วันที่เริ่มเขียน</strong></th>
							<th style='width: auto'><strong>วันที่เขียนเสร็จ</strong></th>
							<th style='width: auto'><strong>กำหนดส่ง</strong></th>
							<th style='width: auto'><strong>ประเภทบทความ</strong></th>
							<th style='width: auto'><strong>สถานะงาน</strong></th>
							<th style='width: 130px;' colspan='3'></th>
						</tr>
					</thead>
					<tbody id="result_search_writer">
					</tbody>
				</table>
			</div>
			<!-- end table -->
			<!-- pagination start -->
				<div class="row-fluid">
					<div id="width-100-persen" class="span9 m-b-xs ">
						<span class="pagination_bottom m-b-none pagination"></span>
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
				<button class="close" type="button" style="padding-top: 5px" data-target=#confrimModalCancel data-toggle='modal' data-backdrop="static" data-keyboard="false">
					<span aria-hidden="true"><i class='fa fa-times'></i></span>
					<span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="modalTitleRole">เพิ่ม/แก้ไข  Writer</h4>
			</div>
			
			<div class="modal-body">
				<!-- content start -->
				<!-- form start -->
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">รหัสบทความ:</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									name="article_code" id="article_code" disabled="disabled">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ชื่อบทความ<span style="color:red;">*</span>:</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									name="article_name" id="article_name">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid" style="margin-bottom: 5px;">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ประเภทบทความ<span style="color:red;">*</span>:</label>
							<div class="controls">
								<select class="form-control input-sm span12" id="article_type" name="article_type">
								</select>
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">หัตถการ<span style="color:red;">*</span>:</label>
							<div class="controls">
								<select class="form-control input-sm span12" id="procedure_name" name="procedure_name">
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">แพทย์<!-- <span style="color:red;">*</span> -->:</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="form_doctor" id="form_doctor">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">ผู้เขียน<span style="color:red;">*</span>:</label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12"
									placeholder="" name="author" id="author">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">วันที่เริ่มเขียน<span style="color:red;">*</span>: </label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12 datepicker"
									placeholder="" name="start_date" id="start_date">
							</div>
						</div>
					</div>
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">กำหนดส่ง<span style="color:red;">*</span>: </label>
							<div class="controls">
								<input type="text" class="form-control input-sm span12 datepicker"
									placeholder="" name="plan_date" id="plan_date">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5 form-horizontal p-t-xxs">
						<div class="form-group p-xxs">
							<label class="control-label">บทความที่มีอยู่: </label>
							<div class="controls">
								<span id="span_doc_path">
								</span>
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
				
				<br/>
				<br/>
				<!-- case_social_media -->
				<div class="row-fluid wrap" id="article_social_media">
					<h3 class="">ช่องทางลงสื่อ</h3>
					<div class="content_field " >
						<div class="wrap_button">
<%-- 							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr"> --%>
<!-- 									<td><select class="article_social_media_social social"> -->
<!-- 										<option value=""> ---- เลือกสื่อ ---- </option></select></td> -->
<!-- 									<td><input type="text" class="article_social_media_link" placeholder="ลิงค์"></td> -->
<!-- 									<td><input type="number" class="article_social_media_follow" placeholder="จำนวน Follow"></td> -->
<!-- 									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td> -->
<%-- 								</tr>'>เพิ่ม</button> --%>
								<span id="btn_add_social">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="article_social_media_social social">
											<option value=""> ---- เลือกสื่อ ---- </option></select></td>
										<td><input type="text" class="article_social_media_link" placeholder="ลิงค์"></td>
										<td><input type="text" class="article_social_media_username" placeholder="Username"></td>
										<td><input type="text" class="article_social_media_password" placeholder="Password"></td>
										<td><input type="text" class="article_social_media_remark" placeholder="หมายเหตุ"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								</span>
							<span id="btn_edit_social">
								<button class="btn btn-warning modal-edit btn-action">แก้ไข</button>
							</span>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</div>
						<div class="responsive-table" style="overflow: auto;">
							<table class="table table-bordered">
								<thead>
										<tr>
											<th>ประเภท <span class="redFont ">*</span></th>
											<th>ลิงค์  (ตัวอย่าง https://www.facebook.com)<span class="redFont ">*</span></th>
											<th>Username</th>
											<th>Password</th>
											<th>หมายเหตุ</th>
											<th width="20px"></th>
										</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<br/>
				<br/>
				<div class="row-fluid">
					<h3 class="">Workflow</h3>
					<div class="row-fluid">
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">จากขั้นตอน :</label>
								<div class="controls">
									<select class="form-control input-sm span12" id="by_step" name="by_step">
									<option value="201">ร้องขอบทความ</option>
								</select>
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">ไปขั้นตอน<span style="color:red;">*</span>:</label>
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
								<label class="control-label">วันที่เสร็จ:</label>
								<div class="controls">
									<input type="text" class="form-control input-sm span12 datepicker"
										placeholder="" name="writing_end_date" id="writing_end_date">
								</div>
							</div>
						</div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">ส่งถึง:</label>
								<div class="controls">
<!-- 									<input type="text" class="form-control input-sm span12" -->
<!-- 										placeholder="" name="send_to" id="send_to"> -->
									<select class="form-control input-sm span12" id="send_to" name="send_to">
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
								<label class="control-label">วันครบกำหนด :</label>
								<div class="controls">
									<input type="text" class="form-control input-sm span12 datepicker"
										placeholder="" name="actual_date" id="actual_date">
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
						<div class="span5 form-horizontal p-t-xxs"></div>
						<div class="span5 form-horizontal p-t-xxs">
							<div class="form-group p-xxs">
								<label class="control-label">แนบเอกสาร: </label>
								<div class="controls">
									<button type="button" name="btn_upload_form_workflow" id="btn_upload_form_workflow" class="btn btn-success input-sm" data-target="#ModalImportFormWorkflow" data-toggle="modal" title="อัพโหลด" data-placement="top">
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
					<button class="btn btn-danger btnCancle"
						type="button" id="btn_cancel_form" data-target=#confrimModalCancel data-toggle='modal' data-backdrop="static" data-keyboard="false">Cancel</button>
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
<div aria-hidden="true" role="dialog" tabindex="-1" id="confrimModalCancel"
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
				<h5 class="modal-title">ยืนยันการปิดแบบฟอร์ม</h5>
			</div>
			<div class="modal-body">
				
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">
						<label>คุณต้องการปิดแบบฟอร์มนี้หรือไม่?</label>
					</div>
				</div>

			</div><!-- modal body -->
			<div class="modal-footer">
				<div align="center">
					<button class="btn btn-success" id="btnConfirmOK2" type="button">
						&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Yes&nbsp;&nbsp;
					</button>
					&nbsp;&nbsp;
					<button class="btn btn-danger" type="button" id="btnCancelOK2" >
						<i class="fa fa-times-circle"></i>&nbsp;Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Confirm End -->

<!-- Modal Confirm Start -->
<div aria-hidden="true" role="dialog" tabindex="-1" id="confrimModalDelFile"
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
				<h5 class="modal-title">ยืนยันการลบไฟล์</h5>
			</div>
			<div class="modal-body">
				
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">
						<label>คุณต้องการลบไฟล์นี้หรือไม่?</label>
					</div>
				</div>

			</div><!-- modal body -->
			<div class="modal-footer">
				<div align="center">
					<button class="btn btn-success" id="btnConfirmDelFile" type="button">
						&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Yes&nbsp;&nbsp;
					</button>
					&nbsp;&nbsp;
					<button data-dismiss="modal" class="btn btn-danger" type="button" id="btnCancelDelFile" >
						<i class="fa fa-times-circle"></i>&nbsp;Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Confirm End -->

<!-- Modal Confirm Start -->
<div aria-hidden="true" role="dialog" tabindex="-1" id="confrimModalDelData"
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
				
				<div class="form-kpi-mangement">
					<div class="form-kpi-label" align="center">
						<label>คุณต้องการลบข้อมูลนี้หรือไม่?</label>
					</div>
				</div>

			</div><!-- modal body -->
			<div class="modal-footer">
				<div align="center">
					<button class="btn btn-success" id="btnConfirmDelData" type="button">
						&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Yes&nbsp;&nbsp;
					</button>
					&nbsp;&nbsp;
					<button data-dismiss="modal" class="btn btn-danger" type="button" id="btnCancelDelData" >
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

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
