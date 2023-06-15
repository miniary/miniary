<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="게시글 상세" name="title"/>
</jsp:include>

<html>
<head>
	<title>게시글 상세</title>

	<style>
		a {
			text-decoration: none;
			color: black;
		}
		.button-list{
			position: relative;
		    bottom: 20px;
		    right: 10px;
		}

		.title-box{
			border:1px solid;
			border-color: lightgrey;
		}
		button{
		    background-color: transparent !important;
        	border-color: transparent;	
		}
		
		.preview{
			width: 50px;
		    height: 50px; 
			border-radius:50% ;
			overflow: hidden;
			vertical-align: middle;
		}
		
		.time{
			position: relative;
 		    bottom: 40px; 
 		    right: 10;
 		    margin-bottom : -10px;
		}
		
		.content-box{
			border:1px solid;
			border-color: lightgrey;
			margin-top: 5px;
		}
		
		.content{
			border: none;
			border-color : lightgray;
			padding: 10px;
			width:1199px; 
			height:400px; 
			resize:none;
		}
		
		.content:focus {
			outline: none;
		}
		
		hr{
			width : 1180px;
		}
		
		#reply-list {
			margin : 10px;
		}
		
		#reply-list > div {
			margin-bottom : 7px;
		}
		
		#reply-list > div > div{
			left : 2px;
			margin : 5px;	
		}
		#replyContent{
			margin : 10px;
			margin-left: 15px;
			width : 1000px;
			border : 1px solid;
			border-color : lightgrey;
		}
		#replyContent:focus {
			outline : 0;
		}
		
		.file-list{
			margin-left : 15px;
		}
		

	</style>
</head>

