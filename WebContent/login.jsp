<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ログイン | 得点管理システム</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    body {
      background-color: #f9f9f9;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .login-card {
      max-width: 400px;
      width: 100%;
      margin: 80px auto;
    }
    .login-card .card-header {
      background-color: #f8f9fa;
      font-weight: bold;
      text-align: center;
      font-size: 1.2rem;
    }
    .show-pass {
      font-size: 0.9rem;
    }
  </style>
  <script>
    function togglePassword() {
      const p = document.getElementById("password");
      p.type = (p.type === "password" ? "text" : "password");
    }
  </script>
</head>
<body>

  <%-- 共通ヘッダー --%>
  <%@ include file="/header.jsp" %>

  <div class="login-card">
    <div class="card shadow-sm">
      <div class="card-header">ログイン</div>
      <div class="card-body">

        <!-- サーバー認証失敗時のエラーメッセージ -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger py-2 mb-3" role="alert">
            ${error}
          </div>
        </c:if>

        <!-- novalidate を削除して HTML5 validation を有効に -->
        <form action="${pageContext.request.contextPath}/login"
              method="post">

          <div class="mb-3">
            <label for="userId" class="form-label">ID</label>
            <input
              type="text"
              id="userId"
              name="id"
              class="form-control"
              value="${fn:escapeXml(param.id)}"
              required
              autofocus
            >
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">パスワード</label>
            <input
              type="password"
              id="password"
              name="password"
              class="form-control"
              required
            >
          </div>

          <div class="form-check mb-4 show-pass">
            <input
              class="form-check-input"
              type="checkbox"
              id="showPass"
              onclick="togglePassword()"
            >
            <label class="form-check-label" for="showPass">
              パスワードを表示
            </label>
          </div>

          <button type="submit"
                  class="btn btn-primary w-100">
            ログイン
          </button>
        </form>
      </div>
    </div>
  </div>

  <%-- 共通フッター --%>
  <%@ include file="/footer.jsp" %>

</body>
</html>
