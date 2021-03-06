<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
<div class="search">
  <div class="game-search">
    <!-- have this div all on left or right side -->
    <form class="search-criteria" action="findByKeyword.do" method="GET">

	<div class="titleSearch">
      <label for="title">Search by Title</label>
      <input type="text" name="title"><br><br>
	</div>
	
	<div class="searchCondition">
    	<label for="condition">Condition</label>
    		<select class="condition" name="filteredcondition">
        		<option value="new">New</option>
        		<option value="used">Used</option>
      		</select><br><br>
    </div>

	<div class = searchGenre>
		<label for="genre">Genre: </label>
			<select name="genreId">
				<option value=0>--Choose Genre--</option>
				<c:forEach items="${genres}" var="genre">
					<option value="${genre.id}">
							${genre.name}
					</option>
				</c:forEach>
			</select>	
		<br><br>
      </div>
      	
      <div class="searchRating">
      	<label for="rating">Rating: </label>
			<select name="ratingId">
			<option value=0>--Choose Rating--</option>
				<c:forEach items="${ratings}" var="rating">
					<option value="${rating.id}">
							${rating.name}
					</option>
				</c:forEach>
			</select>	<br><br>
	  </div>
	  
      <div class="searchPlatform">
      	<label for="platform">Platform: </label>
			<select name="platformId">
			<option value=0>--Choose Platform--</option>
				<c:forEach items="${platforms}" var="platform">
					<option value="${platform.id}">
							${platform.name}
					</option>
				</c:forEach>
			</select><br><br>
	   </div>
	   
	   <div class="searchButton">
      		<input type="submit" value="Search">
       </div>
    </form>
  </div>
  <!-- must have a selection for all fields before submitting search -->
  <!-- search conditions stretch goals  -sale/rent -->

  
  
  <div class="searchResults">
		<c:choose>
			<c:when test="${! empty result}">
				<ul>
					<c:forEach var="item" items="${result}">
						<c:choose>
							<c:when test="${item.available}">
								<li><a href="goToItemListing.do?inventoryItemId=${item.id}">${item.game.title} <fmt:formatNumber type="currency" value="${item.salePrice}"/> </a></li>
							</c:when>
						</c:choose>
					</c:forEach>
				</ul>
				<!-- Not seeing what you're looking for? -->
			</c:when>
		</c:choose>
	</div>
</div>
</body>
</html>