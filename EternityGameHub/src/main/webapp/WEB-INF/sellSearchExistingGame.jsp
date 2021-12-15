<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Titles to List | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />

</head>
<body>
<jsp:include page="navBar.jsp" />
	
	<div>
	<h2>Search Title to List</h2>
	
	<form action="searchByTitle.do" method="GET">
	
	<label for="title">Title: </label>
	<input type="text" name="title"/>
	<input type="submit" value="Search">

	</form>
	</div>
	
	<div>
	<c:choose>
		
		<c:when test="${! empty alreadyInGames}">
			<ul>
				<c:forEach var="item" items="${alreadyInGames}"> <!-- Need to confirm these names are correct  -->
					<li>	<a href="addGame.do?inventoryItemId=${item.id}">${item.game.title}</a></li> <!-- Need to confirm href is correct -->
				</c:forEach>
			</ul>
		</c:when>
		<!-- Not seeing what you're looking for? -->
		<!-- add catch for when first coming to page that user doesnt have option to add game or see
		this message prior to doing 1 search first??????? -->
		<c:when test="${empty alreadyInGames }">
			<h3>We don't have that game yet!</h3>
		</c:when>
	
	</c:choose>	
	
	</div>
	
	<div>
		<button type="button" onclick="location.href='goToAddGame.do'" value="Add New Game!">Add New Game!</button> <!-- Not 100% sure the on click command is correct -->
	</div>
</body>
</html>