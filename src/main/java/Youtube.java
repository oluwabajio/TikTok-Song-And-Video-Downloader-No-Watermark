import com.github.kiulian.downloader.OnYoutubeDownloadListener;
import com.github.kiulian.downloader.YoutubeDownloader;
import com.github.kiulian.downloader.YoutubeException;
import com.github.kiulian.downloader.model.VideoDetails;
import com.github.kiulian.downloader.model.YoutubeVideo;
import com.github.kiulian.downloader.model.formats.AudioFormat;
import com.github.kiulian.downloader.model.formats.AudioVideoFormat;
import com.github.kiulian.downloader.model.formats.VideoFormat;
import com.github.kiulian.downloader.model.quality.VideoQuality;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.sql.*;

@WebServlet("/Youtube")
public class Youtube extends HttpServlet {

    final static String reg = "(?:youtube(?:-nocookie)?\\.com\\/(?:[^\\/\\n\\s]+\\/\\S+\\/|(?:v|e(?:mbed)?)\\/|\\S*?[?&]v=)|youtu\\.be\\/)([a-zA-Z0-9_-]{11})";
    private static final String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = request.getParameter("name");
        String ytUrl = request.getParameter("yt_url");
        String downloadUrl = request.getParameter("vid_url");
        String uuidFromServer = request.getParameter("uuid");
        String action = request.getParameter("action");


        String dbUrl = "jdbc:mysql://localhost:3306/downloads?useLegacyDatetimeCode=false&serverTimezone=UTC";
        String uname = "root";
        String pass = "";

        String query2 = "select path from download_table where uuid=1";

        System.out.println("action is "+ action);

        if (action.equalsIgnoreCase("fetch_percent")) {

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                System.out.println("forname worked");


                Connection con = DriverManager.getConnection(dbUrl, uname, pass);
                Statement st = con.createStatement();
             //   uuidFromServer = "MQROUWQ";
                System.out.println("uuid from server isgg " + uuidFromServer);
                String query1 = "select * from download_table where uuid='" + uuidFromServer.trim() + "'";
                ResultSet rs = st.executeQuery(query1);

                rs.next();
                String percent = rs.getString("percent");
                System.out.println("i got the path successfully " + percent);


                st.close();
                con.close();

                PrintWriter out = response.getWriter();
//                out.println("Percent is  " + percent);
                out.println(percent);


            } catch (ClassNotFoundException | SQLException e) {
                System.out.println("Errror: " + e.getMessage());
                e.printStackTrace();

            }


        } else { //init Download


            YoutubeDownloader downloader = new YoutubeDownloader();
            YoutubeVideo video;
            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                System.out.println("forname worked");
                String uuid = generateRandom(7);


                Connection con = DriverManager.getConnection(dbUrl, uname, pass);
                Statement st = con.createStatement();
                String insertInitQuery = "insert into download_table (uuid, path, percent) values ('" + uuid + "', 'sdjs',  0)";
                int count = st.executeUpdate(insertInitQuery);


                video = downloader.getVideo(getVideoId(ytUrl));

                System.out.println("what i inserted "+ uuid);

                List<VideoFormat> videos = video.videoFormats();
                videos.forEach(it -> {
                    System.out.println(it.videoQuality() + " allVids: " + it.url());
                });



                File outputDir3 = new File("my_videos");
                video.downloadAsync(videos.get(0), outputDir3, new OnYoutubeDownloadListener() {
                    @Override
                    public void onDownloading(int progress) {


                        try {
                            Connection con = DriverManager.getConnection(dbUrl, uname, pass);
                            String query5 = "update download_table set percent = ? where uuid = ?";
                            PreparedStatement preparedStmt = con.prepareStatement(query5);
                            preparedStmt.setString   (1, ""+progress);
                            preparedStmt.setString(2, uuid);

                            // execute the java preparedstatement
                            preparedStmt.executeUpdate();
                       //     System.out.printf("Downloaded %d%%\n", progress);
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                            System.out.printf("Error: ", throwables.getMessage());
                        }


                    }

                    @Override
                    public void onFinished(File file) {
                        System.out.println("Finished file: " + file);


                        try {
                            Connection con = DriverManager.getConnection(dbUrl, uname, pass);
                            String query5 = "update download_table set percent = ? where uuid = ?";
                            PreparedStatement preparedStmt = con.prepareStatement(query5);
                            preparedStmt.setString   (1, "finished");
                            preparedStmt.setString(2, uuid);

                            // execute the java preparedstatement
                            preparedStmt.executeUpdate();
                            System.out.printf("Download Finished");
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                            System.out.printf("Error: ", throwables.getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable throwable) {
                        System.out.println("Error: " + throwable.getLocalizedMessage());
                    }
                });

                System.out.println("uuid i sent");
                PrintWriter out = response.getWriter();
                out.println(uuid);



            } catch (YoutubeException | ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                System.out.println("Error: " + e.getMessage());
            }


        }


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
                System.out.println(it.videoQuality() + " vidWithAudio: " + it.url());

            });

            // filtering only audio formats
            List<AudioFormat> audioFormats = video.audioFormats();
            audioFormats.forEach(it -> {
                System.out.println(it.audioQuality() + " Audio: " + it.url());
            });

            // All Video Type
            List<VideoFormat> videos = video.videoFormats();
            videos.forEach(it -> {
                System.out.println(it.videoQuality() + " allVids: " + it.url());
            });


//            // filtering only video formats
//            List<VideoFormat> videoFormats = video.findVideoWithQuality(VideoQuality.large);
//            videoFormats.forEach(it -> {
//                System.out.println(it.videoQuality() + " noAudio: " + it.url());
//            });
            AudioVideoFormat format = videoWithAudioFormats.get(videoWithAudioFormats.size() - 1);


            System.out.println("Size is " + videoWithAudioFormats.size());

            //    File outputDir = new File("my_videos");

            //  response.sendRedirect(format.url());

            request.setAttribute("sample_download_url", format.url());
            request.setAttribute("yt_url", url);
            request.setAttribute("vid_formats", videoWithAudioFormats);
            request.setAttribute("audio_formats", audioFormats);
            request.setAttribute("all_vid_formats", videos);
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


//
//            File outputDir = new File("my_videos");
//
//// async downloading with callback
//            video.downloadAsync(videoWithAudioFormats.get(0), outputDir, new OnYoutubeDownloadListener() {
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


        } catch (YoutubeException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("Errror: " + e.getMessage());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("Errror: " + e.getMessage());
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

    public static String generateRandom(int length) {
        Random random = new SecureRandom();
        if (length <= 0) {
            throw new IllegalArgumentException("String length must be a positive integer");
        }

        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }

        return sb.toString();
    }


}
