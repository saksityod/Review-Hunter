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
<input type="hidden" id="user_portlet" name="user_portlet"	value="<%=username%>">
<input type="hidden" id="pass_portlet" name="pass_portlet"	value="<%=password%>">
<input type="hidden" id="url_portlet" name="url_portlet"	value="<%= renderRequest.getContextPath() %>">
<input type="hidden" id="plid_portlet" name="plid_portlet"	value="<%= plid %>">

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
				<div class="ibox-title">
					<h5>ค้นหา</h5>
				</div>

				<div class="ibox-content breadcrumbs2"	>
					<br/>
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3">
							<label class="label-control" for="">ชื่อ Case</label>
							<input data-toggle="tooltip" title="ชื่อ Case"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อ Case" id="case_name" name="case_name"
								type="text">
						</div>
						<div id="drop_down_organization" class="form-group span3" >
							<label class="label-control" for="">สถานะงาน</label>
							<select data-toggle="tooltip" title="สถานะงาน"
								class="input span12 m-b-n" id="job_status" name="job_status">
								<option selected value="">เขียน Review</option>
							</select>

						</div>
						
						<div id="drop_down_organization" class="form-group span3">
							<label class="label-control" for="">หัตถการ</label>
							<select data-toggle="tooltip" title="หัตถการ"
								class="input span12 m-b-n" id="medical_procedure"
								name="medical_procedure">
								<option selected value="">หน้าอก</option>
							</select>

						</div>
						<div class="form-group span3" >
							<label class="label-control" for="">ชื่อแพทย์</label>
							<input data-toggle="tooltip" title="ชื่อแพทย์"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ชื่อแพทย์" id="doctor_name" name="doctor_name"	type="text">
						</div>
					</div>	
					<div class="row-fluid p-t-xs">
						<div class="form-group span3" >
							<label class="label-control" for="">ผู้รับผิดชอบ</label>
							<input data-toggle="tooltip" title="ผู้รับผิดชอบ"
								data-placement="top" class="span12 m-b-n ui-autocomplete-input"
								placeholder="ผู้รับผิดชอบ" id="responsible" name="responsible"	type="text">
						</div>
						<div class="form-group text-right span9" style=" margin-top: 25px;">
							<button type="button" name="btn_search" id="btn_search"	class="btn btn-info input-sm ">
								<i class="fa fa-search"></i>&nbsp;ค้นหา
							</button>
						</div>

					</div>
					<br/>
				</div>
				<!-- content end -->
			</div>

		</div>

	</div>

	<div class="row-fluid " id="job_status_list_content">
		<div class="col-lg-12">
			<div class="ibox-title" >
				<h5>สถานะงานที่ต้องทำ</h5>
			</div>

			<div class="ibox-content">
				<div class="row-fluid">
					<div class="height-32-px"></div>
				</div>
				<!-- pagination start -->
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
			<!-- pagination end -->
				<!-- start table -->
				<div class="row-fluid" style="overflow: auto;">
					<table class="table table-striped" id="table_job_status">
						<thead>
							<tr>
								<th style='width: auto'><strong>ชื่อ Case</strong></th>
								<th style='width: auto'><strong>ชื่อบทความ</strong></th>
								<th style='width: auto'><strong>หัตถการ</strong></th>
								<th style='width: auto'><strong>สถานะงาน</strong></th>
								<th style='width: auto'><strong>ผู้รับผิดชอบ</strong></th>
								<th style='width: auto'><strong>วันครบกำหนด</strong></th>
								<th style='width: auto'><strong>วันที่เสร็จ</strong></th>
								<th style='width: auto'><strong>แพทย์</strong></th>
								<th style='width: auto'><strong>VN</strong></th>
							</tr>
						</thead>
						<tbody id="list_job_status">
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
							<!-- pagination end -->
<!-- 					<div class="span3 object-right ResultsPerPageBottom"> -->
	
<!-- 						<div class='pagingDropdown'> -->
<!-- 							<select id='countPaginationBottom' -->
<!-- 								class="form-control input-sm countPagination"> -->
<!-- 								<option>10</option> -->
<!-- 								<option>20</option> -->
<!-- 								<option>50</option> -->
<!-- 								<option>100</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 						<div class='pagingText'>Results per page</div> -->
<!-- 					</div> -->
				</div>
				<!-- pagination end -->
			</div>
			<!-- content end -->
		</div>
	</div>