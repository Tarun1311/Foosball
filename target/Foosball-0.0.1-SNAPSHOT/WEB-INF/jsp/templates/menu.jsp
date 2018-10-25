<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/employee/" var="addplayers"></spring:url>
<spring:url value="/team/" var="addteam"></spring:url>
<spring:url value="/match/" var="addmatches"></spring:url>
<spring:url value="/employee/hlll" var="leaderboard"></spring:url>
<div id="mySidenav" class="sidenav">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&#9776;<!-- &times; --></a>
	<ul>
		<li class="nav-item"><a class="nav-link js-scroll-trigger"
			href="${addplayers }">Add Players</a></li>
		<li class="nav-item"><a class="nav-link js-scroll-trigger"
			href="${addteam }">Add Team</a></li>
		<li class="nav-item"><a class="nav-link js-scroll-trigger"
			href="${addmatches }">Add Match</a></li>
		<li class="nav-item"><a class="nav-link js-scroll-trigger"
			href="${leaderboard }">LeaderBoard</a></li>
	</ul>
</div>
