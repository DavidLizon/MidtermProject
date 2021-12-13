<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGH User Login</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<form action="login.do" method="POST">
Username
	<input type="text" name="Username"/>
	<br>
Password
	<input type="password" name="password"/>
	<input type="submit" value="Log In"/>
</form>
<form action="accountCreation.do" method="GET">
	<input type="submit" value="Create Account"/>
</form>
</body>
</html>