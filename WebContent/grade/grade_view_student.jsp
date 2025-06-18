<%--成績管理の『成績参照』 --%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績一覧</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .content-box {
            margin: 40px auto;
            max-width: 880px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 12px #ddd;
        }
        .content-header {
            background-color: #ededed;
            padding: 16px 24px;
            font-weight: bold;
            font-size: 1.2rem;
            border-radius: 10px 10px 0 0;
        }
        .content-body {
            padding: 24px 30px;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-search {
            background-color: #6c757d;
            color: #fff;
            padding: 6px 16px;
            font-size: 1rem;
            text-align: center;
            vertical-align: middle;
            white-space: nowrap;
        }
    </style>
</head>
<body>

<div class="content-box">
    <div class="content-header">
        成績一覧
    </div>
    <div class="content-body">
        <!-- 科目情報 -->
        <div class="mb-4">
            <label class="form-label">科目情報</label>
            <div class="row g-2 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">入学年度</label>
                    <select class="form-select">
                        <option>--------</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">クラス</label>
                    <select class="form-select">
                        <option>--------</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">科目</label>
                    <select class="form-select">
                        <option>--------</option>
                    </select>
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-search">検索</button>
                </div>
            </div>
        </div>

        <!-- 学生情報 -->
        <div>
            <label class="form-label">学生情報</label>
            <div class="row g-2 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">学生番号</label>
                    <input type="text" class="form-control" placeholder="学生番号を入力">
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-search">検索</button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
