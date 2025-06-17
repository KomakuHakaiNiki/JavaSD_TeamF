<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録 | 得点管理システム</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: "Meiryo", sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            border-right: 1px solid #dee2e6;
            padding-top: 2rem;
        }
        .sidebar a {
            display: block;
            margin-bottom: 1rem;
            color: #0d6efd;
            text-decoration: none;
        }
        .sidebar a:hover {
            text-decoration: underline;
        }
        .sidebar-title {
            font-weight: bold;
            color: #376345;
            margin-top: 1rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- ヘッダー -->
    <header class="bg-light px-4 py-3 d-flex justify-content-between align-items-center border-bottom">
        <h1 class="h4 mb-0">得点管理システム</h1>
        <div>
            大原 太郎様　
            <a href="<%=request.getContextPath()%>/logout" class="text-primary text-decoration-underline">ログアウト</a>
        </div>
    </header>

    <div class="container-fluid">
        <div class="row">
            <!-- サイドバー -->
            <nav class="col-md-2 sidebar bg-white">
                <a href="<%=request.getContextPath()%>/student/list">学生管理</a>
                <div class="sidebar-title">成績管理</div>
                <a href="<%=request.getContextPath()%>/grade/create">成績登録</a>
                <a href="<%=request.getContextPath()%>/grade/view">成績参照</a>
                <a href="<%=request.getContextPath()%>/subject/list">科目管理</a>
            </nav>

            <!-- メインコンテンツ -->
            <main class="col-md-10 py-5 d-flex justify-content-center">
                <form action="<%=request.getContextPath()%>/subject/create" method="post" class="w-100" style="max-width: 600px;">
                    <div class="card shadow-sm">
                        <div class="card-header bg-secondary text-white fw-bold">科目情報登録</div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="subjectCode" class="form-label">科目コード</label>
                                <input type="text" class="form-control" id="subjectCode" name="subjectCode"
                                    placeholder="科目コードを入力してください"
                                    value="${param.subjectCode != null ? param.subjectCode : ''}">
                            </div>
                            <div class="mb-3">
                                <label for="subjectName" class="form-label">科目名</label>
                                <input type="text" class="form-control" id="subjectName" name="subjectName"
                                    placeholder="科目名を入力してください"
                                    value="${param.subjectName != null ? param.subjectName : ''}">
                            </div>
                            <div class="d-flex justify-content-between">
                                <button type="submit" class="btn btn-primary">登録</button>
                                <a href="<%=request.getContextPath()%>/subject/list" class="btn btn-link">戻る</a>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS (必要に応じて) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
