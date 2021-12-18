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
	
	<form action="addGame.do" method = "POST">  <!-- REMOVE . PRIOR TO COMMENT method="POST"> --> <!--Need to match action address & get/put method to controller  -->
	<br>
	
	<div class="addGame">
	<input type="hidden" name="user.id" value="${user.id}"/>
	

		
		<label for="title">Title:</label>
			<input type="text" name="title" value="${newGame.title}" required/> 
		<br>

		<label for="description">Description:</label>
			<input type="text" name="description" value="${newGame.description}" required/>
		<br>

		<label for="maxPlayers">Max players:</label>
			<input type="text" name="maxPlayers" value="${newGame.maxPlayers}" required/>
		<br>		
			
		<label for="genre">Genre: </label>
			<select name="genre.id">
				<c:forEach items="${genres}" var="genre">
					<option value="${newGame.genre.id}">
							${genre.name}
					</option>
				</c:forEach>
			</select>	
		<br>

		<label for="rating">Rating: </label>
			<select name="rating.id">
				<c:forEach items="${ratings}" var="rating">
					<option value="${newGame.rating.id}">
							${rating.name}
					</option>
				</c:forEach>
			</select>	
		<br>
		
	<!-- need to add image upload field -->
		If you know the URL image location enter it below: <br>
		<label for="gameImageUrl">Image URL: </label>
			<input type="text" name="gameImageUrl" />
		<br>
	</div>

	<input type="submit" value="Submit Game">
	<input type="hidden" name="newGame.id" value="${newGame.id}"/>
	</form>
	
	
	<c:choose>
		<c:when test="${! empty gameExists}">
			<h3>"${gameExists}"</h3>
		</c:when>	
	</c:choose>
	
	
	
</body>
</html>
