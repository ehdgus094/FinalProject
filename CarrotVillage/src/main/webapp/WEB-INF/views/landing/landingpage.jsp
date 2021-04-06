<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<html>
<head>
<title>landing페이지</title>
<meta name="viewport" content="width-device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet"> <!--CDN 링크 -->
<style>
	
	html,body {
		margin:0;
		height:100%;
		width : 100%;
		background: #f6fcf1; 
	}
	.container {
		width: 100%;
		height:100%;
		background: #f6fcf1; 
		display: grid;
	}
	.card-title {
		display : grid;
		font-size : 4em;
		font-weight : bolder;
		color : orange;
		margin-top : -20px;
		grid-row-start: 4;
	    grid-row-end: 5;
	    grid-column-start: 4;
	    grid-column-end: 12;
	}
	a:hover {
	color : orange;
    text-decoration: none;
    }
    
	.card-text {
		display : grid;
		font-size : 1em;
		font-weight : bold;
		color : #898686;
		grid-row-start: 5;
	    grid-row-end: 6;
	    grid-column-start: 6;
	    grid-column-end: 13;
	    align-self: center;
	}
	.card img-fluid {
	   margin: auto;
	   background: #f6fcf1;
	   border: none;
	}
	.card-img-top{
	    min-width: 70%;
        min-height: 100%;
		height : auto;
		margin: auto;
	    background: #f6fcf1;
	    opacity: 0.2;
	}
	.card-img-overlay {
		display : grid;
		grid-template-rows : repeat(12, 8%);
		grid-template-columns : repeat(12, 8%);
	}
	
	.buttons{
		 display : grid; 
		 width: 1200px;
  		 height: 700px;
   		 grid-template-rows: repeat(12, 8%);
   		 grid-template-columns: repeat(12, 8%);
   		 margin-left: -40%;
	}
	
	.card {
		border : none;
	}
	.icons {
		 display : grid; 
		 width: 1200px;
  		 height: 700px;
   		 grid-template-rows: repeat(12, 8%);
   		 grid-template-columns: repeat(12, 8%);
	}
	
	.icons:hover {
		opacity:1; 
	}
	
	.icons .fa-shopping-cart {
		display : grid; 
		opacity : 0.7;
		grid-row-start: 7;
	    grid-row-end: 9;
	    grid-column-start: 3;
	    grid-column-end: 5;
	    color: #165916;
   }
   .icons  .fa-user-friends {
        display : grid; 
		opacity : 0.7;
		grid-row-start: 7;
	    grid-row-end: 9;
	    grid-column-start: 6;
	    grid-column-end: 8;
	    color: #165916;
   }
   .icons  .fa-utensils {
	    display : grid; 
		opacity : 0.7;
		grid-row-start: 7;
	    grid-row-end: 9;
	    grid-column-start: 9;
	    grid-column-end:11;
	    color: #165916;
   }
    .ghost-button {
        align-items: left;
        display: grid;
        padding: 15px 30px;
        border: 3px solid #c2daa6;
        color: #54752e;
        text-align: center; 
        font-weight: bolder;
    }
    .ghost-button:hover {
       background-color: #2d7a29;
   	   color: #f8faf6;
       font-weight: bolder;
    }
    
    .buttons #market {
        display : grid; 
    	grid-row-start: 9;
	    grid-row-end: 10;
	    grid-column-start: 2;
	    grid-column-end: 4;
    }
    .buttons #meetup {
   	    display : grid; 
    	grid-row-start: 9;
	    grid-row-end: 10;
	    grid-column-start: 5;
	    grid-column-end:7;
    }
    .buttons #sub {
     	display : grid; 
    	grid-row-start: 9;	
	    grid-row-end: 10;
	    grid-column-start: 8;
	    grid-column-end:10;
    }
    
    @media only screen and (max-width: 1000px) {
		.card-img-overlay {
			margin-left : -180px; 
			vertical-align : center;
	  }
    @media only screen and (max-width: 840px) {
    	.card-img-overlay {
			margin-left : -200px; 
			vertical-align : center;
	  }
    
   /*  
     @media only screen and (max-width: 781px) {
    	.card-img-overlay {
			margin-left : -200px; 
			margin-top : -200px;
			vertical-align : center;
	  }
		.icons, .buttons {  
		grid-auto-flow : row;
	 }  
	 */
   

</style> 
</head>
<body>
<div class="container">
  <div class="card img-fluid" >
    <img class="card-img-top"
       src="${pageContext.request.contextPath}/resources/image/nhr_landingcarrot.jpg"  alt="" >
    <div class="card-img-overlay">
      <a href="${pageContext.request.contextPath}/main/mainPage" class="card-title">당근빌리지</a>
      <h6 class="card-text">나와 가까운 동네의 이웃들과 당신의 일상을 함께하세요!</h6>
	      <div class="icons">
				<i class="fas fa-shopping-cart fa-5x" aria-hidden="true" ></i> 
				<i class="fas fa-user-friends fa-5x" aria-hidden="true"></i> 
				<i class="fas fa-utensils fa-5x" aria-hidden="true"></i>
		  </div>
		  <div class="buttons">
		      <a href="${pageContext.request.contextPath}/market/list" class="ghost-button" id="market">중고마켓</a>
		      <a href="${pageContext.request.contextPath}/meetup/list" class="ghost-button" id="meetup">우리동네 소모임</a>
		      <a href="${pageContext.request.contextPath}/sub/submarket" class="ghost-button" id="sub">동네 온라인마켓</a>
	     </div>
      </div>	  
   </div>
</div>
</body>
</html>