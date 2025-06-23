<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>成績削除 | 得点管理システム</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
    .search-area  { max-width: 950px; margin: 0 auto; }
    .title-row    { background: #f8f9fa; border: 1px solid #dee2e6;
                    border-bottom: none; border-radius: 8px 8px 0 0;
                    padding: 14px 25px; font-weight: bold; }
    .form-body    { background: #fff; border-radius: 0 0 12px 12px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                    border: 1px solid #dee2e6; padding: 20px 30px; }
    .results-area { margin-top: 30px; }
  </style>
</head>
<body>
<%@ include file="/menu.jsp" %>

<main class="main-content">
  <div class="search-area">
    <div class="title-row">成績削除</div>
    <div class="form-body">

      <!-- 検索フォーム -->
      <form method="get" action="delete">
        <div class="row gx-3 gy-2 align-items-end mb-4">
          <div class="col-sm-3">
            <label class="form-label">入学年度</label>
            <select name="entYear" class="form-select">
              <c:forEach var="y" items="${ent_years}">
                <option value="${y}" <c:if test="${param.entYear == y}">selected</c:if>>${y}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-sm-3">
            <label class="form-label">クラス</label>
            <select name="classNum" class="form-select">
              <c:forEach var="c" items="${class_nums}">
                <option value="${c}" <c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-sm-4">
            <label class="form-label">科目</label>
            <select name="subjectCd" class="form-select">
              <c:forEach var="s" items="${subjects}">
                <option value="${s.cd}" <c:if test="${param.subjectCd == s.cd}">selected</c:if>>${s.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-sm-auto">
            <button type="submit" class="btn btn-secondary">検索</button>
          </div>
        </div>
      </form>

      <!-- 結果一覧 -->
      <c:if test="${not empty delete_list}">
        <div class="results-area">
          <form method="post" action="delete">
            <input type="hidden" name="entYear" value="${param.entYear}">
            <input type="hidden" name="classNum" value="${param.classNum}">
            <input type="hidden" name="subjectCd" value="${param.subjectCd}">
            <h5 class="mb-3">${searched_subject_name != null ? searched_subject_name : ''} 成績一覧</h5>
            <table class="table table-bordered table-sm">
              <thead>
                <tr>
                  <th>選択</th>
                  <th>入学年度</th>
                  <th>クラス</th>
                  <th>学生番号</th>
                  <th>氏名</th>
                  <th>1回</th>
                  <th>2回</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="r" items="${delete_list}">
                  <tr>
                    <td>
                      <c:if test="${r.no1 != null}">
                        <input type="checkbox" name="deleteIds" value="${r.studentNo},1">
                      </c:if>
                      <c:if test="${r.no2 != null}">
                        <input type="checkbox" name="deleteIds" value="${r.studentNo},2">
                      </c:if>
                    </td>
                    <td>${r.entYear}</td>
                    <td>${r.classNum}</td>
                    <td>${r.studentNo}</td>
                    <td>${r.studentName}</td>
                    <td>${r.no1 != null ? r.no1 : "-"}</td>
                    <td>${r.no2 != null ? r.no2 : "-"}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
            <button type="submit" class="btn btn-danger">選択した成績を削除</button>
          </form>
        </div>
      </c:if>
      <c:if test="${empty delete_list && param.entYear != null}">
        <div class="alert alert-warning mt-3">該当する成績がありません。</div>
      </c:if>
    </div>
  </div>
</main>
</body>
</html>
