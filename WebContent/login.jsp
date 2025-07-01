<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ログイン | 得点管理システム</title>
  <style>
    /* --- 既存の login-box スタイル --- */
    body {
      font-family: sans-serif;
      background: #f5f5f5;
      margin: 0;
      padding: 0;
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
      margin: 16px 0 6px;
      font-size: 1em;
    }
    .form-input {
      width: 100%;
      box-sizing: border-box;
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

  <%-- === 共通ヘッダーを挿入 === --%>
  <%@ include file="/header.jsp" %>

  <div class="login-box">
    <div class="login-title">ログイン</div>

    <c:if test="${not empty error}">
      <p class="error-message">${error}</p>
    </c:if>

    <form action="<%=request.getContextPath()%>/login" method="post">
      <label class="form-label" for="userId">ID</label>
      <input
        type="text"
        name="id"
        id="userId"
        class="form-input"
        value="<c:out value='${param.id}' />">

      <label class="form-label" for="password">パスワード</label>
      <input
        type="password"
        name="password"
        id="password"
        class="form-input">

      <div class="show-pass">
        <label>
          <input type="checkbox" onclick="togglePassword()">
          パスワードを表示
        </label>
      </div>

      <button type="submit" class="form-btn">ログイン</button>
    </form>
  </div>

  <%-- === 共通フッターを挿入 === --%>
  <%@ include file="/footer.jsp" %>

</body>
</html>
