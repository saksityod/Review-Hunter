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
	long userId = layout.getUserId();
	//out.print(username);
	//out.print("password2="+password);
%>

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

</style>
<input type="hidden" id="user_portlet" name="user_portlet"
	value="<%=username%>">
<input type="hidden" id="pass_portlet" name="pass_portlet"
	value="<%=password%>">
<input type="hidden" id="url_portlet" name="url_portlet"
	value="<%=renderRequest.getContextPath()%>">
<input type="hidden" id="plid_portlet" name="plid_portlet"
	value="<%=plid%>">
<input type="hidden" id="userId_portlet" name="userId_portlet"
	value="<%=userId%>">
	
<div class='row-fluid '>
	<div class='col-xs-12'>
		<div id="slide_status" class="span12" style="z-index: 9000;">
			<div id="btnCloseSlide">
				<i class='fa fa-times'></i>
			</div>
			<div id="slide_status_area"></div>
		</div>
	</div>
</div>


<div class="row-fluid " id="">
	<div class="col-lg-12">
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h5>ค้นหา</h5>
			</div>
			<div class="ibox-content breadcrumbs2" >
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="" class="control-label">ชื่อ Case</label> 
						<input type="text" id="search_caseName" placeholder="กรอกชื่อ Case" />
					</div>
					<div class="form-group span3">
						<label for="" class="control-label ">ประเภท Case</label> 
						<select class="casetype" id="search_caseType">
							<option value="">-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label ">หัตถการ</label>
						<select class="procedure" id="search_procedure">
							<option value="">-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label ">ช่องทางลงสื่อ</label>
						<select class="social" id="search_social">
							<option value="">-- ทั้งหมด --</option>
						</select>
					</div>
				</div>
				
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="">HN</label> 
						<input type="text"  id="search_hn" placeholder="กรอกเลข  HN" class="num" />
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">VN</label> 
						<input type="text" id="search_vn" placeholder="กรอกเลข VN"  class="num" />
					</div>
					<div class="form-group span3">
						<label for="">Case ติดดาว</label> 
						<select class="form-control" id="search_review" >
							<option value='0'>-- ทั้งหมด --</option>
							<option value='1'>Case ยอดแย่</option>
							<option value='2'>Review ติดดาว</option>
							<option value='3'>Case ติดดาว</option>
							<option value='4'>ไม่ติดดาว</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="">วันหมดสัญญา</label> 
						<select id="search_expireDate">
							<option value="">-- ไม่ระบุ --</option>
							<option value="0">หมดสัญญาแล้ว</option>
							<option value="1">ยังไม่หมดสัญญา</option>
						</select>
					</div>
				</div>
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="" class="control-label">หัตถการที่ควรทำต่อ</label> 
						<select id="search_followup" class="procedure ">
							<option value=""> -- เลือกหัตถการที่ควรทำต่อ -- </option>	
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">กลุ่มของ  Case</label> 
						<select id="search_case_group" class="caseGroup">
							<option value=""> -- เลือกกลุ่ม Case -- </option>	
						</select>
					</div>
					<label for="">&nbsp;</label> 
					<button type="button" class="btn btn-info span3 pull-right" id="btn_search" style="width: auto;">
						<i class="fa fa-search"></i> ค้นหา
					</button>
				</div>
				
			</div>
				<br />
		</div>
		<!-- content end -->
	</div>

	<div class="col-lg-12">
		<div class="ibox-title">
			<h5>B&A Library 
				<button class="btn btn-success" id='addCase'  data-type="add"  data-keyboard="false">
					<i class="fa fa-plus"></i> เพิ่ม
				</button>
			</h5>
		</div>
		<div class="ibox-content" style="">
			<!-- pagination start -->
			<div class="row-fluid">
				<div id="width-100-persen" class=" m-b-xs">
				
					<!-- start table -->
					<div class="row-fluid" style="overflow: auto;">
						<div class="table" id="show_list"></div>
					</div>

					<div class="row-fluid">
						<div id="width-100-persen" class="span9 m-b-xs">
							<span class="pagination_top m-b-none pagination"
								id="yui_patched_v3_11_0_1_1514185894268_841">
								<ul class="pagination bootpag" id="ba_pagination"></ul>
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
					
				</div>
			</div>
		</div>

	</div>

	<!-- Modal Start add -->
	<div aria-hidden="true" role="dialog" class="modal inmodal  large"
		tabindex="-1" id="modalAdd" class="modal inmodal"
		style="display: none;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button"
						style="padding-top: 5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span
							class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitleRole">ข้อมูลส่วนตัว</h4>
				</div>
				<div class="modal-body">
				
					<!-- patient -->
					<div class="row-fluid wrap " id="patient">
						<div class="row-fluid text-center">
						<br><br>
							 อัพโหลดรูปโปรไฟล์
							<div class="display_profileImage"><img style="width: 20%;" id="profileImage" src="#" alt=""  /></div>
							<p>
								<input type="file" id="btnUpload_profileImage" class="btn btn-info storeFile" accept="image/x-png,image/gif,image/jpeg" >
							</p>
						</div>
						<div class="row-fluid">
							<div class="form-group span3">
								<label>เลข HN: </label>
								<input type="text" id="patient_hnNo"  class=" input_control num" placeholder="ตัวเลขเท่านั้น" >
							</div>
							<div class="form-group span3">
								<label class=" ">ชื่อ : <span class="redFont ">*</span></label>
								<input type="text" id="patient_name" class=" input_control" placeholder="ชื่อ - นามสกุล">
							</div>
							<div class="form-group span2">
								<label class=" ">ชื่อเล่น : </label>
								<input type="text" id="patient_nickName" class=" input_control" placeholder="ชื่อเล่น">
							</div>
							<div class="form-group span3">
								<label class=" ">วันเดือนปีเกิด : <span class="redFont ">*</span></label>
								<input type="text" id="patient_birthDate" class="datepicker input_control" readonly  placeholder="วว/ดด/ปปปป">
							</div>
							<div class="form-group span1">
								<label class="">อายุ : <div class='yearOld'></div></label>
							</div>	
						</div>
						<div class="row-fluid">
							<div class="form-group span3">
								<label >สัญชาติ : <span class="redFont ">*</span></label>
								<select id="patient_nationality" class="nationality input_control">
									<option value=""> ---- เลือกสัญชาติ ---- </option>
								</select>
							</div>
							<div class="form-group span3">
								<label class="">เพศ : <span class="redFont ">*</span></label>
								<select id="patient_gender" class=" input_control">
									<option value=""> ---- เลือกเพศ ---- </option>
									<option value="male">ชาย</option>
									<option value="female">หญิง</option>
								</select>
							</div>
							<div class="form-group span6">
								<label class="">เลขที่บัตรประจำตัวประชาชน/หนังสือเดินทาง : <span class="redFont ">*</span></label><input type="text" id="patient_idCard" class=" input_control" placeholder="xxxxxxxxxxxxx">
							</div>
						</div>
						<div class="row-fluid">
							<div class="form-group span3">
								<label class="">บ้านเลขที่ : <span class="redFont ">*</span></label>
								<input type="text" id="patient_homeNo" class=" input_control" placeholder="บ้านเลขที่">
							</div>
							<div class="form-group span3">
								<label class="">หมู่ที่ : </label>
								<input type="text" id="patient_moo" class=" input_control"  placeholder="หมู่ที่">
							</div>
							<div class="form-group span6">
								<label class="">อาชีพ : </label>
								<input type="text" id="patient_career" class=" input_control" placeholder="อาชีพ">
							</div>
						</div>
						<div class="row-fluid">
							<div class="form-group span3">
								<label class=" ">ซอย : </label>
								<input type="text" id="patient_soi" class=" input_control" placeholder="ซอย">
							</div>
							<div class="form-group span3">
								<label class=" ">ถนน : </label>
								<input type="text" id="patient_road" class=" input_control" placeholder="ซอย">
							</div>
							<div class="form-group span3">
								<label class=" ">โทรศัพท์มือถือ : <span class="redFont ">*</span></label>
								<input type="text" id="patient_mobile" class=" input_control" placeholder="โทรศัพท์มือถือ">
							</div>
							<div class="form-group span3">
								<label class="">โทรศัพท์บ้าน : </label>
								<input type="text" id="patient_telNo" class=" input_control" placeholder="โทรศัพท์บ้าน">
							</div>
						</div>
						<div class="row-fluid">
							<div class="form-group span3">
								<label class="">จังหวัด : <span class="redFont ">*</span></label>
								<select id="patient_province" class=" input_control">
									<option value=""> ---- เลือกจังหวัด ---- </option>
								</select>
							</div>
							<div class="form-group span3">
								<label class="">อำเภอ/เขต : <span class="redFont ">*</span></label><select id="patient_amphur" class=" input_control"></select>
							</div>
							<div class="form-group span3">
								<label class="">ตำบล/แขวง : <span class="redFont ">*</span></label><select id="patient_district" class=" input_control"></select>
							</div>
							<div class="form-group span3">
								<label class="">รหัสไปรษณีย์ : </label><div id="patient_zipcode" ></div>
							</div>
						</div>
					</div>
					
					
					<!-- patient_social_media -->
					<div class="row-fluid wrap" id="patient_social_media">
						<h4>ข้อมูล Social Network &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4> 
						<div class="content_field collapse" id='collapse_patient_social_media'>
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="patient_social_media_type social">
											<option value=""> ---- เลือกสื่อ ---- </option></select></td>
										<td><input type="text" class="patient_social_media_link" placeholder="บัญชีผู้ใช้งาน/ลิ้งค์"></td>
										<td><input type="number" class="patient_social_media_follow" placeholder="จำนวน Follower"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'
								>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action">แก้ไข</button>
								<button class="btn btn-danger modal-cancel pull-right btn-action">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>ประเภท <span class="redFont ">*</span></th>
											<th>บัญชีผู้ใช้งาน/ลิ้งค์ <span class="redFont ">*</span></th>
											<th>จำนวน Follower <span class=""></span></th>
											<th width="20px"></th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
					
					
					<!-- surgery_history -->
					<div class="row-fluid wrap" id="surgery_history">
						<h4>ประวัติศัลยกรรม &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4> 
						<div class="content_field collapse" id="collapse_surgery_history">
							<div class="wrap_button">
								<button class="btn btn-success modal-add  btn-action" data-tr='<tr class="dump_tr">
										<td><select class="surgery_year reverse_year">
											<option value=""> ---- เลือกปี ---- </option></select></td>
										<td><div class="surgery_lengthYear">0</div></td>
										<td><input type="text" class="surgery_clinic" placeholder="ระยะเวลา(ปี)"></td>
										<td><input type="text" class="surgery_doctor" placeholder="แพทย์"></td>
										<td><input type="text" class="surgery_procedure" placeholder="หัตถการ"></td>
										<td><input type="text" class="surgery_remark" placeholder="หมายเหตุ"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>ปี <span class="redFont ">*</span></th>
											<th>ระยะเวลา(ปี)</th>
											<th>คลินิก/โรงพยาบาล </th>
											<th>แพทย์</th>
											<th>หัตถการ  <span class="redFont ">*</span></th>
											<th>หมายเหตุ</th>
											<th width="20px"></th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
					
					
					<!-- patient_case -->
					<div class="row-fluid wrap" id="patient_case">
						<h4>ข้อมูลการทำหัตถการ (Case) &nbsp;&nbsp;&nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4> 
						<div class="content_field collapse" id="collapse_patient_case">
							<br/>	
							<div class="row-fluid">
								<div class="form-group span3">
									<label class=" ">กลุ่มที่แนะนำ: </label>
									<input type="text" id="patient_case_suggesGroup" class="input_control" placeholder="กลุ่มแนะนำ">
								</div>
								<div class="form-group span3">
									<label class=" ">แนะนำโดย: </label>
									<input type="text" id="patient_case_suggestedBy" class="input_control" placeholder="แนะนำโดย">
								</div>
								<div class="form-group span3">
									<label >ประเภท Case : <span class="redFont ">*</span></label>
									<select id="patient_case_caseType" class="casetype input_control">
										<option value=""> ---- เลือกประเภท Case ---- </option>
									</select>
								</div>
								<div class="form-group span3">
									<label >กลุ่มของ Case :  <span class="redFont ">*</span></label>
									<select id="patient_case_caseGroup" class="caseGroup input_control">
										<option value=""> ---- เลือกกลุ่มCase ---- </option>	
									</select>
								</div>	
							</div>
							
							<div class="row-fluid">
								<div class="span3">
									<label >ผู้ดูแล : (Auto complete) <span class="redFont ">*</span></label>
									<input type="text" id="patient_case_supervisedBy" class=" input_control" placeholder="ค้นหาผู้ดูแลอัตโนมัติ">
									<span class="add_supervisedBy"><i class="fa fa-angle-double-right text-success"></i></span> 
								</div>
								<div class="span9">
									<div class="view_supervisedBy"></div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="form-group span3">
									<label class=" ">กลุ่มที่เลข VN : </label>
									<input type="text" id="patient_case_vn" class=" input_control num" placeholder="ตัวเลขเท่านั้น">
								</div>
								<div class="form-group span3">
									<label class=" ">หัตถการ : <span class="redFont ">*</span></label>
									<select id="patient_case_procedure" class="procedure input_control">
										<option value=""> ---- เลือกหัตถการ ---- </option>
									</select>
								</div>
								<div class="form-group span3">
									<label class=" ">แพทย์ :  <span class="redFont ">*</span></label>
									<select id="patient_case_doctor" class="doctor input_control">
										<option value=""> ---- เลือกหมอ ---- </option>
									</select>
								</div>
							</div>
							<div class="row-fluid">
								<div class="form-group span3">
									<input id="patient_case_isGood" type="checkbox" class=" input_control"><span> Case ติดดาว</span>
								</div>
								<div class="form-group span3">
									<input id="patient_case_isBad" type="checkbox" class=" input_control"><span> Case ยอดแย่</span>
								</div>
								<div class="form-group span3">
									<input id="patient_case_isGoodReview" type="checkbox" class=" input_control"><span> Review ติดดาว</span>
								</div>
							</div>
							<div class="row-fluid">
								<div class="span12">
									<label class=" ">เหตุผล :  </label>
									<input type="text" id="patient_case_remark" class=" input_control span12" placeholder="หมายเหตุ">
								</div>
							</div>
							<div class="row-fluid text-center patientSubmit hide">
								<div class="wrap_button">
									<button class="btn btn-success input_control btnModalSubmit"  type="button">
										Submit
									</button>
									<button data-dismiss="modal" class="btn btn-danger" type="button">
										Cancel
									</button>
								</div>
							</div>
							<br/>
						</div>
					</div>
					
					<div class="row-fluid wrap" id="case_followup">
						<div class="row-fluid">
							<h4 class="">หัตถการที่ควรทำ &nbsp;&nbsp;
								<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
							</h4>
							<div class="content_field collapse" id="collapse_case_followup">
								<div class="wrap_button">
									<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
											<td><select class="case_followup_procedure procedure">
												<option value=""> ---- เลือกหัตถการ ---- </option></select></td>
											<td><select class="case_followup_year next_year">
												<option value=""> ---- เลือกปี ---- </option></select></td>
											<td><input type="text" class="case_followup_remark" placeholder="หมายเหตุ"></td>
											<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
										</tr>'>เพิ่ม</button>
									<button class="btn btn-warning modal-edit btn-action " style="display: inline-block;">แก้ไข</button>
									<button class="btn btn-danger modal-cancel btn-action pull-right" style="display: none;">ยกเลิก</button>
								</div>
								<div class="responsive-table">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>ชื่อหัตถการ <span class="redFont ">*</span></th>
												<th>ปีที่ควรทำ </th>
												<th>หมายเหตุ</th>
												<th width="20px"></th>
											</tr>
										</thead>
										<tbody>
											
										</tbody>
									</table>
									<div class="wrap_button">
										<button class="btn btn-primary modal-add btn-action pull-right" id="followupSubmit">บันทึก</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					<!-- case_price -->
					<div class="row-fluid wrap" id="case_price">
						<h4 class=" ">ราคา &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_price">
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="case_price_type discount">
											<option value=""> ---- เลือกประเภทส่วนลด ---- </option></select></td>
										<td><input type="number" class="case_price_offer"  placeholder="ราคาที่เสนอ"></td>
										<td><input type="number" class="case_price_accept" placeholder="ราคาที่ยอมจ่าย"></td>
										<td><div class="case_price_percent">0</div></td>
										<td><div class="case_price_value">0</div></td>
										<td><input type="text" class="case_price_remark" placeholder="หมายเหตุ"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>ประเภทส่วนลด <span class="redFont ">*</span></th>
											<th>ราคาที่เสนอ <span class="redFont ">*</span></th>
											<th>ราคาที่ยอมจ่าย <span class="redFont ">*</span></th>
											<th>%ส่วนลด</th>
											<th>มูลค่าส่วนลด</th>
											<th>หมายเหตุ</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<!-- case_social_media -->
					<div class="row-fluid wrap" id="case_social_media">
						<h4 class=" ">ช่องทางลงสื่อ &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_social_media">
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="case_social_media_social social">
											<option value=""> ---- เลือกสื่อ ---- </option></select></td>
										<td><input type="text" class="case_social_media_link" placeholder="ลิงค์"></td>
										<td><input type="text" class="case_social_media_username" placeholder="Username"></td>
										<td><input type="text" class="case_social_media_password" placeholder="Password"></td>
										<td><input type="text" class="case_social_media_remark" placeholder="หมายเหตุ"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>ประเภท <span class="redFont ">*</span></th>
											<th>ลิงค์ <span class="redFont ">*</span></th>
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
					
					<!-- case_coordinate -->
					<div class="row-fluid wrap" id="case_coordinate">
						<h4 class=" ">การประสานงานคลินิก &nbsp;&nbsp;&nbsp;&nbsp; 
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_coordinate" style="display: flow-root;">
							<br/>
						</div>
					</div>
					
					<!-- case_appointment -->
					<div class="row-fluid wrap" id="case_appointment">
						<h4 class=" ">นัดหมาย &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_appointment">
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr"></td>
										<td><select class="case_appointment_type appointment">
											<option value=""> ---- เลือก ---- </option></select></td>
										<td><input type="text" class="case_appointment_date datetimepicker" readonly  placeholder="หมายเหตุ"></td>
										<td><select class="case_appointment_doctor doctor">
											<option value=""> ---- เลือกหมอ ---- </option></select></td>
										<td><input class="case_appointment_supervised " type="text" placeholder="ผู้ดูแล ค้นหาอัตโนมัติ"></td>
										<td><label class="label-control"><input class="case_appointment_isVdoProduct" type="checkbox"> ถ่าย VDO</label>
											<label class="label-control"><input class="case_appointment_isVdoRh" type="checkbox"> RH VDO</label>
											<label class="label-control"><input class="case_appointment_isPictureProduct" type="checkbox"> ถ่ายภาพ</label>
											<label class="label-control"><input class="case_appointment_isPictureRh" type="checkbox"> RH ถ่ายภาพ</label>
											<label class="label-control"><input class="case_appointment_isMeetDoctor" type="checkbox"> พบแพทย์</label></td>
										<td><input class="case_appointment_remark" type="text" placeholder="หมายเหตุ"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<br/>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>รายการ <span class="redFont ">*</span></th>
											<th>ณ วันที่ <span class="redFont ">*</span></th>
											<th>แพทย์ <span class="redFont ">*</span></th>
											<th>ผู้ดูแล (Auto complete)</th>
											<th>รายการนัดหมาย</th>
											<th>หมายเหตุ</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					
					<!-- case_contract -->
					<div class="row-fluid wrap" id="case_contract">
						<h4 class=" ">รายละเอียดสัญญา &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" data-target="collapse_case_contract">
							<div class="wrap_button">
								<button type="button" class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><div class="case_contract_no no"></div></td>
									<td><select class="case_contract_procedure procedure">
										<option value=""> ---- เลือกหัตถการ ---- </option></select></td>
									<td><input type="text" class="case_contract_startDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
									<td><input type="text" class="case_contract_endDate datepicker" readonly placeholder="วว/ดด/ปปปป"><hr class="hr1">
	    								<div class="text-center">เหลือเวลา <span class="remaining_days">0</span> วัน</div></td>
									<td><label class="label-control"><input class="case_contract_isPost" type="checkbox"> โพสรีวิว</label>
										<label class="label-control"><input class="case_contract_isUsage"	type="checkbox"> อนุญาตให่้่ใช้รูปภาพและVDO</label>
										<label class="label-control"><input class="case_contract_isPicture_vdo" type="checkbox"> ถ่ายภาพและVDO</label>
										<label class="label-control"><input class="case_contract_isReview" type="checkbox"> เขียนReview</label>
										<label class="label-control"><input class="case_contract_isPr" type="checkbox"> ช่วยประชาสัมพันธ์ข่าว</label>
										<label class="label-control"><input class="case_contract_isGroupPost" type="checkbox"> โพสรีวิวในกลุ่มศัลยกรรม</label>
										<label class="label-control"><input class="case_contract_isSendPicture" type="checkbox"> ส่งรูปภาพ</label>
										<label class="label-control"><input class="case_contract_isOther" 	type="checkbox"> อื่นๆ</label></td>
									<td><input class="case_contract_upload storeFile" multiple type="file" ></td>
									<td>
										<button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button>
									</td>
									<input class="case_contract_file_name_check" type="hidden">
									
									
								</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>ลำดับ</th>
											<th>หัตถการ <span class="redFont ">*</span></th>
											<th>วันเริ่มสัญญา <span class="redFont ">*</span></th>
											<th>วันหมดสัญญา <span class="redFont ">*</span></th>
											<th>ยินยอม</th>
											<th>ไฟล์อัพโหลด</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<!-- case_pr -->
					<div class="row-fluid wrap" id="case_pr">
						<h4 class=" ">รายละเอียดการประชาสัมพันธ์ &nbsp;&nbsp;
							<div class="btn-collapse pull-right"><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_pr">
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="case_pr_pr pr">
											<option value=""> ---- เลือกรายการประชาสัมพันธ์ ---- </option></select></td>
										<td><input type="text" class="case_pr_planDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
										<td >
											 <label class="label-control"><input class="case_pr_isPicture" type="checkbox"> รูปภาพ</label>
											 <label class="label-control"><input class="case_pr_isVdo" type="checkbox"> วีดีโอ(selfie)</label>
											 <label class="label-control"><input class="case_pr_isInstragram" type="checkbox"> live Instragram</label>
											 <label class="label-control"><input class="case_pr_isFacebook" type="checkbox"> live Facebook</label>
										</td>
										<td><input type="text" class="case_pr_actualDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>รายการ <span class="redFont ">*</span></th>
											<th>ณ วันที่ <span class="redFont ">*</span></th>
											<th>โดยจะลงเป็น</th>
											<th>ในวันที่ <span class="redFont ">*</span></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<!-- case_file -->
					<div class="row-fluid wrap" id="case_file">
						<h4 class=" ">แฟ้ม  &nbsp;&nbsp;
							<div class="btn-collapse pull-right"><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse"  id="collapse_case_file">
							<div class="wrap_button">
								<button class="btn btn-info btn-action btn-upload modal-add" id="btnAddFolder"  data-target="#addFolder" data-toggle="modal">สร้างแฟ้มรูป</button> 
								<button class="btn btn-success btn-action btn-upload modal-add" id="btnUploadFile" data-target="#ModalImportForm" data-toggle="modal" >อัพโหลด</button>
								<button class="btn btn-danger btn-action btn-upload" id="btndeleteFolder" data-target="#deleteFolderForm" data-toggle="modal">ลบแฟ้มข้อมูล</button>
							</div>
							<div class="row-fluid">
								<div class="span8">
									<ul id="list" class="list_tree">
									    <li><a href="#">Home</a><ul> </ul></li>
									</ul>
								</div>
								<div class="span4">
									<div id="review_image">
										<img src=''>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Article -->
					<div class="row-fluid wrap" id="case_article">
						<h4 class=" ">รีวิว &nbsp;&nbsp;
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_case_article">
							<div class="wrap_button">
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><input class="case_article_name" type="text" placeholder="ชื่อรีวิว"></td>
										<td><select class="case_article_type_id article">
											<option value=""> ---- เลือกรีวิว ---- </option></select></td>
										<td><input class="case_article_writer user" type="text" placeholder="ผู้เขียน ค้นหาอัตโนมัติ"></td>
										<td><input type="text" class="case_article_writingStartDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
										<td><input type="text" class="case_article_writingEndDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
										<td><input type="text" class="case_article_planDate datepicker" readonly placeholder="วว/ดด/ปปปป"></td>
										<td><input class="case_article_upload storeFile" multiple type="file"></td>
										<td >
											<button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button>
										<input class="case_contract_file_name_check" type="hidden">
										</td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
							</div>
							<div class="responsive-table">
								<table class="table table-bordered" width="100%">
									<thead>
										<tr>
											<th>ชื่อรีวิว <span class="redFont ">*</span></th>
											<th>ประเภทรีวิว <span class="redFont ">*</span></th>
											<th>ผู้เขียน (Auto Complete) <span class="redFont ">*</span></th>
											<th>วันที่เริ่มเขียน <span class="redFont ">*</span></th>
											<th>วันที่เขียนเสร็จ</th>
											<th>กำหนดส่ง <span class="redFont ">*</span></th>
											<th>ไฟล์อัพโหลด</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<!-- case_stage -->
					<div class="row-fluid wrap" id="case_stage">
						<h4 class=" ">Workflow</h4>
						<div class="content_field">
							<br/>
							<div class="row-fluid">
								<div class="form-group span4">
									<label class="input_control ">จากขั้นตอน : <span class="redFont ">*</span></label>
									<select id="case_stage_fromStage"  class="input_control "></select>
								</div>
								<div class="form-group span4">
									<label class=" ">ไปขั้นตอน : <span class="redFont ">*</span></label>
									<select id="case_stage_toStage"  class="input_control "></select>
								</div>
								<div class="form-group span4">
									<label class=" ">ส่งถึง:  <span class="redFont ">*</span></label>
									<select id="case_stage_toUser" class=" input_control"><option value="">-- เลือกส่งถึง --</option></select>
								</div>	
							</div>
							<div class="row-fluid">
								<div class="form-group span4">
									<label class=" ">วันที่เสร็จ : </label>
									<div id="case_stage_actualDate" class=""></div>
								</div>
								<div class="form-group span4">
									<button class="btn btn-primary" id="btn_case_stage_upload" data-target="#addImage" data-toggle="modal">เลือกรูปภาพ</button>
									<div id="case_stage_upload"></div>
								</div>
								<div class="form-group span4">
									<label class=" ">วันครบกำหนด: </label>
									<input type="text" id="case_stage_planDate" class="datepicker input_control" readonly placeholder="วว/ดด/ปปปป">
								</div>	
							</div>
							<div class="row-fluid ">
								<div class="span8">
									<label >เหตุผล : </label>
									<textarea id="case_stage_remark" rows="4" class="input_control" placeholder="หมายเหตุ"></textarea>
								</div>
								<div class="span4">
									<label class=" ">แจ้งเตือน: </label>
									<select id="case_stage_notification" class="input_control" multiple>
									</select>
								</div>	
							</div>
							<div class="row-fluid">
								<div class="span8">
									<label class=" ">แนบเอกสาร : </label>
									<input type="file" id="case_stage_upfile" class="storeFile input_control" multiple >
								</div>
							</div>
							
							<div class="row-fluid text-center">
								<div class="wrap_button">
									<button class="btn btn-success input_control btnModalSubmit" id="btnModalSubmit" type="button">
										Submit
									</button>
									<button data-dismiss="modal" class="btn btn-danger" type="button">
										Cancel
									</button>
								</div>
							</div>
							<div class="row-fluid">
							<br>
							   <div class="alert alert-warning information" id="information_errors" style="display: none;height:120px; overflow-y: scroll; position:relative;">
								<h4>แจ้งเตือน</h4></div>
							</div>	
						</div>
					</div>
					
					<!-- Workflow -->
					<div class="row-fluid wrap" id="workflow">
						<h4 class=" ">Workflow History
							<div class="btn-collapse pull-right" ><i class="fa icon-chevron-down"></i></div>
						</h4>
						<div class="content_field collapse" id="collapse_workflow">
							<div class="responsive-table none">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th rowspan=2>วันเวลา</th>
											<th colspan=2>จาก</th>
											<th colspan=2>ถึง</th>
											<th rowspan=2>หมายเหตุ</th>
											<th rowspan=2>แจ้งเตือน</th>
											<th rowspan=2>เอกสารแนบ</th>
										</tr>
										<tr>
											<th>งาน</th>
											<th>ผู้รับผิดชอบ</th>
											<th>งาน</th>
											<th>ผู้รับผิดชอบ</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
						
				</div><!--  modal body -->
				
				<div class="modal-footer">
				
					
					
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End add -->
		
	<!-- Modal Import file form -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="ModalImportForm"
		class="modal inmodal portlet-frame" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only"></span>
					</button>
					<h4 class="modal-title" id="">อัพโหลดไฟล์</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<form id="">
						<div class="row-fluid"> 
							<div class=""> <label class=" ">แฟ้มหลัก: </label> 
								<select class="folderList"></select>
							</div>
						</div>
						<h6>File Upload</h6>
						<div class="fileImport">
							<input type="file" id="fileForm" class=" fileUpload" accept=".xls, .xlsx, .pdf, .docx ,.png,.jpg,.jpeg" multiple/><span></span>
						</div>
						<h6 class="label-content-import-export"></h6>
					</form>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" type="button" id="importsubmitForm" >Upload</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End  -->
	
	<!-- Modal Delete Folder form -->
	<div aria-hidden="true" role="dialog" tabindex="-1" id="deleteFolderForm"
		class="modal inmodal portlet-frame" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header" style="background-color: rgb(0, 206, 215); border-color: rgb(0, 206, 215);">
					<button data-dismiss="modal" class="close" type="button" style="padding-top:5px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span class="sr-only"></span>
					</button>
					<h4 class="modal-title" id="">ลบแฟ้มข้อมูล</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<form id="">
						<div class="row-fluid"> 
							<div class=""> <label class=" ">แฟ้ม: </label> 
								<ul class="folderList list_tree">
								    <li><a href="#">Home</a><ul> </ul></li>
								</ul>
							</div>
						</div>
					</form>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">ปิด</button>
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
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"
						style="padding-top: 3px">
						<span aria-hidden="true"><i class='fa fa-times'></i></span><span
							class="sr-only">Close</span>
					</button>
					<h5 class="modal-title">Confirm Dialog</h5>
				</div>
				<div class="modal-body">
					<!-- content start -->

					<!-- form start -->
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
						</button>&nbsp;&nbsp;
						<button data-dismiss="modal" class="btn btn-danger" type="button">
							<i class="fa fa-times-circle"></i>&nbsp;Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Modal create folder Start -->
		<div aria-hidden="true" role="dialog" tabindex="-1" id="addFolder"
			class="modal inmodal in"
			style="width: 400px; left: calc; display: none;">
			<div class="modal-dialog">
				<div class="modal-content  bounceInRight">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button"
							style="padding-top: 3px">
							<span aria-hidden="true"><i class='fa fa-times'></i></span><span
								class="sr-only">Close</span>
						</button>
						<h5 class="modal-title">สร้างแฟ้มรูป</h5>
					</div>
					<div class="modal-body">
						<div class="row-fluid"> 
							<div class=""> <label class=" ">แฟ้มหลัก: </label> 
								<select class="main_folder"></select>
							</div>
							<div class=""> <label class=" ">ชื่อแฟ้ม: </label> 
								<input type="text" id="folderName" class="">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div align="center">
							<button class="btn btn-success" id="btnSubmitAddFolder" type="button">
								&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;สร้าง&nbsp;&nbsp;
							</button>&nbsp;&nbsp;
							<button data-dismiss="modal" class="btn btn-danger" type="button">
								<i class="fa fa-times-circle"></i>&nbsp;ยกเลิก
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Modal Image Start -->
		<div aria-hidden="true" role="dialog" tabindex="-1" id="addImage"
			class="modal inmodal in"
			style="width: 400px; left: calc; display: none;">
			<div class="modal-dialog">
				<div class="modal-content  bounceInRight">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button"
							style="padding-top: 3px">
							<span aria-hidden="true"><i class='fa fa-times'></i></span><span
								class="sr-only">Close</span>
						</button>
						<h5 class="modal-title">เลือกรูป</h5>
					</div>
					<div class="modal-body">
						<div class="row-fluid wrap"> 
							
						</div>
					</div>
					<div class="modal-footer">
						<div align="center">
							<button class="btn btn-success" id="btnSubmitAddImage" type="button">
								&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;เลือก&nbsp;&nbsp;
							</button>&nbsp;&nbsp;
							<button data-dismiss="modal" class="btn btn-danger" type="button">
								<i class="fa fa-times-circle"></i>&nbsp;ยกเลิก
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Modal edit folder Start -->
		<div aria-hidden="true" role="dialog" tabindex="-1" id="editFolder"
			class="modal inmodal in"
			style="width: 400px; left: calc; display: none;">
			<div class="modal-dialog">
				<div class="modal-content  bounceInRight">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button"
							style="padding-top: 3px">
							<span aria-hidden="true"><i class='fa fa-times'></i></span><span
								class="sr-only">Close</span>
						</button>
						<h5 class="modal-title">แก้ไขแฟ้มรูป</h5>
					</div>
					<div class="modal-body">
						<div class="row-fluid">
							<div class=""> <label class=" ">ชื่อแฟ้ม: </label> 
								<input type="text" id="edit_folderName" class="">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div align="center">
							<button class="btn btn-success" id="btnSubmitEditFolder" type="button">
								&nbsp;&nbsp;<i class="fa fa-check-circle"></i>&nbsp;&nbsp;ตกลง&nbsp;&nbsp;
							</button>&nbsp;&nbsp;
							<button data-dismiss="modal" class="btn btn-danger" type="button">
								<i class="fa fa-times-circle"></i>&nbsp;ยกเลิก
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>