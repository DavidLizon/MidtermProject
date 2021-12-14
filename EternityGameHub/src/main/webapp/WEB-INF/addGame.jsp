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

<!-- ADD NAV BAR HERE -->

	<h1>Add New Game to EGH</h1>

	<form action="addNewGame.do" method="get"> <!--Need to match action address & get/put method to controller  -->
	<br>
	<label for="name">Name:</label>
		<input type="text" name="name"/> <br>
		
	<label for="description">Description:</label>
		<input type="text" name="description"/><br>
		
	<label for="maxPlayers">Max players:</label>
		<input type="text" name="maxPlayers"/><br>
		
	<label for="genre">Genre:</label> 
		<input type="text" name="genre"/><br>
	
	<label for="platform">Platform:</label> 
		<input type="text" name="platform"/><br> <!-- What does "name"= need to match? -->
	
	<label for="rentalPrice">Rental price:</label> 
		<input type="text" name="rentalPrice"/><br>
	
	<label for="salePrice">Sale price:</label>
		<input type="text" name="salePrice"/><br>
		
	<!-- need to add image upload field -->
	
	<input type="submit" value="Submit Game">
	</form>
</body>
</html>