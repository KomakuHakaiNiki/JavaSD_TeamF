<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // セッションからユーザー名を取得
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "大原 太郎様"; // ダミー
%>
<style>
.layout-flex {
    display: flex;
    min-height: 100vh;
}
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
.menu-header-user {
    font-size: 1em;
}
.menu-header-user a {
    color: #0a6bce;
    text-decoration: underline;
    margin-left: 10px;
}
.menu-sidebar {
    width: 180px;
    padding: 30px 0 0 20px;
    border-right: 1.5px solid #d3d5de;   /* 縦線追加 */
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
    /* リストマーク非表示 */
    list-style: none;
}
.menu-nav a {
    color: #2366b1;
    text-decoration: underline;
    font-size: 1.05em;
    margin-left: 0;
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
</style>

<div class="menu-header">
    <span class="menu-header-title">得点管理システム</span>
    <span class="menu-header-user">
        <%= userName %>　
        <a href="<%=request.getContextPath()%>/logout">ログアウト</a>
    </span>
</div>

<div class="layout-flex">
    <nav class="menu-sidebar">
        <div class="menu-nav">
            <a href="<%=request.getContextPath()%>/student/list">学生管理</a>
            <span class="menu-nav-title">成績管理</span>
            <a href="<%=request.getContextPath()%>/grade/create">成績登録</a>
            <a href="<%=request.getContextPath()%>/grade/view">成績参照</a>
            <a href="<%=request.getContextPath()%>/subject/list">科目管理</a>
        </div>
    </nav>
    <!-- 右側のmain部分はここに入ります（各JSPごとに配置） -->
    <!-- <main>...</main> -->
</div>

<footer class="footer">
    © 2023 TIC<br>大原学園
</footer>
