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
	
	<div>
	
	<h2>Reset your password, ${user.username}</h2>
	
	<form action="resetUserPassword.do" method="POST">
	
	<label for="oldPassword"> Old Password: </label> <input type="password" name=oldPassword>
	<br>
	<label for="newPassword"> New Password: </label> <input type="password" name=newPassword>
	<br>
	<input type="submit" value="Update"/>
	
	</form>
	</div>
	
	<!-- If oldPassword matches current password AND newPassword != oldPassword 
	 	reset password to newPassword and show "Password reset success"-->
	<!-- Else, password reset unsuccessful -->
	<c:if test="${!empty oldPasswordIsIncorrect }">
		<h5>${oldPasswordIsIncorrect} </h5>
	</c:if>
	
	
	
</body>
</html>