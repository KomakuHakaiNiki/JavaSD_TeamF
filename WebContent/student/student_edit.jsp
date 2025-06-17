<%-- FILE: WebContent/student/student_edit.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生情報変更 | 得点管理システム</title>
    <style>
        body {
            font-family: "Meiryo", sans-serif;
            margin: 0;
            background: #f7fafd;
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
        .form-input[readonly] {
            background-color: #f5f5f5;
            color: #555;
            cursor: not-allowed;
        }
        .form-btn {
            background: #1e88e5;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .form-btn:hover {
            background: #1565c0;
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
    </style>
</head>
<body>
    <%-- <%@ include file="/common/menu.jsp" %> --%>

    <div class="main-area">
        <div class="main-title-row">
            <span>学生情報変更</span>
        </div>

        <div class="form-area">

            <%-- エラーメッセージ表示 --%>
            <c:if test="${not empty error}">
                <p class="error-message"><c:out value="${error}" /></p>
            </c:if>

            <form method="post" action="update">
                <%-- ★重要: 更新対象の学生番号を隠しフィールドで送信 --%>
                <input type="hidden" name="no" value="<c:out value='${student.no}'/>">

                <div class="form-group">
                    <label>入学年度</label>
                    <%-- ★修正点: サーブレットから渡された値を表示、変更不可 --%>
                    <input type="text" name="entYear" class="form-input" value="<c:out value='${student.entyear}'/>" readonly>
                </div>
                 <div class="form-group">
                    <label>学籍番号</label>
                    <input type="text" class="form-input" value="<c:out value='${student.no}'/>" readonly>
                </div>
                 <div class="form-group">
                    <label for="name">氏名</label>
                    <input type="text" id="name" name="name" class="form-input" value="<c:out value='${student.name}'/>" required>
                </div>
                <div class="form-group">
                    <label for="classNum">クラス</label>
                    <%-- ★修正点: クラス一覧を動的に生成 --%>
                    <select id="classNum" name="classNum" class="form-select">
                        <c:forEach var="classNumItem" items="${classNumList}">
                           <option value="${classNumItem}" <c:if test="${classNumItem eq student.classNum}">selected</c:if>>${classNumItem}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>
                        <%-- ★修正点: 在学状況をチェックボックスで表示 --%>
                        <input type="checkbox" name="isAttend" value="true" ${student.attend ? 'checked' : ''}>
                        在学中
                    </label>
                </div>
                <button type="submit" class="form-btn">変更</button>
            </form>
            <a href="list" class="back-link">一覧へ戻る</a>
        </div>
    </div>
</body>
</html>
