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
	
			</form><br>
			<c:choose>
				<c:when test="${! empty alreadyInGames}">
					<button type="button" onclick="location.href='goToAddGame.do'" value="Add New Game!">Add New Game!</button>
				</c:when>
				
				<c:when test="${!empty noGamesFound }">
					<button type="button" onclick="location.href='goToAddGame.do'" value="Add New Game!">Add New Game!</button>
				</c:when>
			</c:choose>
		</div>
	
		<div class="sellsearchexisitinggameresults">
		<c:choose>
			
			<c:when test="${! empty alreadyInGames}">
				<ul>
					<c:forEach var="item" items="${alreadyInGames}"> 
						<li>	<a href="populateItem.do?id=${item.id}">${item.title}</a></li>
					</c:forEach>
				</ul><br>
				
			</c:when>
			<c:when test="${!empty noGamesFound }">
				<br><br>
				<h3>${noGamesFound}</h3><br>
				
			</c:when>
		</c:choose>	
	
		</div>
	</div>
</body>
</html>