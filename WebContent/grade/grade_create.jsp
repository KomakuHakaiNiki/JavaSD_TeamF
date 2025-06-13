<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録 | 得点管理システム</title>
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
        .form-box {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px #ddd;
            padding: 32px 40px 40px 40px;
            min-height: 180px;
        }
        .form-label {
            display: block;
            margin: 18px 0 6px 0;
            font-size: 1.05em;
        }
        .form-input {
            width: 97%;
            font-size: 1.05em;
            padding: 8px 10px;
            border-radius: 5px;
            border: 1px solid #bbb;
            margin-bottom: 6px;
            background: #fff;
        }
        .form-btn {
            background: #1976d2;
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
            background: #1254a1;
        }
        @media (max-width: 700px) {
            .main-area { margin-left: 0; min-width: 0; padding: 0 2vw; }
        }
    </style>
</head>
<body>
    <div class="main-area">
        <!-- ① タイトル -->
        <div class="main-title-row">科目情報登録</div>
        <div class="form-box">
            <form action="<%=request.getContextPath()%>/subject/create" method="post">
                <!-- ② 科目コード -->
                <label class="form-label" for="cd">科目コード</label>
                <input type="text" name="cd" id="cd" class="form-input" placeholder="科目コードを入力してください" required />

                <!-- ④ 科目名 -->
                <label class="form-label" for="name">科目名</label>
                <input type="text" name="name" id="name" class="form-input" placeholder="科目名を入力してください" required />

                <!-- ⑥ 登録ボタン -->
                <button type="submit" class="form-btn">登録</button>
            </form>
        </div>
    </div>
</body>
</html>
