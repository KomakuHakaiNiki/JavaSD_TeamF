<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン | 得点管理システム</title>
<style>
    /* スタイルは変更ありません */
    body {
        font-family: sans-serif;
        background: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .header {
        font-size: 1.5em;
        font-weight: bold;
        padding: 20px 30px;
        color: #333;
        text-align: left;
        background-color: #f0f8ff;
    }
    .login-box {
        background: #ededed;
        width: 380px;
        margin: 40px auto;
        padding: 30px 24px;
        border-radius: 12px;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.1);
    }
    .login-title {
        font-size: 1.3em;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }
    .form-label {
        display: block;
        margin: 16px 0 6px 0;
        font-size: 1em;
    }
    .form-input {
        width: 100%;
        box-sizing: border-box; /* paddingを含めた幅計算のため */
        padding: 10px;
        font-size: 1em;
        border: 1px solid #ededed;
        border-radius: 6px;
        background: #f0f8ff;
        margin-bottom: 14px;
    }
    .form-btn {
        background: #4d93ff;
        color: #fff;
        font-size: 1em;
        padding: 10px 30px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        width: 100%;
    }
    .form-btn:hover {
        background: #1a5cba;
    }
    .footer {
        background-color: #e0e0e0;
        text-align: center;
        padding: 16px;
        margin-top: 40px;
        font-size: 0.9em;
        color: #555;
    }
    .show-pass {
        margin-top: -10px;
        margin-bottom: 14px;
        font-size: 0.9em;
        text-align: center;
    }
    .error-message {
        color: #d32f2f;
        text-align: center;
        margin-bottom: 15px;
        font-weight: bold;
    }
</style>
<script>
    function togglePassword() {
        var passField = document.getElementById("password");
        passField.type = passField.type === "password" ? "text" : "password";
    }
</script>
</head>
<body>

<div class="header">得点管理システム</div>

<div class="login-box">
    <div class="login-title">ログイン</div>

    <%-- ★修正点2: エラーメッセージを表示 --%>
    <c:if test="${not empty error}">
        <p class="error-message"><c:out value="${error}" /></p>
    </c:if>

    <%-- ★修正点3: action属性を修正 --%>
    <form action="<%=request.getContextPath()%>/login" method="post">
        <label class="form-label" for="userId">ID</label>
        <%-- ★修正点1: name属性を"id"に変更、ログイン失敗時に値を保持 --%>
        <input type="text" name="id" id="userId" class="form-input" value="<c:out value='${param.id}' />">

        <label class="form-label" for="password">パスワード</label>
        <input type="password" name="password" id="password" class="form-input">

        <div class="show-pass">
            <label><input type="checkbox" onclick="togglePassword()"> パスワードを表示</label>
        </div>

        <button type="submit" class="form-btn">ログイン</button>
    </form>
</div>

<div class="footer">
    © 2025 TTC<br>大原学園
</div>

</body>
</html>
