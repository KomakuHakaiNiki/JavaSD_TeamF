<%-- FILE: WebContent/grade/grade_create.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- セキュリティチェック --%>
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
    <title>成績登録 | 得点管理システム</title>

    <%-- 共通メニュー(スタイル含む)を読み込み --%>
    <%@ include file="/menu.jsp" %>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .main-content {
            padding: 30px;
            width: 100%;
            box-sizing: border-box;
        }
        .regist-area {
            max-width: 950px;
            margin: 0 auto;
        }
        .title-row {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-bottom: none;
            border-radius: 8px 8px 0 0;
            padding: 14px 25px;
            font-weight: bold;
        }
        .form-body {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6;
            padding: 20px 30px;
        }
        .results-info {
            font-weight: bold;
            font-size: 1.1em;
        }
    </style>
</head>
<body>

    <main class="main-content">
        <div class="regist-area">
            <div class="title-row">成績管理</div>
            <div class="form-body">

                <%-- 検索フォーム --%>
                <form method="post" action="create">
                    <input type="hidden" name="cmd" value="search">
                    <div class="row gx-3 gy-2 align-items-end mb-3">
                        <div class="col-sm-2">
                            <label class="form-label">入学年度</label>
                            <select name="f1" class="form-select">
                                <c:forEach var="year" items="${ent_years}">
                                    <option value="${year}" <c:if test="${year eq param.f1}">selected</c:if>>${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label class="form-label">クラス</label>
                            <select name="f2" class="form-select">
                                <c:forEach var="c" items="${class_nums}">
                                    <option value="${c}" <c:if test="${c eq param.f2}">selected</c:if>>${c}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label class="form-label">科目</label>
                            <select name="f3" class="form-select">
                                <c:forEach var="s" items="${subjects}">
                                    <option value="${s.cd}" <c:if test="${s.cd eq param.f3}">selected</c:if>>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label class="form-label">回数</label>
                            <select name="f4" class="form-select">
                                <option value="1" <c:if test="${'1' eq param.f4}">selected</c:if>>1</option>
                                <option value="2" <c:if test="${'2' eq param.f4}">selected</c:if>>2</option>
                            </select>
                        </div>
                        <div class="col-sm-auto">
                            <button type="submit" class="btn btn-secondary">検索</button>
                        </div>
                    </div>
                </form>

                <%-- 検索結果がある場合のみ、点数入力フォームを表示 --%>
                <c:if test="${not empty results}">
                    <hr>
                    <p class="results-info">科目: ${subjects.stream().filter(s -> s.cd.equals(param.f3)).findFirst().get().name} (${param.f4}回)</p>

                    <form method="post" action="create">
                        <input type="hidden" name="cmd" value="regist">
                        <input type="hidden" name="subject_cd" value="${param.f3}">
                        <input type="hidden" name="num" value="${param.f4}">

                        <table class="table table-sm table-bordered">
                            <thead>
                                <tr>
                                    <th>入学年度</th>
                                    <th>クラス</th>
                                    <th>学生番号</th>
                                    <th>氏名</th>
                                    <th>点数</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${results}">
                                    <tr>
                                        <td>${param.f1}</td>
                                        <td>${r.classNum}</td>
                                        <td>${r.student.no}</td>
                                        <td>${r.student.name}</td>
                                        <td><input type="number" name="point_${r.student.no}" value="${r.point}" class="form-control" min="0" max="100"></td>
                                        <input type="hidden" name="class_num_${r.student.no}" value="${r.classNum}">
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="text-start mt-3">
                            <button type="submit" class="btn btn-primary">登録して終了</button>
                        </div>
                    </form>
                </c:if>

                 <%-- 検索して結果が0件だった場合のメッセージ --%>
                <c:if test="${empty results and not empty param.f1}">
                    <hr>
                    <div class="alert alert-warning">指定された条件の学生が見つかりませんでした。</div>
                </c:if>

            </div>
        </div>
    </main>

    <%-- menu.jspで開始したレイアウト用divを閉じる --%>
    </div>
</body>
</html>
