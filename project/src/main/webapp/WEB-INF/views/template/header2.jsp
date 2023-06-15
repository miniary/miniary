<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
	<title></title>

	<style>
		#top_menu {
			float: right;
			position: relative;
			right: 10px;
			top: 15px;
			padding: 5px; /* 두께 */
		}
		#top_menu>a {
			color: black;
			display: inline-block;
			text-align: center;
			text-decoration: none;
		}		
		
		#doran{
			width: 150px;
   			margin-left: 250px;
		}
		
		#my{
			width: 150px;
 	    	margin-left: 250px;
		}
		
		#pw{
			width:150px;
			margin-left: 250px;
		}
		.profile-preview{
			width: 50px;
		    height: 50px; 
			border-radius:50% ;
			overflow: hidden;
			vertical-align: middle;
/* 			border : 1px solid; */
/* 			border : lightgrey; */
		}
		
		.loginNick{
			vertical-align: middle;
		}
		
		.logout{
			width : 30px;
			height : 30px;
			margin-left : 10px;
			vertical-align: middle;
		}
		
		.loginNick{
			font-size: 17px;
		}
		
		a{
        	text-decoration: none;
        	color : black;
        	
        }
	</style>
</head>
<link rel="stylesheet" type="text/css" href="/css/view.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<body>
	<header>
		<div class="mb-20">
			<a href="/rest/board"><img src="/img/logo.png" style="width:200px"></a>
			<div id="top_menu">
				<span class="loginNick">${loginNick}님</span>
				<c:choose>
					<c:when test="${empty profile}">
						<img class="profile-preview" name="basic" src="/img/basic.png">
					</c:when>
					<c:otherwise>
					<c:forEach var="profile" items="${profile}">
						<img class="profile-preview" src="/rest/board/file/${profile.attachNo}" >
					</c:forEach>
					</c:otherwise>
				</c:choose>
					<img class="logout" src="/img/logout.png" >
			</div>
		</div>
		
	</header>
	<div>
		<div class="mb-30">
			<ul class="dropdown-menu">
				<li id="doran"><a href="/rest/board">도란도란 놀이터</a></li>
				<li id="my"><a href="profile">마이프로필 수정</a></li>
				<li id="pw"><a href="pw">비밀번호 변경</a></li>
			</ul>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#logout").click(function(){
			logout();
		})
	});
		
		function logout(session){
			$.ajax({
				url : "/rest/mem/info/local",
				method : "delete",
				async: false,
                success : function(resp) {
                	alert("로그아웃 되었습니다.")
                	location.href="/mem/info/local";
                }
			});
		}
	

</script>
</html>

