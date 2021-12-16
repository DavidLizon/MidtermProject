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
		<h3>${game.title} Info</h3>
		<img src="${game.gameImageUrl}" alt="${game.title} Cover Art">
		<br>
		Title: ${game.title}
		<br>
		Description: ${game.description}
		<br>
		Max players: ${game.maxPlayers}
		<br>
		Genre: 	<c:forEach var="genre" items="${game.genres}">
					${genre.name}
				</c:forEach>
		<br>
		<br>

		<form action="addGameInventoryItem.do" method="POST">

		<label for="price"> Price: </label>
			<input type="number" name="price"/>
			<br>
<!-- 		<label for="platform"> Platform: </label> This should be a dropdown with pre-existing platforms, not a text box
			<input type="text" name="platform">
			<br> -->
			
			 <label for="platform">Platform: </label>
		<select name="platform">
			<c:forEach items="${platforms}" var="platform">
				<option value="${platform}">
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
		<input type="submit" value="List Game for Sale"/>
		</form>

	</div>
</body>
</html>
