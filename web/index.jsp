<%-- 
    Document   : index
    Created on : Sep 29, 2024, 4:03:12 PM
    Author     : longnguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Models.User" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DropzoneAZ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  </head>
  <body>
      
    <h1>ユーザーのプロフィール画像を一括で取り込みます。</h1>
    <p>
        <% 
        int totalFile = 0;
        long totalSize = 0;
        int totalDownload = 0;
        int purchaseStatus = 0;
        ResultSet myFiles;
        if (session.getAttribute("user_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = Integer.parseInt(session.getAttribute("user_id").toString());;
        User user = new User();
        ResultSet userInfor = user.findById(userId);
        // Get my file
        myFiles = user.myFile(userId);
        int i = 0;
        while (myFiles.next()) {
            totalFile = myFiles.getInt("total_file");
            totalSize = myFiles.getLong("total_size");
            totalDownload = myFiles.getInt("total_download");
            purchaseStatus = myFiles.getInt("purchase_status");
            i++;
            break;
        }
        ResultSet fileList;
        // Get a fresh ResultSet for file listing
        fileList = user.myFile(userId);
        %>
    </p>
    <div class="container">
        <div class="col-md-12 border-default box-list-file">
            <div class="row">
                <div class="col-md-12 txt-title">
                    <h2>ここで画像フォルダを選択してください。</h2>
                </div>
                <%
                while(fileList.next()) {
                %>
                <div class="col-md-2 file-item">
                    <i class="fa-regular fa-file"></i>
                    <a href="/download-file?file-id=<%=fileList.getInt("id")%>">
                        <i class="fa-solid fa-download icon-download"></i>
                    </a>
                    <div class="col-md-12 margin-top-15">
                        <div class="row">
                            <div class="col-md-9">
                                <a href="/download-file?file-id=<%=fileList.getInt("id")%>">
                                    <%=fileList.getString("file_name")%>
                                </a>
                            </div>
                            <div class="col-md-3">| 
                                <a href="/delete-file?file-id=<%=fileList.getInt("id")%>"><i class="fa-solid fa-trash icon-delete"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
                <div class="col-md-2 file-item">
                    <form action="UploadController" method="POST" enctype="multipart/form-data" id="form-upload">
                    <i class="fa-regular fa-file"></i>
                    <a href="#">
                        <label for="chose_file"><i class="fa-solid fa-plus icon-plus"></i></label>
                        <input type="file" accept=".zip" class="hidden chose-file" name="chose_file" id="chose_file">
                    </a>
                    </form>
                </div>
            </div>
            <div class="col-md-12 margin-left-right-15">
                <div class="row">
                    <div class="col-md-4 border-default">
                        <p>合計ファイル: <span><%=totalFile%><%if(purchaseStatus == 0) {%> /100 <%}%></span></p>
                    </div>
                    <div class="col-md-4 border-default">
                        <p>ダンジョンの攻略Kb: <span><%=totalSize%></span></p>
                    </div>
                    <div class="col-md-4 border-default" style="width: 31.1%">
                        <p>ソランタイ: <span><%=totalDownload%><%if(purchaseStatus == 0) {%> /100 <%}%></span></p>
                    </div>
                </div>
            </div>
            <br/>
            <div class="col-md-12">
                <a href="#" class="btn btn-primary" style="margin-left: 5px">購入</a>
                <a href="#" class="btn btn-danger" style="float: right; margin-right: 5px" id="button-logout">ログアウト</a>
            </div>
            <br/>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {
            $('#chose_file').on('change', function () {
                let fileInput = this;
                let filePath = fileInput.value;
                const allowedExtension = 'zip';
                const maxFileUpload = 2048 * 1024;
                // Validate ext file
                let fileExtension = filePath.split('.').pop();
                if (fileExtension !== allowedExtension) {
                    alert(".zip ファイルを選択してください。");
                    fileInput.value = null;
                    return;
                }
                // Validate file size
                let file = fileInput.files[0];
                if (file.size > maxFileUpload) {
                    alert("ファイルサイズ > 2mb");
                    fileInput.value = null;
                    return;
                }
                // Submited form
                $('#form-upload').submit();
            });
        });
    </script>
  </body>
</html>
