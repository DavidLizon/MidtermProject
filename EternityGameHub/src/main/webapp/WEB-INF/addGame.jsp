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
	
	<div class="addgamebody">
		<br>
		<h1>Add New Game to EGH</h1>
		
		<form action="addGame.do" method = "POST" modelAttribute="newGame">  <!-- REMOVE . PRIOR TO COMMENT method="POST"> --> <!--Need to match action address & get/put method to controller  -->
		
		<div class="addGame">
		<input type="hidden" name="user.id" value="${user.id}"/>
		
	
			<div class="addgametitle"></div>
				<label for="title">Title:</label>
					<input type="text" name="title" value="${newGame.title}" required/> 
				<br>
			</div>
			
			<div class="addgamedescription">
				<label for="description">Description:</label>
					<input type="text" name="description" value="${newGame.description}" required/>
				<br>
			</div>
			
			<div class="addgamemaxplayers">
				<label for="maxPlayers">Max players:</label>
					<input type="text" name="maxPlayers" value="${newGame.maxPlayers}" required/>
				<br>		
			</div>
			
			<div class="addgamegenre">
				<label for="genre">Genre: </label>
					<select name="genreId">
						<c:forEach items="${genres}" var="genre">
							<option value="${genre.id}">
									${genre.name}
							</option>
						</c:forEach>
					</select>	
				<br>
			</div>
			
			<div class="addgamerating">
				<label for="rating">Rating: </label>
					<select name="rating.id">
						<c:forEach items="${ratings}" var="rating">
							<option value="${rating.id}">
									${rating.name}
							</option>
						</c:forEach>
					</select>	
				<br>
			</div>
			
			<div class="addgameimage">
		<!-- need to add image upload field -->
				If you know the URL image location enter it below: <br>
				<label for="gameImageUrl">Image URL: </label>
					<input type="text" name="gameImageUrl" value="https://i.imgur.com/a3H171W.png"/>
				<br>
			</div>
	
			<div class="addgamesubmit">
				<input type="submit" value="Submit Game">
				<input type="hidden" name="newGame.id" value="${newGame.id}"/>
				
			</div>
		</form>
			<div class="addgameexists">
				<c:choose>
					<c:when test="${! empty gameExists}">
						<h3>${gameExists}</h3>
					</c:when>	
				</c:choose>
			</div>
	</div>
	
</body>
</html>
