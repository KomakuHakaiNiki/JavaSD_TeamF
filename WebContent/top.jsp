<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/menu.jsp" %>
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
    .layout-flex {
        display: flex;
        min-height: 100vh;
    }
    .main-content {
        flex: 1;
        padding: 40px 0 0 50px;
    }
    .menu-sidebar {
        width: 180px;
        padding: 30px 0 0 20px;
        border-right: 1.5px solid #d3d5de;
        min-height: 80vh;
        box-sizing: border-box;
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
        z-index: 100;
    }
    /* メニューのボックススタイル例 */
    .menu-box-group {
        display: flex;
        gap: 25px;
        margin-top: 35px;
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
    @media (max-width: 900px) {
        .layout-flex, .menu-box-group { flex-direction: column; align-items: center;}
        .main-content { padding: 0; }
        .menu-box { width: 90%; margin-bottom: 18px;}
    }
    </style>
</head>
<body>
    <!-- ヘッダーはmenu.jspでインクルードされる -->
    <div class="layout-flex">
        <!-- サイドバーもmenu.jspでインクルードされる（またはここで記述） -->
        <nav class="menu-sidebar">
            <div class="menu-nav">
                <a href="<%=request.getContextPath()%>/student/list">学生管理</a>
                <span class="menu-nav-title">成績管理</span>
                <a href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                <a href="<%=request.getContextPath()%>/grade/view">成績参照</a>
                <a href="<%=request.getContextPath()%>/subject/list">科目管理</a>
            </div>
        </nav>
        <main class="main-content">
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
    <footer class="footer">
        © 2025 TIC<br>大原学園
    </footer>
</body>
</html>

