<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - ログアウト</title>
<style>
    /* ページ全体のレイアウトと基本スタイル */
    body {
        margin: 0;
        font-family: 'Meiryo', 'メイリオ', 'Hiragino Kaku Gothic ProN', 'ヒラギノ角ゴ ProN W3', sans-serif;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        background-color: #ffffff;
    }

    /* ヘッダーのスタイル */
    header {
        background-color: #e7f0ff;
        padding: 20px 40px;
        font-size: 22px;
        font-weight: bold;
        color: #343a40;
    }

    /* メインコンテンツエリアのスタイル */
    main {
        flex-grow: 1;
        padding: 50px 20px;
    }
    
    .content-wrapper {
        max-width: 900px;
        margin: 0 auto;
    }

    /* フッターのスタイル */
    footer {
        background-color: #e9ecef;
        padding: 20px 40px;
        text-align: center;
        color: #6c757d;
        font-size: 14px;
        border-top: 1px solid #dee2e6;
    }

    /* --- ログアウトコンテンツ関連のスタイル --- */
    
    .title-bar {
        background-color: #f8f9fa;
        padding: 15px 25px;
        font-size: 20px;
        font-weight: bold;
        color: #495057;
        border: 1px solid #dee2e6;
        border-radius: 3px;
    }

    .message-box {
        background-color: #a5d6a7;
        color: #155724;
        padding: 15px 25px;
        margin-top: 25px;
        border-radius: 3px;
        font-size: 16px;
        border: 1px solid #97c999;
        text-align: center;
    }

    /* ③ 「ログイン」へのリンク */
    .login-link {
        margin-top: 162px; /* 上の余白を広げてリンクを下に移動 */
        padding-left: 5px;
    }

    .login-link a {
        color: #0d6efd;
        text-decoration: underline;
        font-size: 16px;
    }
    .login-link a:hover {
        text-decoration: none;
    }
</style>
</head>
<body>

    <!-- ヘッダー -->
    <header>
        得点管理システム
    </header>

    <!-- メインコンテンツ -->
    <main>
        <div class="content-wrapper">
            <!-- ① タイトルバー -->
            <div class="title-bar">
                ログアウト
            </div>
    
            <!-- ② メッセージボックス -->
            <div class="message-box">
                ログアウトしました
            </div>
    
            <!-- ③ ログインへのリンク -->
            <div class="login-link">
                <a href="login.jsp">ログイン</a>
            </div>
        </div>
    </main>

    <!-- フッター -->
    <footer>
        © 2023 TIC<br>
         大原学園
    </footer>

</body>
</html>