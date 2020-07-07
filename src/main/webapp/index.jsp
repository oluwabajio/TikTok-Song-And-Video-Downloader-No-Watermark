<%@ page import="com.github.kiulian.downloader.model.formats.AudioVideoFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.github.kiulian.downloader.model.formats.AudioFormat" %>
<%@ page import="com.github.kiulian.downloader.model.formats.VideoFormat" %>
<%@ page import="java.io.File" %>
<%@ page import="com.github.kiulian.downloader.YoutubeDownloader" %>
<%@ page import="com.github.kiulian.downloader.model.YoutubeVideo" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="com.github.kiulian.downloader.OnYoutubeDownloadListener" %>
<%@ page import="com.github.kiulian.downloader.YoutubeException" %><%--
  Created by IntelliJ IDEA.
  User: administrator
  Date: 05/07/2020
  Time: 5:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Mentor Bootstrap Template - Index</title>
    <meta content="" name="descriptison">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">


</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

        <h1 class="logo mr-auto"><a href="index.html">Mentor</a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html" class="logo mr-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

        <nav class="nav-menu d-none d-lg-block">
            <ul>
                <li class="active"><a href="index.html">Home</a></li>
                <li><a href="tiktok.jsp">Tik Tok</a></li>
                <li><a href="courses.html">Courses</a></li>
                <li><a href="trainers.html">Trainers</a></li>
                <li><a href="events.html">Events</a></li>
                <li><a href="pricing.html">Pricing</a></li>
                <li class="drop-down"><a href="">Drop Down</a>
                    <ul>
                        <li><a href="#">Drop Down 1</a></li>
                        <li class="drop-down"><a href="#">Deep Drop Down</a>
                            <ul>
                                <li><a href="#">Deep Drop Down 1</a></li>
                                <li><a href="#">Deep Drop Down 2</a></li>
                                <li><a href="#">Deep Drop Down 3</a></li>
                                <li><a href="#">Deep Drop Down 4</a></li>
                                <li><a href="#">Deep Drop Down 5</a></li>
                            </ul>
                        </li>
                        <li><a href="#">Drop Down 2</a></li>
                        <li><a href="#">Drop Down 3</a></li>
                        <li><a href="#">Drop Down 4</a></li>
                    </ul>
                </li>
                <li><a href="contact.html">Contact</a></li>

            </ul>
        </nav><!-- .nav-menu -->

        <a href="courses.html" class="get-started-btn">Get Started</a>

    </div>
</header><!-- End Header -->

