<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="게시글 작성" name="title"/>
</jsp:include>

<html>
<head>
	<title>게시글 작성</title>
	<style>
	     	
	.boardHead{
			border: 1px solid lightgrey;
			border-radius: 5px 5px;
		    padding-left: 10px;
        	width : 80px;
        	height: 40px;
        	vertical-align: middle;
	}
	.boardHead:focus{
			  outline: 1px solid lightgrey;
			  border-radius: 5px 5px;
			  padding-left: 10px;
	}
	
	.boardTitle{
			border: 1px solid lightgrey;
			border-radius: 5px 5px;
			padding-left: 10px;
		    width : 1100px;
        	height: 40px;
        	vertical-align: middle;
	}
	
	.boardTitle:focus{
		outline: 1px solid lightgrey;
	    border-radius: 5px 5px;
	    padding-left: 10px;
	}
	.boardContent{
		border: 1px solid lightgrey;
		border-radius: 5px 5px;
		padding-left: 10px;
		width:1185px; 
		height:350px; 
		padding : 10px;
	    resize:none;/* 크기고정 */ 
	}
	
	.boardContent:focus{
	 	outline: 1px solid lightgrey;
		border-radius: 5px 5px;
		padding-left: 10px;	
		padding-bottom : 10px;
	}
	
	 #write-btn{
        	width : 100px;
        	height : 30px;
	        border: none;
		    border-radius: 5px 5px;
		    background-color: rgb(52, 152, 219);
        	color : white;
        }
	
	
	</style>
</head>

<body>
	<div class="container-1200">
			<div>
				<select class="boardHead" name="boardHead" required>
					<option value="정보">정보</option>
					<option value="일상">일상</option>
					<option value="이슈">이슈</option>
					<option value="질문">질문</option>
				</select>
				
				<input class="boardTitle input" type="text" placeholder="제목을 입력하세요" name="boardTitle" autocomplete="off" required>
			</div>
			<div class="mt-10 mb-10">
				<textarea class="boardContent" name="boardContent" required></textarea>
			</div>
			<div>
				<input type="file" class="file" name="attachments" multiple>
				<hr>
				<div class="file-list"></div>
			</div>
			<div class="row right">
				<button type="button" id="write-btn">등록</button>
			</div>
	</div>


<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
			var fileInput =  $('.file');
			
			//파일 창을 클릭했을 때
			$(fileInput).click(function(e){
				if(fileInput[0].files[0]!=null){
					if(confirm("이미 파일이 선택되었습니다. 새로 선택 시 기존 파일은 초기화됩니다.")){
						$(fileInput).change(function(){
							newFileAdd();				
						})
					}
					else{
						return false;
					}
				}
				
				else{
					$(fileInput).change(function(){
						newFileAdd();				
					});
				}
			});
			
			function newFileAdd(){
				$(".file-list").html('');
				if(fileInput[0].files[0]!=null){
					//fileInput 개수를 구한다
					for(var i=0; i<fileInput.length; i++){
						if(fileInput[i].files.length>0){			
							var $fileX = $('<i class="fa-solid fa-trash new-file-x"></i>');
							var $span = $("<span>");
							
								$(".file-list").text("[업로드 파일]");
								$(".file-list").append($span);
								$($span).append($fileX);
							for(var j=0; j<fileInput[i].files.length; j++){
															
								var $fileNameDiv = $('<div>'); 
								var $span = $("<span>");
								var $i = $('<i class="fa-solid fa-file-arrow-up"></i>');
								
								$(".file-list").append($fileNameDiv);
								$($fileNameDiv).addClass("name-div");
								$fileNameDiv.append($i);
								$fileNameDiv.append($span);
								$span.text($('.file')[i].files[j].name);		
							}
						}
					}			
	 			}
			};
			
			//새로운 파일 x버튼 클릭시
			$(".file-list").on("click", ".new-file-x", function(e){
					$span = $(this).parent();
					$nameDiv = $($span).parent();
					$($nameDiv).html('');
					$(fileInput).val("");
			});
			

				
		$("#write-btn").click(function(e){
			e.preventDefault();
			if(validForm()){
				write();				
			}
		});
		
	    function validForm(){
	        var boardTitle = $("input[name=boardTitle]").val();
	        var boardContent = $("textarea[name=boardContent]").val();
	        
	        if(boardTitle.trim() === ""){
	            alert("제목을 입력하세요.");
	            return false;
	        }
	        
	        if(boardContent.trim() === ""){
	            alert("내용을 입력하세요.");
	            return false;
	        }
	        
	        return true; // 폼이 유효한 경우
	    }
		
		function write(){
			//FormData 객체 생성(글(JSON)+file 함께 보내기위한 객체)
			var formData = new FormData();
					
			var boardHead = $("select[name=boardHead]").val();
			var boardTitle = $("input[name=boardTitle]").val();
			var boardContent = $("textarea[name=boardContent]").val();
			
			var data = {
					boardHead:boardHead,
					boardTitle:boardTitle,
					boardContent:boardContent
			}
			
			//formData에 'board'라는 키 값으로 JSON 형식으로 data첨부
			formData.append("board", new Blob([JSON.stringify(data)],{type:"application/json"}));
			
			var fileInput =  $('.file');
			
			//파일이 있다면
 			if(fileInput[0].files[0]!=null){
				//fileInput 개수를 구한다
				for(var i=0; i<fileInput.length; i++){
					if(fileInput[i].files.length>0){
						for(var j=0; j<fileInput[i].files.length; j++){
						
							// formData에 'file'이라는 키값으로 fileInput 값을 append 시킨다.  
							formData.append('file', $('.file')[i].files[j]);
						}
					}
				}			
 			}
 			
			$.ajax({
				url:"/rest/board",
				method:"post",
				data:formData,
			    contentType: false, //contentType : false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
			    processData: false, //rocessData : false로 선언 시 formData를 string으로 변환하지 않음
			    cache: false,
			    enctype: "multipart/form-data",
			    dataType: "json",
				success:function(resp){
					location.href="/rest/board/"+resp;
				}
			});
		}
	});
	

</script>
</body>
</html>