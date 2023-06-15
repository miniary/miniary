<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="게시판 목록" name="title"/>
</jsp:include>

<html>
<head>
	<title>게시판 목록</title>

	<style>
	
	     .table > thead > tr > th,
        .table > thead > tr > td,
        .table > tbody > tr > th,
        .table > tbody > tr > td,
        .table > tfoot > tr > th,
        .table > tfoot > tr > td {  
           border : 1px solid lightgray;
        }
        .td{
        	text-align : center
        }

        .type{
        	width : 80px;
        	height: 40px;
        	vertical-align: middle;
        }
        
        .keyword-input{
        	width : 250px;
        	height: 40px;
        	vertical-align: middle;
        }
        .search-btn{
        	background-color: transparent !important;
        	border-color: transparent;
        	height: 40px;
        	position: relative;
   			right: 40px;
        }
        .write-btn{
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
	<div>
		<div>
			<div class="container-1000">
					<!-- 검색창 -->
					<div class="row center">
						<form action="/rest/board" method="get">
						<div>
							<select class="type" name="type">
								<option value="board_title" <c:if test="${page.type=='board_title'}">selected</c:if>>제목</option>
								<option value="board_head" <c:if test="${page.type=='board_head'}">selected</c:if>>유형</option>
								<option value="board_content" <c:if test="${page.type=='board_content'}">selected</c:if>>내용</option>
								<option value="board_writer" <c:if test="${page.type=='board_writer'}">selected</c:if>>작성자</option>
							</select>
							<input class="keyword-input" type="text" name="keyword" placeholder="검색어를 입력하세요" value="${page.keyword}" autocomplete="off" required="required">
							<button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
						</form>
					</div>
					<table class="table" border="1">
						<thead>
						  <tr>
						    <th>글번호</th>
						    <th>유형</th>
						    <th width="45%">제목</th>
						    <th>작성자</th>
						    <th>작성일</th>
						    <th>조회수</th>
						  </tr>
						</thead>
						<tbody class="tbody">
								<c:forEach var="list" items="${boardList}">
							<tr>
								<td align="center">${list.boardNo}</td>
								<td align="center">${list.boardHead}</td>
								<td><a href="/rest/board/${list.boardNo}">${list.boardTitle} <span style="color:rgb(200,0,0);">[${list.replyCount}]</span></a></td>
								<td align="center">${list.memNick}</td>
								<td align="center">${list.boardWriteTime}</td>
								<td align="center">${list.boardRead}</td>
							</tr>
								</c:forEach>
						</tbody>
					</table>
					<div class="row right">
						<a href="/rest/board/post" id="write-btn"><button class="write-btn"><i class="fa-solid fa-pencil"></i> 글 작성</button></a>
					</div>				
				<div class="row center">
					<ul class="pagination">
						<c:choose>
							<c:when test="${not page.isFirst()}">
								<li><a href="board?p=${page.firstBlock()}&${page.parameter()}">처음으로</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#">처음으로</a></li>
							</c:otherwise>
						</c:choose> 
						
						<!-- 이전을 누르면 이전 구간의 마지막 페이지로 안내 -->
						<c:choose>
							<c:when test="${page.hasPrev()}">
								<li><a href="?p=${page.prevBlock()}&${page.parameter()}"><i class="fa-sharp fa-solid fa-arrow-left"></i></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#"><i class="fa-sharp fa-solid fa-arrow-left"></i></a></li>
							</c:otherwise>
						</c:choose>
						
						<c:forEach var = "i" begin="${page.startBlock()}" end="${page.endBlock()}" step="1">
							<c:choose>
								<c:when test="${page.p==i}">
									<li class="on"><a href="#">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="?p=${i}&${page.parameter()}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- 다음을 누르면 다음 구간의 첫 페이지로 안내 -->
						<c:choose>
							<c:when test="${page.hasNext()}">
								<li><a href="?p=${page.nextBlock()}&${page.parameter()}"><i class="fa-sharp fa-solid fa-arrow-right"></i></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#"><i class="fa-sharp fa-solid fa-arrow-right"></i></a></li>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${not page.isLast()}">
								<li><a href="?p=${page.lastBlock()}&${page.parameter()}">끝으로</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#"></a>끝으로</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		loadList();		

		//목록 조회
		var boardList = [];
		function loadList(){		
			$.ajax({
				url:"/rest/board",
				method:"get",
				success:function(resp){
					boardList = resp;	
				}
			});
		};
		
	});
	
	
		
	

</script>
</body>
</html>