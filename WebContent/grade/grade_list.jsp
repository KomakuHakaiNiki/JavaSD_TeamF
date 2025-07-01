<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"    prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>成績参照 | 得点管理システム</title>
  <%@ include file="/menu.jsp" %>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    /* ページ全体の余白 */
    .main-content { padding: 30px; width:100%; box-sizing:border-box; }
    /* カードのタイトルバー */
    .title-row {
      background: #f8f9fa;
      border: 1px solid #dee2e6;
      border-bottom: none;
      border-radius: 8px 8px 0 0;
      padding: 14px 25px;
      font-weight: bold;
    }
    /* カード本文 */
    .form-body {
      background: #fff;
      border-radius: 0 0 12px 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #dee2e6;
      padding: 20px 30px;
    }
    .results-area { margin-top: 30px; }
  </style>
</head>
<body>
<main class="main-content">

  <div class="card mb-4">
    <div class="title-row">成績参照</div>
    <div class="form-body">

      <!-- グローバルエラー / 情報メッセージ -->
      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty info}">
        <div class="alert alert-info">${info}</div>
      </c:if>

      <!-- 科目情報：全てデフォルトのまま検索したときのエラー -->
      <c:if test="
            ${param.search_type=='subject'
              and empty param.f1
              and empty param.f2
              and empty param.f3}">
        <div class="alert alert-danger mb-4">
          入学年度とクラスと科目を入力してください
        </div>
      </c:if>

      <!-- ■ 科目情報 検索フォーム -->
      <p class="fw-bold">科目情報</p>
      <form method="post" action="search" class="mb-4">
        <input type="hidden" name="search_type" value="subject"/>
        <div class="row gx-3 gy-2 align-items-end">
          <div class="col-sm-3">
            <label class="form-label">入学年度</label>
            <select name="f1" class="form-select">
              <option value="">----------</option>
              <c:forEach var="y" items="${ent_years}">
                <option value="${y}"
                  <c:if test="${param.f1==y.toString()}">selected</c:if>>
                  ${y}
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="col-sm-3">
            <label class="form-label">クラス</label>
            <select name="f2" class="form-select">
              <option value="">----------</option>
              <c:forEach var="cnum" items="${class_nums}">
                <option value="${cnum}"
                  <c:if test="${param.f2==cnum}">selected</c:if>>
                  ${cnum}
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="col-sm-4">
            <label class="form-label">科目</label>
            <select name="f3" class="form-select">
              <option value="">----------</option>
              <c:forEach var="s" items="${subjects}">
                <option value="${s.cd}"
                  <c:if test="${param.f3==s.cd}">selected</c:if>>
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

      <hr/>

      <!-- ■ 学生情報 検索フォーム -->
      <p class="fw-bold">学生情報</p>
      <form method="post" action="search">
        <input type="hidden" name="search_type" value="student"/>
        <div class="row gx-3 gy-2 align-items-end">
          <div class="col-sm-4">
            <label class="form-label">学生番号</label>
            <input type="text"
                   name="f4"
                   class="form-control"
                   value="${fn:escapeXml(param.f4)}"
                   placeholder="学生番号を入力してください"
                   required>
          </div>
          <div class="col-sm-auto">
            <button type="submit" class="btn btn-secondary">検索</button>
          </div>
        </div>
      </form>

      <!-- 学生検索：存在しない番号 -->
      <c:if test="
            ${param.search_type=='student'
              and empty results_student
              and not empty param.f4}">
        <div class="alert alert-warning mt-4">
          成績情報が存在しませんでした
        </div>
      </c:if>

      <!-- ■ 科目検索結果 -->
      <c:if test="${not empty results_subject}">
        <div class="results-area">
          <h4>${searched_subject_name} 成績一覧</h4>
          <table class="table table-bordered table-sm">
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
              <c:forEach var="r" items="${results_subject}">
                <tr>
                  <td>${r.entYear}</td>
                  <td>${r.classNum}</td>
                  <td>${r.studentNo}</td>
                  <td>${r.studentName}</td>
                  <td><c:out value="${r.no1}" default="-"/></td>
                  <td><c:out value="${r.no2}" default="-"/></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <!-- ■ 学生検索結果 -->
      <c:if test="${not empty results_student}">
        <div class="results-area">
          <h4>${student.name} 成績一覧</h4>
          <table class="table table-bordered table-sm">
            <thead>
              <tr>
                <th>科目コード</th>
                <th>科目名</th>
                <th>回数</th>
                <th>点数</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${results_student}">
                <tr>
                  <td>${r.subjectCd}</td>
                  <td>${r.subjectName}</td>
                  <td>${r.num}</td>
                  <td>${r.point}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

    </div>
  </div>

</main>
</body>
</html>
