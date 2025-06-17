<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <style>
    body {
        margin: 0;
        background: #f7fafd;
        font-family: "Meiryo", sans-serif;
    }
    .header {
        background: #e6eef7;
        padding: 10px 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .header-title {
        font-size: 1.3em;
        font-weight: bold;
        color: #2b2e33;
    }
    .header-user a {
        color: #0a6bce;
        text-decoration: underline;
        margin-left: 10px;
    }
    .main-layout {
        display: flex;
        min-height: calc(100vh - 80px); /* ヘッダーとフッターの分だけ引く */
    }
    .sidebar {
        width: 180px;
        padding: 30px 0 0 20px;
        border-right: 1.5px solid #d3d5de;
        min-height: 80vh;
        background: transparent;
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
        padding: 40px 0 0 0;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .menu-title {
        font-size: 1.15em;
        font-weight: bold;
        margin-bottom: 26px;
    }
    .menu-box-group {
        display: flex;
        gap: 38px;
        margin-top: 10px;
        justify-content: center;
    }
    .menu-box {
        min-width: 240px;
        min-height: 150px;
        border-radius: 16px;
        box-shadow: 0 4px 16px #c8c8d2a0;
        padding: 28px 20px 22px 20px;
        background: #ffe0e0;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        transition: transform 0.12s;
    }
    .menu-box.menu-grade { background: #e5ffe0; }
    .menu-box.menu-subject { background: #e0e3ff; }
    .menu-box:hover {
        transform: translateY(-4px) scale(1.025);
        box-shadow: 0 8px 24px #bbbbe5a8;
    }
    .menu-title-box {
        font-size: 1.16em;
        font-weight: bold;
        margin-bottom: 18px;
    }
    .menu-link {
        display: block;
        margin: 10px 0 0 0;
        color: #167abc;
        font-size: 1em;
        text-decoration: underline;
        transition: color 0.13s;
    }
    .menu-link:hover { color: #0e599b; }
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
        z-index: 100;
    }
    @media (max-width: 1000px) {
        .menu-box-group { flex-direction: column; gap: 22px; align-items: center;}
        .main-content { padding: 8vw 0; }
    }
    </style>
</head>
<body>
    <!-- ヘッダー -->
    <%@ page import="bean.Teacher" %>
<%
    Teacher loginUser = (Teacher) session.getAttribute("user");
%>

<div class="header">
    <span class="header-title">得点管理システム</span>
    <span class="header-user">
        <% if (loginUser != null) { %>
            <%= loginUser.getName() %> 様 |
        <% } %>
        <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
    </span>
</div>

    <div class="main-layout">
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
            <div class="menu-title"><b>メニュー</b></div>
            <div class="menu-box-group">
                <div class="menu-box">
                    <div class="menu-title-box">学生管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/student/list">学生管理</a>
                </div>
                <div class="menu-box menu-grade">
                    <div class="menu-title-box">成績管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                    <a class="menu-link" href="<%=request.getContextPath()%>/grade/view">成績参照</a>
                </div>
                <div class="menu-box menu-subject">
                    <div class="menu-title-box">科目管理</div>
                    <a class="menu-link" href="<%=request.getContextPath()%>/subject/list">科目管理</a>
                </div>
            </div>
        </main>
    </div>
    <footer class="footer">
        © 2025 TIC<br>大原学園
    </footer>
</body>
</html>

