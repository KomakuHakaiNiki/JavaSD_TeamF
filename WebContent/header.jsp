<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- セッションからユーザー名取得（例：user.name でTeacher等から取得） --%>
<%
    // sessionスコープの"user"オブジェクトがnullの場合用のダミー
    Object userObj = session.getAttribute("user");
    String userName = "";
    if (userObj != null) {
        try {
            // Teacher型などで「getName()」があればリフレクションで取得
            java.lang.reflect.Method getName = userObj.getClass().getMethod("getName");
            userName = (String) getName.invoke(userObj);
        } catch (Exception e) {
            userName = ""; // 何かあったら空
        }
    }
    if (userName == null || userName.isEmpty()) userName = "ゲスト";
%>
<div class="header">
    <span class="header-title">得点管理システム</span>
    <span class="header-user">
        <%= userName %> 様
        <a href="<%=request.getContextPath()%>/logout" style="margin-left:18px;">ログアウト</a>
    </span>
</div>
<style>
.header {
    font-size: 1.5em;
    font-weight: bold;
    padding: 18px 34px 14px 30px;
    color: #333;
    background-color: #f0f8ff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1.5px solid #e0e6ef;
}
.header-title {
    font-size: 1.3em;
    font-weight: bold;
    color: #2b2e33;
}
.header-user {
    font-size: 1em;
    color: #1976d2;
}
.header-user a {
    color: #1976d2;
    text-decoration: underline;
    font-size: 1em;
    margin-left: 10px;
}
</style>
