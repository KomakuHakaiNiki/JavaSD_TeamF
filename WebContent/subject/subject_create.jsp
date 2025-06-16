<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録 | 得点管理システム</title>
    <style>
        body {
            margin: 0;
            background: #f7fafd;
            font-family: "Meiryo", sans-serif;
        }
        .layout-flex {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 180px;
            padding: 30px 0 0 20px;
            border-right: 1.5px solid #d3d5de;
            min-height: 80vh;
            box-sizing: border-box;
        }
        .sidebar a {
            display: block;
            margin-bottom: 15px;
            color: #2366b1;
            text-decoration: underline;
            font-size: 1.05em;
        }
        .sidebar-title {
            font-weight: bold;
            color: #376345;
            font-size: 1.05em;
            margin-bottom: 5px;
            padding-top: 6px;
            padding-left: 2px;
        }
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 0;
        }
        .main-box {
            background: #f7fafd;
            border-radius: 12px;
            box-shadow: 0 4px 18px #c8c8d240;
            max-width: 620px;
            min-width: 320px;
            padding: 28px 30px 32px 30px;
        }
        .main-title {
            font-size: 1.3em;
            font-weight: bold;
            background: #ededed;
            padding: 14px 24px;
            border-radius: 8px 8px 0 0;
            margin-bottom: 28px;
        }
        .form-label {
            display: block;
            margin: 16px 0 4px 0;
            font-size: 1.05em;
        }
        .form-input {
            width: 97%;
            font-size: 1.05em;
            padding: 8px 10px;
            border-radius: 5px;
            border: 1px solid #bbb;
            margin-bottom: 8px;
            background: #fff;
        }
        .form-btn {
            background: #4d93ff;
            color: #fff;
            font-size: 1em;
            padding: 10px 38px;
            border: none;
            border-radius: 8px;
            margin-top: 18px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .form-btn:hover {
            background: #1a5cba;
        }
        .back-link {
            display: inline-block;
            margin-top: 24px;
            color: #1976d2;
            text-decoration: underline;
            font-size: 1em;
        }
    </style>
</head>
<body>
    <!-- ヘッダー（ヘッダー部だけmenu.jspからインクルード、またはここで直書きでもOK） -->
    <div class="header" style="background:#e6eef7; padding:10px 24px; display:flex; justify-content:space-between; align-items:center;">
        <span style="font-size:1.3em; font-weight:bold; color:#2b2e33;">得点管理システム</span>
        <span>大原 太郎様　
            <a href="<%=request.getContextPath()%>/logout" style="color:#0a6bce; text-decoration:underline;">ログアウト</a>
        </span>
    </div>
    <div class="layout-flex">
        <!-- サイドバー -->
        <nav class="sidebar">
            <a href="<%=request.getContextPath()%>/student/list">学生管理</a>
            <div class="sidebar-title">成績管理</div>
            <a href="<%=request.getContextPath()%>/grade/create">成績登録</a>
            <a href="<%=request.getContextPath()%>/grade/view">成績参照</a>
            <a href="<%=request.getContextPath()%>/subject/list">科目管理</a>
        </nav>
        <!-- メイン -->
        <main class="main-content">
            <form action="<%=request.getContextPath()%>/subject/create" method="post" class="main-box">
                <div class="main-title">科目情報登録</div>
                <label class="form-label" for="subjectCode">科目コード</label>
                <input type="text" name="subjectCode" id="subjectCode" class="form-input"
                       placeholder="科目コードを入力してください"
                       value="${param.subjectCode != null ? param.subjectCode : ''}"/>
                <label class="form-label" for="subjectName">科目名</label>
                <input type="text" name="subjectName" id="subjectName" class="form-input"
                       placeholder="科目名を入力してください"
                       value="${param.subjectName != null ? param.subjectName : ''}"/>
                <button type="submit" class="form-btn">登録</button>
                <div>
                    <a href="<%=request.getContextPath()%>/subject/list" class="back-link">戻る</a>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
