<%-- FILE: WebContent/student/student_create_done.jsp --%>
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
    <title>学生登録完了 | 得点管理システム</title>

    <%@ include file="/menu.jsp" %>
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
            /* ★★★ 修正箇所 ★★★ */
            /* リンク同士の間隔を広げるために、右側の余白を大きくします */
            margin-right: 4rem; 
        }
    </style>
</head>
<body>
    <%-- menu.jspがここに展開されます --%>

    <main class="main-content flex-grow-1">
        
        <h2>学生情報登録</h2>

        <div class="done-message">
            登録が完了しました
        </div>

        <a href="create" class="action-link">戻る</a>
        <a href="list" class="action-link">学生一覧</a>

    </main>
</body>
</html>