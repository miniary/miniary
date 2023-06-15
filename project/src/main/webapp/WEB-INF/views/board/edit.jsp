<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="게시글 수정" name="title"/>
</jsp:include>

<html>
<head>
	<title>게시글 수정</title>
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
	
	 #edit-btn{
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
		<span class="boardNo" hidden>${boardVO.boardNo}</span>
			<div>
				<select class="boardHead" name="boardHead">
					<!-- 말머리 고정을 위해 if 처리 -->
					<option <c:if test="${boardVO.boardHead=='정보'}">selected</c:if> value="정보">정보</option>
					<option <c:if test="${boardVO.boardHead=='일상'}">selected</c:if> value="일상">일상</option>
					<option <c:if test="${boardVO.boardHead=='이슈'}">selected</c:if> value="이슈">이슈</option>
					<option <c:if test="${boardVO.boardHead=='질문'}">selected</c:if> value="질문">질문</option>
				</select>
				
				<input class="boardTitle" type="text" name="boardTitle" value="${boardVO.boardTitle}" autocomplete="off">
			</div>
			<div class="mt-10 mb-10">
				<textarea class="boardContent" name="boardContent">${boardVO.boardContent}</textarea>
			</div>
			<div>
				<input type="file" class="file" name="attachments" multiple>
				<hr>
				<div class="file-list">
					<c:forEach var="fileList" items="${attachDto}">
						<div class="name-div">${fileList.attachName}<span hidden class="origin-file-no">${fileList.attachNo}</span><i class="fa-solid fa-trash file-x"></i></div>
					</c:forEach>
				</div>
			</div>
			<div class="row right">
				<button type="button" id="edit-btn">수정</button>
			</div>
<!-- 		</form> -->
	</div>


<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		
		var boardHead = $(".boardHead").text();
		var boardNo = $(".boardNo").text();
		var originAttachNo = []
		
		
		//파일 x버튼 클릭 시
		$(".file-x").click(function(e){
			
			$nameDiv = $(this).parent();
			
			$originDiv = $($nameDiv).children(".origin-file-no");
			
			$originNo = $($originDiv).text();
			$($nameDiv).html('');
			
			originAttachNo.push($originNo);
		});
		
				
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
			
			function newFileAdd(){				
				if(fileInput[0].files[0]!=null){
					$(".new-file-div").remove();
					//fileInput 개수를 구한다
					for(var i=0; i<fileInput.length; i++){
								var $newFileDiv = $('<div>'); 
								var $span = $("<span>");
								var $fileX = $('<i class="fa-solid fa-trash new-file-x"></i>')
								
								$(".file-list").append($newFileDiv);
								$($newFileDiv).addClass("new-file-div");
								$($newFileDiv).text("[추가 업로드 파일]");
								$($newFileDiv).append($span);
								$($span).append($fileX);
								
						if(fileInput[i].files.length>0){								
							for(var j=0; j<fileInput[i].files.length; j++){
															
								var $fileNameDiv = $('<div>'); 
								var $span = $("<span>");
								var $span2 = $("<span>");
								var $i = $('<i class="fa-solid fa-file-arrow-up"></i>');
								
								$(".new-file-div").append($fileNameDiv);
								$($fileNameDiv).addClass("name-div-new");
								$fileNameDiv.append($span);
								$span.append($i);
								$fileNameDiv.append($span2);
								$span2.text($('.file')[i].files[j].name);		
							}
						}
					}			
	 			}
				else {
	 			      $(".new-file-div").remove();
	 		    }
			}
			
			//새로운 파일 x버튼 클릭시
			$(".file-list").on("click", ".new-file-x", function(e){
					$span = $(this).parent();
					$nameDiv = $($span).parent();
					$($nameDiv).html('');
					$(fileInput).val("");
								
			});
			
		});

		
		//수정 버튼 클릭 시
		$("#edit-btn").click(function(e){
			e.preventDefault();
			if(validForm()){
				editPost();				
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
		
	
		//글 수정
		function editPost(){
			//FormData 객체 생성(글(JSON)+file 함께 보내기위한 객체)
			var formData = new FormData();
			
			var boardHead = $("select[name=boardHead]").val();
			var boardTitle = $("input[name=boardTitle]").val();
			var boardContent = $("textarea[name=boardContent]").val();

			
			var data = {
					boardNo:boardNo,
					boardHead:boardHead,
					boardTitle:boardTitle,
					boardContent:boardContent,
					
				}
						
			//formData에 'board'라는 키 값으로 JSON 형식으로 data첨부
			formData.append("board", new Blob([JSON.stringify(data)],{type:"application/json"}));
			formData.append("originAttachNo", new Blob([JSON.stringify(originAttachNo)],{type:"application/json"}));
			
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
				url:"/rest/board/"+boardNo,
				method:"put",
				data:formData,
			    contentType: false, //contentType : false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
			    processData: false, //rocessData : false로 선언 시 formData를 string으로 변환하지 않음
			    traditional: true,
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