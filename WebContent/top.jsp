<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // セッションチェック
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>得点管理システム</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    /* メインコンテンツの余白 */
    .main-content {
      padding: 40px;
      box-sizing: border-box;
      width: 100%;
    }
    /* メニューカードのレイアウト */
    .menu-box-group {
      display: flex;
      flex-wrap: wrap;
      gap: 40px;
      justify-content: center;
    }
    .menu-box {
      flex-basis: 240px;
      min-height: 150px;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.08);
      padding: 25px;
      text-align: center;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .menu-box:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 24px rgba(0,0,0,0.12);
    }
    .menu-box.student { background: #fff0f0; }
    .menu-box.grade   { background: #f0fff0; }
    .menu-box.subject { background: #f0f8ff; }
    .menu-title-box {
      font-size: 1.2em;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .menu-link {
      display: block;
      margin-top: 8px;
      text-decoration: none;
      color: #6a1b9a;
    }
  </style>
</head>
<body>

  <!-- ヘッダー -->
  <%@ include file="/header.jsp" %>

  <!-- サイドバー＋メインを横並びに -->
  <div class="layout-container d-flex">
    <!-- サイドバー -->
    <%@ include file="/menu.jsp" %>

    <!-- メイン -->
    <main class="main-content flex-grow-1">
      <h2 class="text-center mb-4">メニュー</h2>
      <div class="menu-box-group">
        <!-- 学生管理カード -->
        <div class="menu-box student">
          <div class="menu-title-box">学生管理</div>
          <a class="menu-link"
             href="${pageContext.request.contextPath}/student/list">
            学生一覧
          </a>
        </div>
        <!-- 成績管理カード -->
        <div class="menu-box grade">
          <div class="menu-title-box">成績管理</div>
          <a class="menu-link"
             href="${pageContext.request.contextPath}/grade/create">
            成績登録
          </a>
          <a class="menu-link"
             href="${pageContext.request.contextPath}/grade/delete">
            成績削除
          </a>
          <a class="menu-link"
             href="${pageContext.request.contextPath}/grade/search">
            成績参照
          </a>
        </div>
        <!-- 科目管理カード -->
        <div class="menu-box subject">
          <div class="menu-title-box">科目管理</div>
          <a class="menu-link"
             href="${pageContext.request.contextPath}/subject/list">
            科目管理
          </a>
        </div>
      </div>
    </main>
  </div> <!-- /.layout-container -->

  <!-- フッター -->
  <%@ include file="/footer.jsp" %>

</body>
</html>
