<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"    prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>学生登録 | 得点管理システム</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">
  <style>
    .layout-container { display: flex; }
    /* メイン部。flex-grow-1 で横に伸びます */
    .main-content { padding: 30px; }
    /* フォームカードを中央ナローに */
    .form-area {
      max-width: 700px;
      margin: 0 auto;
    }
    .main-title-row {
      background: #f8f9fa;
      border: 1px solid #dee2e6;
      border-bottom: none;
      border-radius: 8px 8px 0 0;
      padding: 14px 25px;
      font-weight: bold;
    }
    .form-body {
      background: #fff;
      border: 1px solid #dee2e6;
      border-radius: 0 0 12px 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 30px 40px;
    }
  </style>
</head>
<body>

  <%@ include file="/header.jsp" %>

  <div class="layout-container">
    <%@ include file="/menu.jsp" %>

    <!-- ここに flex-grow-1 クラスを付ける -->
    <main class="main-content flex-grow-1">
      <div class="form-area">
        <div class="main-title-row">学生情報登録</div>
        <div class="form-body">

          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>

          <form method="post"
                action="${pageContext.request.contextPath}/student/create">

            <!-- 入学年度 -->
            <div class="mb-3">
              <label class="form-label" for="entYear">入学年度</label>
              <select id="entYear" name="entYear" class="form-select" required>
                <option value="">-- 選択してください --</option>
                <c:forEach var="y" items="${entYearList}">
                  <option value="${y}"
                    <c:if test="${param.entYear == y.toString()}">selected</c:if>>
                    ${y}
                  </option>
                </c:forEach>
              </select>
            </div>

            <!-- 学生番号 -->
            <div class="mb-3">
              <label class="form-label" for="no">学生番号</label>
              <input type="text"
                     id="no" name="no"
                     class="form-control"
                     maxlength="10"
                     value="${fn:escapeXml(param.no)}"
                     required>
            </div>

            <!-- 氏名 -->
            <div class="mb-3">
              <label class="form-label" for="name">氏名</label>
              <input type="text"
                     id="name" name="name"
                     class="form-control"
                     value="${fn:escapeXml(param.name)}"
                     required>
            </div>

            <!-- クラス -->
            <div class="mb-3">
              <label class="form-label" for="classNum">クラス</label>
              <select id="classNum" name="classNum" class="form-select" required>
                <option value="">-- 選択してください --</option>
                <c:forEach var="c" items="${classNumList}">
                  <option value="${c}"
                    <c:if test="${param.classNum == c}">selected</c:if>>
                    ${c}
                  </option>
                </c:forEach>
              </select>
            </div>

            <!-- 在学中 -->
            <div class="form-check mb-4">
              <input type="checkbox"
                     id="isAttend" name="isAttend"
                     class="form-check-input"
                     <c:if test="${param.isAttend != null}">checked</c:if> />
              <label class="form-check-label" for="isAttend">在学中</label>
            </div>

            <!-- ボタン -->
            <button type="submit" class="btn btn-primary">登録</button>
            <a href="${pageContext.request.contextPath}/student/list"
               class="btn btn-link">戻る</a>

          </form>
        </div>
      </div>
    </main>
  </div>

  <%@ include file="/footer.jsp" %>
</body>
</html>
