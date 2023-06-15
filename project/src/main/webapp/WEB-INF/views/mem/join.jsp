<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>회원가입</title>

	<style>
	
	   .success-message,
	   .fail-message,
	   .NNNNN-message,
	   .NNNNY-message {
	           display: none;
	           position: relative;
	           left: 20px;
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
	   #success-message,
	   #fail-message {
	           display: none;      
	        }
	   .input.success ~ #success-message{
	   		display : block;
	   		color:green;
	        font-size: 12px;
	        margin-top: -10px;  
			position: relative;
	        left: 30px;    
	   }
	   .input.fail ~ #fail-message{
	   		display : block;
	   		color : red;
	        font-size: 12px;
	        margin-top: -10px;  
			position: relative;
	        left: 30px;    
	   }
	   .input.NNNNY ~ .success-message{
	   		display : block;
	   		color:green;
	        font-size: 12px;
	        margin-top: -10px;  
	   }	  
	   .input.NNNNN ~ .NNNNN-message{
	   		display : block;
	   		color : red;
	        font-size: 12px;
	        margin-top: -10px;  
	   }
	   .input.NNNNN ~ .success-message{
	   		display : none;
	   		color:green;
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
		
	   .text-title{
		   	position: relative;
		   	top: 20px;
		   	left: 20px;   	
		  		 }
	   .text-title i{
	   	color: red;
				   }	
	  
	   #form-button{
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
			padding-left: 200px;
			width:250px;
		}
		h3{
			padding-left: 15px;
		}
	  
	</style>
</head>
<link rel="stylesheet" type="text/css" href="/css/view.css"> <!-- css 링크 -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/><!-- 폰트어썸 -->

