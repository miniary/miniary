<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header2.jsp">
	<jsp:param value="프로필 수정" name="title"/>
</jsp:include>

<html>
<head>
	<title>프로필 수정</title>

	<style>
	   .success-message,
	   .fail-message,
	   .NNNNN-message,
	   .NNNNY-message { 
	           display: none;
	           position: relative;           
	           left: 29px;         
	    	   margin-right: 180px;               
	        }
	   .input.success ~ .success-message{
	   		display : block;
	   		color:green;
	        font-size: 12px;
	        margin-right: 180px;
	        
	        
	   }	
	   .input.fail ~ .fail-message {
	            display: block;
	            color : red;
	            font-size: 12px;
	            margin-right: 180px;
	        }
	   .input.NNNNY ~ .success-message{
	   		display : block;
	   		color:green;
	        font-size: 12px; 
	        margin-right: 300px;
	   }	   
	   .input.NNNNN ~ .NNNNN-message{
	   		display : block;
	   		color : red;
	        font-size: 12px;
	        margin-right: 180px;

	   }
	   .input.NNNNN ~ .success-message{
	   		display : none;
	   		color:green;
	        font-size: 12px;
	        margin-right: 180px;
	   }
	   
	   	 .input{
		    width: 450px;
		    height: 50px;
		    border: 1px solid lightgrey;
		    border-radius: 10px 10px;
		    margin: 10px;
		    padding-left: 15px;
			}        	
		.input:focus{
		    outline: 1px solid lightgrey;
		}
		
	.preview{
		width: 120px;
    	height: 120px;
   		border-radius : 50%;
   		border:1px black solid transparent;
   			}
   .preview.preview-hover:hover{
    	opacity : 0.5;
    	cursor: pointer;
   			}
   			
   	.profile-delete{
   			margin-top: 15px;
			background: none;
			outline: none;
			border: none;
   	}
   	
   	.profile-delete:hover{
		cursor: pointer;
	}
	
		.edit-btn{
		    width: 450px;
		    height: 50px;
		    margin: 10px;
   			margin-left: 60px;
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
			<div class="row center">
			<c:choose>
				<c:when test="${empty profile}">
					<div class="row center"><img class="preview preview-hover" name="basic" src="/img/basic.png"></div>
				</c:when>
				<c:otherwise>
				<c:forEach var="profile" items="${profile}">
					<img class="preview preview-hover" src="/rest/board/file/${profile.attachNo}" >
				</c:forEach>
				</c:otherwise>
			</c:choose>
			<div class="row center">			
				<button class="profile-delete"><i class="fa-solid fa-trash"></i> 프로필 초기화</button>
			</div>
			</div>
			<div class="row center"><input hidden type="file" name="profile" class="file profile-input" accept=".jpg, .png, .gif" ></div>
			<div class="row center">
				<span>아이디</span>
				<input class="input" value ="${memDto.memId}" disabled="off"  ></input>
			</div>
			<div class="row center">
				<span>닉네임</span>
				<input class="input" name="memNick" type="text" value="${memDto.memNick}">
				<div class="success-message">사용 가능한 닉네임입니다.</div>
				<div class="fail-message">한글과 숫자를 이용하여 2~10글자로 작성해주세요.</div>
				<div class="NNNNN-message">이미 사용중인 닉네임입니다.</div>	
			</div>
			<div class="row center">
				<span>&nbsp생일&nbsp</span>
				<input class="input" name="memBirth" type="date" value="${memDto.memBirth}">
			</div>
			<div class="row center">
				<button class="edit-btn" type="button">프로필 수정</button>
			</div>
		</div>
		
	</div>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		
		//사진 클릭시 파일 선택창 클릭
		$(".preview").click(function(){
			$("input[name=profile]").click();
			
		});
		
		$(".profile-input").change(function(){
			if(this.files.length>0){
				$(".preview").attr("src",window.URL.createObjectURL(this.files[0]));
			}
			else{
				$(".preview").attr("src", "/img/basic.png");
			}
			
			var fileInput = $('.file');
		});
		
		$(".profile-delete").click(function(){
			$(".profile-input").val("");
			$(".preview").attr("src", "/img/basic.png");
					
			$.ajax({
					url : "profileImage/"+${sessionScope.loginNo},
					method:"delete",
					success:function(resp){
						$(".preview").attr("src", "/img/basic.png");
					}
			});
		});
		
		var validChecker = {
				//맨 처음 상태는 false, 정규표현식 기재
				memNickValid : false, memNickRegex : /^[가-힣0-9]{2,10}$/,
				memNickTest : false
				};
				
			
			$("input[name=memNick]").blur(function(){
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
			
			//닉네임 input창 검사
			$("input[name=memNick]").blur(function(){
					var memNick = $(this).val();
					$(this).removeClass("fail NNNNN NNNNY");
					$(this).removeClass("success fail")
					
					var nowNick = "${memDto.memNick}"
					
						if(memNick!=nowNick){
							if(validChecker.memNickValid){
								var that = this;//this 보관
								
								$.ajax({
									url:"${pageContext.request.contextPath}/rest/mem/nick",
									method:"post",
									data:{
										memNick:memNick
									},
									success:function(resp){
										if(resp=="NNNNN"){
											$(that).addClass("NNNNN");
											validChecker.memNickTest = false;	
											$(this).removeClass("success fail").addClass("success");
										}
										else if(resp="NNNNY"){
											$(that).addClass("NNNNY");
											validChecker.memNickTest = true;
											$(this).removeClass("success fail").addClass("fail");
										}
									},
									error:function(){}
								});
							}
							else{
								$(this).addClass("fail");
								validChecker.memNickTest = false;	
							}
						}
						else{
							validChecker.memNickValid = true;
							validChecker.memNickTest = true;
						}
						
					});
		
		
		
		$(".edit-btn").click(function(e){
			
			$("input[name=memNick]").blur();
						
			if(validChecker.memNickValid&&validChecker.memNickTest){		
				editProfile();
			}
				
		});
		
			function editProfile(){			
				var formData = new FormData();
				
				var memNick = $("[name=memNick]").val();
				var memBirth = $("[name=memBirth]").val();
				
				var data = {
						memNick : memNick,
						memBirth : memBirth
				};
				
				formData.append("inputDto", new Blob([JSON.stringify(data)],{type:"application/json"}));
				
				var fileInput = $('.file');
				
				if(fileInput[0].files[0]!=null){
					formData.append('file',$('.file')[0].files[0]);
				}
				
			
				$.ajax({
					url:"/rest/mem/info",
					method:"put",
					data:formData,
				    contentType: false, //contentType : false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
				    processData: false, //rocessData : false로 선언 시 formData를 string으로 변환하지 않음
				    traditional: true,
				    cache: false,
				    enctype: "multipart/form-data",
				    dataType: "json",
					success:function(resp){
							if(resp){
								alert("프로필이 수정되었습니다.")
								location.href="/rest/mem/info/profile";
								}
							else{
								alert("오류가 발생하였습니다. 재시도 해주세요.")
							}
						}
				});
			}
		
	});
	
	
		
	

</script>
</body>
</html>