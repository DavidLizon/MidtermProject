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
	<div class="sellsearchexisitnggame">
		<div class=sellsearchexistinggametitlesearch>
			<h2>Search Title to List</h2>
		
			<form action="searchByTitle.do" method="GET">
		
				<label for="title">Title: </label>
				<input type="text" name="title"/>
				<input type="submit" value="Search">
	
			</form>
		</div>
	
		<div class="sellsearchexisitinggameresults">
		<c:choose>
			
			<c:when test="${! empty alreadyInGames}">
				<ul>
					<c:forEach var="item" items="${alreadyInGames}"> 
						<li>	<a href="populateItem.do?id=${item.id}">${item.title}</a></li> <!-- Need to confirm href is correct -->
					</c:forEach>
				</ul><br>
				<button type="button" onclick="location.href='goToAddGame.do'" value="Add New Game!">Add New Game!</button> <!-- Not 100% sure the on click command is correct -->
			</c:when>
			<c:when test="${!empty noGamesFound }">
				<h3>"${noGamesFound}"</h3><br>
				<button type="button" onclick="location.href='goToAddGame.do'" value="Add New Game!">Add New Game!</button> <!-- Not 100% sure the on click command is correct -->
				
			</c:when>
		</c:choose>	
	
		</div>
		<!-- Not seeing what you're looking for? -->
		<!-- add catch for when first coming to page that user doesnt have option to add game or see
		this message prior to doing 1 search first??????? -->
	
	</div>
</body>
</html>