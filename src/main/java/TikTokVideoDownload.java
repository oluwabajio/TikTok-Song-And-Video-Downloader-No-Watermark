import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/TikTokVideoDownload")
public class TikTokVideoDownload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getParameter("tiktok_url");
        System.out.println(url);

        Document doc = Jsoup.connect(url).get();
        Elements mp4Links = doc.select("a[href$=.mp4]");

        System.out.println("size is "+ mp4Links.size());
        List<String> links = new ArrayList<String>();
        for (Element mp4Link : mp4Links) {
            String absHref = mp4Link.attr("abs:href");
            links.add(absHref);
            System.out.println(absHref);
        }

        final Document document = Jsoup.connect(url)
//                .userAgent("Mozilla/5.0 (Linux; U; Android 4.0.2; en-us; Galaxy Nexus Build/ICL53F) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30")
                .get();

        for (Element element : document.select("script")) {
            final String data = element.data();
            if (data.contains("videoData")) {
                System.out.println(data.toString());
                final String substring = data.substring(data.lastIndexOf("urls"));
                final String substring2 = substring.substring(substring.indexOf("[") + 1);
                final String substring3 = substring2.substring(0, substring2.indexOf("]"));
              String  playURL = substring3.substring(1, substring3.length() - 1);
                System.out.println(playURL);
                withoutWatermark(playURL);
            }
        }


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
                        System.out.println("stringBuffer.toString()"+ stringBuffer.toString());
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