<body>
	<div>
		<div>
			<img src="/img/logo.png">
		</div>
			
			<form class="memInfo" method="post" autocomplete="off">
			<div class="container-500">
				<div class="row">
					<h3>회원가입</h3>
				</div>
				<div class="row">
					<div class="text-title"> 아이디  <i class="fa-solid fa-asterisk"></i></div>
					<input type="text" class="input" name="memId" autocomplete="off">
					<div class="success-message">사용 가능한 아이디입니다.</div>
					<div class="fail-message">영소문자로 시작하여 영소문자 또는 숫자 6~20자로 작성해주세요.</div>
				    <div class="NNNNN-message">이미 사용중인 아이디입니다.</div>
				</div>
				<div>
					<div class="text-title"> 비밀번호  <i class="fa-solid fa-asterisk"></i></div>
					<input type="password" class="input" name="memPw">		
					<div class="success-message">사용 가능한 비밀번호입니다.</div>
					<div class="fail-message">숫자, 영문 소문자, 특수문자를 반드시 1개 이상 포함하여 8~16자로 작성해주세요.</div>		
				</div>
				<div>
					<div class="text-title"> 비밀번호 확인  <i class="fa-solid fa-asterisk"></i></div>
					<input type="password" class="input" id="pw-re">		
					<div class="success-message">비밀번호가 일치합니다.</div>
				    <div class="fail-message">비밀번호가 일치하지 않습니다.</div>				
				</div>
				<div>
					<div class="text-title"> 닉네임  <i class="fa-solid fa-asterisk"></i></div>
					<input type="text" class="input" name="memNick" autocomplete="off">		
					<div class="success-message">사용 가능한 닉네임입니다.</div>
				    <div class="fail-message">한글과 숫자를 이용하여 2~10글자로 작성해주세요.</div>
				    <div class="NNNNN-message">이미 사용중인 닉네임입니다.</div>			
				</div>
				<div>
					<div class="text-title">생일  <i class="fa-solid fa-asterisk"></i></div>
					<input type="date" class="input" name="memBirth" autocomplete="off">			
					<div class="fail-message">생년월일을 선택해주세요.</div>	
				</div>
				
				<div><button type="submit" id="form-button">가입하기</button></div>				
			</div>		
			</form>	
		</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	//폼이 submit 됐을 때
	$(function(){
		
		//input 입력값 상태 객체
		var validChecker = {
				//맨 처음 상태는 false, 정규표현식 기재
				memIdValid : false, memIdRegex : /^[a-z]+[a-z0-9]{5,19}$/,
				memPwValid : false, memPwRegex : /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
				memPwReValid : false,
				memNickValid : false, memNickRegex : /^[가-힣0-9]{2,10}$/,
				memBirthValid : false, memBirthRegex : /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/,				
		
				isAllValid : function(){
					return this.memIdValid
						&& this.memPwValid
						&& this.memPwReValid
						&& this.memNickValid
						&& this.memBirthValid
				}
		};
		
		//name이 있는 입력값 블러 이벤트 → 정규표현식 검사
		$("[name]").blur(function(){
			var name = $(this).attr("name"); //속성 값을 가져오는 함수
			var value = $(this).val();
			var regex = validChecker[name+"Regex"];
			if(regex.test(value)) { //정규표현식 성공 시 성공 메세지만 남기기
				validChecker[name+"Valid"] = true;
				$(this).removeClass("success fail").addClass("success");
			}
       	 else {//반대는 실패 메세지만
        	    validChecker[name+"Valid"] = false;
            	$(this).removeClass("success fail").addClass("fail");
      	  	}
		});		
		
		//아이디 input창 검사(정규표현식 검사 통과 → 중복 검사)
		$("input[name=memId]").blur(function(){
			var memId = $(this).val();
			$(this).removeClass("fail NNNNN NNNNY");
			$(this).removeClass("success fail")

			if(validChecker.memIdValid){
				var that = this;//input창의 this
				
				$.ajax({
					url : "/rest/mem/id",
					method : "post",
					data : {
						memId:memId
					},
					success:function(resp){
						if(resp=="NNNNN"){
							$(that).addClass("NNNNN");
							validChecker.memIdValid = false;
							$(this).removeClass("success fail").addClass("success");
						}
						else if(resp=="NNNNY"){
							$(that).addClass("NNNNY");
							validChecker.memIdValid = true;
							$(this).removeClass("success fail").addClass("fail");
						}
					},
					error:function(){}
				});				
			}		
			else{
				$(this).addClass("fail");
				validChecker.memIdValid = false;
			}
		});
		
		//닉네임 input창 검사
		$("input[name=memNick]").blur(function(){
				var memNick = $(this).val();
				$(this).removeClass("fail NNNNN NNNNY");
				$(this).removeClass("success fail")
				
				if(validChecker.memNickValid){
					var that = this;//input창의 this
				
				$.ajax({
					url:"/rest/mem/nick",
					method:"post",
					data:{
						memNick:memNick
					},
					success:function(resp){
						if(resp=="NNNNN"){
							$(that).addClass("NNNNN");
							validChecker.memNickValid = false;
							$(this).removeClass("success fail").addClass("success");
						}
						else if(resp=="NNNNY"){
							$(that).addClass("NNNNY");
							validChecker.memNickValid = true;
							$(this).removeClass("success fail").addClass("fail");
						}
					},
					error:function(){}
				});
			}
			else{
				$(this).addClass("fail");
				validChecker.memNickValid = false;
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
		
		$("input[name=memBirth]").blur(function(){
			var memBirth = $(this).val();
			$(this).removeClass("success fail");
			if(memBirth.length>0){
				validChecker.memBirthValid = true;
			}
			else{
				validChecker.memBirthValid = false;
				$(this).addClass("fail");
			}
		});
		
		
		$(".memInfo").submit(function(e){
			
			e.preventDefault();
			
			$(this).find("input, textarea, select").blur();
		
		if(validChecker.isAllValid()){
			
			var memId = $("[name=memId]").val();
			var memPw = $("[name=memPw]").val();
			var memNick = $("[name=memNick]").val();
			var memBirth = $("[name=memBirth]").val();
			
			join(memId, memPw, memNick, memBirth);
			
			}		
		});
			
	});
	
		//회원 가입
		function join(memId, memPw, memNick, memBirth){
			var data = {
				memId:memId,
				memPw:memPw,
				memNick:memNick,
				memBirth:memBirth
			};
			
			
			$.ajax({
				url:"/rest/mem/info/new",
				method:"post",
				contentType:"application/json",
				data:JSON.stringify(data),
				success:function(resp){
					alert("회원 가입이 완료되었습니다.");
					location.href="/mem/info/local";
				}
			});
		};
</script>
</body>
</html>