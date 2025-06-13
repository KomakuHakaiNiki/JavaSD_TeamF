<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報削除 | 得点管理システム</title>
    <style>
        .main-area {
            margin: 30px 0 0 240px;
            min-width: 450px;
        }
        .main-title-row {
            background: #ededed;
            border-radius: 8px 8px 0 0;
            padding: 14px 30px;
            font-weight: bold;
            font-size: 1.18em;
        }
        .delete-box {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px #ddd;
            padding: 32px 40px 40px 40px;
            margin-top: 0;
            min-height: 160px;
        }
        .delete-message {
            margin: 12px 0 26px 0;
            font-size: 1.09em;
        }
        .delete-btn {
            background: #e55b63;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 1em;
            padding: 8px 32px;
            margin-right: 30px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .delete-btn:hover {
            background: #b8323c;
        }
        .back-link {
            color: #1976d2;
            text-decoration: underline;
            margin-left: 5px;
            font-size: 1em;
        }
    </style>
</head>
<body>
    <div class="main-area">
        <div class="main-title-row">科目情報削除</div>
        <div class="delete-box">
            <form action="<%=request.getContextPath()%>/subject/delete" method="post">
                <!-- ②科目名を表示（サーブレットでリクエスト属性でセット） -->
                <div class="delete-message">
                    「${subject.name}（${subject.cd}）」を削除してよろしいですか？
                </div>
                <!-- ③削除ボタン -->
                <input type="hidden" name="cd" value="${subject.cd}">
                <button type="submit" class="delete-btn">削除</button>
                <!-- ④戻る -->
                <a href="<%=request.getContextPath()%>/subject/list" class="back-link">戻る</a>
            </form>
        </div>
    </div>
</body>
</html>
