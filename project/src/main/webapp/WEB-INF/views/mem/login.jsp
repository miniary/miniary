<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>로그인</title>

	<style>
	
	   .input{
			    width: 450px;
			    height: 50px;
			    border: 1px solid lightgrey;
			    border-radius: 10px 10px;
			    margin: 20px;
			    padding-left: 10px;
			}        	
		.input:focus{
			    width: 450px;
			    height: 50px;
			    outline: 1px solid lightgrey;
			    border-radius: 10px 10px;
			    margin: 20px;
			    padding-left: 10px;
		}	
		
		button{
		    width: 450px;
		    height: 50px;
		    margin: 20px;
		    align-items: center;
		    border: none;
		    border-radius: 10px 10px;
		    background-color: rgb(52, 152, 219);
		    font-size: 17px;
		    font-weight: bold;
		    color : white;
		    cursor: pointer;
		}
		
		img{
			width:350px;
		}
		a{
			text-decoration : none; 
			color:black;
		}
	
	</style>
</head>
<link rel="stylesheet" type="text/css" href="/css/view.css">

<body>
	<div class = "container-500">
	
		<div class = "row center">
			<img src="/img/logo.png">
		</div>
			
			<div class="row center">
			<form method="post" autocomplete="off" id="loginForm">
				<div><input class="input" type="text" name="memId" placeholder="아이디" autocomplete="off"></div>
	       	    <div><input class="input" type="password" name="memPw" placeholder="비밀번호"></div>
	            <div><button type="submit">로그인</button></div>
	            <div><a href="/mem/info/new">회원가입 | </a><a href="/rest/mem/info/check">비밀번호 재설정</a></div>
				<div>
					<c:if test="${param.error !=null}">
						<h4>입력된 정보가 올바르지 않습니다.</h4>
					</c:if>
				</div>
			</form>
			</div>
			

		</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#loginForm").submit(function(e){
			e.preventDefault();
				var memId = $("[name=memId]").val();
				var memPw = $("[name=memPw]").val();
				
				login(memId, memPw);
			});
		});
	
	function login(memId, memPw){	
		var data = {
				memId:memId,
				memPw:memPw
			};
							
			$.ajax({
				url : "/rest/mem/info/local",
				method : "post",
				contentType:"application/json",
				data:JSON.stringify(data),
				async: false,
				statusCode : {
					200: function(resp){
						if(resp=="OK"){//로그인 정보 일치 시 게시판으로 이동
							location.href="/rest/board";
						}
						else{//로그인 정보 불일치 시 에러 메세지
							location.href="/mem/info/local?error";
						}
					}
				}
			});
		};
</script>
</body>
</html>