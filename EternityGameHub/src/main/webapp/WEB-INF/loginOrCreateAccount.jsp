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

		<form action="getUserAccount.do" method="GET"> <!-- Need to confirm this is the correct mapping within controller -->

			<label for="username">Username: </label> 
			<input type="text" name="username" /> 
			<br> 
		
			<label for="password">Password:</label> 
			<input type="text" name="password" /> 
			<br> 
		
			<input type="submit" value="Login">
		</form>
		
		<!-- It's possible the logic below needs to be wrapped around/within the entire existingUserLogin class -->
		
		<c:if test="${loginConfirmation}">
			<c:choose>
				
				<c:when test="${loginSuccessful}">
					<div>		
						<form action="home.do"> <!-- Need to confirm this is the correct mapping within controller -->
							<input type="submit" value="Home"/>
						</form>	
					</div>
				</c:when>
				
				<c:when test="${!loginSuccessful}">
					<div>
						<p>Your username or password was incorrect.</p>
					</div>
				</c:when>
				
			</c:choose>
		</c:if>
	</div>

	<div class="newAccountCreation">
	
		<h2>New Account Creation</h2>

		<form action="createAccount.do"> <!-- Need to confirm this is the correct mapping within controller -->

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
			<input required type="text" name="password" /> 
			<br> 
			
			<label for="email">Email: </label> 
			<input required type="text" name="email" />
			<br> 
			
			<input type="submit" value="Create Account">
		
		</form>
		

		<c:if test="${!accountConfirm }">

			<c:if test="${ !goodEmailAddress }">
			Unable to create account. Email already in use.
		</c:if>

			<c:if test="goodUsername }">
			Unable to create account. Username already in use.
		</c:if>

		</c:if>
	</div>

</body>
</html>