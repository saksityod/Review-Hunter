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

#list, #list ul {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  list-style-type: none;
  margin-left:0;
  padding-left:40px;
  text-indent: -30px;
}
#list li ul li:before {
    color: orange;
    font-size: 25px;
    padding-right: 10px;
}
#list li ul li.folder:before {
	font-family: FontAwesome;
    content: "\f07b";
}
#list li ul li.file:before {
	font-family: FontAwesome;
    content: "\f15b";
    color: #0aba1d;
    font-size: 20px;
}
#list li ul li.file.type-jpg:before,
#list li ul li.file.type-png:before,
#list li ul li.file.type-jpeg:before {
	font-family: FontAwesome;
    content: "\f1c5";
}
#list > li:before {
    font-family: FontAwesome;
    content: "\f015";
    color:skyblue;
    font-size: 40px;
    padding-right: 10px;
}
#list li {
	font-size: 13px;
}

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
}	
.remove_supervisedBy{
        margin-left: 5px;
}
#fileForm {
 width: 100%;
 height: 100%;
}
.coordinate_group{ margin-bottom:15px}
.ui-autocomplete{ z-index:1099 !important}
.aui li{ margin-top: 5px;}

.aui .btn.active, .aui .btn:active{ background: #0044cc ;color:white}
.case_list {
    margin-bottom: 20px;
}
.wrap{
	margin-bottom: 40px;
}

.stage_upload_img{	 }
.stage_upload_img.active{filter:opacity(30%);border : 5px solid blue!important}
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
						<input type="text" id="search_caseName" />
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
						<input type="text"  id="search_hn" />
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">VN</label> 
						<input type="text" id="search_vn" />
					</div>
					<div class="form-group span3">
						<label for="">Case ติดดาว</label> 
							<select class="form-control" id="search_review" >
								<option value='0'>ทั้งหมด</option>
								<option value='1'>Case ยอดแย่</option>
								<option value='2'>Review ติดดาว</option>
								<option value='3'>Case ติดดาว</option>
								<option value='4'>ไม่ติดดาว</option>
							</select>
					</div>
					<div class="form-group span3">
						<label for="">วันหมดสัญญา</label> 
						<select id="search_expireDate">
							<option value="">ไม่ระบุ</option>
							<option value="0">หมดสัญญาแล้ว</option>
							<option value="1">ยังไม่หมดสัญญา</option>
						</select>
					</div>
				</div>
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="" class="control-label">หัตถการที่ควรทำต่อ</label> 
						<select id="search_followup" class="procedure ">
							<option value=""> ---- เลือกหัตถการที่ควรทำต่อ ---- </option>	
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">กลุ่มของ  Case</label> 
						<select id="search_case_group" class="caseGroup">
							<option value=""> ---- เลือกกลุ่มCase ---- </option>	
						</select>
					</div>
					<label for="">&nbsp;</label> 
					<button type="button" class="btn btn-info span3" id="btn_search" style="width: auto;">
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
				<button class="btn btn-success" id='addCase' data-target=#modalAdd data-toggle='modal' data-type="add">
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
								<ul class="pagination bootpag" id=""></ul>
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
					<h4 class="modal-title" id="modalTitleRole">เป้าหมายของแพทย์</h4>
				</div>
				<div class="modal-body">
				
					<!-- patient -->
					<div class="row-fluid wrap " id="patient">
						<div class="row-fluid text-center">
						<br><br>
							 อัพโหลดรูปโปรไฟล์
							<div class="display_profileImage"><img style="width: 20%;" id="profileImage" src="#" alt=""  /></div>
							<label>
								<input type="file" id="btnUpload_profileImage" class="btn btn-info storeFile" accept="image/x-png,image/gif,image/jpeg" >
							</label>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label>เลข HN: </label><input type="text" id="patient_hnNo"  class=" input_control">
							</div>
							<div class="span3">
								<label class=" ">ชื่อ : </label><input type="text" id="patient_name" class=" input_control">
							</div>
							<div class="span2">
								<label class=" ">ชื่อเล่น : </label><input type="text" id="patient_nickName" class=" input_control">
							</div>
							<div class="span3">
								<label class=" ">วันเดือนปีเกิด : </label>
								<input type="text" id="mask_patient_birthDate"  class="datepicker input_control" class=" input_control">
								<input type="hidden" id="patient_birthDate" class="datepicker_ad input_control">
							</div>
							<div class="span1">
								<label class="">อายุ : </label><div class='yearOld'></div>
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label >สัญชาติ : </label>
								<select id="patient_nationality" class="nationality input_control">
									<option value=""> ---- เลือกสัญชาติ ---- </option>
								</select>
							</div>
							<div class="span3">
								<label class="">เพศ : </label>
								<select id="patient_gender" class=" input_control">
									<option value=""> ---- เลือกเพศ ---- </option>
									<option value="male">ชาย</option>
									<option value="female">หญิง</option>
								</select>
							</div>
							<div class="span6">
								<label class="">เลขที่บัตรประจำตัวประชาชน/หนังสือเดินทาง : </label><input type="text" id="patient_idCard" class=" input_control">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class="">บ้านเลขที่ : </label><input type="text" id="patient_homeNo" class=" input_control">
							</div>
							<div class="span3">
								<label class="">หมู่ที่ : </label><input type="text" id="patient_moo" class=" input_control">
							</div>
							<div class="span6">
								<label class="">อาชีพ : </label><input type="text" id="patient_career" class=" input_control">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class=" ">ซอย : </label><input type="text" id="patient_soi" class=" input_control">
							</div>
							<div class="span3">
								<label class=" ">ถนน : </label><input type="text" id="patient_road" class=" input_control">
							</div>
							<div class="span3">
								<label class=" ">โทรศัพท์มือถือ : </label><input type="text" id="patient_mobile" class=" input_control">
							</div>
							<div class="span3">
								<label class="">โทรศัพท์บ้าน : </label><input type="text" id="patient_telNo" class=" input_control">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class="">จังหวัด : </label>
								<select id="patient_province" class=" input_control">
									<option value=""> ---- เลือกจังหวัด ---- </option>
								</select>
							</div>
							<div class="span3">
								<label class="">อำเภอ/เขต : </label><select id="patient_amphur" class=" input_control"></select>
							</div>
							<div class="span3">
								<label class="">ตำบล/แขวง : </label><select id="patient_district" class=" input_control"></select>
							</div>
							<div class="span3">
								<label class="">รหัสไปรษณีย์ : </label><div id="patient_zipcode" ></div>
							</div>
						</div>
					</div>
					
					
					<!-- patient_social_media -->
					<div class="row-fluid wrap" id="patient_social_media">
						<h4>ข้อมูล Social Network &nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><select class="patient_social_media_type social">
										<option value=""> ---- เลือกสื่อ ---- </option></select></td>
									<td><input type="text" class="patient_social_media_link"></td>
									<td><input type="number" class="patient_social_media_follow"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'
							>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action">แก้ไข</button>
							<button class="btn btn-danger modal-cancel pull-right btn-action">ยกเลิก</button> 
						</h4> 
						<hr/>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>ประเภท</th>
									<th>บัญชีผู้ใช้งาน/ลิ้งค์</th>
									<th>จำนวน Follower</th>
									<th width="20px"></th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
					
					<!-- surgery_history -->
					<div class="row-fluid wrap" id="surgery_history">
						<h4>ประวัติศัลยกรรม &nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-success modal-add  btn-action" data-tr='<tr class="dump_tr">
									<td><select class="surgery_year next_year">
										<option value=""> ---- เลือกปี ---- </option></select></td>
									<td><div class="surgery_lengthYear"></div></td>
									<td><input type="text" class="surgery_clinic"></td>
									<td><select class="surgery_doctor doctor">
										<option value=""> ---- เลือกหมอ ---- </option></select></td>
									<td><select class="surgery_procedure procedure">
										<option value=""> ---- เลือกหัตถการ ---- </option></select></td>
									<td><input type="text" class="surgery_remark"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4> 
						<hr/>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>ปี</th>
									<th>ระยะเวลา(ปี)</th>
									<th>คลินิก/โรงพยาบาล</th>
									<th>แพทย์</th>
									<th>หัตถการ</th>
									<th>หมายเหตุ</th>
									<th width="20px"></th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
					
					<!-- patient_case -->
					<div class="row-fluid wrap" id="patient_case">
						<h4>ข้อมูลการทำหัตถการ (Case) &nbsp;&nbsp;&nbsp;&nbsp;</h4> 
						<hr/>
						<div class="row-fluid">
							<div class="span3">
								<label class=" ">กลุ่มที่แนะนำ: </label>
								<input type="text" id="patient_case_suggesGroup" class="input_control">
							</div>
							<div class="span3">
								<label class=" ">แนะนำโดย: </label>
								<input type="text" id="patient_case_suggestedBy" class="input_control">
							</div>
							<div class="span3">
								<label >ประเภท Case : </label>
								<select id="patient_case_caseType" class="casetype input_control">
									<option value=""> ---- เลือกประเภท Case ---- </option>
								</select>
							</div>
							<div class="span3">
								<label >กลุ่มของ Case :  </label>
								<select id="patient_case_caseGroup" class="caseGroup input_control">
									<option value=""> ---- เลือกกลุ่มCase ---- </option>	
								</select>
							</div>	
						</div>
						
						<div class="row-fluid">
							<div class="span3">
								<label >ผู้ดูแล : (Auto complete)</label>
								<input type="text" id="patient_case_supervisedBy" class=" input_control">
								<span class="add_supervisedBy"><i class="fa fa-angle-double-right text-success"></i></span> 
							</div>
							<div class="span9">
								<label class=" ">&nbsp; </label>
								<div class="view_supervisedBy"></div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class=" ">กลุ่มที่เลข VN : </label>
								<input type="text" id="patient_case_vn" class=" input_control">
							</div>
							<div class="span3">
								<label class=" ">หัตถการ : </label>
								<select id="patient_case_procedure" class="procedure input_control">
									<option value=""> ---- เลือกหัตถการ ---- </option>
								</select>
							</div>
							<div class="span6">
								<label class=" ">แพทย์ :  </label>
								<select id="patient_case_doctor" class="doctor input_control">
									<option value=""> ---- เลือกหมอ ---- </option>
								</select>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<input id="patient_case_isGood" type="checkbox" class=" input_control"><span> Case ติดดาว</span>
							</div>
							<div class="span3">
								<input id="patient_case_isBad" type="checkbox" class=" input_control"><span> Case ยอดแย่</span>
							</div>
							<div class="span3">
								<input id="patient_case_isGoodReview" type="checkbox" class=" input_control"><span> Review ติดดาว</span>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span12">
								<label class=" ">เหตุผล :  </label>
								<input type="text" id="patient_case_remark" class=" input_control">
							</div>
						</div>
					</div>
					
					<div class="row-fluid wrap" id="case_followup">
						<div class="row-fluid">
							<h4 class="">หัตถการที่ควรทำ &nbsp;&nbsp;&nbsp;&nbsp; 
								<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
										<td><select class="case_followup_procedure procedure">
											<option value=""> ---- เลือกหัตถการ ---- </option></select></td>
										<td><select class="case_followup_year next_year">
											<option value=""> ---- เลือกปี ---- </option></select></td>
										<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
								<button class="btn btn-warning modal-edit btn-action " style="display: inline-block;">แก้ไข</button>
								<button class="btn btn-danger modal-cancel btn-action pull-right" style="display: none;">ยกเลิก</button>
							</h4>
							
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th>ชื่อหัตถการ</th>
											<th>ปีที่ควรทำ</th>
											<th width="20px"></th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					
					<!-- case_price -->
					<div class="row-fluid wrap" id="case_price">
						<h4 class=" ">ราคา &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><select class="case_price_type discount">
										<option value=""> ---- เลือกประเภทส่วนลด ---- </option></select></td>
									<td><input type="number" class="case_price_offer"></td>
									<td><input type="number" class="case_price_accept"></td>
									<td><div class="case_price_percent"></div></td>
									<td><div class="case_price_value"></div></td>
									<td><input type="text" class="case_price_remark"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>ประเภทส่วนลด</th>
										<th>ราคาที่เสนอ</th>
										<th>ราคาที่ยอมจ่าย</th>
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
					
					<!-- case_social_media -->
					<div class="row-fluid wrap" id="case_social_media">
						<h4 class=" ">ช่องทางลงสื่อ &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><select class="case_social_media_social social">
										<option value=""> ---- เลือกสื่อ ---- </option></select></td>
									<td><input type="text" class="case_social_media_link"></td>
									<td><input type="text" class="case_social_media_username"></td>
									<td><input type="text" class="case_social_media_password"></td>
									<td><input type="text" class="case_social_media_remark"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>ประเภท</th>
										<th>ลิงค์</th>
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
					
					<!-- case_coordinate -->
					<div class="row-fluid wrap" id="case_coordinate">
						<h4 class=" ">การประสานงานคลินิก &nbsp;&nbsp;&nbsp;&nbsp; </h4>
						<hr/>
					</div>
					
					<!-- case_appointment -->
					<div class="row-fluid wrap" id="case_appointment">
						<h4 class=" ">นัดหมาย &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr"></td>
									<td><select class="case_appointment_type appointment">
										<option value=""> ---- เลือก ---- </option></select></td>
									<td><input class="datepicker" type="text">
										<input class="case_appointment_date datepicker_ad" type="hidden"></td>
									<td><select class="case_appointment_doctor doctor">
										<option value=""> ---- เลือกหมอ ---- </option></select></td>
									<td><input class="case_appointment_supervised user" type="text"></td>
									<td><input class="case_appointment_isVdoProduct" type="checkbox"></td>
									<td><input class="case_appointment_isVdoRh" type="checkbox"></td>
									<td><input class="case_appointment_isPictureProduct" type="checkbox"></td>
									<td><input class="case_appointment_isPictureRh" type="checkbox"></td>
									<td><input class="case_appointment_isMeetDoctor" type="checkbox"></td>
									<td><input class="case_appointment_remark" type="text"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>รายการ</th>
										<th>ณ วันที่</th>
										<th>แพทย์</th>
										<th>ผู้ดูแล</th>
										<th>ถ่าย VDO</th>
										<th>RH VDO</th>
										<th>ถ่ายภาพ</th>
										<th>RH ถ่ายภาพ</th>
										<th>พบแพทย์</th>
										<th>หมายเหตุ</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
					
					
					<!-- case_contract -->
					<div class="row-fluid wrap" id="case_contract">
						<h4 class=" ">รายละเอียดสัญญา &nbsp;&nbsp;&nbsp;&nbsp; 
							<button type="button" class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
								<td><input class="case_contract_no no" 	type="text"></td>
								<td><select class="case_contract_procedure procedure">
									<option value=""> ---- เลือกหัตถการ ---- </option></select></td>
								<td><input class="datepicker" 	type="text">
									<input class="case_contract_startDate datepicker_ad" 	type="hidden"></td>
								<td><input class="datepicker" 	type="text">
									<input class="case_contract_endDate datepicker_ad" type="hidden"></td>
								<td><input class="case_contract_isPost" type="checkbox"></td>
								<td><input class="case_contract_isUsage"	type="checkbox"></td>
								<td><input class="case_contract_isPicture_vdo" type="checkbox"></td>
								<td><input class="case_contract_isReview" type="checkbox"></td>
								<td><input class="case_contract_isPr" type="checkbox"></td>
								<td><input class="case_contract_isGroupPost" 	type="checkbox"></td>
								<td><input class="case_contract_isSendPicture" type="checkbox"></td>
								<td><input class="case_contract_isOther" 	type="checkbox"></td>
								<td><input class="case_contract_upload storeFile" multiple type="file" ></td>
								<td>
									<button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button>
								</td>
								<input class="case_contract_file_name_check" type="hidden">
								
								
							</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th colspan='4'></th>
										<th colspan='10'style="text-align:center">ยินยอม</th>
									</tr>
									<tr>
										<th>ลำดับ</th>
										<th>หัตถการ</th>
										<th>วันเริ่มสัญญา</th>
										<th>วันหมดสัญญา</th>
										<th>โพสรีวิว</th>
										<th>อนุญาตให่้่ใช้รูปภาพและVDO</th>
										<th>ถ่ายภาพและVDO</th>
										<th>เขียนReview</th>
										<th>ช่วยประชาสัมพันธ์ข่าว</th>
										<th>โพสรีวิวในกลุ่มศัลยกรรม</th>
										<th>ส่งรูปภาพ</th>
										<th>อื่นๆ</th>
										<th>ไฟล์อัพโหลด</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- case_pr -->
					<div class="row-fluid wrap" id="case_pr">
						<h4 class=" ">รายละเอียดการประชาสัมพันธ์ &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><select class="case_pr_pr pr">
										<option value=""> ---- เลือกรายการประชาสัมพันธ์ ---- </option></select></td>
									<td><input class=" datepicker" type="text">
										<input class="case_pr_planDate datepicker_ad" type="hidden"></td>
									<td width="150px">
										 <label><input class="case_pr_isPicture" type="checkbox"> รูปภาพ</label>
										 <label><input class="case_pr_isVdo" type="checkbox"> วีดีโอ(selfie)</label>
										 <label><input class="case_pr_isInstragram" type="checkbox"> live Instragram</label>
										 <label><input class="case_pr_isFacebook" type="checkbox"> live Facebook</label>
									</td>
									<td><input class=" datepicker" type="text">
										<input class="case_pr_actualDate datepicker_ad" type="hidden"></td>
									<td><button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>รายการ</th>
									<th>ณ วันที่</th>
									<th>โดยจะลงเป็น</th>
									<th>ในวันที่</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					
					<!-- case_file -->
					<div class="row-fluid wrap" id="case_file">
						<h4 class=" ">แฟ้ม  &nbsp;&nbsp;&nbsp;&nbsp;  
							<button class="btn btn-info btn-action modal-add" id="btnAddFolder"  data-target="#addFolder" data-toggle="modal">สร้างแฟ้มรูป</button> 
							<button class="btn btn-success btn-action modal-add" id="btnUploadFile" data-target="#ModalImportForm" data-toggle="modal" form="fileUploadWriterForm">อัพโหลด</button>
						</h4>
						<hr/>
						<div class="row-fluid">
							<div class="span8">
								<ul id="list">
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
					
					<!-- Article -->
					<div class="row-fluid wrap" id="case_article">
						<h4 class=" ">บทความ &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add btn-action" data-tr='<tr class="dump_tr">
									<td><input class="case_article_name" type="text"></td>
									<td><select class="case_article_type_id article">
										<option value=""> ---- เลือกบทความ ---- </option></select></td>
									<td><input class="case_article_writer user" type="text"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_writingStartDate datepicker_ad" type="hidden"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_writingEndDate datepicker_ad" type="hidden"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_planDate datepicker_ad" type="hidden"></td>
									<td><input class="case_article_upload storeFile" multiple type="file"></td>
									<td width="150px">
										<button class="btn btn-danger del-tr btn-action"><i class="fa fa-times-circle"></i></button>
									<input class="case_contract_file_name_check" type="hidden">
									</td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit btn-action ">แก้ไข</button>
							<button class="btn btn-danger modal-cancel btn-action pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>ชื่อบทความ</th>
										<th>ประเภทบทความ</th>
										<th>ผู้เขียน</th>
										<th>วันที่เริ่มเขียน</th>
										<th>วันที่เขียนเสร็จ</th>
										<th>กำหนดส่ง</th>
										<th>ไฟล์อัพโหลด</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- case_stage -->
					<div class="row-fluid wrap" id="case_stage">
						<h4 class=" ">Workflow  &nbsp;&nbsp;&nbsp;&nbsp;</h4>
						<hr/>
						<div class="row-fluid">
							<div class="span4">
								<label class="input_control ">จากขั้นตอน : </label>
								<select id="case_stage_fromStage"  class="input_control "></select>
							</div>
							<div class="span4">
								<label class=" ">ไปขั้นตอน : </label>
								<select id="case_stage_toStage"  class="input_control "></select>
							</div>
							<div class="span4">
								<label class=" ">ส่งถึง: (Auto complete)</label>
								<select id="case_stage_toUser" class=" input_control"></select>
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span4">
								<label class=" ">วันที่เสร็จ : </label>
								<div id="case_stage_actualDate_mask" class="" ></div>
								<div id="case_stage_actualDate" class=""></div>
							</div>
							<div class="span4">
								<button class="btn btn-primary" id="btn_case_stage_upload" data-target="#addImage" data-toggle="modal">เลือกรูปภาพ</button>
								<div id="case_stage_upload"></div>
							</div>
							<div class="span4">
								<label class=" ">วันครบกำหนด: </label>
								<input id="" class="datepicker input_control" type="text">
								<input id="case_stage_planDate" class="datepicker_ad input_control" type="hidden">
							</div>	
						</div>
						<div class="row-fluid ">
							<div class="span8">
								<label >เหตุผล : </label>
								<textarea id="case_stage_remark" rows="4" class="input_control"></textarea>
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
								<input type="file" id="case_stage_upfile" class="storeFile input_control" multiple>
							</div>
						</div>
						<div align="center">
							<button class="btn btn-success input_control" id="btnModalSubmit" type="button">
								Submit
							</button>&nbsp;&nbsp;
							<button data-dismiss="modal" class="btn btn-danger" type="button">
								Cancel
							</button>
						</div>
						<div class="row-fluid">
						<br>
						   <div class="alert alert-warning information" id="information_errors" style="display: none;height:120px; overflow-y: scroll; position:relative;">
							<h4>แจ้งเตือน</h4></div>
						</div>	
					</div>
					
					<!-- Workflow -->
					<div class="row-fluid wrap" id="workflow">
						<h4 class=" ">Workflow History</h4>
						<hr/>
						
						<div class="table-responsive">
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
					<form id="fileUploadWriterForm">
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
					<button class="btn btn-success" type="button" id="importsubmitForm" form="fileUploadWriterForm">Upload</button>
					<button data-dismiss="modal" class="btn btn-danger btnCancle"
						type="button">Cancel</button>
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
		
		<!-- Modal Confirm Start -->
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
		
	</div>
</div>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>


<script type="text/javascript">
$(document).ready(function() {
	$username = $("#user_portlet").val();
	$password = $("#pass_portlet").val();
	$plName = $("#plid_portlet").val();
	$roles = "rh_co";
	if(connectionServiceFn($username,$password,$plName)){
		$appName = "ba";
		$perpage = $("#countPaginationBottom").val();
		$plRoute = restfulURL+"/"+serviceName+'/'+$appName;

		var n_id = 0;
		getAjax($plRoute+'/getOnLoad','get',{userId:$('#userId_portlet').val()},function(rs){
			console.log(rs);
			$host = rs.host;
			$current_year = parseInt(rs.currentDate.split("-")[2])+543;
			$current_date = rs.currentDate.split("-")[0]+'/'+rs.currentDate.split("-")[1]+'/'+$current_year;
			$('#case_stage_actualDate_mask').text($current_date);
			$('#case_stage_actualDate').text(beToad($current_date)).hide();
			$(".datepicker").each(function(){
				$(this).closest("div").find(".datepicker_ad").val(beToad($(this).val()));
			});
			
			var html_temp = '';
			$.each(rs.province,function(){
				html_temp +='<option value="'+this.province_id+'">'+this.province_name+'</option>';
			}); $('#patient_province').append(html_temp);
			
			$html_procedure = '';
			$.each(rs.medicalProcedure,function(){
				$html_procedure +='<option value="'+this.procedure_id+'">'+this.procedure_name+'</option>';
			}); $('.procedure').append($html_procedure);

			$html_doctor = '';
			$.each(rs.doctor,function(){
				$html_doctor +='<option value="'+this.doctor_id+'">'+this.doctor_name+'</option>';
			}); $('.doctor').append($html_doctor );
			
			$html_social = '';
			$.each(rs.socialMedia,function(){
				$html_social +='<option value="'+this.social_media_id+'">'+this.social_media_name+'</option>';
			}); $('.social').append($html_social);
			
			$html_caseType = '';
			$.each(rs.caseType,function(){
				$html_caseType +='<option value="'+this.case_type_id+'">'+this.case_type+'</option>';
			}); $('.casetype').append( $html_caseType);
			
			$html_caseGroup = '';
			$.each(rs.casegroup,function(){
				$html_caseGroup +='<option value="'+this.case_group_id+'">'+this.case_group+'</option>';
			}); $('.caseGroup').append( $html_caseGroup);
			
			$html_discountType = '';
			$.each(rs.discountType,function(){
				$html_discountType +='<option value="'+this.discount_type_id+'">'+this.discount_type_name+'</option>';
			}); $('.discount').append( $html_discountType );
			
			html_temp = '';
			$.each(rs.nationality,function(){
				html_temp +='<option value="'+this.nationality_id+'">'+this.nationality_name+'</option>';
			}); $('.nationality').append( html_temp );
			
			$html_pr = '';
			$.each(rs.pr,function(){
				$html_pr +='<option value="'+this.pr_id+'">'+this.pr_desc+'</option>';
			}); $('.pr').append( $html_pr );
			
			$html_appointment = '';
			$.each(rs.appointmentType,function(){
				$html_appointment +='<option value="'+this.appointment_type_id+'">'+this.appointment_type_name+'</option>';
			}); $('.appointment').append( $html_appointment );
			
			$html_articleType = '';
			$.each(rs.articleType,function(){
				$html_articleType +='<option value="'+this.article_type_id+'">'+this.article_type_name+'</option>';
			}); $('.article').append( $html_articleType );
			
			$html_temp = '';
			$.each(rs.getUserAlert,function(){
				$html_temp +='<option data-email="'+this.emailAddress+'" value="'+this.userId+'">'+this.screenName+'</option>';
			});	$('#case_stage_notification').append( $html_temp );
			
			html_temp = '';
			$.each(rs.usageType,function(k,v){
				html_temp += "<div class='span5 coordinate_group dump-multiselect'><label>"+v.usage_type_name+"</label><select data-usageType_id='"+v.usage_type_id+"' class='multiple case_coordinate' multiple='multiple'>";
				$.each(v.usage_item,function(){
					html_temp +='<option value="'+this.usage_id+'">'+this.usage_name+'</option>';
				});	html_temp +="</select></div>"	;	
			}); 
			$('#case_coordinate').append( html_temp );
			$('.multiple').multiSelect();
			//$('.folder_toggle').click(function(){	$(this).parent('li').find('ul').toggle();	});
			$('.datepicker').keydown(function(e){e.preventDefault();});
			$('#case_stage_notification').multiselect({
		        includeSelectAllOption: false,
		        maxHeight: 200
		    });
			getList();
		});
		
		$('#btn_search').click(function(){	getList();  });
		
		/* edit case */
		$('body').on('click','.edit-list',function(){		
			$('#edit-list').data('method',$(this).data('type'));
			getAjax($plRoute+'/getOneCase','get',{case_id:$(this).closest('.case_list').data('id')},function(rs){
				console.log(rs);
				if(rs){
					clearAll();
					$('#review_image img').attr('src',$host+rs.patient.image_path);
					getCurrentStage(rs.stage.stage_id,'#case_stage_fromStage');
					$('#case_stage').data('id',rs.stage.stage_id);
						pushData_patient(rs.patient);
					if(rs.patient.social) 	pushData_socialMedia(rs.patient.social);
					if(rs.patient_surgery) 	pushData_sugery(rs.patient_surgery);
						pushData_patientCase(rs);
					if(rs.case_social_media)pushData_caseSocialMedia(rs.case_social_media);
					if(rs.case_follow_up) 	pushData_caseFollowup(rs.case_follow_up);
					if(rs.case_price)		pushData_casePrice(rs.case_price);
					if(rs.case_coordinate)	pushData_caseCoordinate(rs.case_coordinate);
					if(rs.case_appointment)	pushData_caseAppointment(rs.case_appointment);
					if(rs.case_contract)	pushData_caseContact(rs.case_contract);
					if(rs.case_pr)			pushData_casePr(rs.case_pr);
					if(rs.folder)			getFolder(rs.folder);
					if(rs.case_article)		pushData_caseArticle(rs.case_article);
					if(rs.caseStageHistory)	pushData_workFlow(rs.caseStageHistory);
					
					$('.btn-action').hide();
					$('.case_coordinate').attr('disabled','disabled').multiselect("refresh");
					$('.input_control').attr('disabled','disabled');

					getStage(rs.stage.stage_id);
					checkRoleAuthurize(rs.stage.stage_id);
				}
			});
		});
		
		function checkRoleAuthurize(stage_id){
			getAjax($plRoute+'/sectionRole','get',{stage_id:stage_id},function(rs){
				console.log(rs);
				$.each(rs.section,function(){
					if(this.section_id == 'patient' || this.section_id == 'patient_case'){
						if(this.add_flag == 1 && this.edit_flag == 1) $('#'+this.section_id).find('.input_control').removeAttr('disabled');
					}else{
						if(this.add_flag == 1)		$('#'+this.section_id).find('.modal-add,.btn-other').show();
						if(this.edit_flag == 1)		$('#'+this.section_id).find('.modal-edit').show();
						if(this.delete_flag == 1)	$('#'+this.section_id).find('.btn-delete').show();
						if(this.upload_flag == 1)	$('#'+this.section_id).find('.btn-Upload').show();
						if(this.download_flag == 1)	$('#'+this.section_id).find('.btn-Download').show();
					}
				});
				if($.inArray(rs.stageRole.role_id, rs.userRole)!= -1){
					$('#case_stage').find('.input_control').removeAttr('disabled');
				}else{
					$('#case_stage').find('.input_control').attr('disabled',true);
				}
				$('#case_stage_notification').multiselect("refresh");
			});
			
		}
		
		$('#btnModalSubmit').click(function(){
			var FormAllData = new FormData();
			$case_id = $('#case_stage').data('id');
			getData_patient();
			getData_patientCase();
			getData_patientSocial();
			getData_patientSurgery();
			getData_caseFollowup();
			getData_casePrice();
			getData_caseSocial();
			getData_caseCoordinate();
			getData_caseAppointment();
			getData_caseContact();
			getData_casePr();
			getData_caseArticle();
			getData_caseStage(); 

			console.log($data);
			$('.storeFile').each(function() {
				var id = this.id;
				if(this.files){
					$.each(this.files,function(i,v){
						console.log(this);
						FormAllData.append(id+'[]',this);
					});
				}
			});
			FormAllData.append('formdata', JSON.stringify($data));
			$.ajax({
			    url:$plRoute+'/cu',
			    type:'POST',
			    data: FormAllData,
			    cache: false,
			    dataType: 'json',
			    content:"application/json",
			    processData: false, // Don't process the files
			    contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			    headers:{Authorization:"Bearer "+tokenID.token},
			    success: function(rs) {
			    	console.log(rs);
			    	if(rs.status==200){
			    		callFlashSlide('บันทึกข้อมูลสำเร็จ','success');
			    		getList();
			    		$('#modalAdd').modal('hide');
			    	}else if(rs.status==400){
			    		callFlashSlide('ไม่สามารถบันทึกข้อมูลได้!!  กรุณาตรวจกรอกข้อมูลให้ครบถ้วน','Error');
			    		validatetorInformation(validatetor(rs.errors));
			    	}
			    },
			    error:function(rs){
			    	console.log('error',rs);
			    }
			}); 
		});
		
		$('#case_stage_toStage').change(function(){
			var html_send_to = '';
			if($(this).val()!=''){
				getAjax($plRoute+'/sendTo','get',{stage_id:$(this).val()},function(rs){
					console.log(rs,'action #case_stage_toStage');
					if(rs.length > 0){
						$.each(rs,function(){
							html_send_to +='<option data-email="'+this.emailAddress+'" value="'+this.userId+'">'+this.screenName+'</option>';
						}); 
					}
				})
			}
			$('#case_stage_toUser').html(html_send_to);
		});
		
		$('body').on('click','.stage_upload_img',function(){
			if($(this).hasClass('active')){
				$(this).removeClass('active');
			}else{
				$(this).addClass('active');
			}
		});
		$('#btn_case_stage_upload').click(function(){
			$('#addImage .wrap,#case_stage_upload').html('');
			getAjax($plRoute+'/getCaseFile','get',{case_id:$('#patient_case').data('id')},function(rs){
				console.log(rs);
				var html = '<ul class="thumbnails">';
				if(rs){
					$.each(rs,function(){
						var fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
						if(fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg'){
			  				html +='<li class="span6">'
							    +'<a href="javascript:void(0);" data-imagepath="'+this.image_path+'" data-name="'+this.file_name+'" class="stage_upload_img thumbnail">'
							      +'<img src="'+$host+this.image_path+'" alt=""></a></li>';
						}
					});
				}	$('#addImage .wrap').html(html+'</ul>');
			});
		});
		$('#btnSubmitAddImage').on('click',function(){
			$('#addImage .stage_upload_img.active').each(function(i,v){
				//console.log(this.data('imagePath'));
				$('#case_stage_upload').append('<div class="case_stage_upload_img" data-imagepath ="'+$(this).data('imagepath')+'">'+$(this).data('name')+'</div>');
			})
			$('#addImage .wrap').html('');
			$('#addImage').modal('hide');
		});

		$('body').on('click','.type-png,.type-jpg,.type-jpeg',function(){
			$('#review_image img').attr('src',$host+$(this).data('path'));
		});
		$('body').on('click','.add_procedure,#addCase', function () {
			clearAll();
			$('#case_stage').data('id',1);
			$('.case_coordinate').attr('disabled','disabled').multiselect("refresh");
			$('#patient,#patient_social_media,#surgery_history,#patient_case,#case_followup,#case_price,#case_social_media').find('.input_control').removeAttr('disabled');
			$('#patient_social_media,#surgery_history,#case_followup,#case_price,#case_social_media').find('.modal-add').show();
			getAjax($plRoute+'/getOnePatient','get',{patient_id:$(this).data('patient_id')},function(rs){
				console.log(rs);
				if(rs){
					pushData_patient(rs);
					if(rs.social) pushData_socialMedia(rs.social);
					if(rs.surgery) pushData_sugery(rs.surgery);
				}
			});
			getCurrentStage($('#case_stage').data('id'),'#case_stage_fromStage');
			getCurrentStage($('#case_stage').data('id'),'#case_stage_toStage');
			$('#case_stage').find('.input_control').removeAttr('disabled');
		});
		
		function getCurrentStage(stage_id,target){
			getAjax($plRoute+'/getStage','get',{stage_id:stage_id},function(rs){
				console.log(rs,'current Stage');
				$(target).html('<option selected data-status="'+rs.status+'" value="'+rs.from_stage_id+'">'+rs.status+'</option>');
			});
		}
		
		function getStage(current_stage){
			getAjax($plRoute+'/action_to','get',{stage_id:current_stage},function(rs){
				console.log(rs,'getStage');
				var html_stage_to = '<option data-status="" value="">บันทึกฉบับร่าง</option>';
				if(rs.length > 0){
					$.each(rs,function(){
						html_stage_to +='<option data-status="'+this.status+'" value="'+this.stage_id+'">'+this.stage_name+'</option>';
					}); 
					$('#case_stage').find('.input_control').removeAttr('disabled');
					$('#case_stage_toStage').html(html_stage_to);
				}
			})
		}
		
		function pushData_patient(data){
			$('#profileImage').attr('src',$host+data.image_path);
			$('#patient').data('id',data.patient_id);
			$('#patient_hnNo').val(data.hn_no);
			$('#patient_name').val(data.patient_name);
			$('#patient_nickName').val(data.nick_name);
			$('#mask_patient_birthDate').val(paresDateToDate(data.birthday)).change()
			$('#patient_nationality').val(data.nationality_id);
			$('#patient_gender').val(data.gender);
			$('#patient_idCard').val(data.id_card);
			$('#patient_homeNo').val(data.home_no);
			$('#patient_moo').val(data.moo);
			$('#patient_career').val(data.career);
			$('#patient_soi').val(data.soi);
			$('#patient_road').val(data.road);
			$('#patient_mobile').val(data.mobile_no);
			$('#patient_telNo').val(data.telephone_no);
			$('#patient_province').val(data.province_id).change();
			$('#patient_amphur').val(data.amphur_id).change();
			$('#patient_district').val(data.district_id).change();
		}
		function pushData_socialMedia(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.patient_media_id+'">'
					+'<td><select class="patient_social_media_type social input_control">'
						+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_social+'</select></td>'
					+'<td><input type="text" value="'+this.user_link+'" class="patient_social_media_link input_control"></td>'
					+'<td><input type="number" value="'+this.n_of_follwer+'" class="patient_social_media_follow input_control"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#patient_social_media tbody').append($html);
				getBasicData($('#patient_social_media tbody'));
				$('#patient_social_media tbody tr:last-child').find('.social').val(this.social_media_id);
			});
		};
		function pushData_sugery(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.history_id+'">'
					+'<td><select class="surgery_year next_year input_control">'
						+'<option value=""> ---- เลือกปี ---- </option>'+getyear($current_year,$current_year+10)+'</select></td>' 
					+'<td><div class="surgery_lengthYear"></div></td>' 
					+'<td><input type="text" class="surgery_clinic input_control" value="'+this.clinic_name+'"></td>'
					+'<td><select class="surgery_doctor doctor input_control">'
						+'<option value=""> ---- เลือกหมอ ---- </option>'+$html_doctor+'</select></td>'
					+'<td><select class="surgery_procedure procedure input_control">'
						+'<option value=""> ---- เลือกหัตถการ ---- </option>'+$html_procedure+'</select></td>'
						+'<td><input type="text" class="surgery_remark input_control" value="'+this.remark+'"></td>'
						+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#surgery_history tbody').append($html);
				getBasicData($('#surgery_history tbody'));
				$('#surgery_history tbody tr:last-child').find('.surgery_year').val(this.surgery_year);
				$('#surgery_history tbody tr:last-child').find('.surgery_doctor').val(this.doctor_id);
				$('#surgery_history tbody tr:last-child').find('.surgery_procedure').val(this.procedure_id);
			});
		};
		function pushData_patientCase(data){
			$('#patient_case').data('id',data.case_id);	
			$('#patient_case_suggesGroup').val(data.suggest_group);
			$('#patient_case_suggestedBy').val(data.suggested_by);	
			$('#patient_case_caseType').val(data.case_type.case_type_id);
			$('#patient_case_caseGroup').val(data.case_group.case_group_id);
			$('#patient_case_vn').val(data.vn_no);
			$('#patient_case_procedure').val(data.procedure.procedure_id);	
			$('#patient_case_doctor').val(data.doctor.doctor_id);
			$('#patient_case_isGood').prop('checked',data.is_good_case);
			$('#patient_case_isBad').prop('checked',data.is_bad_case);
			$('#patient_case_isGoodReview').prop('checked',data.is_good_review);
			$('#patient_case_remark').val(data.remark);
			$html = '';
			$.each(data.case_supervised,function(){
				$html  += '<div data-user="'+this.supervised_id+'" class="bubble patient_case_supervisedBy alert-info">'
							+this.user.firstName+'  '+this.user.lastName
							+'<a href="javascript:void(0)" class="fa fa-times-circle remove_bubble btn-action  remove_supervisedBy"></a>'
							+'</div>';
			});
			$('.view_supervisedBy').append($html);
		};
		function pushData_caseFollowup(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.followup_id+'">'
						+'<td><select class="case_followup_procedure procedure input_control">'
							+'<option value=""> ---- เลือกหัตถการ ---- </option>'+$html_procedure+'</select></td>'
						+'<td><select class="case_followup_year next_year input_control">'
							+'<option value=""> ---- เลือกปี ---- </option>'+getyear($current_year,$current_year+10)+'</select></td>'
						+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_followup tbody').append($html);
				getBasicData($('#case_followup tbody'));
				$('#case_followup tbody tr:last-child').find('.case_followup_procedure').val(this.procedure_id);
				$('#case_followup tbody tr:last-child').find('.case_followup_year').val(this.followup_year);
			});
		};
		function pushData_casePrice(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.price_id+'">'
							+'<td><select class="case_price_type discount input_control">'
								+'<option value=""> ---- เลือกประเภทส่วนลด ---- </option>'+$html_discountType+'</select></td>'
							+'<td><input type="number" class="case_price_offer input_control" value="'+this.offer_price+'"></td>'
							+'<td><input type="number" class="case_price_accept input_control" value="'+this.accept_price+'"></td>'
							+'<td><div class="case_price_percent input_control"></div></td>'
							+'<td><div class="case_price_value input_control"></div></td>'
							+'<td><input type="text" class="case_price_remark input_control" value="'+this.remark+'"></td>'
							+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_price tbody').append($html);
				getBasicData($('#case_price tbody'));
				$('#case_price tbody tr:last-child').find('.case_price_accept').keyup()
				$('#case_price tbody tr:last-child').find('.case_price_type').val(this.discount_type_id);
			});
		};
		
		function pushData_caseSocialMedia(data){	
			$.each(data,function(){
				$html = '<tr class="" data-id="'+this.case_media_id+'"> '
					+'<td><select class="case_social_media_social social input_control"> '
						+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_social+'</select></td> '
					+'<td><input type="text" class="case_social_media_link input_control" value="'+this.link+'"></td>'
					+'<td><input type="text" class="case_social_media_username input_control" value="'+this.usr_name+'"></td>'
					+'<td><input type="text" class="case_social_media_password input_control" value="'+this.pwd+'"></td>'
					+'<td><input type="text" class="case_social_media_remark input_control" value="'+this.note+'"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_social_media tbody').append($html);
				getBasicData($('#case_social_media tbody'));
				$('#case_social_media tbody tr:last-child').find('.case_social_media_social').val(this.social_media_id);
			});
		};
		
		function pushData_caseCoordinate(data){
			var coordinate  = [];
			$.each(data,function(){
				coordinate.push(this.usage_id);
			});
			$('.case_coordinate').val(coordinate).multiselect("refresh");
			
		};
		function pushData_caseAppointment(data){	
			$.each(data,function(){
				$html = '<tr data-id="'+this.appointment_id+'"></td> '
					+'<td><select class="case_appointment_type appointment input_control">'
						+'<option value=""> ---- เลือกสื่อ ---- </option>'+$html_appointment+'</select></td> '
					+'<td><input class="datepicker input_control" type="text" value="'+paresDateToDate(this.appointment_date)+'">'
						+'<input class="case_appointment_date datepicker_ad input_control" type="hidden"></td>'
					+'<td><select class="case_appointment_doctor doctor input_control">'
						+'<option value=""> ---- เลือกหมอ ---- </option>'+$html_doctor+'</select></td>'
					+'<td><input class="case_appointment_supervised user input_control" data-user="'+this.supervised_by.userId+'" type="text" value="'+this.supervised_by.firstName+'  '+this.supervised_by.lastName+'"></td>'
					+'<td><input class="case_appointment_isVdoProduct input_control" type="checkbox"></td>'
					+'<td><input class="case_appointment_isVdoRh input_control" type="checkbox"></td>'
					+'<td><input class="case_appointment_isPictureProduct input_control" type="checkbox"></td>'
					+'<td><input class="case_appointment_isPictureRh input_control" type="checkbox"></td>'
					+'<td><input class="case_appointment_isMeetDoctor input_control" type="checkbox"></td>'
					+'<td><input class="case_appointment_remark input_control" type="text" value="'+this.remark+'"></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_appointment tbody').append($html);
				getBasicData($('#case_appointment tbody'));
				$('#case_appointment tbody tr:last-child').find('.case_appointment_date').change();
				$('#case_appointment tbody tr:last-child').find('.case_appointment_type').val(this.appointment_type_id);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_doctor').val(this.doctor_id);
				
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isVdoProduct').prop('checked',this.is_vdo_product);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isVdoRh').prop('checked',this.is_vdo_rh);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isPictureProduct').prop('checked',this.is_picture_product);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isPictureRh').prop('checked',this.is_picture_rh);
				$('#case_appointment tbody tr:last-child').find('.case_appointment_isMeetDoctor').prop('checked',this.is_meet_doctor);
			});
		};
		function pushData_caseContact(data){	
			$.each(data,function(){
				$html = '<tr data-id="'+this.contract_id+'">'
					+'<td><input class="case_contract_no no input_control" type="text" value="'+this.seq_id+'"></td>'
					+'<td><select class="case_contract_procedure procedure input_control">'
						+'<option value=""> ---- เลือกหัตถการ ---- </option>'+$html_procedure+'</select></td>'
					+'<td><input class="datepicker input_control" type="text" value="'+paresDateToDate(this.contract_start_date)+'">'
						+'<input class="case_contract_startDate datepicker_ad input_control" 	type="hidden"></td>'
					+'<td><input class="datepicker input_control" type="text" value="'+paresDateToDate(this.contract_end_date)+'">'
						+'<input class="case_contract_endDate datepicker_ad input_control" type="hidden"></td>'
					+'<td><input class="case_contract_isPost input_control" 		type="checkbox"></td>'
					+'<td><input class="case_contract_isUsage input_control"		type="checkbox"></td>'
					+'<td><input class="case_contract_isPicture_vdo input_control" 	type="checkbox"></td>'
					+'<td><input class="case_contract_isReview input_control" 		type="checkbox"></td>'
					+'<td><input class="case_contract_isPr input_control" 			type="checkbox"></td>'
					+'<td><input class="case_contract_isGroupPost input_control" 	type="checkbox"></td>'
					+'<td><input class="case_contract_isSendPicture input_control" 	type="checkbox"></td>'
					+'<td><input class="case_contract_isOther input_control" 		type="checkbox"></td>'
					+'<td><input class="case_contract_upload storeFile input_control" multiple type="file" ></td>'
					+'<td><button class="btn btn-danger del_rec btn-delete btn-action"><i class="fa fa-trash"></i></button></td>'
					+'<input class="case_contract_file_name_check" type="hidden"></tr>';
				$('#case_contract tbody').append($html);
				getBasicData($('#case_contract tbody'));
				$('#case_contract tbody tr:last-child').find('.datepicker').change();
				$('#case_contract tbody tr:last-child').find('.case_contract_procedure').val(this.procedure_id);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPost')		.prop('checked',this.is_post);
				$('#case_contract tbody tr:last-child').find('.case_contract_isUsage')		.prop('checked',this.is_usage);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPicture_vdo').prop('checked',this.is_picture_vdo);
				$('#case_contract tbody tr:last-child').find('.case_contract_isReview')		.prop('checked',this.is_review);
				$('#case_contract tbody tr:last-child').find('.case_contract_isPr')			.prop('checked',this.is_pr);
				$('#case_contract tbody tr:last-child').find('.case_contract_isGroupPost')	.prop('checked',this.is_group_post);
				$('#case_contract tbody tr:last-child').find('.case_contract_isSendPicture').prop('checked',this.is_send_picture);
				$('#case_contract tbody tr:last-child').find('.case_contract_isOther')		.prop('checked',this.is_other);
				console.log(this.case_contract_doc);
				if(this.case_contract_doc!=null){
					$.each(this.case_contract_doc,function(){
						var fileName = this.contract_path.split("/").slice(-1)[0];
						$html = '<div data-id="'+this.case_contract_doc_id+'" style="width:max-content;padding:3px;margin-top:10px" class="bg-info file_download">'
							+'<a href="javascript:void(0)" class="fa fa-file ">  '+fileName+'</a> '
							+'<a href="javascript:void(0)" class="fa fa-times-circle remove_file btn-action btn-delete"></a></div>';
						$('#case_contract tbody tr:last-child').find('.case_contract_upload').parent().append($html);
					});
				}
			});
		};
		
		function pushData_casePr(data){	
			$.each(data,function(){
				$html = '<tr  data-id="'+this.case_pr_id+'">'
							+'<td><select class="case_pr_pr pr input_control">'
								+'<option value=""> ---- เลือกรายการประชาสัมพันธ์ ---- </option>'+$html_pr+'</select></td>'
							+'<td><input class="datepicker input_control" type="text" value="'+paresDateToDate(this.pr_plan_date)+'">'
								+'<input class="case_pr_planDate datepicker_ad input_control" type="hidden"></td>'
							+'<td width="150px"><label><input type="checkbox" class="case_pr_isPicture input_control"> รูปภาพ</label> 		  ' 
								+'<label><input type="checkbox" class="case_pr_isVdo input_control"> วีดีโอ(selfie)</label>'
								+'<label><input type="checkbox" class="case_pr_isInstragram input_control"> live Instragram</label> '   
								+'<label><input type="checkbox" class="case_pr_isFacebook input_control"> live Facebook</label></td>'
							+'<td><input class="datepicker input_control" type="text" value="'+paresDateToDate(this.pr_actual_date)+'">'
								+'<input class="case_pr_actualDate datepicker_ad input_control" type="hidden"></td>'
							+'<td><button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button></td></tr>';
				$('#case_pr tbody').append($html);
				getBasicData($('#case_pr tbody'));
				$('#case_pr tbody tr:last-child').find('.case_pr_pr').val(this.pr_id);
				$('#case_pr tbody tr:last-child').find('.case_pr_isPicture').prop('checked',this.is_picture);
				$('#case_pr tbody tr:last-child').find('.case_pr_isVdo').prop('checked',this.is_vdo);
				$('#case_pr tbody tr:last-child').find('.case_pr_isInstragram').prop('checked',this.is_instragram);
				$('#case_pr tbody tr:last-child').find('.case_pr_isFacebook').prop('checked',this.is_facebook);
				
			});
		};
		
		function pushData_caseArticle(data){	
			$.each(data,function(){
				$html = '<tr data-id="'+this.case_article_id+'">'
							+'<td><input class="case_article_name input_control" type="text"  value="'+this.article_name+'"></td>'
							+'<td><select class="case_article_type_id article input_control">'
								+'<option value=""> ---- เลือกบทความ ---- </option>'+$html_articleType+'</select></td>'
							+'<td><input class="case_article_writer user input_control" type="text" data-user="'+this.writer.userId+'" value="'+this.writer.firstName+' '+this.writer.lastName+'"></td>'
							+'<td><input class=" datepicker input_control" type="text " value="'+paresDateToDate(this.writing_start_date)+'">'
								+'<input class="case_article_writingStartDate datepicker_ad input_control" type="hidden"></td>'
							+'<td><input class=" datepicker input_control" type="text" value="'+paresDateToDate(this.writing_end_date)+'">'
								+'<input class="case_article_writingEndDate datepicker_ad input_control" type="hidden"></td>'
							+'<td><input class=" datepicker input_control" type="text" value="'+paresDateToDate(this.plan_date)+'">'
								+'<input class="case_article_planDate datepicker_ad input_control" type="hidden"></td>'
							+'<td><input class="case_article_upload storeFile input_control" multiple type="file"></td>'
							+'<td width="150px">'
								+'<button class="btn btn-danger del_rec btn-delete btn-action" ><i class="fa fa-trash"></i></button>'
							+'<input class="case_contract_file_name_check" type="hidden"></td></tr>';
				$('#case_article tbody').append($html);
				getBasicData($('#case_article tbody'));
				$('#case_article tbody tr:last-child').find('.case_article_type_id').val(this.article_type_id);
				console.log(this.case_article_doc);
				if(this.case_article_doc!=null){
					$.each(this.case_article_doc,function(){
						var fileName = this.article_path.split("/").slice(-1)[0];
						$html = '<div data-id="'+this.case_article_doc_id+'" style="width:max-content;padding:3px;margin-top:10px" class="bg-info file_download">'
							+'<a href="javascript:void(0)" class="fa fa-file ">  '+fileName+'</a> '
							+'<a href="javascript:void(0)" class="fa fa-times-circle remove_file"></a></div>';
						$('#case_article tbody tr:last-child').find('.case_article_upload').parent().append($html);
					});
				}
			});
		};
		
		function pushData_workFlow(data){	
			$.each(data,function(){
				var html_alert = '';
				if(this.alerts.length > 0){
					$.each(this.alerts,function(){
						html_alert +='<div>'+this.screenName+'</div>';
					})
				}
				$html = '<tr data-id="'+this.case_stage_id+'">'
							+'<td>'+this.created_dttm+'</td>'
							+'<td>'+this.from_stage_name+'</td>'
							+'<td>'+this.from_user_name+'</td>'
							+'<td>'+this.to_stage_name+'</td>'
							+'<td>'+this.to_user_name+'</td>'
							+'<td>'+this.remark+'</td>'
							+'<td>'+html_alert+'</td>'
							+'<td>';
				if(this.docs.length > 0){
					$html += '<center><button type="button" class="btn btn-primary input-sm downloadfileCaseHistory" title="ดาวห์โหลด" data-placement="top"><i class="fa fa-download"></i></button>'+
	                '</center></td>';
				}
				$html += '</tr>'
				$('#workflow tbody').append($html);
			});
		};
		
		function clearAll(){
			clearModal();
			$('#list >li > ul,#case_stage_toUser,#case_stage_upload').html('');
			$('.bubble').remove();
			$('.wrap').removeData('id').find('tbody').html('');
			$('.btn-action,#information_errors').hide();
			$('.input_control').attr('disabled','disabled');
			$('#profileImage,#review_image img').attr('src','');
			$('#case_stage_notification').val('').multiselect("refresh");
			$('.storeFile').val('');
		}
		
		/* save patient */
		
		function getData_patient(){
			$data = {
				"patient":{
					"patient_id"	: $("#patient").data("id")?$("#patient").data("id"):'',
				    "hn_no"			: $.trim($("#patient_hnNo").val()),
				    "patient_name"	: $.trim($("#patient_name").val()),
				    "nick_name"		: $.trim($("#patient_nickName").val()),
				    "birthday"		: $.trim($("#patient_birthDate").val()),
				    "nationality_id": $("#patient_nationality").val(),
				    "gender"		: $("#patient_gender").val(),
				    "id_card"		: $.trim($("#patient_idCard").val()),
				    "home_no"		: $.trim($("#patient_homeNo").val()),
				    "moo"			: $.trim($("#patient_moo").val()),
				    "soi"			: $.trim($("#patient_soi").val()),
				    "road"			: $.trim($("#patient_road").val()),
				    "province_id"	: $("#patient_province").val(),
				    "amphur_id"		: $("#patient_amphur").val(),
				    "district_id"	: $("#patient_district").val(),
				    "mobile_no"		: $.trim($("#patient_mobile").val()),
				    "telephone_no"	: $.trim($("#patient_telNo").val()),
				    "career"		: $.trim($("#patient_career").val()),
			   	}
			}
		}
		function getData_patientSocial(){
			var social = [];
			$('#patient_social_media table tbody tr').each(function(i,v){
				social.push({
					patient_media_id:$(this).data("id")?$(this).data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					social_media_id	:$(this).find('.patient_social_media_type').val(),
					user_link		:$.trim($(this).find('.patient_social_media_link').val()),
					n_of_follwer	:$.trim($(this).find('.patient_social_media_follow').val()),
				});
			});
			$data['social_media'] = social; 
		}
		function getData_patientSurgery(){	
			var surgery = [];
			$('#surgery_history table tbody tr').each(function(i,v){
				surgery.push({
					history_id		:$(this).data("id")?$(this).data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					surgery_year 	:$(this).find('.surgery_year').val(),
					clinic_name		:$.trim($(this).find('.surgery_clinic').val()),
					doctor_id		:$(this).find('.surgery_doctor').val(),
					procedure_id	:$(this).find('.surgery_procedure').val(),
					remark			:$.trim($(this).find('.surgery_remark').val()),
				});
			});
			$data['surgery_history'] = surgery; 
		}
		function getData_patientCase(){
			var supervised = '';
			$('#patient_case .patient_case_supervisedBy').each(function(){
				supervised+='|'+$(this).data('user');
			});
			
			$data['patient_case'] ={
				case_id 		:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
				patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
				procedure_id	:$('#patient_case_procedure').val(),
				case_type_id	:$('#patient_case_caseType').val(),
				case_group_id	:$('#patient_case_caseGroup').val(),
				doctor_id		:$('#patient_case_doctor').val(),
				vn_no			:$.trim($('#patient_case_vn').val()),
				suggest_group	:$.trim($('#patient_case_suggesGroup').val()),
				suggested_by	:$.trim($('#patient_case_suggestedBy').val()),
				supervised_by	:supervised,
				is_good_case	:$('#patient_case_isGood').prop('checked')?1:0,
				is_bad_case		:$('#patient_case_isBad').prop('checked')?1:0,
				is_good_review	:$('#patient_case_isGoodReview').prop('checked')?1:0,
				remark			:$.trim($('#patient_case_remark').val()),
                stage_id 		:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage').val():$('#case_stage_toStage').val(),
                status 			:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage option:selected').text():$("#case_stage_toStage option:selected").data('status')
			}
		}
		function getData_caseFollowup(){		 
			var followup = [];
			$('#case_followup table tbody tr').each(function(i,v){
				followup.push({
					followup_id		:$(this).data('id')?$(this).data('id'):'',
					case_id			:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
					procedure_id	:$(this).find('.case_followup_procedure').val(),
					followup_year 	:$(this).find('.case_followup_year').val()
				});
			});
			$data['case_followup'] =followup;
		}
		function getData_casePrice(){		
			var price = [];
			$('#case_price table tbody tr').each(function(i,v){
				price.push({
					price_id 			:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					discount_type_id 	:$(this).find('.case_price_type').val(),
					offer_price 		:$.trim($(this).find('.case_price_offer').val()),
					accept_price 		:$.trim($(this).find('.case_price_accept').val()),
					discount_percent	:$.trim($(this).find('.case_price_percent').text()),
					discount_amount 	:$.trim($(this).find('.case_price_value').text()),
					remark				:$.trim($(this).find('.case_price_remark').val())
				});
			});
			$data['case_price'] =price; 
		}
		function getData_caseSocial(){	
			var channel = [];
			$('#case_social_media table tbody tr').each(function(i,v){
				channel.push({
					case_media_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					social_media_id 	:$('.case_social_media_social ').val(),
					link 				:$.trim($(this).find('.case_social_media_link').val()),
					usr_name 			:$.trim($(this).find('.case_social_media_username').val()),
					pwd					:$.trim($(this).find('.case_social_media_password').val()),
					note 				:$.trim($(this).find('.case_social_media_remark').val())
				});
			});
			$data['case_social_media'] = channel; 
		}
		function getData_caseCoordinate(){	
			var arr_coordinate = [];
			$.each($('#case_coordinate .case_coordinate'),function(){
				if($(this).val()){
					$.each($(this).val(),function(k,v){ arr_coordinate.push(v);});
				}
			});
			var coordinate = [];
			$.each(arr_coordinate,function(i,v){
				coordinate.push({	
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					usage_id 			:v
				}); 
			});
			$data['case_coordinate'] = coordinate;
		}
		function getData_caseAppointment(){
			var appointment = [];
			$('#case_appointment table tbody tr').each(function(i,v){
				appointment.push({
					appointment_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					appointment_type_id :$(this).find(".case_appointment_type").val(),
					appointment_date 	:$(this).find(".case_appointment_date").val(),
					doctor_id 			:$(this).find(".case_appointment_doctor").val(),
					supervised_by		:$(this).find(".case_appointment_supervised").data("user"),
					is_vdo_product 		:$(this).find(".case_appointment_isVdoProduct").prop("checked"),
					is_vdo_rh 			:$(this).find(".case_appointment_isVdoRh").prop("checked"),
					is_picture_product 	:$(this).find(".case_appointment_isPictureProduct").prop("checked"),
					is_picture_rh 		:$(this).find(".case_appointment_isPictureRh").prop("checked"),
					is_meet_doctor 		:$(this).find(".case_appointment_isMeetDoctor").prop("checked"),
					remark 				:$.trim($(this).find('.case_appointment_remark').val())
				});
			});
			$data['case_appointment'] =appointment; 
		}
		function getData_caseContact(){		
			var contract = [];
			$('#case_contract table tbody tr').each(function(i,v){
				contract.push({
					contract_id 		:$(this).data("id")?$(this).data("id"):'',
					seq_id 				:$(this).find(".case_contract_no").val(),
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					procedure_id 		:$(this).find(".case_contract_procedure").val(), 
					contract_start_date	:$(this).find(".case_contract_startDate").val(), 
					contract_end_date	:$(this).find(".case_contract_endDate").val(), 
					is_post 			:$(this).find(".case_contract_isPost").prop("checked")==true?1:0,
					is_usage 			:$(this).find(".case_contract_isUsage").prop("checked")==true?1:0,
					is_picture_vdo 		:$(this).find(".case_contract_isPicture_vdo").prop("checked")==true?1:0,
					is_review 			:$(this).find(".case_contract_isReview").prop("checked")==true?1:0,
					is_pr 				:$(this).find(".case_contract_isPr").prop("checked")==true?1:0,
					is_group_post 		:$(this).find(".case_contract_isGroupPost").prop("checked")==true?1:0,
					is_send_picture 	:$(this).find(".case_contract_isSendPicture").prop("checked")==true?1:0,
					is_other 			:$(this).find(".case_contract_isOther").prop("checked")==true?1:0,
					file_name_check 	:$(this).find(".case_contract_file_name_check").val()
				});
			});
			$data['case_contract'] =contract;
		}
		function getData_casePr(){		
			var pr = [];
			$('#case_pr table tbody tr').each(function(i,v){
				pr.push({
					case_pr_id 		:$(this).data("id")?$(this).data("id"):'',
					case_id 		:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					pr_id 			:$(this).find(".case_pr_pr").val(), 
					pr_plan_date 	:$(this).find(".case_pr_planDate").val(), 
					is_picture		:$(this).find(".case_pr_isPicture").prop("checked")==true?1:0,
					is_vdo			:$(this).find(".case_pr_isVdo").prop("checked")==true?1:0,
					is_instragram 	:$(this).find(".case_pr_isInstragram").prop("checked")==true?1:0,
					is_facebook 	:$(this).find(".case_pr_isFacebook").prop("checked")==true?1:0,
					pr_actual_date 	:$(this).find(".case_pr_actualDate").val(), 
				});
			});
			$data['case_pr'] =pr;
		}
		function getData_caseArticle(){	
			var article = [];
			$('#case_article table tbody tr').each(function(i,v){
				article.push({
					case_article_id 	:$(this).data("id")?$(this).data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					article_name 		:$.trim($(this).find('.case_article_name').val()),
					article_type_id 	:$(this).find('.case_article_type_id').val(),
					writer				:$(this).find('.case_article_writer').data('user'),
					writing_start_date	:$(this).find('.case_article_writingStartDate').val(),
					writing_end_date 	:$(this).find('.case_article_writingEndDate').val(),
					plan_date 			:$(this).find('.case_article_planDate').val(),
					file_name_check 	:$(this).find(".case_contract_file_name_check").val()
				});
			});
			$data['case_article'] =article;
		}
		function getData_caseStage(){		
			$data['case_stage'] = {
				case_id			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
				from_stage_id	:$('#case_stage_fromStage').val(),
				from_user_id	:userId,
				to_user_id		:$('#case_stage_toUser').val(),
				to_stage_id		:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage').val():$('#case_stage_toStage').val(),
				plan_date		:$('#case_stage_actualDate').text(),
				actual_date		:$('#case_stage_planDate').val(),
				status			:$('#case_stage_toStage').val()==''?$('#case_stage_fromStage option:selected').text():$("#case_stage_toStage option:selected").data('status'),
				remark			:$.trim($('#case_stage_remark').val())
			}
			
			var attach_img = [];
			$('body .case_stage_upload_img').each(function(){
				attach_img.push({image_path:$(this).data('imagepath')});
			});
			$data['case_stage']['attach_img'] = attach_img;
			$data['case_stage']['alerts'] = $('#case_stage_notification').val();
		}	
		
		$('body').on('click','.del_rec',function(){
			$('#confrimModal').modal('show');
			var thiss = $(this);
			$('#btnConfirmOK').one('click',function(){
				getAjax($plRoute+'/delRec','post',{id:thiss.closest('tr').data('id'),method:thiss.closest('.wrap').attr('id')},function(rs){
					console.log(rs);
					$('#confrimModal').modal('hide');
					if(rs.status == 200){
						thiss.closest('tr').remove();
						callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
					}else{
						callFlashSlide('ไม่สามารถลบไฟล์ได้!!','Error');
					}
				});
			});
		});
		
		$('body').on('click','.remove_file', function () {
			var elm_file = $(this).parent();
			$('#confrimModal').modal('show');
			$('#btnConfirmOK').one('click',function(){
				getAjax($plRoute+'/deleteFile','post',{method:elm_file.closest('.wrap').attr('id'),file_id:elm_file.data('id')},function(rs){
					console.log(rs);
					$('#confrimModal').modal('hide');
					if(rs.status == 200){
						elm_file.remove();
						callFlashSlide('ลบข้อมูลเรียบร้อย!!','success');
					}else{
						callFlashSlide('ไม่สามารถลบไฟล์ได้!!','Error');
					}
				});
			});
		});
		
		$('body').on("click", ".del-tr", function(){ this.closest('tr').remove(); });
		
			
		$('body').on('click','.modal-edit',function(){
			var elm_parent = $(this).closest('.wrap'); 
			elm_parent.find('.modal-cancel').show();
			$(this).hide();
			elm_parent.find('.input_control').removeAttr('disabled');
			
		});
		$('body').on('click','.modal-cancel',function(){
			var elm_parent = $(this).closest('.wrap'); 
			elm_parent.find('.modal-edit').show();
			$(this).hide();
			elm_parent.find('.input_control').attr('disabled','disabled');
		});
		
		$('#importsubmitForm').on('click',function(){
			var formData = new FormData();
			$.each($('#fileForm').prop('files'),function(i,v){
				formData.append('file[]',this);
			});
			formData.append('folder_id',$('.folderList').val());
			formData.append('case_id',$('#patient_case').data('id'));
			$.ajax({
			    url:$plRoute+'/importFile',
			    type:'POST',
			    data: formData,
			    cache: false,
			    dataType: 'json',
			    content:"application/json",
			    processData: false, // Don't process the files
			    contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			    headers:{Authorization:"Bearer "+tokenID.token},
			    success: function(rs) {
			    	console.log(rs);
		    		$('#ModalImportForm').modal('hide');
			    	if(rs.status==200){
			    		callFlashSlide('บันทึกข้อมูลสำเร็จ','success');
			    		getFolder(rs.data);
			    	}else if(rs.status==400){
			    		callFlashSlide('ไม่สามารถบันทึกข้อมูลได้!!  กรุณาตรวจกรอกข้อมูลให้ครบถ้วน','Error');
			    		validatetorInformation(validatetor(rs.errors));
			    	}
			    }
			});  
		});
		
		$('body').on('click','.downloadfileCaseHistory',function(){
			var case_stage_id = $(this).closest('tr').data('id');
							
			$.ajax({
				url:$plRoute+'/downloadCaseStageDoc/'+case_stage_id,
				type:'get',
				cache: false,
				dataType: 'json',
				headers:{Authorization:"Bearer "+tokenID.token},
				success: function(rs){
					console.log(rs);
					if(rs['status']==200){
						window.open($host+rs.file_path,"_self");
					}
					if(rs['status']==400){
						callFlashSlide("No file Data!",'errors');
					}
				},
				error: function(jqXHR, textStatus, errorThrown)
				{
					console.log(textStatus);
					callFlashSlide("No file Data!",'errors');
				}
			});
		});
		
		$('#patient_birthDate').on('change',function(){	$('.yearOld').text($current_year-$(this).val().split('/')[2]);	})
	    
		$('#patient_province').change(function(){
			$('#patient_zipcode,#patient_district,#patient_amphur').html('');
			getAjax($plRoute+'/getAmphur','get',{province_id:$(this).val()},function(rs){
				var html_amphur = '<option> --เลือกอำเภอ -- </option>';
				$.each(rs,function(){
					html_amphur +='<option value="'+this.amphur_id+'">'+this.amphur_name+'</option>';
				}); 
				$('#patient_amphur').html(html_amphur);
			})
		});
		$('#patient_amphur').change(function(){
			$('#patient_zipcode,#patient_district').html('');
			getAjax($plRoute+'/getDistrict','get',{amphur_id:$(this).val()},function(rs){
				var html_district = '<option> --เลือกตำบล -- </option>';
				$.each(rs,function(){
					html_district +='<option data-zipcode="'+this.zipcode.zipcode+'" value="'+this.district_id+'">'+this.district_name+'</option>';
				}); 
				$('#patient_district').html(html_district);
			})
		});
		$('#patient_district').change(function(){	$('#patient_zipcode').text($('#patient_district option:selected').data('zipcode'));	});
		
		$('.modal-add').click(function(){	
			$(this).closest('.wrap').find('table tbody').append($(this).data('tr'));
			getBasicData($(this));   
		});
		
		$('body').on('keyup','.user',function(){
			var search =  $(this).val();
			$(this).autocomplete({
				minLength: 3,
				delay: 100,
				source: function (request, response) {
			        getAjax($plRoute+"/getUser",'get',{search:search,user:''},function(rs){
			        	response( $.map( rs, function( item ) {
			                var object = new Object();
			                  object.id = item.userId;
			                  object.value = item.firstName +' '+ item.lastName;
			                  return object ;
			            }));
			        });    
			    },
			    select: function (event, ui) {
			    	$(this).data('user',ui.item.id);
			    	$(this).data('userName',ui.item.value);
			    }
			});
		});
		
		$('body').on('focusout','.user',function(){	$(this).val($(this).data('userName'));	});
		
		$('body').on('keyup','.case_price_offer,.case_price_accept',function(){
			$(this).closest('.wrap').find('.case_price_value').text($(this).closest('.wrap').find(".case_price_offer").val()-$(this).closest('.wrap').find('.case_price_accept').val())
			$(this).closest('.wrap').find('.case_price_percent').text(100-($(this).closest('.wrap').find('.case_price_accept').val()*100)/$(this).closest('.wrap').find(".case_price_offer").val())
		});
		
		$('#patient_case_supervisedBy').autocomplete({
			minLength: 3,
			delay: 100,
			source: function (request, response) {
				var supervisedBy = '';
				$('.patient_case_supervisedBy').each(function(){
					supervisedBy+='|'+$(this).data('user');
				})
		        getAjax($plRoute+"/getUser",'get',{search:$('#patient_case_supervisedBy').val(),user:supervisedBy},function(rs){
		        	response( $.map( rs, function( item ) {
		                var object = new Object();
		                  object.id = item.userId;
		                  object.value = item.firstName +' '+ item.lastName;
		                  return object ;
		            }));
		        });    
		    },
		    select: function (event, ui) {
		    	$('.view_supervisedBy').append('<div data-user="'+ui.item.id+'" class="bubble patient_case_supervisedBy alert-info">'+ui.item.value+'<a href="javascript:void(0)" class="fa fa-times-circle remove_supervisedBy"></a></div>');
		    	$(this).val(''); return false;
		    }
		});
		$('body').on('click','.remove_supervisedBy',function(){$(this).parent().remove();});
		
		$('#btnAddFolder').click(function(){
			getAjax($plRoute+"/getFolder/"+$('#patient_case').data('id'),'get','',function(rs){
		        var html_temp ='<option value="" >แฟ้มหลัก</option>';
		        $.each(rs,function(){
					html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">'+this.folder_screen_name+'</option>';
				}); 
				$('#addFolder .main_folder').html( html_temp );
			}); 
			$('#btnSubmitAddFolder').one("click", function( e ) {
				var folder ={
						folder_screen_name	:	$.trim($('#folderName').val()),
						folder_parent_id	:	$('#addFolder .main_folder').val(),
						case_id				:	$('#patient_case').data('id'),
				}
				console.log(folder);
				getAjax($plRoute+"/makeDirectory",'post',folder,function(rs){
					if(rs.status == 200){
						callFlashSlide('สร้างแฟ้มข้อมูลสำเร็จ' ,'success');
						getFolder(rs.data);
						$('#addFolder').modal('hide');
						$('#folderName').val('');
					}else	callFlashSlide('เกิดข้อผิดพลาด','Error');
				});
			});
		});
		
		$('#btnUploadFile').click(function(){
			getAjax($plRoute+"/getFolder/"+$('#patient_case').data('id'),'get','',function(rs){
		        console.log(rs);
		        var html_temp ='';
		        $.each(rs,function(){
					html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">'+this.folder_screen_name+'</option>';
					if(this.sub_folder){
						$.each(this.sub_folder,function(){
							if(this.case_folder)
							html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">&nbsp;&nbsp;&nbsp;&nbsp;'+this.folder_screen_name+'</option>';
						});
					}
		        }); 
				$('#ModalImportForm .folderList').html( html_temp );
			}); 
		});
		

		$("body").on('click','.btnIsOpen:not(.active)',function(e){
			var thiss = $(this);
			console.log($('#patient_case').data('id'));
			getAjax($plRoute+"/updateFolder",'post',{case_id:$('#patient_case').data('id'),folder_id:$(this).closest('li').data('folder_id'),is_open:$(this).data('value')},function(rs){
				console.log(rs);
				if(rs.status == 200){
					thiss.closest('li').find('.wrap_volume').toggle();
				}else{
					e.preventDefault();
				}
			});
			//$(this).closest('li').find('ul').toggle();
		});
		
		$("body").on('click','.isPass',function(e){
			getAjax($plRoute+"/updateFolder",'post',{case_id:$('#patient_case').data('id'),folder_id:$(this).closest('li').data('folder_id'),is_pass:$(this).prop('checked')?1:0},function(rs){
				if(rs.status == 200){
					
				}else{
					e.preventDefault();
				}
			});
		});
		
		$("body").on('click','.del-folder',function(e){
			var thiss = $(this);
			$('#btnConfirmOK').one("click", function( e ) {
				getAjax($plRoute+"/destoryFolder",'post',{folder_id:thiss.closest('li').data('folder_id')},function(rs){
					if(rs.status==200){ thiss.closest('li').remove();$('#confrimModal').modal('hide');}
				});
			});
		});
		
		$("body").on('click','.del-file',function(e){
			var thiss = $(this);
			$('#btnConfirmOK').one("click", function( e ) {
				getAjax($plRoute+"/deleteFile",'post',{file_id:thiss.closest('li').data('file_id'),method:thiss.closest('.wrap').attr('id')},function(rs){
					if(rs.status==200){ 
						thiss.closest('li').remove();
						$('#confrimModal').modal('hide');
					}
				});
			});
		});
		
		$(".datepicker").change(function(){
			$(this).closest("div").find(".datepicker_ad").val(beToad($(this).val()));
		});
		
		function getBasicData(selector){
			var last_tr = selector.closest('.wrap').find('tr:last-child');
			last_tr.find('.caseType').append($html_caseType);
			last_tr.find('.doctor').append($html_doctor);
			last_tr.find('.procedure').append($html_procedure);
			last_tr.find('.discount').append($html_discountType);
			last_tr.find('.social').append($html_social);
			last_tr.find('.article').append($html_articleType);
			last_tr.find('.pr').append($html_pr);
			last_tr.find('.next_year').append(getyear($current_year,$current_year+10));
			last_tr.find('.appointment').append($html_appointment);
			last_tr.find('.datepicker').datepicker({
                format: 'dd/mm/yyyy',
                todayBtn: true,
                language: 'th',            
                thaiyear: true              
            }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});
			last_tr.find('.dropify').dropify();
			last_tr.find('.datepicker').each(function(){
				$(this).closest("div").find(".datepicker_ad").val(beToad($(this).val()));
			});
			
			// new files
			n_id ++;
			last_tr.find('.storeFile').attr('id','storeFile-'+n_id);
			last_tr.find('.case_contract_file_name_check').attr('value','storeFile-'+n_id);
			// end new files
		}
		
		function beToad(text){
			var t = text.split("/");
			return t[0]+"/"+t[1]+"/"+(t[2]-543);
		}

		function getFolder(data){
			console.log(data);
			var html_temp = '';
			$.each(data,function(){
				var isOpen = this.case_folder.is_open==1?'active':'';
				var isClose = this.case_folder.is_open==0?'active':'';
				var volume_tik = this.case_folder.is_open==1?'block':'none';
				var btnDelFolder = $username == this.created_by?'<button class=" btn btn-danger del-folder btn-delete btn-action pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button>':'';
				var btnDelFile = $username == this.created_by?'<button class=" btn btn-danger del-file  btn-delete btn-action pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button>':'';
				
				html_temp +='<li class="folder" data-folder_id="'+this.folder_id+'">'
				+'<a href="javascript:void(0)" class="folder_toggle">'+this.folder_screen_name+'</a>'
				+'<div style="float:right;"class="span6">'
					+'<div class="wrap_volume span5" style="display:'+volume_tik+'">ปริมาณรูป&nbsp;&nbsp;<span class="volume">0</span>&nbsp;%</div>'
					+'<div class="btn-group span5" data-toggle="buttons-radio">'
						+'<button type="button" data-value="1" class="btnIsOpen btn btn-other btn-action '+isOpen+' ">เปิด</button>'
						+'<button type="button" data-value="0" class="btnIsOpen btn btn-other btn-action '+isClose+' ">ปิด</button>'
					+'</div>'+btnDelFolder+'</div>';
				if(this.case_file.length > 0){
					html_temp +='<ul>';
					$.each(this.case_file,function(){
						var fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
						html_temp 	+='<li class="file type-'+fileType+'" data-file_id="'+this.file_id+'" data-path="'+this.image_path+'" >'
						+'<a href="javascript:void(0)" >'+this.file_name+'</a>'
						+'<a href="'+$host+this.image_path+'" download class="fa fa-download btn-download btn-action" download style="position: relative;left: 40px;"></a>'
						+'<div style="float:right;"class="span2">'+btnDelFile+'</div></li>';		
					});	html_temp +='</ul>';
				}
				if(this.sub_folder){
					html_temp +='<ul>';
					$.each(this.sub_folder,function(){
						if(this.case_folder){
							var isPass = this.case_folder.is_pass==1?'checked':'';
							html_temp 	+='<li class="folder" data-folder_id="'+this.folder_id+'" ><a href="javascript:void(0)" >'+this.folder_screen_name+'</a>'
							+'<div style="float:right;"class="span6">'
							+'<label class="span10"><input type="checkbox" '+isPass+' class="isPass btn-action btn-other">&nbsp;&nbsp;ผ่าน</label>'+btnDelFolder+'</div></li>';		
							
							if(this.case_file.length > 0){
								html_temp +='<ul>';
								$.each(this.case_file,function(){
									var fileType = this.file_name.split('.')[this.file_name.split('.').length-1];
									html_temp 	+='<li class="file  type-'+fileType+'" data-file_id="'+this.file_id+'" data-path="'+this.image_path+'" >'
									+'<a href="javascript:void(0)" >'+this.file_name+'</a>'
									+'<a href="'+$host+this.image_path+'" class="fa fa-download btn-download btn-action" download style="position: relative;left: 40px;"></a>'
									+'<div style="float:right;"class="span2">'+btnDelFile+'</div></li>';		
								});	html_temp +='</ul>';
							}
						}
					});	html_temp +='</ul>';
				}	html_temp +='</li>';
			}); 
			$('#list >li > ul').html(html_temp);
		}
		
		function validatetor(data) {
		    var errorData="";
		    $.each(data, function(key, value) {
		    	$.each(value, function(k, v) {
		     		errorData += stripJsonToString(v);
		    	});
		    });
		    return errorData;
		}
		   
		var stripJsonToString= function(json){
		       return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "</br>").replace(/\"/g,'');
		}
		function validatetorInformation(data) {
		    $("#information_errors").show();
		    $("#information_errors").html(data);
		}
		
		function getyear(min,max){
			var html_year ='';
			for($i = min; $i < max;$i++ ){	html_year +="<option value="+($i-543)+">"+$i+"</option>";	}
			return html_year;
		}
		
		function paresDateToDate(date){
			$date = date.split("-");
			$str_date = $date[2]+'/'+$date[1]+'/'+(parseInt($date[0])+543);
			return $str_date;
		}
		
		function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      $('#profileImage').attr('src', e.target.result);
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		}

		$("#btnUpload_profileImage").change(function() {	readURL(this);	});
		
		function getList(){
			$data = { 	search		:$.trim($('#search_caseName').val()),
						caseType	:$('#search_caseType').val(),
						procedure	:$('#search_procedure').val(),
						social		:$('#search_social').val(),
						hn			:$.trim($('#search_hn').val()),
						review		:$('#search_review').val(),
						expDate		:$('#search_expireDate').val(),
						followup	:$('#search_followup').val(),
						case_group	:$('#search_case_group').val(),
						vn			:$('#search_vn').val(),
						
					}
			getAjax($plRoute+"/getCaseList",'get',$data,function(rs){
				console.log(rs);
				 var html_temp = '';
				 if(rs.data.length >0){
					 $.each(rs.data,function(i,v){
						var html_social = '';
						$.each(v.patient_social_media,function(){
							html_social += this.social_media.social_media_name+', ';
						});
						var is_good_case = v.is_good_case==1?'checked':'';
						var is_good_review = v.is_good_review==1?'checked':'';
						if(i%2==0) html_temp += '<div class="row-fluid">';
						html_temp += '<div class="span6 case_list" data-id="'+v.case_id+'">'
							+'<div class="span6"> '
								+'<img src="'+$host+v.patient.image_path+'"> '
								+'</div> <div class="span6" ><br> '
							+'<div> <span>ชื่อ : </span><span>'+v.patient.patient_name+'</span> </div> '
							+'<div> <span>VN no : </span><span>'+v.vn_no+'</span> </div> '
							+'<div> <span>หัตถการ : </span><span>'+v.procedure.procedure_name+'</span> </div> '
							+'<div> <span>ประเภท : </span><span>'+v.case_type.case_type+'</span> </div>' 
							+'<div> <span>ช่องทางลงสื่อ : </span><span>'+html_social+'</span> </div>' 
							+'<div > <input type="checkbox" '+is_good_case+' disabled=""> <span>Case ติดดาว</span> </div> '
							+'<div > <input type="checkbox" '+is_good_review+' disabled=""> <span>Review ติดดาว</span> </div> '
							+'<div> <span>สถานะงาน:</span><span>'+v.status+'</span> </div> '
							+'<div> <button data-patient_id="'+v.patient.patient_id+'" class="btn btn-success add_procedure" data-target="#modalAdd" data-toggle="modal">เพิ่มหัตถการ</button> '
								+'<button class="btn btn-warning edit-list"data-target="#modalAdd" data-toggle="modal" data-type="edit">แก้ไข</button> </div> </div> </div>';
						if(i%2==1) html_temp += '</div>';
					}); 
				 }
					$('#show_list').html(html_temp);
			});
			
		}
	}
});

</script>