<body>
	<span hidden class="boardNo">${boardNo}</span>	
	<div class="container-1200">
		<div class="title-box">	
			<div class="ms-10 mt-10">[${boardVO.boardHead}]&emsp;${boardVO.boardTitle} </div>
			<div class="button-list right">
				<!-- 본인 글일 때만 수정/삭제 버튼 노출 -->
				<c:if test="${loginNick == boardVO.memNick}">
					<button class="edit-btn">수정</button>
					<button class="delete-btn">삭제</button>
				</c:if>	
					<a href="/rest/board"><button class="list-btn">목록</button></a>
			</div>
			
			<div class="ms-10">
				<c:choose>
					<c:when test="${empty profile}">
						<img class="preview" name="basic" src="/img/basic.png">
					</c:when>
					<c:otherwise>
					<c:forEach var="profile" items="${profile}">
						<img class="preview" src="/rest/board/file/${profile.attachNo}" >
					</c:forEach>
					</c:otherwise>
				</c:choose>				
				${boardVO.memNick}
			</div>
			<div class="time right">${boardVO.boardWriteTime} 조회 ${boardVO.boardRead} 댓글 ${boardVO.replyCount}</div>
		</div>
		<div class="content-box">
			<textarea readonly="readonly" class="content" style="white-space:pre-wrap;">${boardVO.boardContent}</textarea>
			
			<c:if test="${not empty attachDto}">
				<hr>
				<c:forEach var="attachDto" items="${attachDto}">			
					<div class="file-list"><i class="fa-solid fa-file-arrow-down"></i> <a href="/rest/board/file/${attachDto.attachNo}">${attachDto.attachName}</a></div>
				</c:forEach>
			</c:if>
			<hr>
			<div class="mt-10" id="reply-list">
			</div>
			<div>
				<input type="text" id = "replyContent" name="replyContent" autocomplete="off">
				<button class="reply-btn">댓글 등록</button>
			</div>	
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		var boardNo = ($(".boardNo").text());
		replyList();//댓글 목록 출력
		
		
		//글 수정 페이지로 연결
		$(".edit-btn").click(function(){
			$.ajax({
				url : "change/"+boardNo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ,
				method : "get",
				success:function(resp){
					location.href="/rest/board/change/"+boardNo
				}
			});
		});
		
		//글 삭제
		$(".delete-btn").click(function(){
			$.ajax({
				url : "/rest/board/"+boardNo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ,
				method : "delete",
				success:function(resp){
					alert("글이 삭제되었습니다. 목록으로 이동합니다.");
					location.href="/rest/board/";
				}
			});
		});
		
		//댓글 목록
		var reply = [];			 
		function replyList(){	
				
			$.ajax({
				url:"/rest/reply/"+boardNo,
				method:"get",
				success:function(resp){
					reply = resp;			
		
				var div = "<div>";
				var button = "<button>";
				$("#reply-list").html('');
						var $icon = $('<i class="fa-solid fa-comments"></i>');
						var $replyCount = $("<div>");
						var $span = $("<span>");
						
						$("#reply-list").append($replyCount);
						$($replyCount).append($icon);
						$($replyCount).append($span);
						$($span).text(" 댓글 "+resp.length);
						
					for(var i=0; i < reply.length; i++){
						var $reply = $("<div>");
						var $replyNo = $("<div>").text(reply[i].replyNo).hide();
						var $memNick = $("<div>").text(reply[i].memNick);
						$($memNick).css("font-weight", "bold")
						var $replyContent = $("<div>").text(reply[i].replyContent);
						var $replyWritetime = $("<div>");
						
						$($replyWritetime).text(reply[i].replyWritetime);
						$($replyWritetime).css("font-size", "12px");
						
						var $deleteBtn = $("<button>삭제</button>")
						var $editBtn = $("<button>수정</button>")
						
						//세션에 있는 로그인 닉네임
						var $loginNick = '<%=(String)session.getAttribute("loginNick")%>';
															
						$("#reply-list").append($reply);
						$reply.addClass("reply"+[i]);
						$($reply).append($replyNo);
						$replyNo.addClass("replyNo");
						
						$($reply).append($memNick);
						$memNick.addClass("memNick");
						$($reply).append($replyContent);
						$replyContent.addClass("replyContent");
						$($reply).append($replyWritetime);
						
						//본인 댓글이면 수정/삭제 버튼 생성
						if($loginNick == $memNick.text()){
							$($replyWritetime).append($editBtn);
							$($replyWritetime).append($deleteBtn);
							$editBtn.addClass("reply-edit-btn");
							$deleteBtn.addClass("reply-delete-btn");		
						}
						
					}

						//댓글 수정
						$(".reply-edit-btn").click(function(){
							var reply = $(this).parent();
							var replyDiv = reply.parent();
							
							//댓글 내용 숨긴다.
							$(replyDiv).children().hide();
							
							//수정 div 추가
							var replyEditDiv = $("<div>");
							replyDiv.append(replyEditDiv);
							
							//수정 div에 닉네임 div 추가
							var replyMemNick = $("<div>");							
							$(replyEditDiv).append(replyMemNick);
							$(replyMemNick).addClass("replyMemNick");
							
							//수정 input 추가
							var replyInput = $("<input>");
							$(replyEditDiv).append(replyInput);
							$(replyInput).css("border-color","1px solid lightgrey");
							$(replyInput).css("width","1000px");
							
							$(replyInput).focus(function() {
							    $(this).css("outline", "0px");
							});
							
							$(replyInput).blur(function() {
							    $(this).css("border", "1px solid lightgrey");
							});
							
							
							//댓글 내용
							var replyContent = $(replyDiv).children(".replyContent");
							$replyContent.addClass("edit-reply-content");
							replyInput.attr('value', replyContent.text());
							
							var editReplyNo = $(this).parent().children(".replyNo").text();
							$(editReplyNo).addClass("edit-reply-no");
							
							var memNick = $(replyDiv).children(".memNick");							
							$memNick.addClass("edit-mem-nick");
							replyMemNick.text($(".edit-mem-nick").text());
							
							//버튼
							var replyeditBtn2 = $("<button>");
							$(replyEditDiv).append(replyeditBtn2);
							replyeditBtn2.addClass("reply-edit-btn2");
							replyeditBtn2.text("수정");
							
							//댓글 수정
								$(".reply-edit-btn2").click(function(){
									var replyContent = replyInput.val();
									var time = $(this).parent();
									var reply = $(time).parent();
									var replyNoDiv = $(reply).children(".replyNo");
									var replyNo = $(replyNoDiv).text();
									var data = {
											replyContent : replyContent,
											replyNo : replyNo
										};					
									replyEdit(data);
								});
							});
						
		
			function replyEdit(data){
				$.ajax({
					url:"/rest/reply",
					method:"put",
					contentType:"application/json",
					data:JSON.stringify(data),
					success:function(resp){
						replyList();
					}
				});	
			}
						
		//댓글 삭제
		$(".reply-delete-btn").click(function(){
			var reply = $(this).parent();
			var replyDiv = reply.parent();
			var replyNo = (replyDiv.children(".replyNo").text());
				replyDelete(replyNo);
					});
						
				}		
			})
		};				
		
		
		//댓글 삭제
		function replyDelete(replyNo){
				$.ajax({
					url : "/rest/reply/"+replyNo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ,
					method : "delete",
					success:function(resp){
						replyList();
					}
				});	
			}
		
		//댓글 등록
		$(".reply-btn").click(function(){				
			var replyContent = $("[name=replyContent]").val();
			var data = {
					boardNo : boardNo,
					replyContent : replyContent
				}	
			
			replyInsert(data);
			
			//댓글 창 비움
			$("[name=replyContent]").val('');
			

		});
			
		//댓글 등록
		function replyInsert(data){				
				$.ajax({
					url:"/rest/reply",
					method:"post",
					contentType:"application/json",
					data:JSON.stringify(data),
					success:function(resp){
						replyList();
					}
				});
			 }
		
	
	
	
	});	

</script>
</body>
</html>