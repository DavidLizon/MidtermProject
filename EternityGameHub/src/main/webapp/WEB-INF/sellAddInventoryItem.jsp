<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Inventory | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />

	<div>
	<input type="hidden" name="newGame.id" value="${newGame.id}"/>
		<h3>${newGame.title} Info</h3>
		<img src="${newGame.gameImageUrl}" alt="${newGame.title} Cover Art">
		<br>
		Title: ${newGame.title}
		<br>
		Description: ${newGame.description}
		<br>
		Max players: ${newGame.maxPlayers}
		<br>
		Genre:
		<c:forEach items="${newGame.genres}" var="genre">
						${genre.name}		
			</c:forEach>
		<br> 
		Rating: ${newGame.rating}
		
		<br>
		
		<form action="addGameInventoryItem.do" method="POST">

		<label for="price"> Price: </label>
			<input type="number" step="0.01" name="salePrice" min="0" max="99"/>
			<br>
<!-- 		<label for="platform"> Platform: </label> This should be a dropdown with pre-existing platforms, not a text box
			<input type="text" name="platform">
			<br> -->
			
			 <label for="platform">Platform: </label>
		<select name="platform.id">
			<c:forEach items="${platforms}" var="platform">
				<option value="${platform.id}">
						${platform.name}
				</option>
			</c:forEach>
		</select>	
		<br><br>  
			
			
			
		<label for="conditionNew">Condition: </label>
			<input type="radio" name="conditionNew" value="1"/> New 	<!-- Do these values need to be true/false? -->
			<input type="radio" name="conditionNew" value="0"/> Used
			<br>

		<label for="description">Description: </label>
			<input type="text" name="description"/>
			<br>
			<br>
		<input type="hidden" name="genres" value="${newGame.genres}"/>
		<input type="hidden" name="ratings" value="${newGame.rating}"/>	
		
		
		
		<input type="hidden" name="user.id" value="${user.id}"/>
		
		<input type="submit" value="List Game for Sale"/>
		<input type="hidden" name="gameID" value="${newGame.id}"/>	
		
		</form>

	</div>
</body>
</html>
