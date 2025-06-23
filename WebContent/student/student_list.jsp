<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>学生管理 | 得点管理システム</title>
  <%@ include file="/menu.jsp" %>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content  { padding: 30px; width:100%; box-sizing:border-box; }
    .filter-area   { background:#f8f9fa; padding:20px; border-radius:4px; }
  </style>
</head>
<body>
  <main class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h2>学生管理</h2>
      <a href="create" class="btn btn-primary">新規登録</a>
    </div>

    <!-- 絞り込みフォーム -->
    <form method="get" action="list" class="filter-area mb-4 row gx-3 gy-2 align-items-end">
      <!-- 入学年度 -->
      <div class="col-auto">
        <label class="form-label">入学年度</label>
        <select name="entYear" class="form-select">
          <option value="">───</option>
          <c:forEach var="y" items="${entYearList}">
            <option value="${y}" <c:if test="${y eq selectedEntYear}">selected</c:if>>${y}</option>
          </c:forEach>
        </select>
      </div>
      <!-- クラス -->
      <div class="col-auto">
        <label class="form-label">クラス</label>
        <select name="classNum" class="form-select">
          <option value="">───</option>
          <c:forEach var="c" items="${classNumList}">
            <option value="${c}" <c:if test="${c eq selectedClassNum}">selected</c:if>>${c}</option>
          </c:forEach>
        </select>
      </div>
      <!-- 在学中チェック -->
      <div class="col-auto form-check mt-4">
        <input type="checkbox" name="attend" id="attend" class="form-check-input" <c:if test="${selectedAttend}">checked</c:if> />
        <label for="attend" class="form-check-label">在学中</label>
      </div>
      <!-- 検索ボタン -->
      <div class="col-auto">
        <button type="submit" class="btn btn-secondary">絞込み</button>
      </div>
    </form>

    <!-- 検索結果テーブル -->
    <div class="table-responsive bg-white p-3 rounded shadow-sm">
      <p>検索結果：<strong>${fn:length(studentList)}件</strong></p>
      <table class="table table-hover align-middle">
        <thead>
          <tr>
            <th>入学年度</th><th>クラス</th><th>学生番号</th><th>氏名</th><th>在学中</th><th>操作</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="s" items="${studentList}">
            <tr>
              <td>${s.entyear}</td>
              <td>${s.classNum}</td>
              <td>${s.no}</td>
              <td>${s.name}</td>
              <td><c:choose>
                    <c:when test="${s.attend}">○</c:when>
                    <c:otherwise>×</c:otherwise>
                  </c:choose>
              </td>
              <td>
                <a href="update?no=${s.no}" class="btn btn-outline-primary btn-sm">変更</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </main>
</body>
</html>
