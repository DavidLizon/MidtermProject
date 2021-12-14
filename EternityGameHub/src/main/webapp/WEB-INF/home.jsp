<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGH Home</title>
<jsp:include page="bootstrapHead.jsp"/>
<jsp:include page="navBar.jsp"/>
</head>
<body>
<div class="listedGames">
<!-- this div will display the games user currently has listed for sale or rent -->


</div>
<div class="purchaseHistory">
<!-- This div will display a history of games the user has purchased or rented in the past -->
</div>
<div>
<form action = "addGame.do" method="GET">
	<input type="submit" value="Add new game"/>
</form>
<!-- for remove game, how to click from the list of games and delete with same button -->
</div>
<div>
<form>

</form>

</div>

</body>
</html>