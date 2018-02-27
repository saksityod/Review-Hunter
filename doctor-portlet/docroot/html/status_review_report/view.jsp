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
					<h5>รายงานสถานะการเขียนรีวิว</h5>
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
						<div class="form-group text-left span3">
							<label class="label-control" for="">&nbsp;</label>
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
					<iframe id="iFrame_report" frameborder="0" style="width :100%;height: 500px;">
			  			<p>Your browser does not support iframes.</p>
					</iframe>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Mainly scripts -->
<!-- <script type="text/javascript">var jQuery_1_1_3 = $.noConflict(true);</script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
var restfulURL="";
var serviceName="";

/*#######Office#######*/

/*#######Localhost#######*/
restfulURL="http://localhost";
serviceName="master_piece/public";
</script>

<script>
/* for portlet*/
var tokenID= [];
var roles = [];
var userId = null;
var screenName = null;

$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({	"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({	html:true	});
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
});


function checkSession(paramTokenID){
	$chk = true;
	tokenID = paramTokenID == undefined || paramTokenID == ""  ? tokenID : paramTokenID ;
	tokenID = eval("("+tokenID+")");
	if(tokenID==null){
		callFlashSlide("login failed.");
		$chk = false;
	}
	$.ajax({
		url:restfulURL+"/"+serviceName+"/session",
		type:"GET",
		dataType:"json",
		headers:{Authorization:"Bearer "+tokenID.token},
		async:false,
		success:function(data){
			//console.log(data)
			if(data.status == "200"){
				$chk = true;
				userId = data.userID;
				screenName = data.screenName;
				roles = data.roles;
			}else{
				callFlashSlide("login failed."); 
				sessionStorage.clear();
				$chk = false;
		    	setTimeout(function(){
		    		window.location.href = "../login.html"; 
				},500);
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    if('error'==textStatus){
		    	callFlashSlide("login failed."); 
		    	console.log("Error is "+textStatus);
		    	$chk = false;
		    	setTimeout(function(){
		    		window.location.href = "../login.html"; 
				},500);
		    }
		}
		
	});
	return $chk;
 }
 
 var connectionServiceFn = function(username,password,plid){
	$chk = true;
	$.ajax({
		url:restfulURL+"/"+serviceName+"/session",
		type:"POST",
		dataType:"text",
		data:{"username":username,"password":password,"plid":plid},
		async:false,
		error: function(jqXHR, textStatus, errorThrown) {
			 sessionStorage.clear();
			 $chk = false;
		    	setTimeout(function(){
		    		window.location.href = "../login.html"; 
				},500);
		},
		success:function(data){
			sessionStorage.setItem("tokenID",data);
			tokenID = eval("("+ sessionStorage.getItem("tokenID")+")");
			console.log(data);
			if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
				$(".aui body *").css({'font-weight':400});
			} 
			if(checkSession(data)){
				$chk = true;
			}
		}
	});	
	return $chk;
}

var flashSLideUp=function(){
	$("#slide_status").slideUp();
}

var flashSlideInModalSlideUp=function(){
	$(".information").slideUp();
}
$(document).on("click","#btnCloseSlide",function(){
	flashSLideUp();
});
$(document).on("click",".btnModalClose",function(){
	flashSlideInModalSlideUp();
});

function callFlashSlide(text,flashType){
	if(flashType=="error"){
		$("#slide_status_area").css("color","red");
		$("#slide_status_area").html(text);
	}else if(flashType=="success"){
		$("#slide_status_area").css("color","lightgreen");
		$("#slide_status_area").html(text);
	}else{
		$("#slide_status_area").html(text);
	}

	$("#slide_status").slideDown("slow");
	setTimeout(function(){
		$("#slide_status").slideUp();
	},5000);
}

var callFlashSlideInModal =function(text,id,flashType){
	var btnClose="<div class=\"btnModalClose\">×</div>";
	if(flashType=="error"){
		if(id!=undefined){
			$(id).html(btnClose+""+text).show();
			
		}else{
			
			$("#information").html(btnClose+""+text).show();
		}
		
	}else{
		
		if(id!=undefined){
			$(id).html(btnClose+""+text).show();
		}else{
			$("#information").html(btnClose+""+text).show();
		}
		setTimeout(function(){
			if(id!=undefined){
				$(id).hide("slow");
			}else{
				$("#information").hide("slow");
			}
		},3000);
	}
}


