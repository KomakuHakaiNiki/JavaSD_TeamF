<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>科目削除確認 | 得点管理システム</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main-layout { flex: 1; display: flex; min-height: 0; }
        .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
        .confirm-area { max-width: 700px; margin: 0 auto; }
        .main-title-row {
            background-color: #f8f9fa; border: 1px solid #dee2e6; border-bottom: none;
            border-radius: 8px 8px 0 0; padding: 14px 25px;
            font-weight: bold; font-size: 1.18em;
        }
        .confirm-body {
            background: #fff; border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6; padding: 40px;
        }
        .confirm-message {
            background-color: #fff3cd; color: #664d03;
            padding: 15px 25px; border-radius: 5px; font-size: 1.1em;
            border: 1px solid #ffde7a; margin-bottom: 30px;
        }
        .confirm-item {
            margin-bottom: 1rem;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
  <%@ include file="/header.jsp" %>
  <div class="main-layout">
    <%@ include file="/menu.jsp" %>
    <main class="main-content">
      <div class="confirm-area">
        <div class="main-title-row">
          <span>科目削除確認</span>
        </div>
        <div class="confirm-body">
          <div class="confirm-message">
            以下の科目を削除します。よろしいですか？
          </div>
          <div class="confirm-item">
            <strong>科目コード:</strong> <c:out value="${subject.cd}" />
          </div>
          <div class="confirm-item">
            <strong>科目名:</strong> <c:out value="${subject.name}" />
          </div>
          <form method="post" action="delete" class="mt-4">
            <input type="hidden" name="cd" value="<c:out value='${subject.cd}'/>">
            <button type="submit" class="btn btn-danger">削除</button>
            <a href="list" class="btn btn-secondary">キャンセル</a>
          </form>
        </div>
      </div>
    </main>
  </div>
  <%@ include file="/footer.jsp" %>
</body>
</html>

