<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 재설정 - 개인정보 확인</title>

	<style>
	     
	    .input{
		    width: 450px;
		    height: 50px;
		    border: 1px solid lightgrey;
		    border-radius: 10px 10px;
		    margin: 20px;
		    padding-left: 15px;
			}        	
		input:focus{
		    outline: 1px solid lightgrey;
		}
		
		.check-btn{
		    width: 450px;
		    height: 50px;
		    margin: 10px;
   			margin-left: 20px;
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
<link rel="stylesheet" type="text/css" href="/css/view.css"> <!-- css 링크 -->

<body>
	<div>
		<a href="/mem/info/local"><img src="/img/logo.png" style="width:200px"></a>
		<div class="container-500 mt-50">
			<div class="row center">
				<img src="/img/lock.png" style="width:150px">
			</div>
			<div class="row center">
				비밀번호 재설정을 위해 개인정보를 확인합니다.
			</div>
			<div>
				<input class="memId input" placeholder="ID" required="required">
			</div>
			<div>
				<input class="memNick input" placeholder="닉네임" required="required">
			</div>
			<div>
				<input class="memBirth input" type="date" placeholder="생일" required="required">
			</div>
			<div>
				<button class="check-btn">확인</button>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
			
		$(".check-btn").click(function(e){
			var memId = $(".memId").val();		
			var memNick = $(".memNick").val();		
			var memBirth = $(".memBirth").val();		
			
			var data = {
					memId : memId,
					memNick : memNick,
					memBirth : memBirth
			}
			
			infoCheck(data)
				
		});
		
			function infoCheck(data){				
			
				$.ajax({
					url : "/rest/mem/info/check",
					method : "post",
					contentType:"application/json",
					data:JSON.stringify(data),
					statusCode : {
						200: function(resp){
							if(resp=="NO"){
								alert("일치하는 정보가 없습니다.");
							}
							else{
								alert("정보가 일치합니다. 비밀번호 재설정 페이지로 이동합니다.");
								location.href="/rest/mem/pw/new/"
							}
						}
					}
				});
			}
		
	});
	
	
		
	

</script>
</body>
</html>