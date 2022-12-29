<%@page import="Model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>ZenBlog Bootstrap Template - Contact</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=EB+Garamond:wght@400;500&family=Inter:wght@400;500&family=Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">

  <!-- Template Main CSS Files -->
  <link href="assets/css/variables.css" rel="stylesheet">
  <link href="assets/css/main.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: ZenBlog - v1.3.0
  * Template URL: https://bootstrapmade.com/zenblog-bootstrap-blog-template/
  * Author: BootstrapMade.com
  * License: https:///bootstrapmade.com/license/
  ======================================================== -->
	<!-- 폰트어썸 script -->
	<script src="https://kit.fontawesome.com/10cd32872a.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.2.min.js"></script>
	<script type="text/javascript">
		navigator.geolocation.getCurrentPosition(success, error);
		
		function success(position) {
			console.log(position);
			    const latitude = position.coords.latitude;  // 경도  
			    const longitude = position.coords.longitude;  // 위도
			    const coordsObj = {
			        latitude,
			        longitude
			    };
			    saveCoords(latitude, longitude);
			    getWeather(latitude, longitude);
		}
	
		function error() {
			console.log("위치 정보를 가져올 수 없습니다." + err);
		}

		function saveCoords(latitude, longitude) {
			sessionStorage.setItem("userLat", latitude);
			sessionStorage.setItem("userLng", longitude);
			console.log(sessionStorage.getItem("userLat"));
			console.log(sessionStorage.getItem("userLng"));
		    }
	
		function requestCoords() {
		    navigator.geolocation.getCurrentPosition(success, error);
		}
		
		function getWeather(latitude, longitude) {
			$.getJSON('https://api.openweathermap.org/data/2.5/weather?lat=35.1074481&lon=126.8828409&appid=b408d025daceb6920be202dc72f52ccc&units=metric',function(data){
				console.log(data.main.temp);
				console.log(data.weather[0].main);
				var $temp = data.main.temp;
				var $weather = data.weather[0].main;
				
				$('.temp').prepend($temp);
				if($weather=="Clouds"){
					$('.weather').attr('class','weather fa-solid fa-cloud-sun');
				}else if($weather=="Clear"){
					$('.weather').attr('class','weather fa-solid fa-sun');
				}else if($weather=="Thunderstorm"){
					$('.weather').attr('class','weather fa-solid fa-cloud-bolt');
				}else if($weather=="Drizzle"){
					$('.weather').attr('class','weather fa-solid fa-cloud-rain');
				}else if($weather=="Rain"){
					$('.weather').attr('class','weather fa-solid fa-cloud-showers-heavy');
				}else if($weather=="Snow"){
					$('.weather').attr('class','weather fa-regular fa-snowflake');
				}else if($weather=="Atmosphere"){
					$('.weather').attr('class','weather fa-solid fa-smog');
				}else{
					$('.weather').attr('class','weather fa-solid fa-cloud');
				}
			})
		}
	</script>
</head>

<body>
<%
	UserDTO dto = new UserDTO();

	dto.setId("smhrd");
	dto.setName("이창현");
	dto.setRrn("123456-1234567");
	dto.setGrade("C");
	
	String id = dto.getId();
	String name = dto.getName();
	String rrn = dto.getRrn();
	String grade = dto.getGrade();
	
	if(grade.equals("A")){
		grade = "VIP";
	}else if(grade.equals("B")){
		grade = "GOLD";
	}else if(grade.equals("C")){
		grade = "SILVER";
	}else {
		grade = "IRON";
	}

	session.setAttribute("id", id);
