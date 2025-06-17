<%-- FILE: WebContent/student/student_list.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理 | 得点管理システム</title>
    <style>
        .main-area {
            margin: 30px auto;
            width: 95%;
            max-width: 850px;
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
        .filter-area {
            display: flex;
            gap: 15px;
            align-items: center;
            padding: 20px 30px;
            background-color: #f8f9fa;
        }
        .filter-label {
            font-weight: bold;
        }
        .filter-select, .search-btn {
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .search-btn {
            background-color: #0d6efd;
            color: white;
            cursor: pointer;
            border: none;
        }
        .student-table-area {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px #ddd;
            padding: 10px 20px 20px 20px;
        }
        .student-table {
            width: 100%;
            border-collapse: collapse;
        }
        .student-table th, .student-table td {
            border-bottom: 1px solid #e4e4e4;
            padding: 12px 15px;
            text-align: left;
        }
        .student-table th {
            background: #f8fafc;
        }
        .table-link {
            color: #1976d2;
            text-decoration: none;
        }
        .table-link:hover {
            text-decoration: underline;
        }
        .btn-right {
            font-size: 0.98em;
            color: #1976d2;
            text-decoration: none;
        }
        .error-message {
            color: #d32f2f;
            padding: 10px 30px;
        }
    </style>
</head>
<body>
    <%-- <%@ include file="/common/menu.jsp" %> --%>
    <div class="main-area">
        <div class="main-title-row">
            <span>学生管理</span>
            <a href="create" class="btn-right">学生登録</a>
        </div>

        <form method="get" action="list">
            <div class="filter-area">
                <span class="filter-label">入学年度</span>
                <select name="entYear" class="filter-select">
                    <option value="0">すべて</option>
                    <c:forEach var="year" items="${entYearList}">
                        <option value="${year}" <c:if test="${year eq param.entYear}">selected</c:if>>${year}</option>
                    </c:forEach>
                </select>

                <span class="filter-label">クラス</span>
                <select name="classNum" class="filter-select">
                    <option value="">すべて</option>
                    <c:forEach var="classNumItem" items="${classNumList}">
                        <option value="${classNumItem}" <c:if test="${classNumItem eq param.classNum}">selected</c:if>>${classNumItem}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="search-btn">絞り込み</button>
            </div>
        </form>

        <c:if test="${not empty error}">
            <p class="error-message"><c:out value="${error}" /></p>
        </c:if>

        <div class="student-table-area">
            <table class="student-table">
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
                                <a href="update?no=${student.no}" class="table-link">変更</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
