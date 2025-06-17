<%-- FILE: WebContent/top.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- ★★★ セキュリティチェック ★★★ --%>
<%-- セッションにユーザー情報がなければ、ログインページに強制的にリダイレクトします --%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return; // この後のJSP処理を中断
    }
%>

<%-- ★★★ 共通メニュー(ヘッダーとサイドバー)を読み込みます ★★★ --%>
<%@ include file="/menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<style>
    /* このページ専用のスタイル */
    .main-content {
        /* サイドバーの幅を考慮して、左側に余白を設定 */
        margin-left: 240px;
        padding: 40px;
    }
    .page-title {
        font-size: 1.5em;
        font-weight: bold;
        margin-bottom: 30px;
        border-bottom: 2px solid #eee;
        padding-bottom: 10px;
    }
    .menu-box-group {
        display: flex;
        gap: 40px; /* ボックス間の余白 */
        flex-wrap: wrap; /* 画面が狭い場合に折り返す */
    }
    .menu-box {
        flex-basis: 240px; /* ボックスの基本幅 */
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
    /* ボックスごとの色分け */
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
        color: #0d6efd;
        font-size: 1em;
        text-decoration: none;
    }
     .menu-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

    <!-- 共通メニューは上で読み込み済み -->

    <!-- このページのメインコンテンツ -->
    <main class="main-content">
        <h2 class="page-title">メニュー</h2>

        <div class="menu-box-group">
            <div class="menu-box student">
                <div class="menu-title-box">学生管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/student/list">学生一覧</a>
            </div>

            <div class="menu-box grade">
                <div class="menu-title-box">成績管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                <a class="menu-link" href="<%=request.getContextPath()%>/grade/search">成績参照</a>
            </div>

            <div class="menu-box subject">
                <div class="menu-title-box">科目管理</div>
                <a class="menu-link" href="<%=request.getContextPath()%>/subject/list">科目管理</a>
            </div>
        </div>
    </main>

    <%-- フッターはmenu.jsp側で読み込まれるため、ここでは不要 --%>

</body>
</html>
