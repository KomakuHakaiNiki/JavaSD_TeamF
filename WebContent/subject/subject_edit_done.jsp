<%-- FILE: WebContent/subject/subject_update_done.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- セキュリティチェック --%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>科目変更完了 | 得点管理システム</title>

    <%-- 共通メニュー(スタイル含む)を読み込み --%>
    <%@ include file="/menu.jsp" %>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* 登録完了画面と共通のスタイル */
        .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
        .done-area { max-width: 700px; margin: 0 auto; }
        .main-title-row {
            background-color: #f8f9fa; border: 1px solid #dee2e6; border-bottom: none;
            border-radius: 8px 8px 0 0; padding: 14px 25px;
            font-weight: bold; font-size: 1.18em;
        }
        .done-body {
            background: #fff; border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6; padding: 40px; text-align: center;
        }
        .done-message {
            background-color: #e8f5e9; color: #2e7d32;
            padding: 15px 25px; border-radius: 5px; font-size: 1.1em;
            border: 1px solid #c8e6c9; margin-bottom: 30px;
        }
    </style>
</head>
<body>

    <!-- 共通メニューは上で読み込み済み -->

    <main class="main-content">
        <div class="done-area">
            <div class="main-title-row">
                <span>科目情報変更</span>
            </div>

            <div class="done-body">
                <div class="done-message">
                    変更が完了しました
                </div>

                <a href="list" class="btn btn-primary">科目一覧へ</a>
            </div>
        </div>
    </main>

    <%-- menu.jspで開始したレイアウト用divをここで閉じる --%>
    </div>

</body>
</html>
