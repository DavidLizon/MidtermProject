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
<jsp:include page="navBar.jsp"/>
<body>
	<div class="forms-container">
			<div class="login-form-box">
					<form class="login-form" action="login.do" method="POST"> <!-- Need to confirm this is the correct mapping within controller -->
						<h2>Existing User Login</h2><br>
							<div class="loginUsername">
								<label for="username">Username: </label> 
								<input type="text" name="username" /> 
								<br> 
							</div>
							
							<div class="loginPassword">
								<label for="password">Password:</label> 
								<input type="password" name="password" /> 
								<br> 
							</div><br>
								<input type="submit" value="Login">
					</form><br>
			<c:choose>
				<c:when test="${!empty tryAgain}">
					<h5>${tryAgain}</h5>
				</c:when>
			</c:choose>
				</div>
					<div class="new-account-form-box">
							<form class="new-account-form" action="createUserAccount.do" method="POST">
								<h2>New Account Creation</h2>
									<input type="hidden" name="user.id" value="${newUser.id}"/>
									 
									<div class="createFname">
										<label for="firstName">First Name: </label> 
										<input required type="text" name="firstName" /> <br>
									</div>
									
									<div class="createLname">
										<label for="lastName">Last Name: </label> 
										<input required type="text" name="lastName" /> <br> 
									</div>
									
									<div class="createUsername">
										<label for="username">Username: </label> 
										<input required type="text" name="username" /> <br> 
									</div>
									
									<div class="createPassword">
										<label for="password">Password:</label> 
										<input required type="password" name="password" /> <br> 
									</div>
									
									<div class="createEmail">
										<label for="email">Email: </label> 
										<input required type="text" name="email" /><br> 
									</div><br>
									
									<div class="createSubmit">
										<input type="submit" value="Create Account">
									</div>
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
	</div>
</body>
</html>