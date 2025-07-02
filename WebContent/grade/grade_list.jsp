<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>成績参照 | 得点管理システム</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">
  <style>
    .layout-container { display: flex; }
    .main-content { padding: 30px; flex-grow: 1; }
    .list-area { max-width: 950px; margin: 0 auto; }
    .title-row {
      background:#f8f9fa; border:1px solid #dee2e6;
      border-bottom:none; border-radius:8px 8px 0 0;
      padding:14px 25px; font-weight:bold;
    }
    .form-body {
      background:#fff; border-radius:0 0 12px 12px;
      box-shadow:0 2px 8px rgba(0,0,0,0.05);
      border:1px solid #dee2e6; padding:20px 30px;
    }
    .mt-4 { margin-top:1.5rem; }
  </style>
</head>
<body>
  <%@ include file="/header.jsp" %>
  <div class="layout-container">
    <%@ include file="/menu.jsp" %>
    <main class="main-content">
      <div class="list-area">
        <div class="title-row">成績参照</div>
        <div class="form-body">

          <!-- ■ 科目検索フォーム -->
          <form method="post"
                action="${pageContext.request.contextPath}/grade/search">
            <input type="hidden" name="search_type" value="subject"/>
            <div class="row gx-3 gy-2 align-items-end mb-3">
              <div class="col-sm-3">
                <label class="form-label">入学年度</label>
                <select name="f1" class="form-select">
                  <option value="">----</option>
                  <c:forEach var="y" items="${ent_years}">
                    <option value="${y}"
                      <c:if test="${param.f1 == y.toString()}">selected</c:if>>
                      ${y}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-3">
                <label class="form-label">クラス</label>
                <select name="f2" class="form-select">
                  <option value="">----</option>
                  <c:forEach var="c" items="${class_nums}">
                    <option value="${c}"
                      <c:if test="${param.f2 == c}">selected</c:if>>
                      ${c}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-4">
                <label class="form-label">科目</label>
                <select name="f3" class="form-select">
                  <option value="">----</option>
                  <c:forEach var="s" items="${subjects}">
                    <option value="${s.cd}"
                      <c:if test="${param.f3 == s.cd}">selected</c:if>>
                      ${s.name}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-auto">
                <button type="submit" class="btn btn-secondary">検索</button>
              </div>
            </div>
          </form>

          <!-- 科目検索のエラー／情報 -->
          <c:if test="${not empty errorSubject}">
            <div class="alert alert-danger">${errorSubject}</div>
          </c:if>
          <c:if test="${empty errorSubject and not empty infoSubject}">
            <div class="alert alert-info">${infoSubject}</div>
          </c:if>

          <!-- ■ 科目検索結果 -->
          <c:if test="${not empty resultsSubject}">
            <hr/>
            <p>科目：<b>${searchedSubjectName}</b> の成績一覧</p>
            <table class="table table-sm table-bordered">
              <thead>
                <tr>
                  <th>入学年度</th>
                  <th>クラス</th>
                  <th>学生番号</th>
                  <th>氏名</th>
                  <th>1回</th>
                  <th>2回</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="r" items="${resultsSubject}">
                  <tr>
                    <td>${r.entYear}</td>
                    <td>${r.classNum}</td>
                    <td>${r.studentNo}</td>
                    <td>${r.studentName}</td>
                    <td>
                      <c:out value="${r.no1 != null ? r.no1 : '-'}"/>
                    </td>
                    <td>
                      <c:out value="${r.no2 != null ? r.no2 : '-'}"/>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:if>

          <!-- ■ 学生検索フォーム -->
          <div class="mt-4"></div>
          <form method="post"
                action="${pageContext.request.contextPath}/grade/search">
            <input type="hidden" name="search_type" value="student"/>
            <div class="row gx-3 gy-2 align-items-end mb-3">
              <div class="col-sm-5">
                <label class="form-label">学生番号</label>
                <input type="text"
                       name="f4"
                       value="${param.f4}"
                       class="form-control"
                       placeholder="例：1234567"/>
              </div>
              <div class="col-sm-auto">
                <button type="submit" class="btn btn-secondary">検索</button>
              </div>
            </div>
          </form>

          <!-- 学生検索のエラー／情報 -->
          <c:if test="${not empty errorStudent}">
            <div class="alert alert-danger">${errorStudent}</div>
          </c:if>
          <c:if test="${empty errorStudent and not empty infoStudent}">
            <div class="alert alert-info">${infoStudent}</div>
          </c:if>

          <!-- ■ 学生検索結果 -->
          <c:if test="${not empty resultsStudent}">
            <hr/>
            <p>学生：<b>${student.name}</b>（番号 ${student.no}）の成績一覧</p>
            <table class="table table-sm table-bordered">
              <thead>
                <tr>
                  <th>科目名</th>
                  <th>科目コード</th>
                  <th>回数</th>
                  <th>点数</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="r" items="${resultsStudent}">
                  <tr>
                    <td>${r.subjectName}</td>
                    <td>${r.subjectCd}</td>
                    <td>${r.num}</td>
                    <td>${r.point}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:if>

        </div>
      </div>
    </main>
  </div>
  <%@ include file="/footer.jsp" %>
</body>
</html>