<main id="main">

    <!-- ======= About Section ======= -->
    <section id="main_download" class="about">
        <div class="container" data-aos="fade-up">

            <div class="section-title">
                <h2>About</h2>
                <p>About Us</p>
            </div>

            <div class="row">
                <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-left" data-aos-delay="100">
                    <img src="assets/img/how_to.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6 pt-4 pt-lg-0 order-2 order-lg-1 content">
                    <h3>Download High Quality Youtube Videos and Mp3 Audio</h3>
                    <br>
                    <form action="Youtube">
                        <div class="row">
                            <input type="text"placeholder="Enter Youtube Url" class="col-8 ml-3 form-control" name="vid_url">
                            <input type="submit" class="col-3" name="submit" value="Download">

                        </div>
                    </form>

                    <%!


                        final static String reg = "(?:youtube(?:-nocookie)?\\.com\\/(?:[^\\/\\n\\s]+\\/\\S+\\/|(?:v|e(?:mbed)?)\\/|\\S*?[?&]v=)|youtu\\.be\\/)([a-zA-Z0-9_-]{11})";
                        public static String getVideoId(String videoUrl) {
                            if (videoUrl == null || videoUrl.trim().length() <= 0)
                                return null;

                            Pattern pattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
                            Matcher matcher = pattern.matcher(videoUrl);

                            if (matcher.find())
                                return matcher.group(1);
                            return null;
                        }

                        private String formatVideoQualityString(String videQuality) {

                            String formatedQUality;
                            if (videQuality.equalsIgnoreCase("tiny")) {
                                formatedQUality = "144p";
                            } else if (videQuality.equalsIgnoreCase("small")) {
                                formatedQUality = "240p";
                            } else if (videQuality.equalsIgnoreCase("medium")) {
                                formatedQUality = "360p";
                            }else if (videQuality.equalsIgnoreCase("large")) {
                                formatedQUality = "480p";
                            }else if (videQuality.equalsIgnoreCase("hd720")) {
                                formatedQUality = "720p";
                            }else if (videQuality.equalsIgnoreCase("hd1080")) {
                                formatedQUality = "1080p";
                            }else if (videQuality.equalsIgnoreCase("hd1440")) {
                                formatedQUality = "1440p";
                            }else if (videQuality.equalsIgnoreCase("hd2160")) {
                                formatedQUality = "2160p";
                            }else if (videQuality.equalsIgnoreCase("hd2880p")) {
                                formatedQUality = "2880p";
                            }else if (videQuality.equalsIgnoreCase("highres")) {
                                formatedQUality = "3072p";
                            } else {
                                formatedQUality = videQuality;
                            }

                            return formatedQUality;
                        }



                        List<AudioVideoFormat> videoWithAudioFormats = null;
                        List<AudioFormat> audioOnlyFormats = null;
                        List<VideoFormat> videoOnlyFormats = null;
                        List<VideoFormat> allVidoeFormats = null;

                        String ytUrl = null;
                    %>

                    <br>


                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#video" role="tab" aria-controls="pills-home" aria-selected="true">Videos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#audio" role="tab" aria-controls="pills-profile" aria-selected="false">Audio (Mp3)</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="pills-all-videos-tab" data-toggle="pill" href="#allvideo" role="tab" aria-controls="pills-home" aria-selected="false">All Videos</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="video" role="tabpanel" aria-labelledby="pills-home-tab">

                            <%
                                //yt Url
                                ytUrl = (String) request.getAttribute("yt_url");

                                //Videos WIth Audio
                                videoWithAudioFormats = (List<AudioVideoFormat>) request.getAttribute("vid_formats");
                                audioOnlyFormats = (List<AudioFormat>) request.getAttribute("audio_formats");
                                videoOnlyFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");
                                allVidoeFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");

                                if (videoWithAudioFormats != null) {
                                    System.out.println("its not null");
                                    if (videoWithAudioFormats.size() >= 1) {

                                        out.println("<table class=\"table table-bordered \">");
                                        out.println("<th>Quality</th>");
                                        out.println("<th>Extension</th>");
                                        out.println("<th>Download</th>");



                                        for (int i=0; i<videoWithAudioFormats.size(); i++) {
                                            String url = videoWithAudioFormats.get(i).url();
                                            String videQuality =videoWithAudioFormats.get(i).videoQuality() +"";
                                            videQuality = formatVideoQualityString(videQuality);
                                            String videoExtension =videoWithAudioFormats.get(i).extension().value() +"";

                                            out.println("<tr>");
                                            out.println("<td>"+ videQuality +"</td>");
                                            out.println("<td>"+ videoExtension +"</td>");
                                            out.println("<td><a href="+ url +" target=\"_blank\" class=\"learn-more-btn\">Download</a></td>");
                                            out.println("</tr>");
                                        }


                                        out.println("</table>");

                                        out.println("<input type=\"text\" id=\"yt-url\" value=\"" + ytUrl +"\" hidden><br>");
                                        out.println("<input type=\"text\" id=\"vid-url\" value=\"" + videoWithAudioFormats.get(0).url() +"\" hidden><br>");


                                    } else {
                                        System.out.println("isize is less than one");
                                    }

                                } else {

                                    System.out.println("its null");
                                }


                            %>

                        </div>
                        <div class="tab-pane fade" id="audio" role="tabpanel" aria-labelledby="pills-profile-tab">

                            <%
                                // Audio Only
                                videoWithAudioFormats = (List<AudioVideoFormat>) request.getAttribute("vid_formats");
                                audioOnlyFormats = (List<AudioFormat>) request.getAttribute("audio_formats");
                                videoOnlyFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");
                                allVidoeFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");

                                if (audioOnlyFormats != null) {
                                    System.out.println("its not null");
                                    if (audioOnlyFormats.size() >= 1) {

                                        out.println("<table class=\"table table-bordered\">");
                                        out.println("<tr>");
                                        out.println("<th>Quality</th>");
                                        out.println("<th>Extension</th>");
                                        out.println("<th>Download</th>");
                                        out.println("</tr>");


                                        for (int i=0; i<audioOnlyFormats.size(); i++) {
                                            String url = audioOnlyFormats.get(i).url();
                                            String audioQuality =audioOnlyFormats.get(i).audioQuality() +"";
                                            String audioExtension =audioOnlyFormats.get(i).extension().value() +"";
                                            out.println("<tr>");
                                            out.println("<td>"+ audioQuality +"</td>");
                                            out.println("<td>"+ audioExtension +"</td>");
                                            out.println("<td><a href="+ url +" target=\"_blank\" class=\"learn-more-btn\">Download</a></td>");
                                            out.println("</tr>");
                                        }


                                        out.println("</table>");
                                    } else {
                                        System.out.println("isize is less than one");
                                    }

                                } else {

                                    System.out.println("its null");
                                }


                            %>
                        </div>

                        <div class="tab-pane fade" id="allvideo" role="tabpanel" aria-labelledby="pills-profile-tab">

                            <%
                                // All Video Type
                                videoWithAudioFormats = (List<AudioVideoFormat>) request.getAttribute("vid_formats");
                                audioOnlyFormats = (List<AudioFormat>) request.getAttribute("audio_formats");
                                videoOnlyFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");
                                allVidoeFormats = (List<VideoFormat>) request.getAttribute("all_vid_formats");

                                if (allVidoeFormats != null) {
                                    System.out.println("its not null");
                                    if (allVidoeFormats.size() >= 1) {

                                        out.println("<table class=\"table table-bordered\">");
                                        out.println("<tr>");
                                        out.println("<th>Quality</th>");
                                        out.println("<th>Extension</th>");
                                        out.println("<th>Download</th>");
                                        out.println("</tr>");


                                        for (int i=0; i<allVidoeFormats.size(); i++) {
                                            String url = allVidoeFormats.get(i).url();
                                            String videoQuality =allVidoeFormats.get(i).videoQuality() +"";
                                            videoQuality = formatVideoQualityString(videoQuality);
                                            String videoExtension =allVidoeFormats.get(i).extension().value() +"";

                                            out.println("<tr>");
                                            out.println("<td>"+ videoQuality +"</td>");
                                            out.println("<td>"+ videoExtension +"</td>");
                                            out.println("<td><a href="+ url +" target=\"_blank\" class=\"learn-more-btn\" >Download</a></td>");

                                            out.println("</tr>");
                                        }


                                        out.println("</table>");
                                    } else {
                                        System.out.println("isize is less than one");
                                    }

                                } else {

                                    System.out.println("its null");
                                }


                            %>


                        </div>

                    </div>



                    <br><br>


                    <p>
                        Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
                        in voluptate
                    </p>
                    <a href="about.html" class="learn-more-btn">Learn More</a>
                </div>
            </div>

        </div>
    </section><!-- End About Section -->
















    <!-- ======= About Section ======= -->
    <section id="about" class="about">
        <div class="container" data-aos="fade-up">

            <div class="section-title">
                <h2>About</h2>
                <p>About Us</p>
            </div>

            <div class="row">
                <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-left" data-aos-delay="100">
                    <img src="assets/img/about.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6 pt-4 pt-lg-0 order-2 order-lg-1 content">
                    <h3>Voluptatem dignissimos provident quasi corporis voluptates sit assumenda.</h3>
                    <p class="font-italic">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                        labore et dolore
                        magna aliqua.
                    </p>
                    <ul>
                        <li><i class="icofont-check-circled"></i> Ullamco laboris nisi ut aliquip ex ea commodo
                            consequat.
                        </li>
                        <li><i class="icofont-check-circled"></i> Duis aute irure dolor in reprehenderit in voluptate
                            velit.
                        </li>
                        <li><i class="icofont-check-circled"></i> Ullamco laboris nisi ut aliquip ex ea commodo
                            consequat. Duis aute irure dolor in reprehenderit in voluptate trideta storacalaperda
                            mastiro dolore eu fugiat nulla pariatur.
                        </li>
                    </ul>
                    <p>
                        Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
                        in voluptate
                    </p>
                    <a href="about.html" class="learn-more-btn">Learn More</a>
                </div>
            </div>

        </div>
    </section><!-- End About Section -->

    <!-- ======= Counts Section ======= -->
    <section id="counts" class="counts section-bg">
        <div class="container">

            <div class="row counters">

                <div class="col-lg-3 col-6 text-center">
                    <span data-toggle="counter-up">1232</span>
                    <p>Students</p>
                </div>

                <div class="col-lg-3 col-6 text-center">
                    <span data-toggle="counter-up">64</span>
                    <p>Courses</p>
                </div>

                <div class="col-lg-3 col-6 text-center">
                    <span data-toggle="counter-up">42</span>
                    <p>Events</p>
                </div>

                <div class="col-lg-3 col-6 text-center">
                    <span data-toggle="counter-up">15</span>
                    <p>Trainers</p>
                </div>

            </div>

        </div>
    </section><!-- End Counts Section -->

    <!-- ======= Why Us Section ======= -->
    <section id="why-us" class="why-us">
        <div class="container" data-aos="fade-up">

            <div class="row">
                <div class="col-lg-4 d-flex align-items-stretch">
                    <div class="content">
                        <h3>Why Choose Mentor?</h3>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            labore et dolore magna aliqua. Duis aute irure dolor in reprehenderit
                            Asperiores dolores sed et. Tenetur quia eos. Autem tempore quibusdam vel necessitatibus
                            optio ad corporis.
                        </p>
                        <div class="text-center">
                            <a href="about.html" class="more-btn">Learn More <i class="bx bx-chevron-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8 d-flex align-items-stretch" data-aos="zoom-in" data-aos-delay="100">
                    <div class="icon-boxes d-flex flex-column justify-content-center">
                        <div class="row">
                            <div class="col-xl-4 d-flex align-items-stretch">
                                <div class="icon-box mt-4 mt-xl-0">
                                    <i class="bx bx-receipt"></i>
                                    <h4>Corporis voluptates sit</h4>
                                    <p>Consequuntur sunt aut quasi enim aliquam quae harum pariatur laboris nisi ut
                                        aliquip</p>
                                </div>
                            </div>
                            <div class="col-xl-4 d-flex align-items-stretch">
                                <div class="icon-box mt-4 mt-xl-0">
                                    <i class="bx bx-cube-alt"></i>
                                    <h4>Ullamco laboris ladore pan</h4>
                                    <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
                                        deserunt</p>
                                </div>
                            </div>
                            <div class="col-xl-4 d-flex align-items-stretch">
                                <div class="icon-box mt-4 mt-xl-0">
                                    <i class="bx bx-images"></i>
                                    <h4>Labore consequatur</h4>
                                    <p>Aut suscipit aut cum nemo deleniti aut omnis. Doloribus ut maiores omnis
                                        facere</p>
                                </div>
                            </div>
                        </div>
                    </div><!-- End .content-->
                </div>
            </div>

        </div>
    </section><!-- End Why Us Section -->

    <!-- ======= Features Section ======= -->
    <section id="features" class="features">
        <div class="container" data-aos="fade-up">

            <div class="row" data-aos="zoom-in" data-aos-delay="100">
                <div class="col-lg-3 col-md-4">
                    <div class="icon-box">
                        <i class="ri-store-line" style="color: #ffbb2c;"></i>
                        <h3><a href="">Lorem Ipsum</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4 mt-md-0">
                    <div class="icon-box">
                        <i class="ri-bar-chart-box-line" style="color: #5578ff;"></i>
                        <h3><a href="">Dolor Sitema</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4 mt-md-0">
                    <div class="icon-box">
                        <i class="ri-calendar-todo-line" style="color: #e80368;"></i>
                        <h3><a href="">Sed perspiciatis</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4 mt-lg-0">
                    <div class="icon-box">
                        <i class="ri-paint-brush-line" style="color: #e361ff;"></i>
                        <h3><a href="">Magni Dolores</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-database-2-line" style="color: #47aeff;"></i>
                        <h3><a href="">Nemo Enim</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-gradienter-line" style="color: #ffa76e;"></i>
                        <h3><a href="">Eiusmod Tempor</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-file-list-3-line" style="color: #11dbcf;"></i>
                        <h3><a href="">Midela Teren</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-price-tag-2-line" style="color: #4233ff;"></i>
                        <h3><a href="">Pira Neve</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-anchor-line" style="color: #b2904f;"></i>
                        <h3><a href="">Dirada Pack</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-disc-line" style="color: #b20969;"></i>
                        <h3><a href="">Moton Ideal</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-base-station-line" style="color: #ff5828;"></i>
                        <h3><a href="">Verdo Park</a></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 mt-4">
                    <div class="icon-box">
                        <i class="ri-fingerprint-line" style="color: #29cc61;"></i>
                        <h3><a href="">Flavor Nivelanda</a></h3>
                    </div>
                </div>
            </div>

        </div>
    </section><!-- End Features Section -->

    <!-- ======= Popular Courses Section ======= -->
    <section id="popular-courses" class="courses">
        <div class="container" data-aos="fade-up">

            <div class="section-title">
                <h2>Courses</h2>
                <p>Popular Courses</p>
            </div>

            <div class="row" data-aos="zoom-in" data-aos-delay="100">

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                    <div class="course-item">
                        <img src="assets/img/course-1.jpg" class="img-fluid" alt="...">
                        <div class="course-content">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Web Development</h4>
                                <p class="price">$169</p>
                            </div>

                            <h3><a href="course-details.html">Website Design</a></h3>
                            <p>Et architecto provident deleniti facere repellat nobis iste. Id facere quia quae dolores
                                dolorem tempore.</p>
                            <div class="trainer d-flex justify-content-between align-items-center">
                                <div class="trainer-profile d-flex align-items-center">
                                    <img src="assets/img/trainers/trainer-1.jpg" class="img-fluid" alt="">
                                    <span>Antonio</span>
                                </div>
                                <div class="trainer-rank d-flex align-items-center">
                                    <i class="bx bx-user"></i>&nbsp;50
                                    &nbsp;&nbsp;
                                    <i class="bx bx-heart"></i>&nbsp;65
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Course Item-->

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4 mt-md-0">
                    <div class="course-item">
                        <img src="assets/img/course-2.jpg" class="img-fluid" alt="...">
                        <div class="course-content">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Marketing</h4>
                                <p class="price">$250</p>
                            </div>

                            <h3><a href="course-details.html">Search Engine Optimization</a></h3>
                            <p>Et architecto provident deleniti facere repellat nobis iste. Id facere quia quae dolores
                                dolorem tempore.</p>
                            <div class="trainer d-flex justify-content-between align-items-center">
                                <div class="trainer-profile d-flex align-items-center">
                                    <img src="assets/img/trainers/trainer-2.jpg" class="img-fluid" alt="">
                                    <span>Lana</span>
                                </div>
                                <div class="trainer-rank d-flex align-items-center">
                                    <i class="bx bx-user"></i>&nbsp;35
                                    &nbsp;&nbsp;
                                    <i class="bx bx-heart"></i>&nbsp;42
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Course Item-->

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4 mt-lg-0">
                    <div class="course-item">
                        <img src="assets/img/course-3.jpg" class="img-fluid" alt="...">
                        <div class="course-content">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Content</h4>
                                <p class="price">$180</p>
                            </div>

                            <h3><a href="course-details.html">Copywriting</a></h3>
                            <p>Et architecto provident deleniti facere repellat nobis iste. Id facere quia quae dolores
                                dolorem tempore.</p>
                            <div class="trainer d-flex justify-content-between align-items-center">
                                <div class="trainer-profile d-flex align-items-center">
                                    <img src="assets/img/trainers/trainer-3.jpg" class="img-fluid" alt="">
                                    <span>Brandon</span>
                                </div>
                                <div class="trainer-rank d-flex align-items-center">
                                    <i class="bx bx-user"></i>&nbsp;20
                                    &nbsp;&nbsp;
                                    <i class="bx bx-heart"></i>&nbsp;85
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Course Item-->

            </div>

        </div>
    </section><!-- End Popular Courses Section -->

    <!-- ======= Trainers Section ======= -->
    <section id="trainers" class="trainers">
        <div class="container" data-aos="fade-up">

            <div class="section-title">
                <h2>Trainers</h2>
                <p>Our Professional Trainers</p>
            </div>

            <div class="row" data-aos="zoom-in" data-aos-delay="100">
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                    <div class="member">
                        <img src="assets/img/trainers/trainer-1.jpg" class="img-fluid" alt="">
                        <div class="member-content">
                            <h4>Walter White</h4>
                            <span>Web Development</span>
                            <p>
                                Magni qui quod omnis unde et eos fuga et exercitationem. Odio veritatis perspiciatis
                                quaerat qui aut aut aut
                            </p>
                            <div class="social">
                                <a href=""><i class="icofont-twitter"></i></a>
                                <a href=""><i class="icofont-facebook"></i></a>
                                <a href=""><i class="icofont-instagram"></i></a>
                                <a href=""><i class="icofont-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                    <div class="member">
                        <img src="assets/img/trainers/trainer-2.jpg" class="img-fluid" alt="">
                        <div class="member-content">
                            <h4>Sarah Jhinson</h4>
                            <span>Marketing</span>
                            <p>
                                Repellat fugiat adipisci nemo illum nesciunt voluptas repellendus. In architecto rerum
                                rerum temporibus
                            </p>
                            <div class="social">
                                <a href=""><i class="icofont-twitter"></i></a>
                                <a href=""><i class="icofont-facebook"></i></a>
                                <a href=""><i class="icofont-instagram"></i></a>
                                <a href=""><i class="icofont-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                    <div class="member">
                        <img src="assets/img/trainers/trainer-3.jpg" class="img-fluid" alt="">
                        <div class="member-content">
                            <h4>William Anderson</h4>
                            <span>Content</span>
                            <p>
                                Voluptas necessitatibus occaecati quia. Earum totam consequuntur qui porro et laborum
                                toro des clara
                            </p>
                            <div class="social">
                                <a href=""><i class="icofont-twitter"></i></a>
                                <a href=""><i class="icofont-facebook"></i></a>
                                <a href=""><i class="icofont-instagram"></i></a>
                                <a href=""><i class="icofont-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </section><!-- End Trainers Section -->

