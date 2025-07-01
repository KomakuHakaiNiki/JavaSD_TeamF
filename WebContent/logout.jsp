<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>得点管理システム - ログアウト</title>
  <style>
    /* --- 既存の logout.jsp 用スタイル --- */
    body {
      margin: 0;
      font-family: 'Meiryo', sans-serif;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      background-color: #f8f9fa;
    }
    main {
      flex-grow: 1;
      padding: 50px 20px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .content-wrapper {
      max-width: 600px;
      width: 100%;
      text-align: center;
    }
    .message-box {
      background-color: #e8f5e9;
      color: #2e7d32;
      padding: 20px 25px;
      border-radius: 8px;
      font-size: 18px;
      border: 1px solid #c8e6c9;
      margin-bottom: 30px;
    }
    .login-link a {
      color: #0d6efd;
      text-decoration: underline;
      font-size: 16px;
    }
    .login-link a:hover {
      text-decoration: none;
    }
  </style>
</head>
<body>

  <%-- === 共通ヘッダー を挿入 === --%>
  <%@ include file="/header.jsp" %>

  <main>
    <div class="content-wrapper">
      <div class="message-box">
        ログアウトしました
      </div>

      <div class="login-link">
        <a href="<%=request.getContextPath()%>/login">
          ログイン画面へ
        </a>
      </div>
    </div>
  </main>

  <%-- === 共通フッター を挿入 === --%>
  <%@ include file="/footer.jsp" %>

</body>
</html>
