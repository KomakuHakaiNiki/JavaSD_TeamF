<%-- FILE: WebContent/student/student_list.jsp --%>
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
    <title>学生管理 | 得点管理システム</title>

    <%@ include file="/menu.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
        .filter-area { background-color: #f8f9fa; }
    </style>
</head>
<body>
    <main class="main-content">
        <div class="d-flex justify-content-between align-items-center bg-light px-4 py-3 rounded-top shadow-sm">
            <h2 class="h5 mb-0 fw-bold">学生管理</h2>
            <a href="create" class="btn btn-primary btn-sm">学生登録</a>
        </div>

        <form method="get" action="list" class="filter-area px-4 py-3 border-start border-end">
            <%-- ... 絞り込みフォーム ... --%>
        </form>

        <div class="bg-white px-4 pb-4 pt-2 rounded-bottom shadow-sm">
            <table class="table table-hover align-middle mt-3">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>在学中</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${studentList}">
                        <tr>
                            <td>${student.entyear}</td>
                            <td>${student.classNum}</td>
                            <td>${student.no}</td>
                            <td>${student.name}</td>
                            <td>${student.attend ? 'はい' : 'いいえ'}</td>
                            <td>
                                <%-- ★★★ このリンクを "update" に修正 ★★★ --%>
                                <a href="update?no=${student.no}" class="btn btn-outline-primary btn-sm">変更</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
    </div>
</body>
</html>
