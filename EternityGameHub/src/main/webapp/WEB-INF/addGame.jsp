<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>

<jsp:include page="navBar.jsp"/>

	<h1>Add New Game to EGH</h1>

	<form action="addGame.do">  <!-- REMOVE . PRIOR TO COMMENT method="POST"> --> <!--Need to match action address & get/put method to controller  -->
	<br>
	
	<div class="addGame">
	<c:if test="${duplicateTitle }">
		Unable to add game. Game with same title already exists.	
	</c:if>
		<label for="title">Title:</label>
			<input type="text" name="title" value="${newGame.title}" required/> <br>

		<label for="description">Description:</label>
			<input type="text" name="description" value="${newGame.description}" required/><br>

		<label for="maxPlayers">Max players:</label>
			<input type="text" name="maxPlayers" value="${newGame.maxPlayers}" required/><br>

		<label for="genre">Genre: </label>
		<select name="genre">
			<c:forEach items="${genres}" var="genres">
				<option value="${genres.id}"
					<%-- <c:if test="${genres.name eq selectedGenre}">selected="selected"</c:if> --%>
						>
						${genres.name}: ${genres.description }
				</option>
			</c:forEach>
		</select>	
		<br>

		<label for="rating">Rating: </label>
		<select name="rating">
			<c:forEach items="${ratings}" var="ratings">
				<option value="${ratings.id}"
						>
						${ratings.name}: ${ratings.description }
				</option>
			</c:forEach>
		</select>	
		<br><br>
		
<%-- 		<select name="category">
            <c:forEach items="${listCategory}" var="category">
                <option value="${category.id}"
                    <c:if test="${category.id eq selectedCatId}">selected="selected"</c:if>
                    >
                    ${category.name}
                </option>
            </c:forEach>
        </select> --%>
		
		
		
<%-- 		<label for="genre">Genre:</label>						<!-- IS GENRE FROM PRE-POPULATED LIST OR USER ENTERS -->
			<input type="text" name="genre" value="${newGame.genre}" required/><br> --%>

<%-- 		<label for="rating">Rating:</label>						
			<input type="text" name="rating" value="${newGame.rating}" required/><br>

		<br><br> --%>

<!-- need to add image upload field -->
	If you know the URL image location enter it below: <br>
	<label for="gameImageUrl">Image URL: </label>
		<input type="text" name="gameImageUrl" />
	<br><br>
</div>

	<input type="submit" value="Submit Game">
	</form>
	
	
	
</body>
</html>
