<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録 | 得点管理システム</title>
    <style>
        body {
            margin: 0;
            background: #f7fafd;
            font-family: "Meiryo", sans-serif;
        }
        .layout-flex {
            display: flex;
            min-height: 100vh;
        }
        .header {
            background:#e6eef7;
            padding:10px 24px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }
        .sidebar {
            width: 180px;
            padding: 30px 0 0 20px;
            border-right: 1.5px solid #d3d5de;
            min-height: calc(100vh - 55px);
            box-sizing: border-box;
        }
        .sidebar a {
            display: block;
            margin-bottom: 15px;
            color: #2366b1;
            text-decoration: underline;
            font-size: 1.05em;
        }
        .sidebar-title {
            font-weight: bold;
            color: #376345;
            font-size: 1.05em;
            margin-bottom: 5px;
            padding-top: 6px;
            padding-left: 2px;
        }
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 0;
        }
        .main-box {
            background: #fff;
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
        }
        .form-input {
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
            border: 1px solid #ffcdd2;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <span style="font-size:1.3em; font-weight:bold; color:#2b2e33;">得点管理システム</span>
        <span>
            <%-- ★修正点: セッションからログインユーザー名を表示 --%>
            <c:out value="${sessionScope.user.name}" />様
            <a href="<%=request.getContextPath()%>/logout" style="color:#0a6bce; text-decoration:underline;">ログアウト</a>
        </span>
    </div>
    <div class="layout-flex">
        <!-- サイドバー -->
        <nav class="sidebar">
            <a href="<%=request.getContextPath()%>/student/list">学生管理</a>
            <div class="sidebar-title">成績管理</div>
            <a href="<%=request.getContextPath()%>/grade/create">成績登録</a>
            <a href="<%=request.getContextPath()%>/grade/view">成績参照</a>
            <a href="<%=request.getContextPath()%>/subject/list">科目管理</a>
        </nav>
        <!-- メイン -->
        <main class="main-content">
            <div class="main-box">
                <div class="main-title">科目情報登録</div>

                <%-- ★修正点: エラーメッセージを表示する処理を追加 --%>
                <c:if test="${not empty error}">
                    <p class="error-message"><c:out value="${error}" /></p>
                </c:if>

                <form action="create" method="post">
                    <label class="form-label" for="subjectCode">科目コード</label>
                    <%-- ★修正点: name属性を "cd" に変更。失敗時に値を保持 --%>
                    <input type="text" name="cd" id="subjectCode" class="form-input"
                           placeholder="科目コードを入力してください (例: T03)"
                           value="<c:out value='${cd}'/>" required maxlength="3"/>

                    <label class="form-label" for="subjectName">科目名</label>
                    <%-- ★修正点: name属性を "name" に変更。失敗時に値を保持 --%>
                    <input type="text" name="name" id="subjectName" class="form-input"
                           placeholder="科目名を入力してください"
                           value="<c:out value='${name}'/>" required maxlength="20"/>

                    <button type="submit" class="form-btn">登録</button>
                    <div>
                        <a href="list" class="back-link">戻る</a>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
