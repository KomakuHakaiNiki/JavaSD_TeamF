<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ログイン | 得点管理システム</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #f5f5f5;
        }
        .main-box {
            background: #fff;
            margin: 60px auto;
            border-radius: 12px;
            box-shadow: 0 4px 18px #ccc;
            max-width: 480px;
            padding: 32px 40px;
            text-align: center;
        }
        .main-title {
            font-size: 1.4em;
            font-weight: bold;
            background: #e0ebff;
            padding: 16px;
            border-radius: 8px 8px 0 0;
            margin-bottom: 28px;
        }
        .form-label {
            display: block;
            text-align: left;
            margin: 10px 0 5px 0;
            font-size: 1em;
        }
        .form-input {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border-radius: 6px;
            border: 1px solid #bbb;
            margin-bottom: 12px;
        }
        .form-checkbox {
            margin-top: 4px;
            margin-bottom: 16px;
            text-align: left;
            font-size: 0.95em;
        }
        .form-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 36px;
            font-size: 1em;
            border-radius: 8px;
            cursor: pointer;
        }
        .form-btn:hover {
            background: #0056b3;
        }
        footer {
            margin-top: 48px;
            text-align: center;
            color: #666;
            font-size: 0.9em;
        }
    </style>
    <script>
        function togglePassword() {
            const pwdInput = document.getElementById("password");
            pwdInput.type = pwdInput.type === "password" ? "text" : "password";
        }
    </script>
</head>
<body>

<div class="main-box">
    <div class="main-title">ログイン</div>
    <form action="<%= request.getContextPath() %>/login" method="post">
        <label class="form-label" for="userId">ＩＤ</label>
        <input type="text" id="userId" name="userId" class="form-input" placeholder="ユーザーIDを入力" value="${param.userId != null ? param.userId : ''}" />

        <label class="form-label" for="password">パスワード</label>
        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力" />

        <div class="form-checkbox">
            <input type="checkbox" id="showPassword" onclick="togglePassword()" />
            <label for="showPassword">パスワードを表示</label>
        </div>

        <button type="submit" class="form-btn">ログイン</button>
    </form>
</div>

<footer>
    © 2025 TTC<br>大原学園
</footer>

</body>
</html>
