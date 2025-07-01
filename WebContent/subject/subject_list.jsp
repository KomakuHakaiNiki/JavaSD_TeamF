<%-- FILE: WebContent/subject/subject_list.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // ログインチェック
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
  <title>科目管理 | 得点管理システム</title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .main-content {
      padding: 30px;
      box-sizing: border-box;
    }
    @media (max-width: 768px) {
      .main-content { margin-left: 0 !important; padding: 1rem; }
    }
  </style>
</head>
<body>

  <%-- ① ヘッダー --%>
  <%@ include file="/header.jsp" %>

  <%-- ② サイド＋メイン用コンテナを横並びで開く --%>
  <div class="d-flex">

    <%-- ③ サイドメニュー --%>
    <%@ include file="/menu.jsp" %>

    <%-- ④ メインコンテンツ --%>
    <main class="main-content flex-grow-1">
      <div class="d-flex justify-content-between align-items-center
                  bg-light px-4 py-3 rounded-top shadow-sm">
        <h2 class="h5 mb-0 fw-bold">科目管理</h2>
        <a href="create" class="btn btn-primary btn-sm">新規登録</a>
      </div>
      <div class="bg-white px-4 pb-4 pt-2 rounded-bottom shadow-sm">
        <c:if test="${not empty error}">
          <div class="alert alert-danger mt-3" role="alert">${error}</div>
        </c:if>
        <table class="table table-hover align-middle mt-3">
          <thead>
            <tr>
              <th style="width:25%">科目コード</th>
              <th style="width:55%">科目名</th>
              <th colspan="2" style="width:20%"></th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="subject" items="${subjects}">
              <tr>
                <td><c:out value="${subject.cd}"/></td>
                <td><c:out value="${subject.name}"/></td>
                <td>
                  <a href="update?cd=${subject.cd}"
                     class="btn btn-outline-primary btn-sm">変更</a>
                </td>
                <td>
                  <a href="delete?cd=${subject.cd}"
                     class="btn btn-outline-danger btn-sm">削除</a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty subjects}">
              <tr>
                <td colspan="4" class="text-center text-muted py-4">
                  登録されている科目がありません。
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </main>

  </div> <%-- d-flex コンテナを閉じる --%>

  <%-- ⑤ フッター --%>
  <%@ include file="/footer.jsp" %>

</body>
</html>