</main><!-- End #main -->

<!-- ======= Footer ======= -->
<footer id="footer">

    <div class="footer-top">
        <div class="container">
            <div class="row">

                <div class="col-lg-3 col-md-6 footer-contact">
                    <h3>Mentor</h3>
                    <p>
                        A108 Adam Street <br>
                        New York, NY 535022<br>
                        United States <br><br>
                        <strong>Phone:</strong> +1 5589 55488 55<br>
                        <strong>Email:</strong> info@example.com<br>
                    </p>
                </div>

                <div class="col-lg-2 col-md-6 footer-links">
                    <h4>Useful Links</h4>
                    <ul>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 footer-links">
                    <h4>Our Services</h4>
                    <ul>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
                    </ul>
                </div>

                <div class="col-lg-4 col-md-6 footer-newsletter">
                    <h4>Join Our Newsletter</h4>
                    <p>Tamen quem nulla quae legam multos aute sint culpa legam noster magna</p>
                    <form action="" method="post">
                        <input type="email" name="email">
                        <input type="submit" value="Subscribe">
                    </form>
                </div>

            </div>
        </div>
    </div>

    <div class="container d-md-flex py-4">

        <div class="mr-md-auto text-center text-md-left">
            <div class="copyright">
                &copy; Copyright <strong><span>Mentor</span></strong>. All Rights Reserved
            </div>
            <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/mentor-free-education-bootstrap-theme/ -->
                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>
        </div>
        <div class="social-links text-center text-md-right pt-3 pt-md-0">
            <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
            <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
            <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
            <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
            <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
        </div>
    </div>
