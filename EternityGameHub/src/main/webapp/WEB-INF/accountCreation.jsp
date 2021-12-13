<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create EGH Account</title>
<jsp:include page="bootstrapHead.jsp" />

</head>
<body>

	<h1>Create EGH Account</h1>

	<label for="firstName">First Name: </label>
	<input required type="text" name="firstName" />
	<br>

	<label for="lastName">Last Name: </label>
	<input required type="text" name="lastName" />
	<br>

	<label for="username">Username: </label>
	<input required type="text" name="username" />
	<br>

	<label for="password">Password: </label>
	<input required type="text" name="password" />
	<br>

	<label for="email">Email: </label>
	<input required type="text" name="email" />
	<br>

	<form action="createAccount.do">
		<input type="submit" value="Create Account">
	</form>
	<br>

	<c:if test="${!accountConfirm }">
		<c:if test="${ !goodEmailAddress }">
			Unable to create account. Email already in use.
		</c:if>
		<c:if test="goodUsername }">
			Unable to create account. Username already in use.
		</c:if>
	</c:if>

</body>
</html>