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
        .main-content {
            padding: 30px;
            box-sizing: border-box;
        }
        h2 {
            font-size: 1.2em;
            font-weight: bold;
            background-color: #f8f9fa;
            padding: 0.75rem 1.25rem;
            border: 1px solid #dee2e6;
            margin-bottom: 1.5rem;
        }
        .done-message {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 1rem;
            border: 1px solid #dee2e6;
            text-align: center;
            margin-bottom: 6.5rem;
        }
        .action-link {
            font-size: 1em;
            margin-right: 4rem; /* リンク同士の間隔 */
        }
    </style>
</head>
<body>

    <%-- menu.jspがここに展開されます --%>

    <main class="main-content flex-grow-1">

        <h2>科目情報変更</h2>

        <div class="done-message">
            変更が完了しました
        </div>

        <a href="list" class="action-link">科目一覧</a>

    </main>

    <%-- 新しいレイアウトでは不要なため、以前の閉じタグ</div>は削除しました --%>

</body>
</html>