<%-- FILE: WebContent/student/student_create.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file="/common/menu.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
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
</head>
<body>
<div style="margin-left:230px;"> <%-- menu.jspがある場合の位置調整 --%>
<form action="create" method="post" class="main-box">
<div class="main-title">学生情報登録</div>

    <%-- ★ エラーメッセージ表示エリア --%>
    <c:if test="${not empty error}">
        <p class="error-message"><c:out value="${error}" /></p>
    </c:if>

    <%-- ① 入学年度 --%>
    <%-- ★ name属性をサーブレットに合わせて"entYear"に変更 --%>
    <label class="form-label" for="entYear">入学年度</label>
    <input type="number" name="entYear" id="entYear" class="form-input"
           placeholder="例: 2024"
           value="<c:out value='${entYear}'/>" required>

    <%-- ② 学生番号 --%>
    <%-- ★ name属性をサーブレットに合わせて"no"に変更 --%>
    <label class="form-label" for="no">学生番号</label>
    <input type="text" name="no" id="no" class="form-input"
           placeholder="7桁の学生番号を入力してください"
           value="<c:out value='${no}'/>" required maxlength="7">

    <%-- ③ 氏名 --%>
    <%-- ★ name属性をサーブレットに合わせて"name"に変更 --%>
    <label class="form-label" for="name">氏名</label>
    <input type="text" name="name" id="name" class="form-input"
           placeholder="氏名を入力してください"
           value="<c:out value='${name}'/>" required>

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
</div>
</body>
</html>
