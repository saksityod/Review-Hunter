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


$( document ).ajaxStart(function() {
	$("body").mLoading();
});
$( document ).ajaxStop(function() {
	$("body").mLoading('hide');
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
			console.log(data)
			if(data.status == "200"){
				$chk = true;
				userId = data.userID;
				screenName = data.screenName;
				roles = data.roles;
				
			}else{
				callFlashSlide("login failed."); 
				sessionStorage.clear();
				$chk = false;
				$("#content").html("");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    if('error'==textStatus){
		    	callFlashSlide("login failed."); 
		    	console.log("Error is "+textStatus);
		    	$chk = false;
		    	$("#content").html("");
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
			 $("#content").html("");
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
	//if(checkSession(JSON.stringify(tokenID))){
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
	//}
}

/*clear field in modal*/
function clearModal(){
	$(".modal input[type='text'],.modal select,.modal textarea").val('');
	$('.modal select').val('');
	$(".modal input[type='radio'],.modal input[type='checkbox']").prop('checked', false);
}

/*get pagenation*/
function getPagenation(target,data){
	$prev_dis = data.prev_page_url?'':'disabled';
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
	if(input == "" || input == undefined || input == null) {
		return null;
	} else {
	    var datePart = input.match(/\d+/g);
	    var day = datePart[0];
	    var month = datePart[1];
	    var year = datePart[2];
	    year -= 543;
	    return year + '-' + month + '-' + day;
	}
}

function formatDateDMY(input) {
	if(input == "" || input == undefined || input == null) {
		return null;
	} else {
	    var datePart = input.split("-");
	    var day = datePart[2];
	    var month = datePart[1];
	    var year = Number(datePart[0]);

		year += 543;
	    return day + '/' + month + '/' + year;
	}
}

function validatetor(data) {
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

function validatetorInformationUpdate(data) {
	$("#information_errors_update").show();
	$("#information_errors_update").html(data);
}

function getDateNow() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!

	var yyyy = today.getFullYear();
	yyyy += 543;
	if(dd<10){
	    dd='0'+dd;
	} 
	if(mm<10){
	    mm='0'+mm;
	} 
	var today = dd+'/'+mm+'/'+yyyy;
	return today;
}