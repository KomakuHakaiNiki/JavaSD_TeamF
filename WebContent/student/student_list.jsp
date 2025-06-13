<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理一覧 | 得点管理システム</title>
    <style>
        .main-area {
            margin: 30px 0 0 240px;
            min-width: 620px;
        }
        .main-title-row {
            background: #ededed;
            border-radius: 8px 8px 0 0;
            padding: 14px 30px;
            font-weight: bold;
            font-size: 1.18em;
            margin-bottom: 10px;
        }
        .filter-box {
            display: flex;
            gap: 16px;
            align-items: center;
            padding: 22px 30px 8px 30px;
        }
        .filter-label {
            font-weight: bold;
            font-size: 1em;
        }
        .filter-select, .filter-input {
            font-size: 1em;
            padding: 6px 12px;
            border: 1px solid #bbb;
            border-radius: 5px;
            background: #fff;
            min-width: 120px;
        }
        .search-btn {
            background: #1976d2;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 8px 26px;
            font-size: 1em;
            margin-left: 12px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .search-btn:hover {
            background: #1254a1;
        }
        .student-table-area {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px #ddd;
            padding: 0 10px 20px 10px;
        }
        .student-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            font-size: 1em;
        }
        .student-table th, .student-table td {
            border-bottom: 1px solid #e4e4e4;
            padding: 10px 8px;
            text-align: left;
        }
        .student-table th {
            background: #f8fafc;
            font-weight: bold;
        }
        .student-table td {
            background: #fff;
        }
        .student-table tr:last-child td {
            border-bottom: none;
        }
        .edit-link {
            color: #1976d2;
            text-decoration: underline;
            font-size: 0.97em;
        }
        @media (max-width: 900px) {
            .main-area { margin-left: 0; min-width: 0; padding: 0 2vw; }
            .filter-box { flex-direction: column; align-items: flex-start; gap: 8px;}
        }
    </style>
</head>
<body>
    <div class="main-area">
        <!-- ①タイトル -->
        <div class="main-title-row">学生管理</div>
        <!-- 検索・フィルター部 -->
        <form method="get" action="<%=request.getContextPath()%>/student/list">
            <div class="filter-box">
                <!-- ②入学年度 -->
                <span class="filter-label">入学年度</span>
                <select name="entYear" class="filter-select">
                    <option value="">--</option>
                    <c:forEach var="year" items="${entYearList}">
                        <option value="${year}" <c:if test="${year eq param.entYear}">selected</c:if>>${year}</option>
                    </c:forEach>
                </select>
                <!-- ④クラス -->
                <span class="filter-label">クラス</span>
                <select name="classNum" class="filter-select">
                    <option value="">--</option>
                    <c:forEach var="classNum" items="${classNumList}">
                        <option value="${classNum}" <c:if test="${classNum eq param.classNum}">selected</c:if>>${classNum}</option>
                    </c:forEach>
                </select>
                <!-- ⑧検索ボタン -->
                <button type="submit" class="search-btn">絞込</button>
            </div>
        </form>
        <!-- 一覧表 -->
        <div class="student-table-area">
            <table class="student-table">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>クラス</th>
                        <th>在学中</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${studentList}">
                        <tr>
                            <td>${student.entyear}</td>
                            <td>${student.no}</td>
                            <td>${student.name}</td>
                            <td>${student.classNum}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${student.attend}">○</c:when>
                                    <c:otherwise>×</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="<%=request.getContextPath()%>/student/update?no=${student.no}" class="edit-link">変更</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
