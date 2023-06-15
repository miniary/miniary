<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 재설정</title>

	<style>
	
	   .success-message,
	   .fail-message 
	   		{ 
	           display: none;
	           position: relative;
	           left: 23px;
	           margin-top: -10px;  
	        }
	   .input.success ~ .success-message{
	   		display : block;
	   		color:green;
	        font-size: 12px;
	        margin-top: -10px;        
	   }	
	   .input.fail ~ .fail-message {
	            display: block;
	            color : red;
	            font-size: 12px;
	        	margin-top: -10px;        	
	        }
	        
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
		
		.pw-btn{
		    width: 450px;
		    height: 50px;
		    margin: 10px;
   			margin-left: 1px;
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
			<div class="row center"><h3>비밀번호 재설정</h3></div>
			<sapn class="memNo" hidden>${memNo}</sapn>
			<div class="row"><input class="input" value ="${memId}" disabled="off"  ></input></div>
			<div class="row">
				<input name="memPw" class="input" type="password" placeholder="새 비밀번호">
				<div class="success-message">사용 가능한 비밀번호입니다.</div>
				<div class="fail-message">숫자, 영문 소문자, 특수문자를 반드시 1개 이상 포함하여 8~16자로 작성해주세요.</div>
			</div>
			
			<div class="row">
				<input id="pw-re" class="input" type="password" placeholder="새 비밀번호 확인">
				<div class="success-message">비밀번호가 일치합니다.</div>
				<div class="fail-message">비밀번호가 일치하지 않습니다.</div>
			</div>
			<div class="row center">
				<button class="pw-btn" type="button">비밀번호 수정</button>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		var validChecker = {
				//맨 처음 상태는 false, 정규표현식 기재
				memPwValid : false, memPwRegex : /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
				memPwReValid : false,
				
				isAllValid : function(){
					return this.memPwValid
						&& this.memPwReValid
				}
		}; 
		
		//비밀번호창 블러 이벤트-> 정규표현식 검사
		$("input[name=memPw]").blur(function(){
			var name = $(this).attr("name");
			var value = $(this).val();
			var regex = validChecker[name+"Regex"];
			if(regex.test(value)) {
				validChecker[name+"Valid"] = true;
				$(this).removeClass("success fail").addClass("success");
			}
	        else {
	            validChecker[name+"Valid"] = false;
	            $(this).removeClass("success fail").addClass("fail");
	        }
			
		});
		
		$("input[name=memPw]").blur(function(){
			var pw = $(this).val();
			$(this).removeClass("fail success");
			
			if(validChecker.memPwValid){
				$(this).addClass("success");
				pwReValid = true;
			}
			else{
				$(this).addClass("fail");
				pwReValid = false;
			}
		});
		
		$("#pw-re").blur(function(){
			var origin = $("input[name=memPw]").val();
			var repeat = $(this).val();
			$(this).removeClass("success fail");
			if(origin==repeat){
				validChecker.memPwReValid = true;
				$(this).addClass("success");
			}
			else{
				validChecker.memPwReValid = false;
				$(this).addClass("fail");
			}
			
		});
			
		$(".pw-btn").click(function(e){
			e.preventDefault();
			
			$("input, textarea, select").blur();
			var newPw = $("input[name=memPw]").val();		
	
			if(validChecker.isAllValid()){		
				var data = {
						newPw : newPw
					};
				pwCheck(data)				
			}
		});
		
			function pwCheck(data){						
				$.ajax({
					url : "/rest/mem/pw/new",
					method : "put",
					contentType:"application/json",
					data:JSON.stringify(data),
					statusCode : {
						200: function(resp){
							if(resp=="OK"){//비밀번호 변경 시 
								alert("비밀번호가 변경되었습니다.");
								location.href="/mem/info/local"
							}
							else{
								alert("비밀번호가 변경되지 않았습니다. 재시도 해주세요.");
							}
						}
					}
				});
			}
		
	});
	
	
		
	

</script>
</body>
</html>