<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGH Account Info</title> 
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>

	<jsp:include page="navBar.jsp" />

	<div class="accountinfoWholePage">
			<h1>Update Account</h1>
				<form action="updateUserAccount.do" method="GET">
					<br /> 
					<input type="hidden" name="id" value="${user.id}"/>
					
					<div class="accountInfoUserInfo">
						<label for="firstName">First Name: </label> 
							<input required type="text" name="firstName" value = "${user.firstName}"/><br> 
						 <label for="lastName">Last Name: </label> 
							<input required type="text" name="lastName" value = "${user.lastName}"/><br> 
						<label for="username">Username: </label> 
							<input required readonly type="text" name="username" value = "${user.username}"/><br> 
					 	<label for="email">Email: </label> 
					 		<input required type="text" name="email" value = "${user.email}"/><br> 
					</div>
					<div class="accountInfoSubmit">
						<input type="submit" value="Update Account">
					</div>
				</form>
				<br>
		<div class="accountInfoSuccess">
			<c:choose>
				<c:when test="${!empty updatedAccount}">
					<h5>${updatedAccount}</h5>
				</c:when>
			</c:choose>
		
			<c:choose>
				<c:when test="${!empty emailInUseAlready}">
					<h5>${emailInUseAlready}</h5>
				</c:when>
			</c:choose>
		</div>

		<!-- redirect to reset password page -->
		<div class="accountInfoResetPassword">
			<input type="hidden" name="id" value="${user.id}"/>
		
			<form action="resetPassword.do" method="GET">
			<input type="hidden" name="user.id" value="${user.id}"/>
				<input type="submit" value="Reset Password">
			</form>
		</div>
		</div>
</body>
</html>
