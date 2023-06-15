<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="비밀번호 확인" name="title"/>
</jsp:include>

<html>
<head>
	<title>비밀번호 확인</title>

	<style>
	   .input-pw{
			    width: 450px;
			    height: 50px;
			    border: 1px solid lightgrey;
			    border-radius: 10px 10px;
			    margin: 10px;
			    padding-left: 10px;
			}        	
		.input-pw:focus{
			    width: 450px;
			    height: 50px;
			    outline: 1px solid lightgrey;
			    border-radius: 10px 10px;
			    margin: 10px;
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
	    
	
	</style>
</head>

<body>
	<div>
		<div class="container-1000">
			<div class="row center mb-20">
				<img src="/img/lock.png" style="width:150px">
			</div>
			<div class="row center">개인정보 보호를 위해 비밀번호를 확인합니다.</div>
			<div class="row center">
				<input name="inputPw" class="input-pw" type="password" placeholder="비밀번호를 입력하세요">
			</div>
			<div class="row center">
				<button class="pw-btn" type="button">비밀번호 확인</button>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		$(".pw-btn").click(function(e){
			var inputPw = $(".input-pw").val();		
			pwCheck(inputPw)
				
		});
			function pwCheck(inputPw){				
				var data = {
						inputPw : inputPw
				};
			
				$.ajax({
					url : "/rest/mem/info/pw",
					method : "post",
					contentType:"application/json",
					data:JSON.stringify(data),
					statusCode : {
						200: function(resp){
							if(resp=="OK"){//로그인 정보 일치 시 게시판으로 이동
								location.href="/rest/mem/info/profile"
							}
							else{//로그인 정보 불일치 시 에러 메세지
								alert("비밀번호가 일치하지 않습니다.");
							}
						}
					}
				});
			}
		
	});
	
	
		
	

</script>
</body>
</html>