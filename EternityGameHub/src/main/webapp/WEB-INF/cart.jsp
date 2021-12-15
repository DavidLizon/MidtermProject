<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navBar.jsp" />



<c:when test="${empty gamesInCart }" >
	<h3>Your cart is empty.</h3>
</c:when>
<c:otherwise>
		<label for="gamesInCart">
			<c:forEach items="${game.id}" var="genres">
				<div>
					${game.title}
					${game.}
					${game.}
					${game.}
			</div>
			</c:forEach>
		</label>
		<br>
</c:otherwise>








</body>
</html>