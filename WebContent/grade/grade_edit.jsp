<!-- 『成績登録』の【成績登録完了】となります。 -->


<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登録完了 | 成績管理システム</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .main-area {
            margin: 30px 0 0 240px;
            min-width: 600px;
        }
        .main-title-row {
            background: #ededed;
            border-radius: 8px 8px 0 0;
            padding: 14px 30px;
            font-weight: bold;
            font-size: 1.2em;
        }
        .alert-custom {
            background-color: #a5d6a7;
            color: #1b5e20;
            padding: 12px 20px;
            margin-top: 0;
            border-radius: 0 0 8px 8px;
        }
        .link-row {
            padding: 30px 20px;
        }
    </style>
</head>
<body>

<div class="main-area">
    <!-- タイトル -->
    <div class="main-title-row">成績管理</div>

    <!-- 登録完了メッセージ -->
    <div class="alert-custom">
        登録が完了しました
    </div>

    <!-- 戻る・参照リンク -->
    <div class="link-row">
        <a href="<%=request.getContextPath()%>/grade/input" class="me-3">戻る</a>
        <a href="<%=request.getContextPath()%>/grade/list">成績参照</a>
    </div>
</div>

</body>
</html>







