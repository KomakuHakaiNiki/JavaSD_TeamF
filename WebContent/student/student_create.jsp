<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生情報登録 | 得点管理システム</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-card {
            margin: 40px auto;
            max-width: 700px;
            background: #f7fafd;
            border-radius: 12px;
            box-shadow: 0 4px 18px #c8c8d240;
            padding: 32px;
        }
        .form-title {
            font-size: 1.3rem;
            font-weight: bold;
            background: #ededed;
            padding: 14px 24px;
            border-radius: 8px 8px 0 0;
            margin: -32px -32px 24px -32px;
        }
        .btn-submit {
            background-color: #4d93ff;
            color: white;
        }
        .btn-submit:hover {
            background-color: #1a5cba;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: underline;
            color: #1976d2;
        }
    </style>
</head>
<body>
<div class="container" style="margin-left:230px;">
    <form action="<%=request.getContextPath()%>/student/create" method="post" class="form-card">
        <div class="form-title">学生情報登録</div>

        <!-- 入学年度 -->
        <div class="mb-3">
            <label for="enrollmentYear" class="form-label fw-bold">入学年度</label>
            <select name="enrollmentYear" id="enrollmentYear" class="form-select">
                <c:forEach var="year" items="${enrollmentYearList}">
                    <option value="${year}" <c:if test="${year eq param.enrollmentYear}">selected</c:if>>${year}</option>
                </c:forEach>
            </select>
        </div>

        <!-- 学生番号 -->
        <div class="mb-3">
            <label for="studentId" class="form-label fw-bold">学生番号</label>
            <input type="text" name="studentId" id="studentId" class="form-control"
                   placeholder="学生番号を入力してください"
                   value="${param.studentId != null ? param.studentId : ''}">
        </div>
        <!-- 氏名 -->
        <div class="mb-3">
            <label for="studentName" class="form-label fw-bold">氏名</label>
            <input type="text" name="studentName" id="studentName" class="form-control"
                   placeholder="氏名を入力してください"
                   value="${param.studentName != null ? param.studentName : ''}">
        </div>

        <!-- クラス -->
        <div class="mb-3">
            <label for="classNum" class="form-label fw-bold">クラス</label>
            <select name="classNum" id="classNum" class="form-select">
                <c:forEach var="cls" items="${classNumList}">
                    <option value="${cls}" <c:if test="${cls eq param.classNum}">selected</c:if>>${cls}</option>
                </c:forEach>
            </select>
        </div>

        <!-- 登録ボタン -->
        <button type="submit" class="btn btn-submit btn-lg mt-3">登録して終了</button>

        <!-- 戻るリンク -->
        <br>
        <a href="<%=request.getContextPath()%>/student/list" class="back-link">戻る</a>
    </form>
</div>

<!-- Bootstrap JS（オプション） -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>