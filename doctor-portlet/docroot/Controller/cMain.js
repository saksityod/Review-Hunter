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
	//set paginate end