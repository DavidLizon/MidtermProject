<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listing Success! | Eternity GameHub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>

<body>
	<jsp:include page="navBar.jsp" />


<div class = "sell-add-inventory-item-successful">	
			<div class = "sell-add-inventory-item-successful-header">	
			<div class = "sell-add-inventory-item-successful-header-1">	
			<input type="hidden" name="game.id" value="${game.id}"/>			
			<label>Great success!<br></label>
			<label> You've successfully listed ${game.title} for sale!</label></div>
			<div class = "sell-add-inventory-item-successful-header-2">	
			<img src="${game.gameImageUrl}" alt="${game.title} Cover Art"></div></div>
		 
			<div class="sell-add-inventory-item-successful-inner-group">Description:<br>${game.description}</div>
		 	
			<div class="sell-add-inventory-item-successful-inner-group">Max players: ${game.maxPlayers} </div>
		 
			<div class="sell-add-inventory-item-successful-inner-group">Genre: 
				<c:forEach items="${game.genres}">
				${game.genres.name}
				</c:forEach></div>
		
			<div class="sell-add-inventory-item-successful-inner-group">Rating: ${game.rating.name} </div>			
		 
			<div class="sell-add-inventory-item-successful-inner-group"> Price:
			<fmt:formatNumber type="currency" value="${newGameInventoryItem.salePrice}"/> </div>
		 
		 	
			<div class="sell-add-inventory-item-successful-inner-group"> Condition: 
				<c:choose>
					<c:when test="${ not newGameInventoryItem.conditionNew}"> Used </c:when>		
					<c:when test="${newGameInventoryItem.conditionNew}"> New </c:when>		
				</c:choose></div>
		 
		 	
			<div class="sell-add-inventory-item-successful-inner-group"> Description: <br>
			${newGameInventoryItem.description} </div>
	</div>	
</body>
</html>