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
<style>
</style>

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
				<br />
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="" class="control-label">ชื่อ Case</label> 
						<select>
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">ประเภท Case</label> 
						<select>
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">หัตถการ</label>
						<select>
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="" class="control-label">ช่องทางลงสื่อ</label>
						<select>
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
				</div>
				
				<div class="row-fluid " id="">
					<div class="form-group span3">
						<label for="">HN</label> 
						<select>
							<option>-- ทั้งหมด --</option>
						</select>
					</div>
					<div class="form-group span3">
						<label for="">Case ติดดาว</label> <input
							type="email" class="form-control" id=""
							placeholder="jane.doe@example.com">
					</div>
					<div class="form-group span3">
						<label for="">วันหมดสัญญา</label> <input
							type="date" class="form-control" id=""
							placeholder="">
					</div>
					<button type="button" class="btn btn-info span3"
						style="margin-top: 25px; width: auto;">
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
			<h5>B&A Library</h5>
		</div>

		<div class="ibox-content" style="">
			<!-- pagination start -->
			<div class="row-fluid">
				<div id="width-100-persen" class=" m-b-xs">
					<br>
					<button class="btn btn-success" data-target=#modalAdd
						data-toggle='modal' data-type="add">
						<i class="fa fa-plus"></i> เพิ่ม
					</button>
					<br>
					<br>
					<!-- start table -->
					<div class="row-fluid" style="overflow: auto;">
						<div class="table">
							<div class="span6 list">
								<div class="span6">
									<img src="https://f.ptcdn.info/907/033/000/1438161082-1123115483-o.jpg">
								</div>
								<div class="span6">
									<div class="span12">
										<button class="btn btn-warning pull-right">แก้ไข</button>
									</div>
									<div class="span12">
										<span>ชื่อ : </span><span>ภัชชาร์ ภัทรเดชาธรรม</span>
									</div>
									<div class="span12">
										<span>หัตถการ : </span><span>Case: Influencer</span>
									</div>
									<div class="span12">
										<span>ประเภท : </span><span>แก้ไข</span>
									</div>
									<div class="span12">
										<span>ช่องทางลงสื่อ : </span><span>Facebook fan page</span>
									</div>
									<div class="span5">
										<input type="checkbox" checked disabled /> <span>Case ติดดาว</span>
									</div>
									<div class="span6">
										<input type="checkbox" checked disabled /> <span>Review ติดดาว</span>
									</div>
									<div class="span12">
										<span>สถานะงาน:</span><span>เสร็จ</span>
									</div>
								</div>
							</div>
							
							<div class="span6 list">
								<div class="span6">
									<img src="https://f.ptcdn.info/434/047/000/oh3r5igepH1TJ9XVHzd-o.jpg">
								</div>
								<div class="span6">
									<div class="span12">
										<button class="btn btn-warning pull-right">แก้ไข</button>
									</div>
									<div class="span12">
										<span>ชื่อ : </span><span>ภัชชาร์ ภัทรเดชาธรรม</span>
									</div>
									<div class="span12">
										<span>หัตถการ : </span><span>Case: Influencer</span>
									</div>
									<div class="span12">
										<span>ประเภท : </span><span>แก้ไข</span>
									</div>
									<div class="span12">
										<span>ช่องทางลงสื่อ : </span><span>Facebook fan page</span>
									</div>
									<div class="span5">
										<input type="checkbox" checked disabled /> <span>Case ติดดาว</span>
									</div>
									<div class="span6">
										<input type="checkbox" checked disabled /> <span>Review ติดดาว</span>
									</div>
									<div class="span12">
										<span>สถานะงาน:</span><span>เสร็จ</span>
									</div>
								</div>
							</div>
						
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
						<div class="span12">
							<span>เลข HN: </span><span>01041803</span>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<label class=" ">ชื่อ : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class=" ">ชื่อเล่น : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class=" ">วันเดือนปีเกิด : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class="">อายุ : </label>
							<input type="text" disabled>
						</div>	
					</div>
					<div class="row-fluid">
						<div class="span3">
							<label class="">สัญชาติ : </label>
							<input type="text" >
						</div>
						<div class="span3">
							<label class="">เพศ : </label>
							<input type="text" >
						</div>
						<div class="span6">
							<label class="">เลขที่บัตรประจำตัวประชาชน/หนังสือเดินทาง : </label>
							<input type="text" >
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<label class="">บ้านเลขที่ : </label>
							<input type="text" >
						</div>
						<div class="span3">
							<label class="">หมู่ที่ : </label>
							<input type="text" >
						</div>
						<div class="span6">
							<label class="">อาชีพ : </label>
							<input type="text" >
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<label class=" ">ซอย : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class=" ">ถนน : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class=" ">โทรศัพท์มือถือ : </label>
							<input type="text">
						</div>
						<div class="span3">
							<label class="">โทรศัพท์บ้าน : </label>
							<input type="text" >
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<label class="">จังหวัด : </label>
							<input type="text" >
						</div>
						<div class="span3">
							<label class="">อำเภอ/เขต : </label>
							<input type="text" >
						</div>
						<div class="span3">
							<label class="">ตำบล/แขวง : </label>
							<input type="text" >
						</div>
						<div class="span3">
							<label class="">รหัสไปรษณีย์ : </label>
							<div >10300</div>
						</div>
					</div>
					<hr>
					<div class="row-fluid">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>ประเภท</th>
									<th>บัญชีผู้ใช้งาน/ลิ้งค์</th>
									<th>จำนวน Follower</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Email</td>
									<td><input type="text"></td>
									<td><input type="text"></td>
								</tr>
								<tr>
									<td>Facebook</td>
									<td><input type="text"></td>
									<td><input type="text"></td>
								</tr>
								<tr>
									<td>Instragram</td>
									<td><input type="text"></td>
									<td><input type="text"></td>
								</tr>
								<tr>
									<td>LineID</td>
									<td><input type="text"></td>
									<td><input type="text"></td>
								</tr>
								<tr>
									<td>Blog</td>
									<td><input type="text"></td>
									<td><input type="text"></td>
								</tr>
							</tbody>
						
						</table>
					
					</div>
	
					<!-- form End -->
					<!-- content end -->
				</div>
	
			</div>
		</div>
	</div>
	<!-- Modal End add -->
		
		
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
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Confirm End -->

	<input type="hidden" name="id" id="id" value=""> <input
		type="hidden" name="action" id="action" value="add">
</div>