<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<!-- How can we pull title from the game to display in the title? -->
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navBar.jsp" />
	<c:choose>
		<c:when test="${! empty game}">
		
			<h1>${game.name}</h1>
			<br>
			<!-- Display image of game -->		

		</c:when>

	</c:choose>
</body>
</html>