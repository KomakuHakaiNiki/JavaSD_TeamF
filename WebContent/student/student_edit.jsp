<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <style>
        body {
            font-family: sans-serif;
        }
        .container {
            width: 80%;
            margin: auto;
        }
        .header {
            background-color: #eef3fb;
            padding: 10px;
        }
        .menu {
            float: left;
            width: 15%;
            margin-top: 20px;
        }
        .menu a {
            display: block;
            margin: 10px 0;
        }
        .main {
            margin-left: 17%;
            margin-top: 20px;
        }
        .title {
    background-color: #f0f0f0; 
    padding: 10px;
    font-size: 18px;
    font-weight: bold;
}
        
        .form-group {
            margin: 10px 0;
        }
        label {
            display: inline-block;
            width: 100px;
        }
        input, select {
            width: 200px;
        }
        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 0.9em;
            color: gray;
        }
        
       
    input.plain-text {
        border: none;
        background: transparent;
        font-size: 1em;
    }
    
    
    </style>
</head>
<body>
    
       
        <div class="main">
            <div class="title">学生情報変更</div>
            <form action="StudentUpdateAction" method="post">
                <div class="form-group">
                    <label>入学年度</label>
                    <input type="text" name="entranceYear" value="2023" readonly class="plain-text">
                </div>
                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="studentNo" value="123456" readonly class="plain-text">
                </div>
                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="大阪 太郎">
                </div>
                <div class="form-group">
                    <label>クラス</label>
                    <select name="class">
                        <option value="201" selected>201</option>
                        <option value="202">202</option>
                        <option value="203">203</option>
                    </select>
                </div>
                <div class="form-group checkbox-group">
    				<label for="isEnrolled">在学中</label>
    				<input type="checkbox" id="isEnrolled" name="isEnrolled" value="true" checked>
				</div>
                
                <input type="hidden" name="studentId" value="123456">
                <div class="form-group">
                    <button type="submit">変更</button>
                </div>
                <div class="form-group">
                    <a href="StudentList.jsp">戻る</a>
                </div>
            </form>
        </div>

        <div class="footer">
            © 2023 TIC<br>大阪学院
        </div>
    </div>
</body>
</html>
