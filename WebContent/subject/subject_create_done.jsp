<%-- FILE: WebContent/subject/subject_create_done.jsp --%>
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
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>科目登録完了 | 得点管理システム</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    .main-content { padding: 30px; box-sizing: border-box; max-width: 600px; margin: 0 auto; }
    h2 {
      font-size: 1.2em; font-weight: bold;
      background-color: #f8f9fa; padding: 0.75rem 1.25rem;
      border: 1px solid #dee2e6; margin-bottom: 1.5rem;
      text-align: center;
    }
    .done-message {
      background-color: #d1e7dd; color: #0f5132;
      padding: 1rem; border: 1px solid #dee2e6;
      text-align: center; margin-bottom: 2rem;
    }
    .action-link {
      display: inline-block; margin-right: 2rem;
      color: #0d6efd; text-decoration: none;
    }
  </style>
</head>
<body>

  <%-- 共通ヘッダー --%>
  <%@ include file="/header.jsp" %>

  <%-- サイドメニュー＋レイアウトコンテナ --%>
  <%@ include file="/menu.jsp" %>

  <main class="main-content">
    <h2>科目情報登録</h2>
    <div class="done-message">
      登録が完了しました
    </div>
    <a href="create" class="action-link">戻る</a>
    <a href="list" class="action-link">科目一覧へ</a>
  </main>

  <%-- menu.jsp のコンテナを閉じる --%>
  </div>

  <%-- 共通フッター --%>
  <%@ include file="/footer.jsp" %>
</body>
</html>