</footer><!-- End Footer -->

<a href="#" class="back-to-top"><i class="bx bx-up-arrow-alt"></i></a>
<div id="preloader"></div>

<!-- Vendor JS Files -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>
<script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
<script src="assets/vendor/counterup/counterup.min.js"></script>
<script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="assets/vendor/aos/aos.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>




<!-- Modal -->
<div class="modal fade" id="downloadModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h6>Processing...</h6>
               <span id="display5">null</span>
                <div class="progress" >
                    <div class="progress-bar" id="progress" role="progressbar" style="width: 5%;" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100">5%</div>
                </div>

                <div class="progress" >
                    <div class="progress-bar" id="progress2" role="progressbar" style="width: 5%;" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100">5%</div>
                </div>
                <br>
                <div class="d-flex justify-content-center">
                    <div class="spinner-border" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>

<%--                <%--%>
<%--                    YoutubeDownloader downloader = new YoutubeDownloader();--%>

<%--                    if (request.getParameter("submit") != null) {--%>
<%--                        YoutubeVideo video = downloader.getVideo(getVideoId(request.getParameter("vid_url")));--%>

<%--                        File outputDir = new File("my_videos");--%>


<%--                        try {--%>
<%--                            video.downloadAsync(videoWithAudioFormats.get(0), outputDir, new OnYoutubeDownloadListener() {--%>
<%--                                @Override--%>
<%--                                public void onDownloading(int progress) {--%>
<%--                                    System.out.printf("Downloaded %d%%\n", progress);--%>

<%--                                }--%>

<%--                                @Override--%>
<%--                                public void onFinished(File file) {--%>
<%--                                    System.out.println("Finished file: " + file);--%>
<%--                                }--%>

<%--                                @Override--%>
<%--                                public void onError(Throwable throwable) {--%>
<%--                                    System.out.println("Error: " + throwable.getLocalizedMessage());--%>
<%--                                }--%>
<%--                            });--%>
<%--                        } catch (YoutubeException e) {--%>
<%--                            e.printStackTrace();--%>
<%--                        }--%>
<%--                    }--%>
<%--                %>--%>

            </div>



            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" >Save changes</button>

            </div>
        </div>
    </div>
