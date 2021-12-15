<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGH Account Info</title>s
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>

	<jsp:include page="navBar.jsp" />

	<h1>Update Account</h1>

	<div class="accountInfo">
		<form action="updateAccount.do" method="POST">
			<br /> 
			<label for="firstName">First Name: </label> 
				<input required type="text" name="firstName" /><br> 
			<label for="lastName">Last Name: </label> 
				<input required type="text" name="lastName" /><br> 
			<label for="username">Username: </label> 
				<input required type="text" name="username" /><br> 
			<label for="password">Password: </label> 
				<input required type="text" name="password" /><br> 
		 	<label for="email">Email: </label> 
		 		<input required type="text" name="email" /><br>

			<input type="submit" value="Update Account">
		</form>
		<br>

		<!-- test if profile was updated -->
		<c:if test="${profileUpdateConfirm }">
			<c:choose>
				<c:when test="${profileUpdated}">
					<div class="profileUpdated">
						<h4>Profile was updated.</h4>
					</div>
				</c:when>
				<c:when test="${!profileUpdated}">
					<div class="profileNotUpdated">
						<h4>Unable to update profile.</h4>
						<c:if test="${!uniqueEmailAddress}">
							Email address was already used.
						</c:if>
					</div>
				</c:when>
			</c:choose>
		</c:if>

		<!-- redirect to reset password page???? -->
		<div class="restPassword">
			<form action="resetPassword.do">
				<input type="submit" value="Reset Password">
			</form>
		</div>
</body>
</html>
