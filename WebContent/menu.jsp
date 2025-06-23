<%-- FILE: WebContent/menu.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 共通のスタイルシート定義 --%>
<style>
    /* ページ全体のスタイル */
    body {
        margin: 0;
        font-family: "Meiryo", sans-serif;
        background-color: #f8f9fa;
    }
    /* ヘッダー */
    .menu-header {
        background: #fff;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #dee2e6;
    }
    .menu-header-title { font-size: 1.5em; font-weight: bold; color: #333; }
    .menu-header-user { font-size: 0.95em; color: #555; }
    .menu-header-user a { color: #0d6efd; text-decoration: none; margin-left: 15px; }
    .menu-header-user a:hover { text-decoration: underline; }

    /* メインのレイアウトコンテナ */
    .layout-container { display: flex; }

    /* サイドバー */
    .menu-sidebar {
        width: 220px;
        flex-shrink: 0; /* 幅が縮まないように固定 */
        padding: 20px;
        border-right: 1.5px solid #d3d5de;
        min-height: calc(100vh - 69px); /* ヘッダーの高さを引いた分 */
        box-sizing: border-box;
        background-color: #fff;
    }
    .menu-nav { list-style: none; padding: 0; margin: 0; }
    .menu-nav li { margin-bottom: 5px; }
    .menu-nav a {
        display: block;
        text-decoration: none;
        padding: 8px 10px;
        border-radius: 4px;
        transition: background-color 0.2s;
        color: #0d6efd;
    }
    .menu-nav a:hover { background-color: #e9ecef; }
    .menu-nav .top-menu-item a { font-weight: bold; font-size: 1.1em; color: #333; margin-bottom: 15px; }
    .menu-nav-title { font-weight: bold; color: #6c757d; padding: 15px 10px 5px 10px; border-top: 1px solid #eee; }
    .sub-menu { list-style: none; padding-left: 15px; }
</style>

<header class="menu-header">
    <span class="menu-header-title">得点管理システム</span>
    <span class="menu-header-user">
        <c:out value="${sessionScope.user.name}" />様
        <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
    </span>
</header>

<%-- メインコンテンツとサイドバーを囲むコンテナを開始 --%>
<div class="layout-container">
    <nav class="menu-sidebar">
        <ul class="menu-nav">
            <li class="top-menu-item"><a href="<%=request.getContextPath()%>/top.jsp">メニュー</a></li>
            <li><a href="<%=request.getContextPath()%>/student/list">学生管理</a></li>
            <li>
                <div class="menu-nav-title">成績管理</div>
                <ul class="sub-menu">
                    <li><a href="<%=request.getContextPath()%>/grade/create">成績登録</a></li>
                    <li><a href="<%=request.getContextPath()%>/grade/delete">成績削除</a></li>
                    <li><a href="<%=request.getContextPath()%>/grade/search">成績参照</a></li>
                </ul>
            </li>
            <li><a href="<%=request.getContextPath()%>/subject/list">科目管理</a></li>
        </ul>
    </nav>
