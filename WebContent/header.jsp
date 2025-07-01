<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ヘッダーの HTML -->
<header class="site-header">
  <div class="container-fluid d-flex justify-content-between align-items-center px-4">
    <h1 class="site-title mb-0">得点管理システム</h1>
    <c:if test="${not empty sessionScope.user}">
      <div class="user-info">
        ${sessionScope.user.name} 様
        <a href="${pageContext.request.contextPath}/logout">ログアウト</a>
      </div>
    </c:if>
  </div>
</header>

<style>
  /* ---- 先ほどの全体フレックスCSSをここに貼り付け ---- */
  html, body {
    height: 100%;
    margin: 0;
  }
  body {
    display: flex;
    flex-direction: column;
  }

  /* ヘッダー固定はしないので position:static のまま */
  .site-header {
    background-color: #f0f8ff;
    border-bottom: 1.5px solid #e0e6ef;
  }
  .site-header .px-4 {
    padding: .75rem 2rem; /* 高さをちょうど良く */
  }
  .site-title {
    font-size: 1.5em;
    font-weight: bold;
    color: #333;
  }
  .user-info {
    font-size: 1em;
    color: #1976d2;
  }
  .user-info a {
    margin-left: 1rem;
    text-decoration: underline;
    color: #1976d2;
  }
</style>
