import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.nibor.autolink.LinkExtractor;
import org.nibor.autolink.LinkSpan;
import org.nibor.autolink.LinkType;
import org.nibor.autolink.Span;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;

@WebServlet("/TikTok")
public class TikTok extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = request.getParameter("url");
        String action = request.getParameter("action");


        System.out.println("TikTok Url is: " + url);

        if (action.equalsIgnoreCase("download_audio")) {

//            Document doc = Jsoup.connect(url).get();
//            Elements musicLinks = doc.select("a[href$=.mp3]");
//
//            System.out.println("music size is " + musicLinks.size());
//
//            for (Element mp3Link : mp3Links) {
//                String absHref = mp3Link.attr("abs:href");
//                System.out.println("Mp3 Link is: " + absHref);
//            }
//
//
//            Document doc2 = Jsoup.connect(url).get();
//            Elements mp3Links = doc2.select("a[href$=.mp3]");
//
//            System.out.println("mp3 size is " + mp3Links.size());
//
//            for (Element mp3Link : mp3Links) {
//                String absHref = mp3Link.attr("abs:href");
//                System.out.println("Mp3 Link is: " + absHref);
//            }

            Document doc = Jsoup.connect(url).get();
            String s= doc.toString();


            String input = s;
            LinkExtractor linkExtractor = LinkExtractor.builder()
                    .linkTypes(EnumSet.of(LinkType.URL)) // limit to URLs
                    .build();
            Iterable<Span> spans = linkExtractor.extractSpans(input);

            String musicPageUrl = "";

            for (Span span : spans) {
                String text = input.substring(span.getBeginIndex(), span.getEndIndex());
                if (span instanceof LinkSpan) {

                    if (text.contains("/music/")){
                        musicPageUrl = text;
                    }

                }
            }

            String mp3Link = "";
            if (!musicPageUrl.equalsIgnoreCase("")) {
                System.out.println("music link is: "+musicPageUrl);

                Document doc7 = Jsoup.connect(musicPageUrl).get();
                String s7= doc7.toString();

                LinkExtractor linkExtractor7 = LinkExtractor.builder()
                        .linkTypes(EnumSet.of(LinkType.URL)) // limit to URLs
                        .build();
                Iterable<Span> spans7 = linkExtractor7.extractSpans(s7);



                for (Span span : spans7) {
                    String text7 = s7.substring(span.getBeginIndex(), span.getEndIndex());
                    if (span instanceof LinkSpan) {
                        System.out.println("link gotten is: "+text7);
                        if (text7.contains(".mp3")){
                            mp3Link = text7;
                        }

                    }
                }

                if (!mp3Link.equalsIgnoreCase("")) {
                    System.out.println("mp3 link is: "+mp3Link);
                    response.getWriter().println(mp3Link);
                }else {
                    System.out.println("mp3 link doesn not exist");
                }
            } else {
                System.out.println("music url doesn not exist");
            }



        } else {
            final Document document = Jsoup.connect(url)
                    .userAgent("Mozilla/5.0 (Linux; U; Android 4.0.2; en-us; Galaxy Nexus Build/ICL53F) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30")
                    .get();

            for (Element element : document.select("script")) {
                final String data = element.data();
                if (data.contains("videoData")) {
                  //  System.out.println(data.toString());
                    final String substring = data.substring(data.lastIndexOf("urls"));
                    final String substring2 = substring.substring(substring.indexOf("[") + 1);
                    final String substring3 = substring2.substring(0, substring2.indexOf("]"));
                    String playURL = substring3.substring(1, substring3.length() - 1);
                    System.out.println(playURL);
                    System.out.println(withoutWatermark(playURL));

                    if (action.equalsIgnoreCase("watermark_video")) {
                        response.getWriter().println(playURL);
                    } else if (action.equalsIgnoreCase("no_watermark_video")) {
                        String withoutWatermarkUrl = withoutWatermark(playURL);
                        response.getWriter().println(withoutWatermarkUrl);
                    }

                }
            }

        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    public String withoutWatermark(final String url) {
        try {
            final HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(url).openConnection();
            httpURLConnection.connect();
            if (httpURLConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                final BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
                final StringBuilder stringBuffer = new StringBuilder();

                String readLine;
                while ((readLine = bufferedReader.readLine()) != null) {
                    stringBuffer.append(readLine);

                    if (stringBuffer.toString().contains("vid:")) {
                        try {
                            if (stringBuffer.substring(stringBuffer.indexOf("vid:")).substring(0, 4).equals("vid:")) {
                                final String substring = stringBuffer.substring(stringBuffer.indexOf("vid:"));
                                final String trim = substring.substring(4, substring.indexOf("%"))
                                        .replaceAll("[^A-Za-z0-9]", "").trim();
                                return "http://api2.musical.ly/aweme/v1/playwm/?video_id=" + trim;
                            }
                        } catch (final Exception e) {
                            System.out.println(e.getMessage());
                        }
                    }
                }
            }

        } catch (final Exception e) {
            System.out.println(e.getMessage());
        }

        return "";
    }
}
