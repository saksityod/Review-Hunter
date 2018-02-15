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
				<!-- start table -->
				<div class="row-fluid" style="overflow: auto;">
					<table class="table table-striped" id="table_job_status">
						<thead>
							<tr>
								<th style='width: auto'><strong>ชื่อ Case</strong></th>
								<th style='width: auto'><strong>หัตถการ</strong></th>
								<th style='width: auto'><strong>สถานะงาน</strong></th>
								<th style='width: auto'><strong>ผู้รับผิดชอบ</strong></th>
								<th style='width: auto'><strong>วันครบกำหนด</strong></th>
								<th style='width: auto'><strong>วันที่เสร็จ</strong></th>
								<th style='width: auto'><strong>แพทย์</strong></th>
							</tr>
						</thead>
						<tbody id="list_job_status">
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

</div>
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
var is_hr = [];
$(document).ready(function() {
	$('[data-toggle="tooltip"]').css({	"cursor":"pointer"});
	$('[data-toggle="tooltip"]').tooltip({	html:true	});
	$('[data-toggle="popover"]').popover();   
	$(".app_url_hidden").show();
});

var checkSession = function(paramTokenID){
	var check=true;
	var tokenID =(paramTokenID == undefined || paramTokenID == ""  ? tokenID : paramTokenID);
	tokenID = eval("("+tokenID+")");
	if(tokenID==null){
		alert("login failed");
		callFlashSlide("login failed.");  
		return false;
	}
	$.ajax({
		url:restfulURL+"/"+serviceName+"/session",
		type:"GET",
		dataType:"json",
		//data:{"plid":}
		headers:{Authorization:"Bearer "+tokenID.token},
		async:false,
		success:function(data){
			if(data['status']!="200"){
				check=false;
				callFlashSlide("login failed.");
				sessionStorage.clear();
			}else{
				console.log("login success");
				check=true;
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    if('error'==textStatus){
		    	callFlashSlide("login failed."); 
		    	check=false;
		    	console.log("Error is "+textStatus);
		    	//window.location.href = "../login.html"; 
		    }
		}
		
	});
	return check;
}
 
var connectionServiceFn = function(username,password,plid){
	var checkConnection=true;
	$.ajax({
		
		url:restfulURL+"/"+serviceName+"/session",
		//url:"http://localhost/"+serviceName+"/public/session",
		type:"POST",
		dataType:"text",
		data:{"username":username,"password":password,"plid":plid},
		async:false,
		//data:{"username":"2015019","password":"2015019"},
		error: function(jqXHR, textStatus, errorThrown) {
			 sessionStorage.clear();
			 checkConnection=false;
			setTimeout(function(){
		    	window.location.href = "../login.html"; 
			},500);
		},
		success:function(data){
			sessionStorage.setItem("tokenID",data);
			tokenID= eval("("+ sessionStorage.getItem("tokenID")+")");
			if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
				$(".aui body *").css({'font-weight':400});
			} 
			if(checkSession(data)==true){
				checkConnection=true;
			}
			
		}
	});	
	
	return checkConnection;
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
    var datePart = input.match(/\d+/g);
    var day = datePart[0];
    var month = datePart[1];
    var year = datePart[2];
    return year + '-' + month + '-' + day;
}

function formatDateDMY(input) {
    var datePart = input.split("-");
    var day = datePart[2];
    var month = datePart[1];
    var year = datePart[0];
    return day + '-' + month + '-' + year;
}
</script>

