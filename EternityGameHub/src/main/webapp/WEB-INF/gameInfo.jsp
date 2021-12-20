<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${game.title} | Eternity GameHub</title>
<!-- How can we pull title from the game to display in the title? -->
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
		<div class="gameinfo">
			<div class="gameinfoGame">
				<div class="gameInfoTitle">
					<h2>${gameItem.game.title}</h2><br>
				</div>
				
				<div class="gameInfoImg">
					<img src="${gameItem.game.gameImageUrl}" alt="${gameItem.game.title} Cover Art">
				</div>
				
			</div>
			
			<div class="gameInfoInventory">	
			
				<div class="gameInfoGameDescription">
					<!-- this can be wrapped in a box, these are instructions how  https://www.w3schools.com/css/css_boxmodel.asp -->
					Game Description: ${gameItem.game.description} <br><br>
				</div>
				
				<div class="gameInfoMaxPlayers">
					Max Players: ${gameItem.game.maxPlayers} <br><br>
				</div>
				
				<div class="gameInfoRating">
					Game Rating: ${gameItem.game.rating} <br><br>
				</div>
				
				<div class="gameInfoGenre">
					<c:forEach items="${gameItem.game.genres}" var="genre">
						Game Genre: ${genre.name}	<br><br>	
					</c:forEach>
				</div>
				
				<div class="gameInfoPlatform">
					Game Platform: ${gameItem.platform.name} <br><br>
				</div>
				
				<div class="gameInfoCondition">
					Condition:  <c:choose>
									<c:when test="${ not gameItem.conditionNew}"> Used </c:when>		
									<c:when test="${gameItem.conditionNew}"> New </c:when>		
								</c:choose>	<br><br>
				</div>
			
				<div class="gameInfoInventoryDescription">
					 User description: ${gameItem.description } <br><br>
				</div>
				
				<div class="gameInfoPrice">
					Buy for <fmt:formatNumber type="currency" value="${gameItem.salePrice}"/>  
				</div><br>
			
				<div class="gameInfoAddToCart">
					<!-- Have to confirm action & method type -->
					<form action="addToCart.do" method="GET">
						<input type="submit" value="Add to Cart">
						<input type="hidden" name="addToCartByInventoryId" value="${gameItem.id}"/>
					</form>
				</div>
				
				<div class="gameInfoAlreadyInCart">
					<c:choose>
						<c:when test="${!empty gameAlreadyInCart}">
							<h5>${gameAlreadyInCart}</h5>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
</body>
</html>