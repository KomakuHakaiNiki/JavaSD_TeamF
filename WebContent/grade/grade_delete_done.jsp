<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- セキュリティチェック --%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>成績削除完了 | 得点管理システム</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    .layout-container { display: flex; }
    .main-content {
      padding: 30px;
      flex-grow: 1;
      box-sizing: border-box;
    }
    h2 {
      font-size: 1.2em;
      font-weight: bold;
      background: #f8f9fa;
      padding: 0.75rem 1.25rem;
      border: 1px solid #dee2e6;
      margin-bottom: 1.5rem;
    }
    .done-message {
      background: #d1e7dd;
      color: #0f5132;
      padding: 1rem;
      border: 1px solid #dee2e6;
      text-align: center;
      margin-bottom: 4rem;
    }
    .action-link { margin-right: 2rem; }
  </style>
</head>
<body>

  <%-- 共通ヘッダー --%>
  <%@ include file="/header.jsp" %>

  <div class="layout-container">
    <%-- サイドバー --%>
    <%@ include file="/menu.jsp" %>

    <%-- メイン --%>
    <main class="main-content">
      <h2>成績削除完了</h2>

      <div class="done-message">
        削除が完了しました
      </div>

      <a href="search" class="action-link">成績参照</a>
    </main>
  </div>

  <%-- 共通フッター --%>
  <%@ include file="/footer.jsp" %>
</body>
</html>