var logoutFn = function(){
	$.ajax({
		url:restfulURL+"/"+serviceName+"/session",
		type:"DELETE",
		dataType:"json",
		headers:{Authorization:"Bearer "+tokenID.token},
		success:function(data){
			if(data['status']=="200"){
				window.location.href = "../login.html"; 
				sessionStorage.setItem("tokenID","{}");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    if('error'==textStatus){
		    	window.location.href = "../login.html"; 
		    }
		}
	});
}

$("#logOut").click(function(){
	logoutFn();
});
 
/*ajax */
function getAjax(url,type,data,callback){
	if(checkSession(JSON.stringify(tokenID))){
		$.ajax({
			url:url,
			type : type,
			dataType : "json",
			data : data,
			async:false,
			headers:{Authorization:"Bearer "+tokenID.token},
			success : function(data,status) {
				if(status == 'success'){
					callback(data);
				}else{
					callFlashSlide(status,'error');
				}
			}
		});
	}
}

/*clear field in modal*/
function clearModal(){
	$(".modal input[type='text'],.modal select,.modal textarea").val('');
	$('.modal select').val('');
	$(".modal input[type='radio'],.modal input[type='checkbox']").prop('checked', false);
}

/*get pagenation*/
function getPagenation(target,data){
	$prev_dis = data.prev_page_url?'':'disabled' ;
	$next_dis = data.next_page_url?'':'disabled';
	$next = data.current_page+1 <= data.last_page?data.current_page+1:'';
	$html = '<li data-lp="1" class="first '+$prev_dis+'">'
		+'<a href="javascript:void(0);"><<</a> </li>'
		+'<li data-lp="1" class="prev '+$prev_dis+'"> <a href="javascript:void(0);">prev</a></li>';
		for($i=1;$i<=data.last_page;$i++){
			$active = data.current_page == $i ? "active":"";
			$html+='<li data-lp="'+$i+'" class="'+$active+'"><a href="javascript:void(0);">'+$i+'</a></li>';
		}
	$html+= '<li data-lp="'+$next+'" class="next '+$next_dis+'" ><a href="javascript:void(0);">next</a></li>'
		+'<li data-lp="'+data.last_page+'" class="last '+$next_dis+'"><a href="javascript:void(0);">>></a></li>';
	$(target).html($html);
}

function formatDateYMD(input) {
	if(input == "") {
		return null;
	} else {
	    var datePart = input.match(/\d+/g);
	    var day = datePart[0];
	    var month = datePart[1];
	    var year = datePart[2];
	    return year + '-' + month + '-' + day;
	}
}

function formatDateDMY(input) {
    var datePart = input.split("-");
    var day = datePart[2];
    var month = datePart[1];
    var year = datePart[0];
    return day + '-' + month + '-' + year;
}

var paginationSetUpFn = function(pageIndex,pageButton,pageTotal){
	
	if(pageTotal==0){
		pageTotal=1
	}
	$('.pagination_top,.pagination_bottom').off("page");
	$('.pagination_top,.pagination_bottom').bootpag({
	    total: pageTotal,//page Total
	    page: pageIndex,//page index
	    maxVisible: 5,//จำนวนปุ่ม
	    leaps: true,
	    firstLastUse: true,
	    first: '←',
	    last: '→',
	    wrapClass: 'pagination',
	    activeClass: 'active',
	    disabledClass: 'disabled',
	    nextClass: 'next',
	    prevClass: 'prev',
	    next: 'next',
	    prev: 'prev',
	    lastClass: 'last',
	    firstClass: 'first'
	}).on("page", function(event, num){
		var rpp=10;
		if($("#rpp").val()==undefined){
			rpp=10;
		}else{
			rpp=$("#rpp").val();
		}
		
		getData(num,rpp);
		
	    $(".pagingNumber").remove();
	    var htmlPageNumber= "<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='"+num+"'>";
	    $("body").append(htmlPageNumber);
	   
	}); 

	$(".countPagination").off("change");
	$(".countPagination").on("change",function(){

		$("#countPaginationTop").val($(this).val());
		$("#countPaginationBottom").val($(this).val());
		
		getData(1,$(this).val());
		
		$(".rpp").remove();
		$(".pagingNumber").remove();
		var htmlRrp="";
			htmlRrp+= "<input type='hidden' id='rpp' name='rpp' class='rpp' value='"+$(this).val()+"'>";
	        htmlRrp+="<input type='hidden' id='pageNumber' name='pageNumber' class='pagingNumber' value='1'>";
	    $("body").append(htmlRrp);
	});
}
</script>

<script>
$(document).ready(function() {
	 var username = $('#user_portlet').val();
	 var password = $('#pass_portlet').val();
	 var plid = $('#plid_portlet').val();
	 if(username!="" && username!=null & username!=[] && username!=undefined ) {
		 if(connectionServiceFn(username,password,plid)==true) {
			 
			var swapFN = function(input) {
				if(input==$("#time").attr('id')) {
					$("#start_date").attr('readonly',true);
					$("#end_date").attr('readonly',true);
					$("#time").attr('readonly',false);
				} else {
					 $("#start_date").attr('readonly',false);
					$("#end_date").attr('readonly',false);
					$("#time").attr('readonly',true);
				}
			}
			 
			$('.datepicker').datepicker({
				format: 'dd/mm/yyyy',
				todayBtn: true,
	            language: 'th',            
	            thaiyear: true              
	        }).datepicker("setDate", "0").keydown(function(e){e.preventDefault();});
	 		
	 		$("#btn_search").click(function() {
	 			var parameter = {
	 				time: $("#time").val(),
	 				writer: $("#writer").val(),
	 				start_date: $("#start_date").val(),
	 				end_date: $("#end_date").val()
	 			}
	 			
	 			var data = JSON.stringify(parameter);
	 			var url_report_jasper = "www.google.com";
	 			
	 			$('#iFrame_report').attr('src',url_report_jasper);
	 		});
	 		
	 		$("#time").click(function(){swapFN(this.id)});
	 		$("#start_date").click(function(){swapFN(this.id)});
	 		$("#end_date").click(function(){swapFN(this.id)});
	 		
	 		$("#time").click();
		}
	}
});
</script>