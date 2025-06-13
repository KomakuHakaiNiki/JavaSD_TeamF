<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    // セッションからユーザー名を取得（仮）
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "大原 太郎様"; // ダミー
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        body {
            font-family: "Meiryo", sans-serif;
            margin: 0;
            background: #f7fafd;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #e6eef7;
            padding: 20px 40px 10px 40px;
        }
        .header-title {
            font-size: 2.2em;
            font-weight: bold;
            color: #222;
        }
        .header-right {
            font-size: 1em;
        }
        .header-right a {
            margin-left: 15px;
            color: #0a6bce;
            text-decoration: underline;
        }
        .container {
            display: flex;
            margin-top: 30px;
            min-height: 480px;
            justify-content: center;
        }
        .sidebar {
            width: 180px;
            padding-top: 20px;
            padding-left: 25px;
        }
        .sidebar a {
            display: block;
            margin-bottom: 18px;
            color: #2366b1;
            font-size: 1.05em;
            text-decoration: underline;
        }
        .main {
            flex: 1;
            padding: 10px 40px;
        }
        .menu-box-group {
            display: flex;
            gap: 25px;
        }
        .menu-box {
            flex: 1 1 190px;
            border-radius: 16px;
            box-shadow: 0 4px 16px #c8c8d2a0;
            padding: 32px 20px 28px 20px;
            background: #ffe0e0;
            text-align: center;
            min-width: 180px;
        }
        .menu-box.menu-grade { background: #e5ffe0; }
        .menu-box.menu-subject { background: #e0e3ff; }
        .menu-title {
            font-size: 1.15em;
            font-weight: bold;
            margin-bottom: 14px;
        }
        .menu-link {
            display: block;
            margin: 12px 0 0 0;
            color: #167abc;
            font-size: 1em;
            text-decoration: underline;
        }
        .footer {
            background: #ededed;
            color: #666;
            text-align: center;
            padding: 16px;
            font-size: 0.98em;
            position: fixed;
            width: 100vw;
            left: 0;
            bottom: 0;
            letter-spacing: 0.03em;
        }
        @media (max-width: 800px) {
            .container, .menu-box-group { flex-direction: column; align-items: center;}
            .sidebar { width: 100%; text-align: center;}
            .main { padding: 0;}
            .menu-box { width: 90%; margin-bottom: 18px;}
        }
    </style>
</head>
<body>
    <div class="header">
        <span class="header-title">得点管理システム</span>
        <span class="header-right">
            <%= userName %>　
            <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
        </span>
    </div>
    <div class="container">
        <!-- メインメニュー（ボックス形式） -->
        <main class="main">
            <div><b>メニュー</b></div>
            <div class="menu-box-group">
                <div class="menu-box">
                    <div class="menu-title">学生管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/student/list">学生管理</a>
                </div>
                <div class="menu-box menu-grade">
                    <div class="menu-title">成績管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                    <a class="menu-link" href="<%=request.getContextPath()%>/grade/view">成績参照</a>
                </div>
                <div class="menu-box menu-subject">
                    <div class="menu-title">科目管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/subject/list">科目管理</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
