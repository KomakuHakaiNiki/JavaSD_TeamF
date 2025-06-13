<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目管理一覧 | 得点管理システム</title>
    <style>
        .main-area {
            margin: 30px 0 0 240px;
            min-width: 450px;
        }
        .main-title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ededed;
            border-radius: 8px 8px 0 0;
            padding: 14px 30px;
            font-weight: bold;
            font-size: 1.18em;
        }
        .subject-table-area {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px #ddd;
            padding: 0 10px 20px 10px;
        }
        .subject-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            font-size: 1em;
        }
        .subject-table th, .subject-table td {
            border-bottom: 1px solid #e4e4e4;
            padding: 10px 12px;
            text-align: left;
        }
        .subject-table th {
            background: #f8fafc;
            font-weight: bold;
        }
        .subject-table td {
            background: #fff;
        }
        .subject-table tr:last-child td {
            border-bottom: none;
        }
        .table-link {
            color: #1976d2;
            text-decoration: underline;
            margin: 0 7px;
            font-size: 0.98em;
        }
        .btn-right {
            font-size: 0.98em;
            color: #1976d2;
            text-decoration: underline;
        }
        @media (max-width: 700px) {
            .main-area { margin-left: 0; min-width: 0; padding: 0 2vw; }
        }
    </style>
</head>
<body>
    <div class="main-area">
        <!-- タイトルと右上新規登録 -->
        <div class="main-title-row">
            <span>科目管理</span>
            <a href="<%=request.getContextPath()%>/subject/create" class="btn-right">科目登録</a>
        </div>
        <div class="subject-table-area">
            <table class="subject-table">
                <thead>
                    <tr>
                        <th style="width: 20%;">科目コード</th>
                        <th style="width: 50%;">科目名</th>
                        <th style="width: 15%;"></th>
                        <th style="width: 15%;"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="subject" items="${subjectList}">
                        <tr>
                            <td>${subject.cd}</td>
                            <td>${subject.name}</td>
                            <td><a href="<%=request.getContextPath()%>/subject/update?cd=${subject.cd}" class="table-link">変更</a></td>
                            <td><a href="<%=request.getContextPath()%>/subject/delete?cd=${subject.cd}" class="table-link">削除</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
