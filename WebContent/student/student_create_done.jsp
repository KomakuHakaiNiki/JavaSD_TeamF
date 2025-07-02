<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>学生登録完了 | 得点管理システム</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content {
      padding: 30px;
      flex-grow: 1;
      box-sizing: border-box;
    }
    h2 {
      font-size: 1.2em;
      font-weight: bold;
      background-color: #f8f9fa;
      padding: 0.75rem 1.25rem;
      border: 1px solid #dee2e6;
      margin-bottom: 1.5rem;
      text-align: center;
    }
    .done-message {
      background-color: #d1e7dd;
      color: #0f5132;
      padding: 1rem;
      border: 1px solid #dee2e6;
      text-align: center;
      margin-bottom: 6.5rem;
    }
    .action-link {
      font-size: 1em;
      margin-right: 4rem;
    }
  </style>
</head>
<body>

  <%-- 共通ヘッダー --%>
  <%@ include file="/header.jsp" %>

  <%-- サイドバー＋メインをflexで横並び --%>
  <div class="layout-container d-flex">

    <%-- サイドバー --%>
    <%@ include file="/menu.jsp" %>

    <%-- メインコンテンツ --%>
    <main class="main-content">
      <h2>学生登録完了</h2>
      <div class="done-message">
        登録が完了しました
      </div>
      <a href="create" class="action-link">続けて登録する</a>
      <a href="list"   class="action-link">学生一覧へ戻る</a>
    </main>
  </div>

  <%-- 共通フッター --%>
  <%@ include file="/footer.jsp" %>

</body>
</html>
