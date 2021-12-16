<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listing Success! | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />

	<h1>Great success!</h1>
	<br>
	<h4>You've successfully listed ${game.title} for sale!</h4>
	<br>
		<img src="${game.gameImageUrl}" alt="${game.title} Cover Art">
		<br>
		Description: ${game.description}
		<br>
		Max players: ${game.maxPlayers}
		<br>
		Genre: 	<c:forEach var="genre" items="${game.genres}">
					${genre.name}
				</c:forEach>		
		<br>
		Price: ${newGameInventoryItem.salePrice}
		<br>
		Condition: ${newGameInventoryItem.conditionNew}
		<br>
		Description: ${newGameInventoryItem.description}
		<br>
		

</body>
</html>