<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/js/sidenav.js" var="sidenavJS"></spring:url>
<jsp:include page="/WEB-INF/jsp/templates/headers.jsp"></jsp:include>
<body background="resources/img/foosball.jpg">
	<jsp:include page="/WEB-INF/jsp/templates/menu.jsp"></jsp:include>
	<div class="container-fluid p-0">
		<span id="nav-button" style="font-size: 30px; cursor: pointer"
			onclick="openNav()">&#9776; Foosball</span>
		<div id="main" align="center">

			<section class="resume-section 
			p-3 p-lg-5 d-flex d-column"
				id="addPlayers">
				<div class="my-auto">
					<h1 class="mb-0">
						Lets Play <span class="text-primary"> FOOSBALL</span>
					</h1>
				</div>
			</section>

		</div>
	</div>
	<script src="${sidenavJS }"></script>
	<jsp:include page="/WEB-INF/jsp/templates/footer.jsp"></jsp:include>

</body>
</html>