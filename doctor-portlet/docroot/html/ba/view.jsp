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
	.list{     border: 1px solid darkgray; }
	.edit-list{ margin:10px}
	.row-fluid {	margin-button: 10px;	}
	.modal-body > div{margin-top:20px}
	/* .modal-body > div{display:none;} */
	.aui hr{ margin:10px 0 20px}

#list, #list ul {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  list-style-type: none;
  margin-left:0;
  padding-left:40px;
  text-indent: -30px;
}
#list li ul li:before {
    font-family: FontAwesome;
    content: "\f07b";
    color: orange;
    font-size: 25px;
    padding-right: 10px;
}
#list > li:before {
    font-family: FontAwesome;
    content: "\f015";
    color:skyblue;
    font-size: 40px;
    padding-right: 10px;
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
<div class="row-fluid">
      <div class="alert alert-warning information" id="information_errors" style="display: none;height:120px; overflow-y: scroll; position:relative;">
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
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label ">หัตถการ</label>
						<select class="procedure" id="search_procedure">
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label ">ช่องทางลงสื่อ</label>
						<select class="social" id="search_social">
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
				</div>
				
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="">HN</label> 
						<input type="text"  id="search_hn" />
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
						<input type="text" class="form-control datepicker">
						<input type="text" class=" datepicker_ad" id="search_expireDate">
					</div>
						<label for="">&nbsp;</label> 
					<button type="button" class="btn btn-info span3" id="btn_search" style="width: auto;">
						<i class="fa fa-search"></i> ค้นหา
					</button>
				</div>
				<br />
			</div>

		</div>
		<!-- content end -->
	</div>

	<div class="col-lg-12">
		<div class="ibox-title">
			<h5>B&A Library 
				<button class="btn btn-success" id='addPatient' data-target=#modalAdd data-toggle='modal' data-type="add">
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
						<div class="table" id="show_list">
							
													
						</div>
					</div>

					<!-- end table -->
					<!-- pagination start -->

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
					<!-- pagination end -->

				</div>
				<!-- content end -->
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
					<div class="row-fluid wrap" id="patient">
						<div class="row-fluid">
							<div class="span3">
								<label>เลข HN: </label><input type="text" id="patient_hnNo">
							</div>
							<div class="span3">
								<label class=" ">ชื่อ : </label>
								<input type="text" id="patient_name">
							</div>
							<div class="span2">
								<label class=" ">ชื่อเล่น : </label>
								<input type="text" id="patient_nickName">
							</div>
							<div class="span3">
								<label class=" ">วันเดือนปีเกิด : </label>
								<input type="text" class="datepicker">
								<input type="text" id="patient_birthDate" class="datepicker_ad">
							</div>
							<div class="span1">
								<label class="">อายุ : </label>
								<div class='yearOld'></div>
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label >สัญชาติ : </label>
								<select id="patient_nationality" class="nationality"></select>
							</div>
							<div class="span3">
								<label class="">เพศ : </label>
								<select id="patient_gender">
									<option value="male">Male</option>
									<option value="female">Female</option>
								</select>
							</div>
							<div class="span6">
								<label class="">เลขที่บัตรประจำตัวประชาชน/หนังสือเดินทาง : </label>
								<input type="text" id="patient_idCard">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class="">บ้านเลขที่ : </label>
								<input type="text" id="patient_homeNo">
							</div>
							<div class="span3">
								<label class="">หมู่ที่ : </label>
								<input type="text" id="patient_moo">
							</div>
							<div class="span6">
								<label class="">อาชีพ : </label>
								<input type="text" id="patient_career">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class=" ">ซอย : </label>
								<input type="text" id="patient_soi">
							</div>
							<div class="span3">
								<label class=" ">ถนน : </label>
								<input type="text" id="patient_road">
							</div>
							<div class="span3">
								<label class=" ">โทรศัพท์มือถือ : </label>
								<input type="text" id="patient_mobile">
							</div>
							<div class="span3">
								<label class="">โทรศัพท์บ้าน : </label>
								<input type="text" id="patient_telNo">
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<label class="">จังหวัด : </label>
								<select id="patient_province"></select>
							</div>
							<div class="span3">
								<label class="">อำเภอ/เขต : </label>
								<select id="patient_amphur"></select>
							</div>
							<div class="span3">
								<label class="">ตำบล/แขวง : </label>
								<select id="patient_district"></select>
							</div>
							<div class="span3">
								<label class="">รหัสไปรษณีย์ : </label>
								<div id="patient_zipcode" ></div>
							</div>
						</div>
					</div>
					
					
					<!-- patient_social_media -->
					<div class="row-fluid wrap" id="patient_social_media">
						<h4>ข้อมูล Social Network &nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><select class="patient_social_media_type social"></select></td>
									<td><input type="text" class="patient_social_media_link"></td>
									<td><input type="number" class="patient_social_media_follow"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'
							>เพิ่ม</button>
							<button class="btn btn-warning modal-edit">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
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
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><select class="surgery_year next_year"></select></td>
									<td><div class="surgery_lengthYear"></div></td>
									<td><input type="text" class="surgery_clinic"></td>
									<td><select class="surgery_doctor doctor"></select></td>
									<td><select class="surgery_procedure procedure"></select></td>
									<td><input type="text" class="surgery_remark"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
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
								<input type="text" id="patient_case_suggesGroup">
							</div>
							<div class="span3">
								<label class=" ">แนะนำโดย: </label>
								<input type="text" id="patient_case_suggestedBy">
							</div>
							<div class="span3">
								<label >ประเภท Case : </label>
								<select id="patient_case_caseType" class="casetype "></select>
							</div>
							<div class="span3">
								<label >กลุ่มของ Case :  </label>
								<select id="patient_case_caseGroup" class="caseGroup"></select>
							</div>	
						</div>
						
						<div class="row-fluid">
							<div class="span3">
								<label class=" ">ผู้ดูแล : (Auto complete)</label>
								<input type="text" id="patient_case_supervisedBy">
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
								<input type="text" id="patient_case_vn">
							</div>
							<div class="span3">
								<label class=" ">หัตถการ : </label>
								<select id="patient_case_procedure" class="procedure"></select>
							</div>
							<div class="span6">
								<label class=" ">แพทย์ :  </label>
								<select id="patient_case_doctor" class="doctor"></select>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span3">
								<input id="patient_case_isGood" type="checkbox"><span> Case ติดดาว</span>
							</div>
							<div class="span3">
								<input id="patient_case_isBad" type="checkbox"><span> Case ยอดแย่</span>
							</div>
							<div class="span3">
								<input id="patient_case_isGoodReview" type="checkbox"><span> Review ติดดาว</span>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span12">
								<label class=" ">เหตุผล :  </label>
								<input type="text" id="patient_case_remark">
							</div>
						</div>
					</div>
					
					<div class="row-fluid wrap" id="case_followup">
						<div class="row-fluid">
							<h4 class="">หัตถการที่ควรทำ &nbsp;&nbsp;&nbsp;&nbsp; 
								<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
										<td><select class="case_followup_procedure procedure"></select></td>
										<td><select class="case_followup_year next_year"></select></td>
										<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
									</tr>'>เพิ่ม</button>
							</h4>
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
					
					
					<!-- case_price -->
					<div class="row-fluid wrap" id="case_price">
						<h4 class=" ">ราคา &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><select class="case_price_type discount"></select></td>
									<td><input type="number" class="case_price_offer"></td>
									<td><input type="number" class="case_price_accept"></td>
									<td><div class="case_price_percent"></div></td>
									<td><div class="case_price_value"></div></td>
									<td><input type="text" class="case_price_remark"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
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
					
					<!-- case_social_media -->
					<div class="row-fluid wrap" id="case_social_media">
						<h4 class=" ">ช่องทางลงสื่อ &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><select class="case_social_media_social social"></select></td>
									<td><input type="text" class="case_social_media_link"></td>
									<td><input type="text" class="case_social_media_username"></td>
									<td><input type="text" class="case_social_media_password"></td>
									<td><input type="text" class="case_social_media_remark"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
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
					
					<!-- case_coordinate -->
					<div class="row-fluid wrap" id="case_coordinate">
						<h4 class=" ">การประสานงานคลินิก &nbsp;&nbsp;&nbsp;&nbsp; </h4>
						<hr/>
					</div>
					
					<!-- case_appointment -->
					<div class="row-fluid wrap" id="case_appointment">
						<h4 class=" ">นัดหมาย &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr"></td>
									<td><select class="case_appointment_type appointment"></select></td>
									<td><input class="datepicker" type="text">
										<input class="case_appointment_date datepicker_ad" type="text"></td>
									<td><select class="case_appointment_doctor doctor"></select></td>
									<td><input class="case_appointment_supervised user" type="text"></td>
									<td><input class="case_appointment_isVdoProduct" type="checkbox"></td>
									<td><input class="case_appointment_isVdoRh" type="checkbox"></td>
									<td><input class="case_appointment_isPictureProduct" type="checkbox"></td>
									<td><input class="case_appointment_isPictureRh" type="checkbox"></td>
									<td><input class="case_appointment_isMeetDoctor" type="checkbox"></td>
									<td><input class="case_appointment_remark" type="text"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
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
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					
					
					<!-- case_contract -->
					<div class="row-fluid wrap" id="case_contract">
						<h4 class=" ">รายละเอียดสัญญา &nbsp;&nbsp;&nbsp;&nbsp; 
							<button type="button" class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
								<td><input class="case_contract_no no" 	type="text"></td>
								<td><select class="case_contract_procedure procedure"></select></td>
								<td><input class="datepicker" 	type="text">
									<input class="case_contract_startDate datepicker_ad" 	type="text"></td></td>
								<td>
								<td><input class="datepicker" 	type="text">
									<input class="case_contract_endDate datepicker_ad" type="text"></td>
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
									<button class="btn btn-danger del-tr-contract"><i class="fa fa-times-circle"></i></button>
								</td>
								<input class="case_contract_file_name_check" type="hidden">
								
								
							</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
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
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><select class="case_pr_pr pr"></select></td>
									<td><input class=" datepicker" type="text">
										<input class="case_pr_planDate datepicker_ad" type="text"></td>
									<td>
										<input class="case_pr_isPicture" type="checkbox">&nbsp;&nbsp;<span>รูปภาพ</span>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="case_pr_isVdo" type="checkbox">&nbsp;&nbsp;<span>วีดีโอ(selfie)</span>&nbsp;&nbsp;&nbsp;&nbsp;
										<br>
										<input class="case_pr_isInstragram" type="checkbox">&nbsp;&nbsp;<span>live Instragram</span>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="case_pr_isFacebook" type="checkbox">&nbsp;&nbsp;<span>live Facebook</span>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
									<td><input class=" datepicker" type="text">
										<input class="case_pr_actualDate datepicker_ad" type="text"></td>
									<td><button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button></td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
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
							<button class="btn btn-info" id="btnAddFolder"  data-target="#addFolder" data-toggle="modal">สร้างแฟ้มรูป</button> 
							<button class="btn btn-success" id="btnUploadFile" data-target="#ModalImportForm" data-toggle="modal" form="fileUploadWriterForm">อัพโหลด</button>
						</h4>
						<hr/>
						<div class="row-fluid">
							<div class="span8">
								<ul id="list">
								    <li><a href="#">Home</a>
								    <ul>
								        
								    </ul>
								    </li>
								</ul>
							</div>
							<div class="span4">
								<div>
									<img src='https://upload.wikimedia.org/wikipedia/th/thumb/2/2f/%E0%B9%81%E0%B8%95%E0%B9%89%E0%B8%A7_2017.jpg/250px-%E0%B9%81%E0%B8%95%E0%B9%89%E0%B8%A7_2017.jpg'>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Article -->
					<div class="row-fluid wrap" id="case_article">
						<h4 class=" ">บทความ &nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="btn btn-success modal-add" data-tr='<tr class="dump_tr">
									<td><input class="case_article_name" type="text"></td>
									<td><select class="case_article_type_id article"></select></td>
									<td><input class="case_article_writer" type="text"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_writingStartDate datepicker_ad" type="text"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_writingEndDate datepicker_ad" type="text"></td>
									<td><input class=" datepicker" type="text">
										<input class="case_article_planDate datepicker_ad" type="text"></td>
									<td><input class="case_article_upload storeFile" multiple type="file"></td>
									<td width="150px">
										<button class="btn btn-info" ><i class="fa fa-download"></i></button>
										<button class="btn btn-danger del-tr"><i class="fa fa-times-circle"></i></button>
									</td>
								</tr>'>เพิ่ม</button>
							<button class="btn btn-warning modal-edit ">แก้ไข</button>
							<button class="btn btn-danger modal-del">ลบ</button> 
							<button class="btn btn-danger modal-cancel pull-right">ยกเลิก</button> 
						</h4>
						<hr/>
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
					
					<!-- case_stage -->
					<div class="row-fluid wrap" id="case_stage">
						<h4 class=" ">Workflow  &nbsp;&nbsp;&nbsp;&nbsp;</h4>
						<hr/>
						<div class="row-fluid">
							<div class="span4">
								<label class=" ">จากขั้นตอน : </label>
								<select id="case_stage_fromStage" ></select>
							</div>
							<div class="span4">
								<label class=" ">ไปขั้นตอน : </label>
								<select id="case_stage_toStage" ></select>
							</div>
							<div class="span4">
								<label class=" ">ส่งถึง: (Auto complete)</label>
								<input type="text" id="case_stage_toUser" class="user">
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span4">
								<label class=" ">วันที่เสร็จ : </label>
								<input id="" class="datepicker" type="text">
								<input id="case_stage_actualDate" class="datepicker_ad" type="text">
							</div>
							<div class="span4">
								<label class=" ">อัพโหลดไฟล์:</label>
								<input class="case_stage_upload storeFile" multiple type="file">
							</div>
							<div class="span4">
								<label class=" ">วันครบกำหนด: </label>
								<input id="" class="datepicker" type="text">
								<input id="case_stage_actualDate" class="datepicker_ad" type="text">
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span8">
								<label class=" ">เหตุผล : </label>
								<textarea id="case_stage_remark" rows="4"></textarea>
							</div>
							<div class="span4">
								<label class=" ">แจ้งเตือน: </label>
								<select id="case_stage_notification"></select>
							</div>	
						</div>
						<div class="row-fluid">
							<div class="span8">
								<label class=" ">แนบเอกสาร : </label>
								<input type="file" id="case_stage_upfile" >
							</div>
						</div>
						
					</div>
					
					<!-- Workflow -->
					<div class="row-fluid wrap" id="workflow">
						<h4 class=" ">Workflow History</h4>
						<hr/>
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
							<tbody>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
						
				</div><!--  modal body -->
				
				<div class="modal-footer">
					<div align="center">
						<button class="btn btn-success" id="btnModalSubmit" type="button">
							Submit
						</button>&nbsp;&nbsp;
						<button data-dismiss="modal" class="btn btn-danger" type="button">
							Cancel
						</button>
					</div>
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
					<h4 class="modal-title" id="">อัพโหลดรูปภาพ</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<form id="fileUploadWriterForm">
						<div class="row-fluid"> 
							<div class=""> <label class=" ">แฟ้มหลัก: </label> 
								<select class="folderList"></select>
							</div>
						</div>
						<h4>File Upload</h4>
						<div class="fileImport">
							<input type="file" id="fileForm" class="dropify fileUpload" accept=".xls, .xlsx, .pdf, .docx" multiple/><span></span>
						</div>
						<h6 class="label-content-import-export"></h6>
					</form>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" type="submit" id="importsubmitForm" form="fileUploadWriterForm">Upload</button>
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
		getAjax($plRoute+'/getOnLoad','get',{userId:$('#userId_portlet').val()},function(rs){
			console.log(rs);
			
			$current_year = parseInt(rs.currentDate.split("-")[2])+543;
			$(".datepicker").each(function(){
				$(this).closest("div").find(".datepicker_ad").val(beToad($(this).val()));
			});
			
			var html_temp = '<option> --เลือกจังหวัด -- </option>';
			$.each(rs.province,function(){
				html_temp +='<option value="'+this.province_id+'">'+this.province_name+'</option>';
			}); $('#patient_province').html(html_temp);
			
			$html_procedure = '';
			$.each(rs.medicalProcedure,function(){
				$html_procedure +='<option value="'+this.procedure_id+'">'+this.procedure_name+'</option>';
			}); $('.procedure').html($html_procedure);

			$html_doctor = '';
			$.each(rs.doctor,function(){
				$html_doctor +='<option value="'+this.doctor_id+'">'+this.doctor_name+'</option>';
			}); $('.doctor').html($html_doctor );
			
			$html_social = '';
			$.each(rs.socialMedia,function(){
				$html_social +='<option value="'+this.social_media_id+'">'+this.social_media_name+'</option>';
			}); $('.social').html($html_social);
			
			$html_caseType = '';
			$.each(rs.caseType,function(){
				$html_caseType +='<option value="'+this.case_type_id+'">'+this.case_type+'</option>';
			}); $('.casetype').html( $html_caseType);
			
			$html_caseGroup = '';
			$.each(rs.casegroup,function(){
				$html_caseGroup +='<option value="'+this.case_group_id+'">'+this.case_group+'</option>';
			}); $('.caseGroup').html( $html_caseGroup);
			
			$html_discountType = '';
			$.each(rs.discountType,function(){
				$html_discountType +='<option value="'+this.discount_type_id+'">'+this.discount_type_name+'</option>';
			}); $('.discount').html( $html_discountType );
			
			html_temp = '';
			$.each(rs.nationality,function(){
				html_temp +='<option value="'+this.nationality_id+'">'+this.nationality_name+'</option>';
			}); $('.nationality').html( html_temp );
			
			$html_pr = '';
			$.each(rs.pr,function(){
				$html_pr +='<option value="'+this.pr_id+'">'+this.pr_desc+'</option>';
			}); $('.pr').html( $html_pr );
			
			$html_appointment = '';
			$.each(rs.appointmentType,function(){
				$html_appointment +='<option value="'+this.appointment_type_id+'">'+this.appointment_type_name+'</option>';
			}); $('.appointment').html( $html_appointment );
			
			$html_articleType = '';
			$.each(rs.articleType,function(){
				$html_articleType +='<option value="'+this.article_type_id+'">'+this.article_type_name+'</option>';
			}); $('.article').html( $html_articleType );
			
			html_temp = '';
			$.each(rs.usageType,function(k,v){
				html_temp += "<div class='span5 coordinate_group'><label>"+v.usage_type_name+"</label><select data-usageType_id='"+v.usage_type_id+"' class='multiple case_coordinate' multiple='multiple'>";
				$.each(v.usage_item,function(){
					html_temp +='<option value="'+this.usage_id+'">'+this.usage_name+'</option>';
				});	html_temp += "</select></div>"	;	
			}); 
			$('#case_coordinate').append( html_temp );
			$('.multiple').multiSelect();
			$('#list >li > ul').html( getFolder(rs.folder) );
			$('.folder_toggle').click(function(){	$(this).parent('li').find('ul').toggle();	});
			$('.datepicker').keydown(function(e){e.preventDefault();});
			getList('');
		});
		
		$('body').on('click','.edit-list',function(){	$('.modal-cancel').hide();	});
		
		$('body').on('click','.modal-edit',function(){
			$(this).closest('.wrap').find('.modal-cancel').show();
			$(this).hide();
		});
		$('body').on('click','.modal-cancel',function(){
			$(this).closest('.wrap').find('.modal-edit').show();
			$(this).hide();
		});
		
		$('#patient_birthDate').on('focusout',function(){
			$('.yearOld').text($current_year-$(this).val().split('/')[2]);
		})
	    
		$('body').on("click", ".del-tr", function(){ this.closest('tr').remove(); });
		
		$('#ModalImportForm').on('show',function(e){
			
		});
		/* if($roles == 'rh_co'){
			$("#profile,#social,#surgery,#medical,#price,#social_channel,#folder,#workflow").show();
		} */
		var stage = $('#case_stage').data('id');
		//if(stage == ){
			
		//}
		
		$('#addPatient').on('click', function (e) {
				$('.modal-edit,.modal-del,.modal-cancel,.wrap').hide();
				$('#patient,#patient_social_media,#surgery_history,#patient_case,#case_followup').show();
				$('#case_price,#case_social_media,#case_file,#case_stage,#workflow').show();
				$("#modalAdd").data('method','add');
		});
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
		
		var n_id = 0;
		$('.modal-add').click(function(){	
			n_id ++;
			$(this).closest('.wrap').find('table tbody').append($(this).data('tr'));
			getBasicData($(this))   });
		
		$('body').on('keyup','.user',function(){
			var search =  $(this).val();
			$(this).autocomplete({
				minLength: 3,
				delay: 100,
				source: function (request, response) {
			        getAjax($plRoute+"/getUser",'get',{search:search,supervised:''},function(rs){
			        	response( $.map( rs, function( item ) {
			                var object = new Object();
			                  object.id = item.userId;
			                  object.value = item.firstName +' '+ item.lastName;
			                  return object ;
			            }));
			        });    
			    },
			    select: function (event, ui) {
			    	$(this).data('supervised',ui.item.id);
			    }
			});
		});
		
		
		/* save patient */
		$('#btnModalSubmit').click(function(){
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
		
			var social = [];
			$('#patient_social_media table tbody tr').each(function(i,v){
				social.push({
					patient_media_id:$('#patient_social_media').data("id")?$('#patient_social_media').data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					social_media_id	:$(this).find('.patient_social_media_type').val(),
					user_link		:$.trim($(this).find('.patient_social_media_link').val()),
					n_of_follwer	:$.trim($(this).find('.patient_social_media_follow').val()),
				});
			});
			$data['social_media'] = social; 
			
			var surgery = [];
			$('#surgery_history table tbody tr').each(function(i,v){
				surgery.push({
					history_id		:$('#surgery_history').data("id")?$('#surgery_history').data("id"):'',
					patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
					surgery_year 	:$(this).find('.surgery_year').val(),
					clinic_name		:$.trim($(this).find('.surgery_clinic').val()),
					doctor_id		:$(this).find('.surgery_doctor').val(),
					procedure_id	:$(this).find('.surgery_procedure').val(),
					remark			:$.trim($(this).find('.surgery_remark').val()),
				});
			});
			$data['surgery_history'] = surgery; 
				
			var supervised = '';
			$('body .patient_case_supervisedBy').each(function(){
				supervised+='|'+$(this).data('supervised');
			});
			
			$data['patient_case'] ={
				case_id 		:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
				workflow_stage_id:$('#case_stage').data('id')?$('#case_stage').data('id'):'',
				patient_id		:$("#patient").data("id")?$("#patient").data("id"):'',
				procedure_id	:$('#patient_case_procedure').val(),
				case_type_id	:$('#patient_case_caseType').val(),
				case_group_id	:$('#patient_case_caseGroup').val(),
				doctor_id		:$('#patient_case_doctor').val(),
				vn_no			:$.trim($('#patient_case_vn').val()),
				suggest_group	:$.trim($('#patient_case_suggesGroup').val()),
				suggested_by	:$.trim($('#patient_case_suggestedBy').val()),
				supervised_by	:supervised,
				is_good_case	:$('#patient_case_isGood').prop('checked'),
				is_bad_case		:$('#patient_case_isBad').prop('checked'),
				is_good_review	:$('#patient_case_isGoodReview').prop('checked'),
				remark			:$.trim($('#patient_case_remark').val())
			}
				 
			var followup = [];
			$('#case_followup table tbody tr').each(function(i,v){
				followup.push({
					followup_id		:$('#case_followup').data('id')?$('#case_followup').data('id'):'',
					case_id			:$('#patient_case').data('id')?$('#patient_case').data('id'):'',
					procedure_id	:$(this).find('.case_followup_procedure').val(),
					followup_year 	:$(this).find('.case_followup_year').val()
				});
			});
			$data['followup'] =followup;
			
			var price = [];
			$('#case_price table tbody tr').each(function(i,v){
				price.push({
					price_id 			:$("#case_price").data("id")?$("#case_price").data("id"):'',
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
			
			var channel = [];
			$('#case_social_media table tbody tr').each(function(i,v){
				channel.push({
					case_media_id 		:$("#case_social_media").data("id")?$("#case_social_media").data("id"):'',
					case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					social_media_id 	:$('.case_social_media_social ').val(),
					link 				:$.trim($(this).find('.case_social_media_link').val()),
					usr_name 			:$.trim($(this).find('.case_social_media_username').val()),
					pwd					:$.trim($(this).find('.case_social_media_password').val()),
					note 				:$.trim($(this).find('.case_social_media_remark').val())
				});
			});
			$data['case_social_media'] = channel; 
		
			if($("#modalAdd").data('method') != 'add'){
				var arr_coordinate = [];
				$.each($('#case_coordinate .case_coordinate'),function(){
					if($(this).val()){
						$.each($(this).val(),function(k,v){ arr_coordinate.push(v);});
					}
				});
				var coordinate = [];
				$.each(arr_coordinate,function(i,v){
					coordinate.push({
						coordinate_id 		:$("#case_coordinate").data("id")?$("#case_coordinate").data("id"):'',
						case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
						usage_id 			:v
					}); 
				});
				$data['case_coordinate'] = coordinate;
				
				var appointment = [];
				$('#case_appointment table tbody tr').each(function(i,v){
					appointment.push({
						appointment_id 		:$("#case_appointment").data("id")?$("#case_appointment").data("id"):'',
						case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
						appointment_type_id :$(this).find(".case_appointment_type").val(),
						appointment_date 	:$(this).find(".case_appointment_date").val(),
						doctor_id 			:$(this).find(".case_appointment_doctor").val(),
						supervised_by		:$(this).find(".case_appointment_supervised").data("supervised"),
						is_vdo_product 		:$(this).find(".case_appointment_isVdoProduct").prop("checked"),
						is_vdo_rh 			:$(this).find(".case_appointment_isVdoRh").prop("checked"),
						is_picture_product 	:$(this).find(".case_appointment_isPictureProduct").prop("checked"),
						is_picture_rh 		:$(this).find(".case_appointment_isPictureRh").prop("checked"),
						is_meet_doctor 		:$(this).find(".case_appointment_isMeetDoctor").prop("checked"),
						remark 				:$.trim($(this).find('.case_appointment_remark').val())
					});
				});
				$data['case_appointment'] =appointment; 
				
				var contract = [];
				$('#case_contract table tbody tr').each(function(i,v){
					contract.push({
						contract_id 		:$("#case_contract").data("id")?$("#case_contract").data("id"):'',
						seq_id 				:$(this).find(".case_contract_no").val(),
						case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
						procedure_id 		:$(this).find(".case_contract_procedure").val(), 
						contract_start_date	:$(this).find(".case_contract_startDate").val(), 
						contract_end_date	:$(this).find(".case_contract_endDate").val(), 
						is_post 			:$(this).find(".case_contract_isPost").prop("checked"),
						is_usage 			:$(this).find(".case_contract_isUsage").prop("checked"),
						is_picture_vdo 		:$(this).find(".case_contract_isPicture_vdo").prop("checked"),
						is_review 			:$(this).find(".case_contract_isReview").prop("checked"),
						is_pr 				:$(this).find(".case_contract_isPr").prop("checked"),
						is_group_post 		:$(this).find(".case_contract_isGroupPost").prop("checked"),
						is_send_picture 	:$(this).find(".case_contract_isSendPicture").prop("checked"),
						is_other 			:$(this).find(".case_contract_isOther").prop("checked"),
						contract_path 		:$temp_formData
					});
				});
				$data['case_contract'] =contract;
				
				var pr = [];
				$('#case_pr table tbody tr').each(function(i,v){
					pr.push({
						case_pr_id 		:$("#case_pr").data("id")?$("#case_pr").data("id"):'',
						case_id 		:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
						pr_id 			:$(this).find(".case_pr_pr").val(), 
						pr_plan_date 	:$(this).find(".case_pr_planDate").val(), 
						is_picture		:$(this).find(".case_contract_isOther").prop("checked"),
						is_vdo			:$(this).find(".case_pr_isPicture").prop("checked"),
						is_instragram 	:$(this).find(".case_pr_isInstragram").prop("checked"),
						is_facebook 	:$(this).find(".case_pr_isFacebook").prop("checked"),
						pr_actual_date 	:$(this).find(".case_pr_actualDate").val(), 
					});
				});
				$data['case_pr'] =pr;
				
				var article = [];
				$('#case_article table tbody tr').each(function(i,v){
					article.push({
						case_article_id 	:$("#case_article").data("id")?$("#case_article").data("id"):'',
						case_id 			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
						article_name 		:$.trim($(this).find('.case_article_name').val()),
						article_type_id 	:$(this).find('.case_article_type_id').val(),
						writer				:$.trim($(this).find('.case_article_writer').val()),
						writing_start_date	:$(this).find('.case_article_writingStartDate').val(),
						writing_end_date 	:$(this).find('.case_article_writingEndDate').val(),
						plan_date 			:$(this).find('.case_article_planDate').val(),
						article_path 		:''
					});
				});
				$data['case_article'] =article;
				
				$data['case_stage'] ={
					case_stage_id 	:$('#case_stage').data('id')?$('#case_stage').data('id'):'',
					case_id			:$("#patient_case").data("id")?$("#patient_case").data("id"):'',
					from_user_id	:$("#modalAdd").data("patient_id")?$("#modalAdd").data("patient_id"):'',
					from_stage_id	:$('#patient_case_procedure').val(),
					to_user_id		:$('#patient_case_caseType').val(),
					to_stage_id		:$('#patient_case_caseGroup').val(),
					plan_date		:$('#patient_case_doctor').val(),
					actual_date		:$.trim($('#patient_case_vn').val()),
					status			:$.trim($('#patient_case_suggesGroup').val()),
					remark			:$.trim($('#patient_case_suggestedBy').val())
				}
			}
			console.log($data)
			
			var FormAllData = new FormData();
			
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
			    success: function(data) {
			     console.log(data);
			    }
			   });
			
// 			getAjax($plRoute+'/cu','post',FormAllData,function(rs){
// 				console.log(rs);
// 			});
		});
		
		
		
		
		
		
			/* $.ajax({
				url:$plRoute+'/cu',
				type:'POST',
				data: $formData,
				cache: false,
				dataType: 'json',
				content:"application/json",
				//processData: false, // Don't process the files
				//contentType: false, // Set content type to false as jQuery will tell the server its a query string request
				headers:{Authorization:"Bearer "+tokenID.token},
				success: function(data)
				{
					console.log(data);
					
				},
				error: function(jqXHR, textStatus, errorThrown)
				{
					callFlashSlide('Format Error : ' + textStatus);
				}
			}); */
			
		
		
		/* Clear modal when hide */
		/* $('#modalAdd').on('hide', function(e){ 
			$(this).data('patient_id','');
			$('.dump_tr').remove();	
			$('.view_supervisedBy').html('');
			clearModal();
		}); */
		
		
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
					supervisedBy+='|'+$(this).data('supervised');
				})
		        getAjax($plRoute+"/getUser",'get',{search:$('#patient_case_supervisedBy').val(),supervised:supervisedBy},function(rs){
		        	response( $.map( rs, function( item ) {
		                var object = new Object();
		                  object.id = item.userId;
		                  object.value = item.firstName +' '+ item.lastName;
		                  return object ;
		            }));
		        });    
		    },
		    select: function (event, ui) {
		    	$('.view_supervisedBy').append('<div data-supervised="'+ui.item.id+'" class="patient_case_supervisedBy alert-info">'+ui.item.value+'<a href="javascript:void(0)" class="fa fa-times-circle remove_supervisedBy"></a></div>');
		    	$(this).val(''); return false;
		    }
		});
		$('body').on('click','.remove_supervisedBy',function(){$(this).parent().remove();});
		
		$('#btnAddFolder').click(function(){
			getAjax($plRoute+"/getFolder",'get','',function(rs){
		        console.log(rs);
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
				}
				console.log(folder);
				getAjax($plRoute+"/makeDirectory",'post',folder,function(rs){
					if(rs.status == 200){
						callFlashSlide('สร้างแฟ้มข้อมูลสำเร็จ' ,'success');
						getAjax($plRoute+"/getFolder",'get','',function(rs){
							$('#list >li > ul').html( getFolder(rs));
						});
						$('#addFolder').modal('hide');
						$('#folderName').val('');
					}else	callFlashSlide('เกิดข้อผิดพลาด','Error');
				});
			});
		});
		
		$('#btnUploadFile').click(function(){
			getAjax($plRoute+"/getFolder",'get','',function(rs){
		        console.log(rs);
		        var html_temp ='<option value="" >แฟ้มหลัก</option>';
		        $.each(rs,function(){
					html_temp +='<option data-folderName="'+this.folder_name+'" value="'+this.folder_id+'">'+this.folder_screen_name+'</option>';
				}); 
				$('#ModalImportForm .folderList').html( html_temp );
			}); 
			/* $('#btnSubmitAddFolder').one("click", function( e ) {
				var folder ={
						folder_screen_name	:	$.trim($('#folderName').val()),
						folder_parent_id	:	$('#addFolder .main_folder').val(),
				}
				console.log(folder);
				getAjax($plRoute+"/makeDirectory",'post',folder,function(rs){
					if(rs.status == 200){
						callFlashSlide('สร้างแฟ้มข้อมูลสำเร็จ' ,'success');
						getAjax($plRoute+"/getFolder",'get','',function(rs){
							$('#list >li > ul').html( getFolder(rs));
						});
						$('#addFolder').modal('hide');
						$('#folderName').val('');
					}else	callFlashSlide('เกิดข้อผิดพลาด','Error');
				});
			}); */
		});
		

		$("body").on('click','.btnIsOpen:not(.active)',function(e){
			var thiss = $(this);
			e.preventDefault();
			getAjax($plRoute+"/updateFolder",'post',{folder_id:$(this).closest('li').data('folder_id'),is_open:$(this).data('value')},function(rs){
				console.log(rs);
				if(rs.status == 200){
					thiss.closest('li').find('.wrap_volume').toggle();
				}
			});
		});
		
		$("body").on('click','.isPass',function(e){
			getAjax($plRoute+"/updateFolder",'post',{folder_id:$(this).closest('li').data('folder_id'),is_pass:$(this).prop('checked')?1:0},function(rs){
				console.log(rs);
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
		
		$(".datepicker").change(function(){
			$(this).closest("div").find(".datepicker_ad").val(beToad($(this).val()));
		});
		
		
		function getBasicData(selector){
			console.log(selector);
			var last_tr = selector.closest('.wrap').find('tr:last-child');
			last_tr.find('.caseType').html($html_caseType);
			last_tr.find('.doctor').html($html_doctor);
			last_tr.find('.procedure').html($html_procedure);
			last_tr.find('.discount').html($html_discountType);
			last_tr.find('.social').html($html_social);
			last_tr.find('.article').html($html_articleType);
			last_tr.find('.pr').html($html_pr);
			last_tr.find('.next_year').html(getyear($current_year,$current_year+10));
			last_tr.find('.appointment').html($html_appointment);
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
			last_tr.find('.storeFile').attr('id','storeFile-'+n_id);
			last_tr.find('.case_contract_file_name_check').attr('value','storeFile-'+n_id);
			// end new files
		}
		
//new files
		
		$('body').on("click", ".del-tr-contract", function() {
			this.closest('tr').remove();
		});
		
		var $inputFilesName;
		$("#case_contract").on("click",'.storeFile',function() {
 			var contractFiles = $(this).attr('id');
 			$inputFilesName = $(this).attr('id');
 			getFilesData(contractFiles);
		});
		
		function getFilesData(data) {
			$('#'+data).on('change', savingFilesData);
		}
		
		function savingFilesData(event) {
			var filedataInput = event.target.files;
			createNewFormData(filedataInput);
		}
		
		var FormAllData = new FormData();
		function createNewFormData(data) {
			$.each(data, function(key, value) {
				console.log(value)
				FormAllData.append($inputFilesName+'|'+key, value);
			});
		}
		
		$("#btnSubmit_contract").click(function() {
			//console.log("test");
			var $dataContract = {};
			var contract = [];
			$('#case_contract table tbody tr').each(function(i,v){
				contract.push({
					contract_id 		:$("#case_contract").data("contract_id")?$("#case_contract").data("contract_id"):'',
					seq_id 				:$("#case_contract").data("seq_id")?$("#case_contract").data("seq_id"):'',
					case_id 			:$("#case_contract").data("case_id")?$("#case_contract").data("case_id"):'',
					procedure_id 		:$(this).find(".case_contract_procedure").val(),
					contract_start_date	:$(this).find(".case_contract_startDate").val(),
					contract_end_date	:$(this).find(".case_contract_endDate").val(),
					is_post 			:$(this).find(".case_contract_isPost").prop("checked"),
					is_usage 			:$(this).find(".case_contract_isUsage").prop("checked"),
					is_picture_vdo 		:$(this).find(".case_contract_isPicture_vdo").prop("checked"),
					is_review 			:$(this).find(".case_contract_isReview").prop("checked"),
					is_pr 				:$(this).find(".case_contract_isPr").prop("checked"),
					is_group_post 		:$(this).find(".case_contract_isGroupPost").prop("checked"),
					is_send_picture 	:$(this).find(".case_contract_isSendPicture").prop("checked"),
					is_other 			:$(this).find(".case_contract_isOther").prop("checked"),
					file_name_check 	:$(this).find(".case_contract_file_name_check").val()
				});
			});
			$dataContract['case_contract'] = contract;
			
			FormAllData.append('formdata', JSON.stringify($dataContract));
			
			$.ajax({
				url:$plRoute+'/cu_contract',
				type:'POST',
				data: FormAllData,
				cache: false,
				dataType: 'json',
				content:"application/json",
				processData: false, // Don't process the files
				contentType: false, // Set content type to false as jQuery will tell the server its a query string request
				headers:{Authorization:"Bearer "+tokenID.token},
				success: function(data) {
					console.log(data);
				}
			});
		});
		//end new
		
		function beToad(text){
			var t = text.split("/");
			return t[0]+"/"+t[1]+"/"+(t[2]-543);
		}
		

		function getFolder(data){
			var html_temp = '';
			$.each(data,function(){
				var isOpen = this.is_open==1?'active':'';
				var isClose = this.is_open==0?'active':'';
				var volume_tik = this.is_open==1?'block':'none';
				var btnDel = $username == this.created_by?'<button class=" btn btn-danger del-folder pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button>':'';
				html_temp +='<li data-folder_id="'+this.folder_id+'"><a href="#" class="folder_toggle">'+this.folder_screen_name+'</a>'
				+'<div style="float:right;"class="span6">'
					+'<div class="span8"><div class="wrap_volume" style="display:'+volume_tik+'">ปริมาณรูป&nbsp;&nbsp;<span class="volume">0</span>&nbsp;%</div></div>'
					+'<div class="btn-group" data-toggle="buttons-radio">'
						+'<button type="button" data-value="1" class="btnIsOpen btn btnOpen '+isOpen+' ">เปิด</button>'
						+'<button type="button" data-value="0" class="btnIsOpen btn btnClose '+isClose+' ">ปิด</button>'
					+'</div>'+btnDel+'</div><ul>';
				if(this.sub_folder){
					$.each(this.sub_folder,function(){
						var isPass = this.is_pass==1?'checked':'';
						var btnDel = $username == this.created_by?'<button class=" btn btn-danger del-folder pull-right"  data-target="#confrimModal" data-toggle="modal">ลบ</button>':'';
						html_temp 	+='<li data-folder_id="'+this.folder_id+'" ><a href="#" >'+this.folder_screen_name+'</a>'
						+'<div style="float:right;"class="span6">'
							+'<div class="span8"><input type="checkbox" '+isPass+' class="isPass">&nbsp;&nbsp;ผ่าน</div>'+btnDel+'</div></li>';		
					});
					html_temp +='</ul>';
				}
				html_temp +='</li>';
			}); 
			return html_temp;
		}
		
		function validatetorWriter(data) {
		    var errorData="";
		    $.each(data, function(key, value) {
		     errorData += stripJsonToString(value);
		    });
		    console.log(errorData);
		    return errorData;
		}
		   
		var stripJsonToString= function(json){
		       return JSON.stringify(json).replace(',', ', ').replace('[', '').replace(']', '').replace('.', "<br>").replace(/\"/g,'');
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
		
		function getList(data){
			var html_temp = '<div class="span6 list">'
								+'<div class="span6"> '
									+'<img src="https://f.ptcdn.info/907/033/000/1438161082-1123115483-o.jpg"> '
									+'</div> <div class="span6" ><br> '
								+'<div class="span12"> <span>ชื่อ : </span><span>ภัชชาร์ ภัทรเดชาธรรม</span> </div> '
								+'<div class="span12"> <span>หัตถการ : </span><span>Case: Influencer</span> </div> '
								+'<div class="span12"> <span>ประเภท : </span><span>แก้ไข</span> </div>' 
								+'<div class="span12"> <span>ช่องทางลงสื่อ : </span><span>Facebook fan page</span> </div>' 
								+'<div class="span5"> <input type="checkbox" checked="" disabled=""> <span>Case ติดดาว</span> </div> '
								+'<div class="span6"> <input type="checkbox" checked="" disabled=""> <span>Review ติดดาว</span> </div> '
								+'<div class="span12"> <span>สถานะงาน:</span><span>เสร็จ</span> </div> '
								+'<div class="span12"> <button class="btn btn-success add_procedure">เพิ่มหัตถการ</button> '
									+'<button class="btn btn-warning edit-list"data-target="#modalAdd" data-toggle="modal" data-type="edit">แก้ไข</button> </div> </div> </div>';
			$('#show_list').html(html_temp);
			
		}
		
	}
});

</script>