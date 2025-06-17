<%-- FILE: WebContent/subject/subject_edit.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報変更 | 得点管理システム</title>
    <%-- 共通のスタイルシートを想定 --%>
    <style>
        /* 以前のJSPと共通のスタイル */
        .main-area {
            margin: 30px auto;
            width: 90%;
            max-width: 600px;
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
        .form-input {
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
        }
        .form-btn {
            background: #1e88e5;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
        }
        .error-message {
            color: #d32f2f;
            background: #ffebee;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="main-area">
        <div class="main-title-row">
            <span>科目情報変更</span>
        </div>

        <div class="form-area">

            <%-- サーブレットから渡されたエラーメッセージを表示 --%>
            <c:if test="${not empty error}">
                <p class="error-message"><c:out value="${error}" /></p>
            </c:if>

            <%-- ★修正点: actionを正しいサーブレットのURLに変更 --%>
            <form method="post" action="update">
                <div class="form-group">
                    <label class="form-label">科目コード</label>
                    <%-- ★修正点: サーブレットから渡されたsubjectオブジェクトのcdを表示。変更不可(readonly)にする --%>
                    <input type="text" name="cd" class="form-input" value="<c:out value='${subject.cd}'/>" readonly>
                </div>
                <div class="form-group">
                    <label for="name" class="form-label">科目名</label>
                    <%-- ★修正点: name属性を "name" に変更。サーブレットから渡されたsubjectオブジェクトのnameを表示 --%>
                    <input type="text" id="name" name="name" class="form-input" value="<c:out value='${subject.name}'/>" required maxlength="20">
                </div>
                <button type="submit" class="form-btn">変更</button>
            </form>
            <%-- ★修正点: 戻るリンクを正しいサーブレットのURLに変更 --%>
            <a href="list" class="back-link">一覧へ戻る</a>
        </div>
    </div>
</body>
</html>
