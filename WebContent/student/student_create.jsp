<%-- FILE: WebContent/student/student_create.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報登録 | 得点管理システム</title>
<style>
    /* 既存の画面と共通のスタイルを想定 */
    body {
        font-family: "Meiryo", sans-serif;
        background: #f7fafd;
        margin: 0;
    }
    .main-area {
        margin: 30px auto;
        width: 90%;
        max-width: 650px;
    }
    .main-title-row {
        background: #ededed;
        border-radius: 8px;
        padding: 14px 30px;
        font-weight: bold;
        font-size: 1.18em;
        margin-bottom: 20px;
    }
    .form-area {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 8px #ddd;
        padding: 30px 40px;
    }
    .form-group {
        margin-bottom: 20px;
    }
    .form-label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
    }
    .form-input, .form-select {
        width: 100%;
        padding: 10px;
        font-size: 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }
    .form-btn {
        background: #4285f4;
        color: #fff;
        border: none;
        padding: 12px 30px;
        font-size: 1em;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.2s;
    }
    .form-btn:hover {
        background: #3367d6;
    }
    .error-message {
        color: #d32f2f;
        background: #ffebee;
        border: 1px solid #ffcdd2;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    .back-link {
        display: inline-block;
        margin-top: 20px;
        color: #555;
        text-decoration: none;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 8px;
    }
</style>
</head>
<body>
    <%-- <%@ include file="/common/menu.jsp" %> --%>
    <div class="main-area">
        <div class="main-title-row">
            <span>学生情報登録</span>
        </div>

        <div class="form-area">
            <%-- サーブレットから渡されたエラーメッセージを表示 --%>
            <c:if test="${not empty error}">
                <p class="error-message"><c:out value="${error}" /></p>
            </c:if>

            <form method="post" action="create">
                <div class="form-group">
                    <label for="entYear">入学年度</label>
                    <input type="number" id="entYear" name="entYear" class="form-input" value="<c:out value='${entYear}'/>" required placeholder="例: 2024">
                </div>
                <div class="form-group">
                    <label for="no">学生番号</label>
                    <input type="text" id="no" name="no" class="form-input" value="<c:out value='${no}'/>" required maxlength="7" placeholder="7桁の半角数字">
                </div>
                <div class="form-group">
                    <label for="name">氏名</label>
                    <input type="text" id="name" name="name" class="form-input" value="<c:out value='${name}'/>" required>
                </div>
                <div class="form-group">
                    <label for="classNum">クラス</label>
                    <select id="classNum" name="classNum" class="form-select">
                        <option value="">-----</option>
                        <%-- サーブレットから渡されたクラス一覧で選択肢を生成 --%>
                        <c:forEach var="classNumItem" items="${classNumList}">
                           <option value="${classNumItem}" <c:if test="${classNumItem eq classNum}">selected</c:if>>${classNumItem}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group checkbox-group">
                    <input type="checkbox" id="isAttend" name="isAttend" value="true" ${isAttend ? 'checked' : ''}>
                    <label for="isAttend">在学中</label>
                </div>
                <button type="submit" class="form-btn">登録</button>
            </form>
            <a href="list" class="back-link">一覧へ戻る</a>
        </div>
    </div>
</body>
</html>
