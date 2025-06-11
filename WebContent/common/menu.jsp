<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // セッションからユーザー名を取得
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "大原 太郎様"; // ダミー
%>
<div style="background:#e6eef7; padding: 10px 24px; display:flex; justify-content:space-between; align-items:center;">
    <span style="font-size:1.3em; font-weight:bold; color:#2b2e33;">
        得点管理システム
    </span>
    <span>
        <%= userName %>　
        <a href="<%=request.getContextPath()%>/logout" style="color:#0a6bce; text-decoration:underline;">ログアウト</a>
    </span>
</div>

<nav style="width:180px; padding:30px 0 0 20px;">
    <a href="<%=request.getContextPath()%>/student/list" style="display:block; margin-bottom:15px; color:#2366b1; text-decoration:underline;">学生管理</a>
    <a href="<%=request.getContextPath()%>/grade/menu" style="display:block; margin-bottom:15px; color:#2366b1; text-decoration:underline;">成績管理</a>
    <a href="<%=request.getContextPath()%>/grade/create" style="display:block; margin-bottom:15px; color:#2366b1; text-decoration:underline;">成績登録</a>
    <a href="<%=request.getContextPath()%>/grade/view" style="display:block; margin-bottom:15px; color:#2366b1; text-decoration:underline;">成績参照</a>
    <a href="<%=request.getContextPath()%>/subject/list" style="display:block; margin-bottom:15px; color:#2366b1; text-decoration:underline;">科目管理</a>
</nav>
