<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目管理一覧 | 得点管理システム</title>

    <!-- ✅ Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        @media (max-width: 768px) {
            .main-area { margin-left: 0 !important; padding: 0 1rem; }
        }
    </style>
</head>
<body>

    <div class="main-area" style="margin: 30px 0 0 240px;">
        <!-- タイトルと登録リンク -->
        <div class="d-flex justify-content-between align-items-center bg-light px-4 py-3 rounded-top shadow-sm">
            <h2 class="h5 m-0 fw-bold">科目管理</h2>
            <a href="<%=request.getContextPath()%>/subject/create" class="text-primary text-decoration-underline">科目登録</a>
        </div>

        <!-- エラーメッセージ -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger mx-4 mt-3" role="alert">
                <c:out value="${error}" />
            </div>
        </c:if>

        <!-- テーブル -->
        <div class="bg-white px-4 pb-4 pt-2 rounded-bottom shadow-sm">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 20%;">科目コード</th>
                        <th style="width: 50%;">科目名</th>
                        <th style="width: 15%;"></th>
                        <th style="width: 15%;"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="subject" items="${subjects}">
                        <tr>
                            <td>${subject.cd}</td>
                            <td>${subject.name}</td>
                            <td>
                                <a href="<%=request.getContextPath()%>/subject/update?cd=${subject.cd}" class="text-primary text-decoration-underline">変更</a>
                            </td>
                            <td>
                                <a href="<%=request.getContextPath()%>/subject/delete?cd=${subject.cd}" class="text-primary text-decoration-underline">削除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
