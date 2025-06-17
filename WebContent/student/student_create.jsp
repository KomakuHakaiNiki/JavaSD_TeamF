<%-- FILE: WebContent/student/student_create.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file="/common/menu.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<meta charset="UTF-8">
<title>学生情報登録 | 得点管理システム</title>
<style>
    /* ご提示いただいたスタイルをそのまま使用します */
    body {
        font-family: "Meiryo", sans-serif;
        background: #f7fafd;
        margin: 0;
    }
    .main-box {
        background: #fff;
        margin: 40px auto;
        border-radius: 12px;
        box-shadow: 0 4px 18px #c8c8d240;
        max-width: 620px;
        min-width: 320px;
        padding: 28px 30px 32px 30px;
    }
    .main-title {
        font-size: 1.3em;
        font-weight: bold;
        background: #ededed;
        padding: 14px 24px;
        border-radius: 8px 8px 0 0;
        margin: -28px -30px 28px -30px;
    }
    .form-label {
        display: block;
        margin: 16px 0 4px 0;
        font-size: 1.05em;
        font-weight: bold;
    }
    .form-input, .form-select {
        width: 100%;
        font-size: 1.05em;
        padding: 8px 10px;
        border-radius: 5px;
        border: 1px solid #bbb;
        margin-bottom: 8px;
        background: #fff;
        box-sizing: border-box;
    }
    .form-btn {
        background: #4d93ff;
        color: #fff;
        font-size: 1em;
        padding: 10px 38px;
        border: none;
        border-radius: 8px;
        margin-top: 18px;
        cursor: pointer;
        transition: background 0.2s;
    }
    .form-btn:hover {
        background: #1a5cba;
    }
    .back-link {
        display: inline-block;
        margin-top: 24px;
        color: #1976d2;
        text-decoration: underline;
        font-size: 1em;
    }
    .error-message {
        color: #d32f2f;
        background: #ffebee;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 8px;
    }
</style>
=======
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
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git
</head>
<body>
<<<<<<< HEAD
<div style="margin-left:230px;"> <%-- menu.jspがある場合の位置調整 --%>
<form action="create" method="post" class="main-box">
<div class="main-title">学生情報登録</div>
=======
<div class="container" style="margin-left:230px;">
    <form action="<%=request.getContextPath()%>/student/create" method="post" class="form-card">
        <div class="form-title">学生情報登録</div>
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git

<<<<<<< HEAD
    <%-- ★ エラーメッセージ表示エリア --%>
    <c:if test="${not empty error}">
        <p class="error-message"><c:out value="${error}" /></p>
    </c:if>
=======
        <!-- 入学年度 -->
        <div class="mb-3">
            <label for="enrollmentYear" class="form-label fw-bold">入学年度</label>
            <select name="enrollmentYear" id="enrollmentYear" class="form-select">
                <c:forEach var="year" items="${enrollmentYearList}">
                    <option value="${year}" <c:if test="${year eq param.enrollmentYear}">selected</c:if>>${year}</option>
                </c:forEach>
            </select>
        </div>
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git

<<<<<<< HEAD
    <%-- ① 入学年度 --%>
    <%-- ★ name属性をサーブレットに合わせて"entYear"に変更 --%>
    <label class="form-label" for="entYear">入学年度</label>
    <input type="number" name="entYear" id="entYear" class="form-input"
           placeholder="例: 2024"
           value="<c:out value='${entYear}'/>" required>
=======
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
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git

<<<<<<< HEAD
    <%-- ② 学生番号 --%>
    <%-- ★ name属性をサーブレットに合わせて"no"に変更 --%>
    <label class="form-label" for="no">学生番号</label>
    <input type="text" name="no" id="no" class="form-input"
           placeholder="7桁の学生番号を入力してください"
           value="<c:out value='${no}'/>" required maxlength="7">
=======
        <!-- クラス -->
        <div class="mb-3">
            <label for="classNum" class="form-label fw-bold">クラス</label>
            <select name="classNum" id="classNum" class="form-select">
                <c:forEach var="cls" items="${classNumList}">
                    <option value="${cls}" <c:if test="${cls eq param.classNum}">selected</c:if>>${cls}</option>
                </c:forEach>
            </select>
        </div>
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git

<<<<<<< HEAD
    <%-- ③ 氏名 --%>
    <%-- ★ name属性をサーブレットに合わせて"name"に変更 --%>
    <label class="form-label" for="name">氏名</label>
    <input type="text" name="name" id="name" class="form-input"
           placeholder="氏名を入力してください"
           value="<c:out value='${name}'/>" required>
=======
        <!-- 登録ボタン -->
        <button type="submit" class="btn btn-submit btn-lg mt-3">登録して終了</button>
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git

<<<<<<< HEAD
    <%-- ④ クラス --%>
    <%-- ★ サーブレットから渡されたclassNumListを使って選択肢を動的に生成 --%>
    <label class="form-label" for="classNum">クラス</label>
    <select name="classNum" id="classNum" class="form-select">
        <option value="">-----</option>
        <c:forEach var="classNumItem" items="${classNumList}">
            <option value="${classNumItem}" <c:if test="${classNumItem eq classNum}">selected</c:if>>${classNumItem}</option>
        </c:forEach>
    </select>

    <%-- ★ 在学中チェックボックスを追加 --%>
    <div class="checkbox-group">
        <input type="checkbox" id="isAttend" name="isAttend" value="true" ${isAttend ? 'checked' : ''}>
        <label for="isAttend">在学中</label>
    </div>

    <%-- ⑤ 登録ボタン --%>
    <button type="submit" class="form-btn">登録</button>

    <%-- ⑥ 戻る --%>
    <a href="list" class="back-link">戻る</a>
</form>
=======
        <!-- 戻るリンク -->
        <br>
        <a href="<%=request.getContextPath()%>/student/list" class="back-link">戻る</a>
    </form>
>>>>>>> branch 'master' of https://github.com/KomakuHakaiNiki/JavaSD_TeamF.git
</div>

<!-- Bootstrap JS（オプション） -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
