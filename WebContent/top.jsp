<%-- FILE: WebContent/top.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- セキュリティチェック --%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
</head>
<body>

    <%-- ★★★ 共通メニューを<body>の直下で読み込む ★★★ --%>
    <%@ include file="/menu.jsp" %>

    <%-- このページ専用のメインコンテンツ --%>
    <main class="main-content" style="padding: 40px; width: 100%; box-sizing: border-box;">
        <style>
            /* このページ専用のスタイル */
            .page-title {
                font-size: 1.5em;
                font-weight: bold;
                margin-bottom: 30px;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
                text-align: center;
                font-family: "Meiryo", sans-serif; /* ★★★ フォントを明示的に指定 ★★★ */
            }
            .menu-box-group {
                display: flex;
                gap: 40px;
                flex-wrap: wrap;
                justify-content: center;
            }
            .menu-box {
                flex-basis: 240px;
                min-height: 150px;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                padding: 25px;
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .menu-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            }
            .menu-box.student { background: #fff0f0; }
            .menu-box.grade { background: #f0fff0; }
            .menu-box.subject { background: #f0f8ff; }
            .menu-title-box {
                font-size: 1.2em;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .menu-link {
                display: block;
                margin-top: 8px;
                text-decoration: none;
            }
        </style>

        <h2 class="page-title">メニュー</h2>

        <div class="menu-box-group">
            <div class="menu-box student">
                <div class="menu-title-box">学生管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/student/list">学生一覧</a>
            </div>
            <div class="menu-box grade">
                <div class="menu-title-box">成績管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                <a class="menu-link" href="<%=request.getContextPath()%>/grade/delete">成績削除</a>
                <a class="menu-link" href="<%=request.getContextPath()%>/grade/search">成績参照</a>
            </div>
            <div class="menu-box subject">
                <div class="menu-title-box">科目管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/subject/list">科目管理</a>
            </div>
        </div>
    </main>

    <%-- menu.jspで開始したレイアウト用divをここで閉じる --%>
    </div>

</body>
</html>
