<%-- FILE: WebContent/grade/grade_create_done.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績登録完了</title>
    <%@ include file="/menu.jsp" %>
    <link href="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css](https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css)" rel="stylesheet">
    <style>
        .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
        .done-area { max-width: 700px; margin: 0 auto; }
        .title-row { background-color: #f8f9fa; border: 1px solid #dee2e6; border-bottom: none; border-radius: 8px 8px 0 0; padding: 14px 25px; font-weight: bold; }
        .done-body { background: #fff; border-radius: 0 0 12px 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); border: 1px solid #dee2e6; padding: 40px; text-align: center; }
        .done-message { background-color: #e8f5e9; color: #2e7d32; padding: 15px 25px; border-radius: 5px; font-size: 1.1em; border: 1px solid #c8e6c9; margin-bottom: 30px; }
    </style>
</head>
<body>
    <main class="main-content">
        <div class="done-area">
            <div class="title-row">成績管理</div>
            <div class="done-body">
                <div class="done-message">登録が完了しました</div>
                <a href="create" class="btn btn-secondary">戻る</a>
                <a href="search" class="btn btn-primary">成績参照</a>
            </div>
        </div>
    </main>
    </div>
</body>
</html>