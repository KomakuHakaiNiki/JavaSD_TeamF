<%--成績管理の『成績参照』 --%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績参照 | 得点管理システム</title>

    <!-- Bootstrap 5 CDN -->
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
        .form-section {
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 8px #ddd;
            margin-bottom: 20px;
        }
        .form-label-section {
            font-weight: bold;
            margin-bottom: 10px;
        }
        .alert-info-custom {
            color: #0275d8;
            font-size: 0.95rem;
            padding-left: 4px;
        }
    </style>
</head>
<body>

<div class="main-area">
    <!-- ① タイトル -->
    <div class="main-title-row">成績参照</div>

    <div class="form-section">

        <!-- ② 科目情報 -->
        <div class="form-label-section">科目情報</div>
        <form action="<%=request.getContextPath()%>/grade/searchBySubject" method="get" class="row g-2 align-items-end mb-4">
            <!-- ③ 入学年度 -->
            <div class="col-md-2">
                <label for="entYear" class="form-label">入学年度</label>
                <select name="entYear" id="entYear" class="form-select">
                    <option value="">------</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024">2024</option>
                </select>
            </div>

            <!-- ④ クラス -->
            <div class="col-md-2">
                <label for="classNum" class="form-label">クラス</label>
                <select name="classNum" id="classNum" class="form-select">
                    <option value="">------</option>
                    <option value="101">101</option>
                    <option value="131">131</option>
                    <option value="201">201</option>
                </select>
            </div>

            <!-- ⑤ 科目 -->
            <div class="col-md-3">
                <label for="subjectCd" class="form-label">科目</label>
                <select name="subjectCd" id="subjectCd" class="form-select">
                    <option value="">------</option>
                    <option value="A01">Python1</option>
                    <option value="B02">Java1</option>
                    <option value="C02">データベース</option>
                </select>
            </div>

            <!-- ⑨ 検索ボタン -->
            <div class="col-md-auto">
                <button type="submit" class="btn btn-secondary">検索</button>
            </div>
        </form>

        <!-- ⑩ 学生情報 -->
        <div class="form-label-section">学生情報</div>
        <form action="<%=request.getContextPath()%>/grade/searchByStudent" method="get" class="row g-2 align-items-end">
            <!-- ⑪ 学生番号 -->
            <div class="col-md-3">
                <label for="studentNo" class="form-label">学生番号</label>
                <input type="text" id="studentNo" name="studentNo" class="form-control" placeholder="学生番号を入力してください">
            </div>

            <!-- ⑬ 検索ボタン -->
            <div class="col-md-auto">
                <button type="submit" class="btn btn-secondary">検索</button>
            </div>
        </form>

        <!-- ⑭ 情報メッセージ -->
        <div class="mt-3 alert-info-custom">
            科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
        </div>

    </div>
</div>

</body>
</html>