%>




  <!-- ======= Header ======= -->
  <header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl d-flex align-items-center justify-content-between">

      <a href="index.html" class="logo d-flex align-items-center">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <img src="https://i.postimg.cc/j27n4qQh/removebg.png" alt="">
        <h1>안전+</h1>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="single-post.html">Single Post</a></li>
          <li class="dropdown"><a href="category.html"><span>대응 요령</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
            <ul>
              <li class="dropdown"><a href="#"><span>자연재난</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul>
                  <li><a href="#">침수</a></li>
                  <li><a href="#">태풍</a></li>
                  <li><a href="#">호우</a></li>
                  <li><a href="#">낙뢰</a></li>
                  <li><a href="#">강풍</a></li>
                  <li><a href="#">풍랑</a></li>
                  <li><a href="#">대설</a></li>
                  <li><a href="#">폭염</a></li>
                  <li><a href="#">황사</a></li>
                  <li><a href="#">지진</a></li>
                  <li><a href="#">해일</a></li>
                  <li><a href="#">가뭄</a></li>
                  <li><a href="#">홍수</a></li>
                  <li><a href="#">산사태</a></li>
                </ul>
              </li>
              <li class="dropdown"><a href="#"><span>사회재난</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul>
                  <li><a href="#">화재</a></li>
                  <li><a href="#">산불</a></li>
                  <li><a href="#">건축물붕괴</a></li>
                  <li><a href="#">폭발</a></li>
                  <li><a href="#">교통사고</a></li>
                  <li><a href="#">전기ㆍ가스사고</a></li>
                  <li><a href="#">철도ㆍ지하철사고</a></li>
                  <li><a href="#">해양 선박사고</a></li>
                  <li><a href="#">수질오염</a></li>
                  <li><a href="#">정전 및 전력부족</a></li>
                  <li><a href="#">해양오염사고</a></li>
                  <li><a href="#">화학물질사고</a></li>
                  <li><a href="#">미세먼지</a></li>
                </ul>
              </li>
            </ul>
          </li>

          <li><a href="about.html">대피소</a></li>
          <li><a href="contact.html">이벤트</a></li>
        </ul>
      </nav><!-- .navbar -->

      <div class="position-relative">
        <a href="#" class="mx-2"><span class="temp">℃</span></a>
        <a href="#" class="mx-2"><span class="weather"></span></a>

        <a href="#" class="mx-2 js-search-open"><span class="bi-search"></span></a>
        <i class="bi bi-list mobile-nav-toggle"></i>

        <!-- ======= Search Form ======= -->
        <div class="search-form-wrap js-search-form-wrap">
          <form action="search-result.html" class="search-form">
            <span class="icon bi-search"></span>
            <input type="text" placeholder="Search" class="form-control">
            <button class="btn js-search-close"><span class="bi-x"></span></button>
          </form>
        </div><!-- End Search Form -->

      </div>

    </div>

  </header><!-- End Header -->
  
  <main id="main">
    <section>
      <div class="container">
        <div class="row">
          <div class="col-md-9" data-aos="fade-up">
            <form action="UpdateProfile" method="post" class="inputform">
            <div class="col-lg-12 text-center mb-5">
              <h1 class="page-title">내 정보</h1>
            </div>
            <div>
              <h3>ID</h3>
              <div class="form-control" name="id" required>
                <%=id%>
              </div>
            </div><br>
            <div>
              <h3>이름</h3>
              <div class="form-control" name="name" required>
                <%=name%>
              </div>
            </div><br>
            <div>
              <h3>주민등록번호</h3>
              <div class="form-control" name="rrn" required>
                <%=rrn%>
              </div>
            </div><br>
            <div>
                <h3>등급</h3>
                <div class="form-control" name="grade" required>
                  <%=grade%>등급
                </div>
              </div><br>
            <div class="form-group">
              <h3>닉네임</h3>
              <input type="text" class="form-control" name="nick" id="nick" placeholder="Your Nickname">
            </div><br>
            <div class="form-group">
              <h3>비밀번호</h3>
              <input type="password" class="form-control" name="pw" id="pw" placeholder="Your Password">
            </div><br>
            <div class="form-group">
              <h3>EMAIL</h3>
              <input type="email" class="form-control" name="email" id="email" placeholder="Your Email">
            </div><br>
            <br>
            <!-- <div class="text-center">
              <button type="submit" formmethod="post" onclick="nextPage()">정보수정</button>
            </div> -->
            <div class="text-center">
              <input type="submit" value="정보수정">
            </div>
            
          </form>

            
          </div>

          <div class="col-md-3">
            <!-- ======= Sidebar ======= -->
            <div class="aside-block">

              <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" id="pills-popular-tab" data-bs-toggle="pill" data-bs-target="#pills-popular" type="button" role="tab" aria-controls="pills-popular" aria-selected="true">내 정보</button>
                </li>
              </ul>

              <div class="tab-content" id="pills-tabContent">

                <!-- Popular -->
                <div class="tab-pane fade show active" id="pills-popular" role="tabpanel" aria-labelledby="pills-popular-tab">
                  <div class="post-entry-1 border-bottom">
                    <div class="post-meta"></div>
                    <h2 class="mb-2"><a href="#">How to Avoid Distraction and Stay Focused During Video Calls?</a></h2>
                    <span class="author mb-3 d-block">Jenny Wilson</span>
                    <span class="author mb-3 d-block">Jenny Wilson</span>
                  </div>

                  <div class="post-entry-1 border-bottom">
                    <div class="post-meta"></div>
                    <h2 class="mb-2"><a href="#">17 Pictures of Medium Length Hair in Layers That Will Inspire Your New Haircut</a></h2>
                    <span class="author mb-3 d-block">Jenny Wilson</span>
                  </div>

                </div> <!-- End Popular -->


              </div>
            </div>

            <div class="aside-block">
              <h3 class="aside-title">내 위치</h3>
              <div class="video-post">
              	<iframe src="http://localhost:8087/Anjun_Plus/UserLocation.jsp"></iframe>
              </div>
            </div><!-- End Video -->

            <div class="aside-block">
              <h3 class="aside-title">Tags</h3>
              <ul class="aside-tags list-unstyled">
                <li><a href="category.html">지진</a></li>
                <li><a href="category.html">홍수</a></li>
                <li><a href="category.html">침수</a></li>
                <li><a href="category.html">Food</a></li>
                <li><a href="category.html">Politics</a></li>
                <li><a href="category.html">Celebrity</a></li>
                <li><a href="category.html">Startups</a></li>
                <li><a href="category.html">Travel</a></li>
              </ul>
            </div><!-- End Tags -->

          </div>

        </div>
      </div>
    </section>
  </main><!-- End #main -->
  

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">


    <div class="footer-legal">
      <div class="container">

        <div class="row justify-content-between">
          <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
            <div class="copyright">
              © Copyright <strong><span>ZenBlog</span></strong>. All Rights Reserved
            </div>

            <div class="credits">
              <!-- All the links in the footer should remain intact. -->
              <!-- You can delete the links only if you purchased the pro version. -->
              <!-- Licensing information: https://bootstrapmade.com/license/ -->
              <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/herobiz-bootstrap-business-template/ -->
              Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>

          </div>

          <div class="col-md-6">
            <div class="social-links mb-3 mb-lg-0 text-center text-md-end">
              <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
              <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
              <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
              <a href="#" class="google-plus"><i class="bi bi-skype"></i></a>
              <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
            </div>

          </div>

        </div>

      </div>
    </div>

  </footer>

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  <script type="text/javascript">
	function nextPage()  {
		$(location).attr('href', 'UpdateProfile');
		}
  
  
  </script>

</body>

</html>