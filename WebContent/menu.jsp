<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.menu-sidebar {
    width: 220px;
    flex-shrink: 0;
    padding: 20px;
    border-right: 1.5px solid #d3d5de;
    min-height: calc(100vh - 70px); /* ヘッダー分引く */
    background-color: #fff;
    box-sizing: border-box;
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
