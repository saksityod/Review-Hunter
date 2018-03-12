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
		</div
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>รายงานการเขียนบทความ (ไม่มีเคส)</h5>
				</div>
				<!-- search -->
				<div class="ibox-content breadcrumbs2">
					<div class="row-fluid p-t-xxs">
						<div class="form-group span3" >
							<label class="label-control" for="">ระบุช่วงเวลา</label>
							<select data-toggle="tooltip" title="ระบุช่วงเวลา"
								class="input span12 m-b-n" id="time" name="time">
								<option value="7">7 วัน</option>
								<option value="15">15 วัน</option>
								<option value="30">1 เดือน</option>
								<option value="365">1 ปี</option>
							</select>
						</div>
						<div class="form-group span3">
							<label class="label-control" for="">วันที่</label>
							<input type="text" class="datepicker" id="start_date" name="start_date" data-toggle="tooltip" title="วันที่">
						</div>
						<div class="form-group span3">
							<label class="label-control" for="">ถึงวันที่</label>
							<input type="text" class="datepicker" id="end_date" name="end_date" data-toggle="tooltip" title="ถึงวันที่">
						</div>
						<div class="form-group span3">
							<label class="label-control" for="">สถานะงาน</label>
							<label class="radio inline">
							  <input type="radio" name="status" id="status" value="1" checked>
							  เสร็จ
							</label>
							<label class="radio inline">
							  <input type="radio" name="status" id="status" value="1">
							  ไม่เสร็จ
							</label>
							<label class="radio inline">
							  <input type="radio" name="status" id="status" value="1">
							  ทั้งหมด
							</label>
						</div>
					</div>
					<div class="row-fluid p-t-xxs">
						<div class="form-group text-right span12" style="padding-right: 12px;">
							<button type="button" name="btn_search" id="btn_search"	class="btn btn-info input-sm">
									<i class="fa fa-search"></i>&nbsp;ออกรายงาน
							</button>
						</div>
					</div>
				</div>
				<!-- search -->
			</div>
		</div>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="ibox-title">
				<h5>Report Result</h5>
			</div>
			<div class="ibox-content">
				<div class="row-fluid">
					<iframe id="iFrame_report" frameborder="0" style="width :100%;height: 1200px;">
			  			<p>Your browser does not support iframes.</p>
					</iframe>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Mainly scripts -->
<!-- <script type="text/javascript">var jQuery_1_1_3 = $.noConflict(true);</script> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->