<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	
	<div class="resetPasswordForm">
		<!-- need to map in user to that username can be displayed -->
		<h2 class="resetPasswordHeader">Reset your password</h2><br>
		
		<form action="resetUserPassword.do" method="POST">
		<div class="resetOldPassword">
			<label for="oldPassword"> Old Password: </label> <input type="password" name=oldPassword><br>
		</div>
		
		<div class="resetNewPassword">
			<label for="newPassword"> New Password: </label> <input type="password" name=newPassword>
		</div><br>
		<input type="submit" value="Update"/>
		
		<div class=resetPasswordFail>
			<c:if test="${!empty oldPasswordIsIncorrect }">
				<h5>${oldPasswordIsIncorrect} </h5>
			</c:if>
		</div>
		</form>
	</div>
	
	<!-- If oldPassword matches current password AND newPassword != oldPassword 
	 	reset password to newPassword and show "Password reset success"-->
	<!-- Else, password reset unsuccessful -->
	
	
</body>
</html>