<script>
$(document).ready(function(){
	var username = $('#user_portlet').val();
	var password = $('#pass_portlet').val();
	var plid = $('#plid_portlet').val();
	if(username!="" && username!=null & username!=[] && username!=undefined ){
		 if(connectionServiceFn(username,password,plid)==true){
			 
			 var generateDropDownList = function(url,type,request,initValue){
			 	var html="";
			 	
			 	if(initValue!=undefined){
			 		html+="<option value=''>"+initValue+"</option>";
				}

			 	$.ajax ({
			 		url:url,
			 		type:type ,
			 		dataType:"json" ,
			 		data:request,
			 		headers:{Authorization:"Bearer "+tokenID.token},
			 		async:false,
			 		success:function(data){
			 			try {
			 			    if(Object.keys(data[0])[0] != undefined && Object.keys(data[0])[0] == "item_id"){
			 			    	galbalDataTemp["item_id"] = [];
			 			    	$.each(data,function(index,indexEntry){
			 			    		galbalDataTemp["item_id"].push(indexEntry[Object.keys(indexEntry)[0]]);
			 		 			});	
			 			    }
			 			}
			 			catch(err) {
			 			    console.log(err.message);
			 			}

			 			
			 			$.each(data,function(index,indexEntry){
			 				html+="<option value="+indexEntry[Object.keys(indexEntry)[0]]+">"+indexEntry[Object.keys(indexEntry)[1] == undefined  ?  Object.keys(indexEntry)[0]:Object.keys(indexEntry)[1]]+"</option>";	
			 			});	

			 		}
			 	});	
			 	return html;
			}
			 
			var searchFN = function() {
				var case_id = $("#case_name").val().split("-");
				var job_status = $("#job_status").val();
				var medical_procedure = $("#medical_procedure").val();
				var doctor_id = $("#doctor_name").val().split("-");
				var responsible = $("#responsible").val().split("-");
			
				case_id = case_id[0];
				doctor_id = doctor_id[0];
				responsible = responsible[0];
				
				$.ajax({
					url:restfulURL+"/"+serviceName+"/todo/search",
					type:"get",
					dataType:"json",
					async:false,
					headers:{Authorization:"Bearer "+tokenID.token},
					data:{
						"patient_id":case_id,
						"status":job_status,
						"procedure_id":medical_procedure,
						"doctor_id":doctor_id,
						"user_id":responsible
					},
					success:function(data) {
						console.log(data);
						//list_data_template(data);
					}
				});
			}
			
			$("#btn_search").click(function() {
				searchFN();
			});
			
			var list_data_template = function(data) {
				var TRTDHTML = "";
				var TRTDClass = "style=\"vertical-align: middle;\"";
				$.each(data, function (key,value) {
						TRTDHTML += 
			                '<tr>'+
			                '<td "'+TRTDClass+'">' + value.article_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.writer +'</td>'+
			                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
			                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_start_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + formatDateDMY(value.writing_end_date) +'</td>'+
			                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
			                '</tr>';
			    });
				$('#list_job_status').html(TRTDHTML);
			}
			
			$("#medical_procedure").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/todo/procedure_list",
				"GET"
			));
			
			$("#job_status").html(generateDropDownList(
				restfulURL+"/"+serviceName+"/todo/status_list",
				"GET"
			));
			
			$("#case_name").autocomplete({
					source: function (request, response) {
			        	$.ajax({
							 url:restfulURL+"/"+serviceName+"/todo/auto_patient",
							 type:"get",
							 dataType:"json",
							 headers:{Authorization:"Bearer "+tokenID.token},
							 //data:{"emp_name":request.term},
							 data:{"patient_name":request.term},
							 //async:false,
			                 error: function (xhr, textStatus, errorThrown) {
			                        console.log('Error: ' + xhr.responseText);
			                    },
							 success:function(data){
									response($.map(data, function (item) {
			                            return {
			                                label: item.patient_id+"-"+item.patient_name,
			                                value: item.patient_id+"-"+item.patient_name,
			                            };
			                        }));
							},
							beforeSend:function(){
								$("body").mLoading('hide');	
							}
							
						});
			        }
			});
			
			$("#doctor_name").autocomplete({
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/todo/auto_doctor",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"doctor_name":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                    },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.doctor_id+"-"+item.doctor_name,
		                                value: item.doctor_id+"-"+item.doctor_name,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
						
					});
		        }
			});
			
			$("#responsible").autocomplete({
				source: function (request, response) {
		        	$.ajax({
						 url:restfulURL+"/"+serviceName+"/todo/auto_user",
						 type:"get",
						 dataType:"json",
						 headers:{Authorization:"Bearer "+tokenID.token},
						 //data:{"emp_name":request.term},
						 data:{"pic_name":request.term},
						 //async:false,
		                 error: function (xhr, textStatus, errorThrown) {
		                        console.log('Error: ' + xhr.responseText);
		                 },
						 success:function(data){
								response($.map(data, function (item) {
		                            return {
		                                label: item.userId+"-"+item.pic_name,
		                                value: item.userId+"-"+item.pic_name,
		                            };
		                        }));
						},
						beforeSend:function(){
							$("body").mLoading('hide');	
						}
						
					});
		        }
			});
		 } //end if
	} //end if
}); //end document
</script>

<!-- Mainly scripts -->
<!-- <script type="text/javascript">var jQuery_1_1_3 = $.noConflict(true);</script> -->

