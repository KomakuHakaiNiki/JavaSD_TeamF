<%-- FILE: WebContent/common/menu.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* ページ全体の余白をリセット */
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
    .menu-header-title {
        font-size: 1.5em;
        font-weight: bold;
        color: #333;
    }
    .menu-header-user {
        font-size: 0.95em;
        color: #555;
    }
    .menu-header-user a {
        color: #0d6efd;
        text-decoration: none;
        margin-left: 15px;
    }
     .menu-header-user a:hover {
        text-decoration: underline;
    }

    /* メインレイアウト */
    .layout-container {
        display: flex;
    }

    /* サイドバー */
    .menu-sidebar {
        width: 220px;
        padding: 20px;
        border-right: 1.5px solid #d3d5de;
        min-height: calc(100vh - 67px); /* ヘッダーの高さを引く */
        box-sizing: border-box;
        background-color: #fff;
    }

    .menu-nav {
        list-style: none;
        padding: 0;
        margin: 0;
        width: 100%;
    }
    .menu-nav li {
        margin-bottom: 5px;
    }

    /* ★★★ ここからが修正点 ★★★ */
    /* 全てのリンクに共通のスタイル */
    .menu-nav a {
        display: block;
        text-decoration: none;
        padding: 8px 10px;
        border-radius: 4px;
        transition: background-color 0.2s;
    }
    .menu-nav a:hover {
        background-color: #e9ecef;
    }

    /* 「メニュー」専用のスタイル */
    .menu-nav .top-menu-item a {
        font-weight: bold;
        font-size: 1.1em;
        color: #333;
        border-bottom: 2px solid #0d6efd;
        margin-bottom: 15px; /* 下の項目との余白 */
        border-radius: 4px 4px 0 0;
    }

    /* 「成績管理」などの見出しのスタイル */
    .menu-nav-title {
        font-weight: bold;
        color: #6c757d;
        font-size: 0.9em;
        padding: 15px 10px 5px 10px;
        text-transform: uppercase;
        border-top: 1px solid #eee;
    }

    /* 見出しの下のリンクのスタイル */
    .menu-nav .sub-menu a {
        color: #0d6efd;
        font-size: 1em;
        padding-left: 25px; /* インデント */
    }

    /* 直下のリンク（学生管理、科目管理） */
    .menu-nav > li > a {
         color: #0d6efd;
         font-size: 1.05em;
    }
     /* ★★★ ここまでが修正点 ★★★ */
</style>

<header class="menu-header">
    <span class="menu-header-title">得点管理システム</span>
    <span class="menu-header-user">
        <c:out value="${sessionScope.user.name}" />様
        <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
    </span>
</header>

<div class="layout-container">
    <nav class="menu-sidebar">
        <%-- ★修正点: 全ての項目を一つのulで囲む --%>
        <ul class="menu-nav">
            <li class="top-menu-item">
                <a href="<%=request.getContextPath()%>/top.jsp">メニュー</a>
            </li>

            <li><a href="<%=request.getContextPath()%>/student/list">学生管理</a></li>

            <li>
                <div class="menu-nav-title">成績管理</div>
                <ul class="sub-menu">
                    <li><a href="<%=request.getContextPath()%>/grade/create">成績登録</a></li>
                    <li><a href="<%=request.getContextPath()%>/grade/search">成績参照</a></li>
                </ul>
            </li>

            <li><a href="<%=request.getContextPath()%>/subject/list">科目管理</a></li>
        </ul>
    </nav>

    <%-- このJSPをインクルードしたページのメインコンテンツは、この下に表示される --%>
    <%--
    <main class="main-content">
        ...
    </main>
    --%>
</div>