</div>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>

  //  document.getElementById('btn_manddfdssds').onclick = runPgUpdate();


// function runPgUpdate2() {
//
//     var ytUrl = $('#yt-url').val();
//     var vidUrl = $('#vid-url').val();
//     var uuid = $('#display1').val();
//     $.post("Youtube",
//         {
//             yt_url: ytUrl,
//             vid_url: vidUrl,
//             action: "init_download"
//         },
//         function(result){
//             document.getElementById("progress2").setAttribute("aria-valuenow", 55);
//             document.getElementById("progress2").setAttribute("style", "width: " +55+ "%;");
//             document.getElementById("progress2").innerHTML = (55 + "%");
//             document.getElementById("progress2").setAttribute("aria-valuemax", 100);
//
//             $('#display1').html(result);
//             $('#display11').val(result);
//             // $('#display1').val(result);
//             alert(result);
//         });
//
//
// }

    function runPgUpdate() {
        var  uuidm;
        let x= 6;
        var ytUrl = $('#yt-url').val();
        var vidUrl = $('#vid-url').val();
        var uuid = $('#display1').text();




        $.post("Youtube",
            {
                yt_url: ytUrl,
                vid_url: vidUrl,
                action: "init_download"
            },
            function(result){
                uuidm = result;
                // alert(result);
            });



        setInterval(function() {
            $.post("Youtube",
                {
                    yt_url: ytUrl,
                    vid_url: vidUrl,
                    uuid: uuidm,
                    action: "fetch_percent"
                },
                function(result){
                    document.getElementById("progress").setAttribute("aria-valuenow", result);
                    document.getElementById("progress").setAttribute("style", "width: " +result+ "%;");
                    document.getElementById("progress").innerHTML = (result + "%");
                    $('#display5').html(result)
                    console.log("From Other Side val 1 is "+ uuidm);

                });

        }, 3000)

    }

</script>
</html>
