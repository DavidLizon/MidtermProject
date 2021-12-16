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
	<jsp:include page="navBar.jsp" />

  <div class="game-search">
    <!-- have this div all on left or right side -->
    <form class="search-criteria" action="findByKeyword.do" method="GET">

      <label for="title">Keyword search for Title or Description</label>
      <input type="text" name="title" required><br>


      <label for="condition">Condition</label>
      <select class="condition" name="condition" required>
        <option value="new">New</option>
        <option value="used">Used</option>
      </select><br>

		
		<%-- <label for="genre">Genre: </label>
			<select name="genre.id" required>
				<c:forEach items="${genres}" var="genre">
					<option value="${genre.id}">
							${genre.name}
					</option>
				</c:forEach>
			</select>	
		<br>
      
      <label for="rating">Rating: </label>
			<select name="rating.id" required>
				<c:forEach items="${ratings}" var="rating">
					<option value="${rating.id}">
							${rating.name}
					</option>
				</c:forEach>
			</select>	
		<br>
      
      <label for="platform">Platform: </label>
			<select name="platform.id" required>
				<c:forEach items="${platforms}" var="platform">
					<option value="${platform.id}">
							${platform.name}
					</option>
				</c:forEach>
			</select>	
		<br>

      <label for="maxPlayers">Max Players</label>
      <select class="maxPlayers" name="maxPlayers" required>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
      </select><br> --%>
      <input type="submit" value="Search">
    </form>
  </div>
  <!-- must have a selection for all fields before submitting search -->
  <!-- search conditions stretch goals  -sale/rent -->
  <div class="searchResults">
		<c:choose>
			<c:when test="${! empty result}">
				<ul>
					<c:forEach var="item" items="${result}">
						<!-- Need to confirm these names are correct  -->
						<li><a href="goToItemListing.do?inventoryItemId=${item.id}">${item.title}</a></li>
						<!-- Need to confirm href is correct -->
					</c:forEach>
				</ul>
				<!-- Not seeing what you're looking for? -->
			</c:when>
		</c:choose>
	</div>
</body>
</html>