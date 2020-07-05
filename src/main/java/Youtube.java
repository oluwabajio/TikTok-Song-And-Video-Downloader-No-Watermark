import com.github.kiulian.downloader.YoutubeDownloader;
import com.github.kiulian.downloader.YoutubeException;
import com.github.kiulian.downloader.model.VideoDetails;
import com.github.kiulian.downloader.model.YoutubeVideo;
import com.github.kiulian.downloader.model.formats.AudioVideoFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/Youtube")
public class Youtube extends HttpServlet {

    final static String reg = "(?:youtube(?:-nocookie)?\\.com\\/(?:[^\\/\\n\\s]+\\/\\S+\\/|(?:v|e(?:mbed)?)\\/|\\S*?[?&]v=)|youtu\\.be\\/)([a-zA-Z0-9_-]{11})";


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = request.getParameter("vid_url");

        YoutubeDownloader downloader = new YoutubeDownloader();


        YoutubeVideo video;
        try {
            video = downloader.getVideo(getVideoId(url));
            // video details
            VideoDetails details = video.details();
            System.out.println(details.title());
            System.out.println(details.author());
            System.out.println(details.viewCount());

            // get videos with audio
            List<AudioVideoFormat> videoWithAudioFormats = video.videoWithAudioFormats();
            videoWithAudioFormats.forEach(it -> {
                System.out.println(it.videoQuality() + " : " + it.url());

            });

            AudioVideoFormat format = videoWithAudioFormats.get(videoWithAudioFormats.size() - 1);


            System.out.println("Size is "+ videoWithAudioFormats.size());

            File outputDir = new File("my_videos");

          //  response.sendRedirect(format.url());

            request.setAttribute("url", format.url());
            request.setAttribute("vid_formats", videoWithAudioFormats);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
//
//
////				// sync downloading
//				File file = video.download(format, outputDir);
//
//
//
//				Future<File> future = video.downloadAsync(format, outputDir);
//				File file2 = future.get(5, TimeUnit.SECONDS);

//				// live videos and streams
//				if (video.details().isLive()) {
//				    System.out.println("Live Stream HLS URL: " + video.details().liveUrl());
//				}
//

        } catch (YoutubeException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }



    }

    public static String getVideoId(String videoUrl) {
        if (videoUrl == null || videoUrl.trim().length() <= 0)
            return null;

        Pattern pattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(videoUrl);

        if (matcher.find())
            return matcher.group(1);
        return null;
    }

}
