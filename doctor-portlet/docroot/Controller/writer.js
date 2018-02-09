	// All function
	
	function formatDateInput(input) {
        var datePart = input.match(/\d+/g);
        var day = datePart[0];
        var month = datePart[1];
        var year = datePart[2];
        return year + '-' + month + '-' + day;
    }
	
	function SetupDataDropDown() {
		DropDownArticleType();
		DropDownProcedure();
		DropDownByStep();
		DropDownToStep();
	}
	
	function SearchAdvance() {
		var article_ID = $("#search_article").val().split("-");
		article_ID = (article_ID == '') ? '' : article_ID[0];
		
		var doctor_id = $("#search_doctor").val().split("-");
		doctor_id = (doctor_id == '') ? '' : doctor_id[0];
		
		var procedure_id = $("#search_procedure").val();
		var writing_start_date = formatDateInput($("#search_start_date").val());
		var writing_end_date = formatDateInput($("#search_end_date").val());
		
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/writer/search_writer",
			type:"get",
			dataType:"json",
			async:false,
			headers:{Authorization:"Bearer "+tokenID.token},
			data:{
				"article_ID":article_ID,
				"procedure_id":procedure_id,
				"doctor_id":doctor_id,
				"writing_start_date":writing_start_date,
				"writing_end_date":writing_end_date
			},
			success:function(data) {
				console.log(data);
				var TRTDHTML;
				var TRTDClass = "style=\"vertical-align: middle;\"";
				$.each(data, function (key,value) {
					TRTDHTML += 
		                '<tr>'+
		                '<td "'+TRTDClass+'">' + value.article_name +'</td>'+
		                '<td "'+TRTDClass+'">' + value.writer +'</td>'+
		                '<td "'+TRTDClass+'">' + value.procedure_name +'</td>'+
		                '<td "'+TRTDClass+'">' + value.doctor_name +'</td>'+
		                '<td "'+TRTDClass+'">' + value.writing_start_date +'</td>'+
		                '<td "'+TRTDClass+'">' + value.writing_end_date +'</td>'+
		                '<td "'+TRTDClass+'">' + value.plan_date +'</td>'+
		                '<td "'+TRTDClass+'">' + value.article_type_name +'</td>'+
		                '<td "'+TRTDClass+'">' + value.status +'</td>'+
		                '<td "'+TRTDClass+'"></td>'+
		                '</tr>';
		    	});
				$('#result_search_writer').html(TRTDHTML);
			}
		});
	};
	
	function InsertWriter() {
		console.log("InsertWriter")
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/appraisal_assignment",
			type:"get",
			dataType:"json",
			async:false,
			headers:{Authorization:"Bearer "+tokenID.token},
			data:{ 
				"article_name":$("#article").val(),
				"article_type_id":$("#article_type").val(),
				"procedure_id":$("#procedure_name").val(),
				"doctor_id":$("#doctor").val(),
				"writer":$("#author").val(),
				"":$("#start_date").val(),
				"":$("#end_date").val(),
				"":$("#by_step").val(),
				"":$("#to_step").val(),
				"":$("#send_to").val(),
				"":$("#complete_date").val(),
				"":$("#deadline_date").val(),
				"":$("#").val(),
				"":$("#article").val()
			},
			success:function(data){
				
				callFlashSlide('Insert Success!','success')
				$("#ModalWriter").modal('hide');
			}
		})
	};
	
	function GetDataEdit() {
		console.log("GetDataEdit")
		$.ajax({
			//url:restfulURL+"/"+serviceName+"/public/appraisal_assignment",
			type:"get",
			dataType:"json",
			async:false,
			headers:{Authorization:"Bearer "+tokenID.token},
			data:{"data_edit":""},
			success:function(data){
				console.log(data);
			}
		})
	};
	
	function UpdateWriter() {
		console.log("UpdateWriter")
		$.ajax({
			//url:restfulURL+"/"+serviceName+"/public/appraisal_assignment",
			type:"get",
			dataType:"json",
			async:false,
			headers:{Authorization:"Bearer "+tokenID.token},
			data:{"data_edit":""},
			success:function(data){
				console.log(data);
			}
		})
	};
	
	function DropDownSearchProcedure() {
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/writer/list_medical_procedure",
			type:"get",
			dataType:"json",
			async:false,
			//data:{"emp_code":session_emp_code},
			headers:{Authorization:"Bearer "+tokenID.token},
			success:function(data){
				var htmlOption="<option value=\"\">ทั้งหมด</option>";
				$.each(data,function(index,indexEntry){
					htmlOption+="<option value="+indexEntry['procedure_id']+">"+indexEntry['procedure_name']+"</option>";
				});
				$("#search_procedure").html(htmlOption);
			}
		});
	}
	
	function DropDownProcedure() {
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/doctor_profile/list_medical_procedure",
			type:"get",
			dataType:"json",
			async:false,
			//data:{"emp_code":session_emp_code},
			headers:{Authorization:"Bearer "+tokenID.token},
			success:function(data){
				var htmlOption="";
				$.each(data,function(index,indexEntry){
					htmlOption+="<option value="+indexEntry['procedure_id']+">"+indexEntry['procedure_name']+"</option>";
				});
				$("#procedure_name").html(htmlOption);
			}
		});
	}
	
	function DropDownArticleType() {
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/writer/list_article_type",
			type:"get",
			dataType:"json",
			async:false,
			//data:{"emp_code":session_emp_code},
			headers:{Authorization:"Bearer "+tokenID.token},
			success:function(data){
				var htmlOption="";
				$.each(data,function(index,indexEntry){
					htmlOption+="<option value="+indexEntry['article_type_id']+">"+indexEntry['article_type_name']+"</option>";
				});
				$("#article_type").html(htmlOption);
			}
		});
	}
	
	function DropDownByStep() {
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/doctor_profile/list_medical_procedure",
			type:"get",
			dataType:"json",
			async:false,
			//data:{"emp_code":session_emp_code},
			headers:{Authorization:"Bearer "+tokenID.token},
			success:function(data){
				var htmlOption="";
				$.each(data,function(index,indexEntry){
					htmlOption+="<option value="+indexEntry['procedure_id']+">"+indexEntry['procedure_name']+"</option>";
				});
				$("#by_step").html(htmlOption);
			}
		});
	}
	
	function DropDownToStep() {
		$.ajax({
			url:restfulURL+"/"+serviceName+"/public/doctor_profile/list_medical_procedure",
			type:"get",
			dataType:"json",
			async:false,
			//data:{"emp_code":session_emp_code},
			headers:{Authorization:"Bearer "+tokenID.token},
			success:function(data){
				var htmlOption="";
				$.each(data,function(index,indexEntry){
					htmlOption+="<option value="+indexEntry['procedure_id']+">"+indexEntry['procedure_name']+"</option>";
				});
				$("#to_step").html(htmlOption);
			}
		});
	}
	
	
	//Autocomeplete
	$("#search_article").autocomplete({
		source: function (request, response) {
        	$.ajax({
				 url:restfulURL+"/"+serviceName+"/public/writer/list_article",
				 type:"get",
				 dataType:"json",
				 headers:{Authorization:"Bearer "+tokenID.token},
				 //data:{"emp_name":request.term},
				 data:{"article_name":request.term},
				 //async:false,
                 error: function (xhr, textStatus, errorThrown) {
                        console.log('Error: ' + xhr.responseText);
                    },
				 success:function(data){
						response($.map(data, function (item) {
                            return {
                                label: item.article_ID+"-"+item.article_name,
                                value: item.article_ID+"-"+item.article_name,
                            };
                        }));
				},
				beforeSend:function(){
					$("body").mLoading('hide');	
				}
				
			});
        }
    });
	
	$("#search_doctor").autocomplete({
		source: function (request, response) {
        	$.ajax({
				 url:restfulURL+"/"+serviceName+"/public/writer/list_doctor_article",
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
	
	$("#doctor").autocomplete({
		source: function (request, response) {
        	$.ajax({
				 url:restfulURL+"/"+serviceName+"/public/writer/list_doctor",
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
	
	//Set Data
	var InsertUpdateForCheck = "";

	DropDownSearchProcedure();
	
	$('#alert_multi').multiselect({
        allSelectedText: 'No option left ...',
        maxHeight: 200,
        onChange: function() {
            console.log($('#alert_multi').val());
        }
    });
	
	$('.dropify').dropify();
	
	$("#search_start_date,#search_end_date,#start_date,#end_date,#complete_date,#deadline_date").datepicker({
		dateFormat: 'dd/mm/yy'
	});
	
	$("#btn_search").click(function(){
		if($("#search_start_date").val()=='') {
			$("#search_start_date").focus();
			callFlashSlide('โปรดระบุจากวันที่!','warning')
		}else if($("#search_end_date").val()=='') {
			$("#search_end_date").focus();
			callFlashSlide('โปรดระบุถึงวันที่!','warning')
		} else {
			SearchAdvance();
		}
	});
	
	$("#btn_add").click(function(){
		InsertUpdateForCheck = "insert";
		SetupDataDropDown();
	});
	
	$("#btn_result_upload").click(function () {
		console.log("result_upload")
	});
	
	$("#btn_result_download").click(function () {
		console.log("search_download")
	});
	
	$("#btn_result_edit").click(function () {
		InsertUpdateForCheck = "update";
		SetupDataDropDown();
		GetDataEdit();
	});
	
	$("#btn_modal_submit").click(function() {
		if(InsertUpdateForCheck=="insert") {
			InsertWriter();
		} else {
			UpdateWriter();
		}
	});
	
	//FILE IMPORT MOBILE START
	$("#btn_result_upload").click(function () {
		$('#file').val("");
//		$(".btnModalClose").click();
//		$(".dropify-clear").click();
	});
	
	// Variable to store your files
	var files;
	// Add events
	$('#file').on('change', prepareUpload2);

	// Grab the files and set them to our variable
	function prepareUpload2(event)
	{
	  files = event.target.files;
	};
	$('form#fileUploadWriter').on('submit', uploadFiles);

	// Catch the form submit and upload the files
	function uploadFiles(event)
	{
		
		event.stopPropagation(); // Stop stuff happening
		event.preventDefault(); // Totally stop stuff happening

		// START A LOADING SPINNER HERE

		// Create a formdata object and add the files
		console.log(files,'files')
		var data = new FormData();
		$.each(files, function(key, value)
		{
			console.log(value)
			data.append(key, value);
		});
		
		$("body").mLoading();
		$.ajax({
			url:"",
			type: 'POST',
			data: data,
			cache: false,
			dataType: 'json',
			processData: false, // Don't process the files
			contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			headers:{Authorization:"Bearer "+tokenID.token},
			success: function(data, textStatus, jqXHR)
			{
				
				console.log(data);
				if(data['status']==200 && data['errors'].length==0){
							
					callFlashSlide("Import Assignment Successfully");
					//getDataFn();
					$("body").mLoading('hide');
					$('#file').val("");
					$('#ModalImport').modal('hide');
					
				}else{
					listErrorFn(data['errors']);
					//getDataFn();
					$("body").mLoading('hide');
				}
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				// Handle errors here
				callFlashSlide('Format Error : ' + textStatus);
				// STOP LOADING SPINNER
			}
		});
		return false;
	};