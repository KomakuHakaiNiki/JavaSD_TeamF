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
  <title>科目登録 | 得点管理システム</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    .main-content {
        padding: 30px;
        width: 100%;
        box-sizing: border-box;
    }
    .form-area {
        max-width: 700px;
        margin: 0 auto;
    }
    .main-title-row {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-bottom: none;
        border-radius: 8px 8px 0 0;
        padding: 14px 25px;
        font-weight: bold;
        font-size: 1.18em;
    }
    .form-body {
        background: #fff;
        border-radius: 0 0 12px 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        border: 1px solid #dee2e6;
        padding: 30px 40px;
    }
    /* ← これが大事！ */
    .main-layout {
        flex: 1;
        display: flex;
        min-height: 0;
    }
  </style>
</head>
<body>
  <%@ include file="/header.jsp" %>
  <div class="main-layout">
    <%@ include file="/menu.jsp" %>
    <main class="main-content">
        <div class="form-area">
            <div class="main-title-row">
                <span>科目情報登録</span>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                    </div>
                </c:if>
                <form method="post" action="create">
                    <div class="mb-3">
                        <label for="cd" class="form-label">科目コード</label>
                        <input type="text" id="cd" name="cd"
                               class="form-control"
                               value="<c:out value='${cd}'/>"
                               required maxlength="3"
                               placeholder="3文字の半角英数字">
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">科目名</label>
                        <input type="text" id="name" name="name"
                               class="form-control"
                               value="<c:out value='${name}'/>"
                               required>
                    </div>
                    <button type="submit" class="btn btn-primary">登録</button>
                    <a href="list" class="btn btn-link text-secondary">戻る</a>
                </form>
            </div>
        </div>
    </main>
  </div>
  <%@ include file="/footer.jsp" %>
</body>
</html>
