<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGH Home</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navBar.jsp"/>
	<section class="buy-sell">
      <div class="container">

        <div class="left-button">
         	<button onclick="location.href='goToSearchByTitle.do'" class="sell-button" type="button">SELL</button>
        </div>

        <div class="right-button">
          <button onclick="location.href='search.do'" class="buy-button" type="button">BUY</button>
        </div>

      </div>
    </section>
<br>
    <section class="reviews">
      <div class="container">
        <ul>
          <li>
            <blockquote>
              "The only place I go when I need a new game!"
            </blockquote>
            <cite>-Ryan Majors</cite>
          </li>
          <li>
            <blockquote>
              "My son loves to buy his games here, I would recommend this site to anyone!"
            </blockquote>
            <cite>-Ryan Majors Mom</cite>
          </li>
          <li>
            <blockquote>
              "All my homies use Eternity Game Hub"
            </blockquote>
            <cite>-Dane S</cite>
          </li>
        </ul>
      </div>
    </section>
</body>
</html>