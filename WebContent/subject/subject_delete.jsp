<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報削除 | 得点管理システム</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main-area {
            margin-left: 240px;
            padding-top: 40px;
            min-width: 450px;
        }
    </style>
</head>
<body>
    <div class="main-area container">
        <div class="card shadow">
            <div class="card-header bg-secondary text-white fw-bold fs-5">
                科目情報削除
            </div>
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/subject/delete" method="post">
                    <!-- 科目名表示 -->
                    <p class="fs-6 mb-4">
                        「<span class="fw-bold">${subject.name}</span>（<span>${subject.cd}</span>）」を削除してよろしいですか？
                    </p>
                    <!-- 隠しパラメータ（科目コード） -->
                    <input type="hidden" name="cd" value="${subject.cd}" />

                    <!-- 削除ボタン -->
                    <button type="submit" class="btn btn-danger me-3">削除</button>

                    <!-- 戻るリンク -->
                    <a href="<%=request.getContextPath()%>/subject/list" class="btn btn-outline-secondary">戻る</a>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS（必要であれば） -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
