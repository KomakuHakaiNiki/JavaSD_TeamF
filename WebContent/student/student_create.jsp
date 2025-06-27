<%-- FILE: WebContent/student/student_create.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"    prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- セキュリティチェック --%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<%@ include file="/menu.jsp" %>  <%-- 共通ヘッダー＋メニュー読み込み --%>

<main class="main-content">
  <div class="form-area">
    <div class="main-title-row">
      <span>学生情報登録</span>
    </div>
    <div class="form-body">

      <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
          <c:out value="${error}"/>
        </div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/student/create">

        <!-- 入学年度プルダウン -->
        <div class="mb-3">
          <label for="entYear" class="form-label">入学年度</label>
          <select id="entYear" name="entYear" class="form-select" required>
            <option value="">-----</option>
            <c:forEach var="year" items="${entYearList}">
              <option value="${year}"
                <c:if test="${param.entYear == year.toString()}">selected</c:if>>
                ${year}
              </option>
            </c:forEach>
          </select>
        </div>

        <!-- 学生番号 -->
        <div class="mb-3">
          <label for="no" class="form-label">学生番号</label>
          <input type="text"
                 id="no" name="no"
                 class="form-control"
                 value="${fn:escapeXml(param.no)}"
                 required maxlength="10">
        </div>

        <!-- 氏名 -->
        <div class="mb-3">
          <label for="name" class="form-label">氏名</label>
          <input type="text"
                 id="name" name="name"
                 class="form-control"
                 value="${fn:escapeXml(param.name)}"
                 required>
        </div>

        <!-- クラスプルダウン -->
        <div class="mb-3">
          <label for="classNum" class="form-label">クラス</label>
          <select id="classNum" name="classNum" class="form-select">
            <option value="">-----</option>
            <c:forEach var="cls" items="${classNumList}">
              <option value="${cls}"
                <c:if test="${param.classNum == cls}">selected</c:if>>
                ${cls}
              </option>
            </c:forEach>
          </select>
        </div>

        <!-- 在学中チェック -->
        <div class="form-check mb-3">
          <input type="checkbox"
                 id="isAttend" name="isAttend"
                 class="form-check-input"
                 <c:if test="${param.isAttend != null}">checked</c:if> />
          <label for="isAttend" class="form-check-label">在学中</label>
        </div>

        <!-- ボタン -->
        <button type="submit" class="btn btn-primary">登録</button>
        <a href="${pageContext.request.contextPath}/student/list"
           class="btn btn-link text-secondary">戻る</a>
      </form>

    </div>
  </div>
</main>

  <%-- menu.jsp で開いたタグを閉じる／フッター含む --%>
