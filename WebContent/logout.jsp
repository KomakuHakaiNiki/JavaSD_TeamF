<%-- FILE: WebContent/logout.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - ログアウト</title>
<style>
    body {
        margin: 0;
        font-family: 'Meiryo', sans-serif;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        background-color: #f8f9fa;
    }
    header {
        background-color: #e7f0ff;
        padding: 20px 40px;
        font-size: 22px;
        font-weight: bold;
        color: #343a40;
        border-bottom: 1px solid #dee2e6;
    }
    main {
        flex-grow: 1;
        padding: 50px 20px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .content-wrapper {
        max-width: 600px;
        width: 100%;
        text-align: center;
    }
    .message-box {
        background-color: #e8f5e9;
        color: #2e7d32;
        padding: 20px 25px;
        border-radius: 8px;
        font-size: 18px;
        border: 1px solid #c8e6c9;
    }
    .login-link {
        margin-top: 30px;
    }
    .login-link a {
        color: #0d6efd;
        text-decoration: underline;
        font-size: 16px;
    }
    .login-link a:hover {
        text-decoration: none;
    }
    footer {
        background-color: #e9ecef;
        padding: 20px 40px;
        text-align: center;
        color: #6c757d;
        font-size: 14px;
        border-top: 1px solid #dee2e6;
    }
</style>
</head>
<body>

    <header>
        得点管理システム
    </header>

    <main>
        <div class="content-wrapper">
            <div class="message-box">
                ログアウトしました
            </div>

            <div class="login-link">
                <%-- ★修正点: リンク先をLoginServletのURLに変更 --%>
                <a href="${pageContext.request.contextPath}/login">ログイン画面へ</a>
            </div>
        </div>
    </main>

    <footer>
        © 2025 TIC<br>
        大原学園
    </footer>

</body>
</html>
