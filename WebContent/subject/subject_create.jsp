<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録 | 得点管理システム</title>
    <style>
        .main-box {
            background: #f7fafd;
            margin: 40px auto;
            border-radius: 12px;
            box-shadow: 0 4px 18px #c8c8d240;
            max-width: 620px;
            min-width: 320px;
            padding: 28px 30px 32px 30px;
        }
        .main-title {
            font-size: 1.3em;
            font-weight: bold;
            background: #ededed;
            padding: 14px 24px;
            border-radius: 8px 8px 0 0;
            margin-bottom: 28px;
        }
        .form-label {
            display: block;
            margin: 16px 0 4px 0;
            font-size: 1.05em;
        }
        .form-input {
            width: 97%;
            font-size: 1.05em;
            padding: 8px 10px;
            border-radius: 5px;
            border: 1px solid #bbb;
            margin-bottom: 8px;
            background: #fff;
        }
        .form-btn {
            background: #4d93ff;
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
            background: #1a5cba;
        }
        .back-link {
            display: inline-block;
            margin-top: 24px;
            color: #1976d2;
            text-decoration: underline;
            font-size: 1em;
        }
    </style>
</head>
<body>
<div style="margin-left:230px;">
    <form action="<%=request.getContextPath()%>/subject/create" method="post" class="main-box">
        <!-- ① タイトル -->
        <div class="main-title">科目情報登録</div>

        <!-- ② ラベル：科目コード -->
        <label class="form-label" for="subjectCode">科目コード</label>

        <!-- ③ 入力：科目コード -->
        <input type="text" name="subjectCode" id="subjectCode" class="form-input"
               placeholder="科目コードを入力してください"
               value="${param.subjectCode != null ? param.subjectCode : ''}"/>

        <!-- ④ ラベル：科目名 -->
        <label class="form-label" for="subjectName">科目名</label>

        <!-- ⑤ 入力：科目名 -->
        <input type="text" name="subjectName" id="subjectName" class="form-input"
               placeholder="科目名を入力してください"
               value="${param.subjectName != null ? param.subjectName : ''}"/>

        <!-- ⑥ 登録ボタン -->
        <button type="submit" class="form-btn">登録</button>

        <!-- ⑦ 戻るリンク -->
        <div>
            <a href="<%=request.getContextPath()%>/subject/list" class="back-link">戻る</a>
        </div>
    </form>
</div>
</body>
</html>
