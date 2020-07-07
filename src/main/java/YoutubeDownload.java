import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/YoutubeDownload")
public class YoutubeDownload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = request.getParameter("name");
        PrintWriter out = response.getWriter();
        out.println("hgg" + url);

//        video.downloadAsync(videoWithAudioFormats.get(0), outputDir, new OnYoutubeDownloadListener() {
//                @Override
//                public void onDownloading(int progress) {
//                    System.out.printf("Downloaded %d%%\n", progress);
//                }
//
//                @Override
//                public void onFinished(File file) {
//                    System.out.println("Finished file: " + file);
//                }
//
//                @Override
//                public void onError(Throwable throwable) {
//                    System.out.println("Error: " + throwable.getLocalizedMessage());
//                }
//            });



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
