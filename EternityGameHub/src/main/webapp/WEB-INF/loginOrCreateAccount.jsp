<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome | Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp" />

</head>
<body>
<jsp:include page="navBar.jsp"/>

	<div class="existingUserLogin">
		<h2>Existing User Login</h2>
		<br>

		<form action="login.do" method="POST"> <!-- Need to confirm this is the correct mapping within controller -->

			<label for="username">Username: </label> 
			<input type="text" name="username" /> 
			<br> 
		
			<label for="password">Password:</label> 
			<input type="password" name="password" /> 
			<br> 
		
			<input type="submit" value="Login">
		</form><br>
		<c:choose>
			<c:when test="${!empty tryAgain}">
				<h5>${tryAgain}</h5>
			</c:when>
		</c:choose>
	</div><br>

	<div class="newAccountCreation">
	
		<h2>New Account Creation</h2>

		<form action="createUserAccount.do" method="POST">
			<input type="hidden" name="user.id" value="${newUser.id}"/> 
			
			<label for="firstName">First Name: </label> 
			<input required type="text" name="firstName" /> 
			<br> 
			
			<label for="lastName">Last Name: </label> 
			<input required type="text" name="lastName" /> 
			<br> 
			
			<label for="username">Username: </label> 
			<input required type="text" name="username" /> 
			<br> 
			
			<label for="password">Password:</label> 
			<input required type="password" name="password" /> 
			<br> 
			
			<label for="email">Email: </label> 
			<input required type="text" name="email" />
			<br> 
			
			<input type="submit" value="Create Account">
		
		</form>
		
			<c:choose>
				<c:when test="${!empty emailInUse}">
					<h5>${emailInUse}</h5>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${!empty usernameInUse}">
					<h5>${usernameInUse}</h5>
				</c:when>
			</c:choose>
		
	</div>

</body>
</html>