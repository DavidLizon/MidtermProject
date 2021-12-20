<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Inventory | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />
<jsp:include page="navBar.jsp" />
</head>

<body id = "sell-add-inventory-item-page">
	<div class="sell-add-inventory-item-page-outer">
		<div class="sell-add-inventory-item-page-inner">
			<div class="sellAddTitleImg">
				<h1 class="sell-add-inventory-item-page-inner-group-header" colspan="2">${newGame.title}</h1>
				<div><img src="${newGame.gameImageUrl}" alt="${newGame.title} Cover Art"></div>
			</div>
			<input type="hidden" name="newGame.id" value="${newGame.id}"/>
			<div class="sell-add-inventory-item-page-inner-group">Description: <br> ${newGame.description}</div>
			<div class="sell-add-inventory-item-page-inner-group">Max players: ${newGame.maxPlayers}</div>
			<div class="sell-add-inventory-item-page-inner-group">Genre:
			<c:forEach items="${newGame.genres}" var="genre">${genre.name}</c:forEach></div>
			<div class="sell-add-inventory-item-page-inner-group">Rating: ${newGame.rating}</div>
		</div>
	</div>	

	<form class="sell-add-inventory-item-container" action="addGameInventoryItem.do" method="POST">
		<div class = "sell-add-inventory-item-container-group">
			<label for="price"> Price: </label>
			<input type="number" step="0.01" name="salePrice" min="0" max="99"/><br><br>
		</div>
		<div class = "sell-add-inventory-item-container-group">
		
			<label for="platform">Platform: </label>
			<select name="platform.id">
				<c:forEach items="${platforms}" var="platform">
					<option value="${platform.id}">
						${platform.name}
					</option>
				</c:forEach>
			</select><br><br>	
		</div>
		<div class = "sell-add-inventory-item-container-group">
		
			<label for="conditionNew">Condition: </label>
				<input type="radio" name="conditionNew" value="1"/> New 
				<input type="radio" name="conditionNew" value="0"/> Used <br><br>
		</div>
		<div class = "sell-add-inventory-item-container-group">
		
		<label for="description">Description: </label>
			<input type="text" name="description"/>
		</div>
		<div class = "sell-add-inventory-item-container-group">
			<input type="hidden" name="genres" value="${newGame.genres}"/>
			<input type="hidden" name="ratings" value="${newGame.rating}"/>	
			<input type="hidden" name="user.id" value="${user.id}"/>
			<input type="hidden" name="gameID" value="${newGame.id}"/>	
			<input type="submit" value="List Game for Sale"/>
		</div>	
	</form>
	</body>
</html>
