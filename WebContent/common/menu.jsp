<!-- /common/menu.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "大原 太郎様";
%>
<style>
.menu-header {
    background: #e6eef7;
    padding: 10px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.menu-header-title {
    font-size: 1.3em;
    font-weight: bold;
    color: #2b2e33;
}
.menu-header-user a {
    color: #0a6bce;
    text-decoration: underline;
    margin-left: 10px;
}
.menu-sidebar {
    width: 180px;
    padding: 30px 0 0 20px;
    border-right: 1.5px solid #d3d5de;
    min-height: 80vh;
    box-sizing: border-box;
}
.menu-nav {
    display: flex;
    flex-direction: column;
    gap: 8px;
}
.menu-nav-title {
    font-weight: bold;
    color: #376345;
    font-size: 1.05em;
    margin-bottom: 5px;
    padding-top: 6px;
    padding-left: 2px;
    list-style: none;
}
.menu-nav a {
    color: #2366b1;
    text-decoration: underline;
    font-size: 1.05em;
    margin-left: 0;
}
</style>
<div class="menu-header">
    <span class="menu-header-title">得点管理システム</span>
    <span class="menu-header-user">
        <%= userName %>　
        <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
    </span>
</div>
<!-- layout-flexは各JSPで開始＆終了させる -->
