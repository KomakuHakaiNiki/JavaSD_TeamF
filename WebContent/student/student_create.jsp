<%-- FILE: WebContent/student/student_create.jsp --%>
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
    <title>学生登録 | 得点管理システム</title>

    <%-- 共通メニュー(スタイル含む)を読み込み --%>
    <%@ include file="/menu.jsp" %>

    <style>
        /* このページ専用のスタイル */
        .main-content {
            padding: 30px;
            width: 100%;
            box-sizing: border-box;
        }
        .form-area {
            max-width: 700px;
            margin: 0 auto;
        }
        .main-title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-bottom: none;
            border-radius: 8px 8px 0 0;
            padding: 14px 25px;
            font-weight: bold;
            font-size: 1.18em;
        }
        .form-body {
            background: #fff;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6;
            padding: 30px 40px;
        }
        .form-label { font-weight: bold; margin-bottom: 0.5rem; }
        .checkbox-label { font-weight: normal; }
    </style>
</head>
<body>

    <!-- 共通メニューは上で読み込み済み -->

    <main class="main-content">
        <div class="form-area">
            <div class="main-title-row">
                <span>学生情報登録</span>
            </div>

            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <form method="post" action="create">
                    <div class="mb-3">
                        <label for="entYear" class="form-label">入学年度</label>
                        <input type="number" id="entYear" name="entYear" class="form-control" value="<c:out value='${entYear}'/>" required placeholder="例: 2024">
                    </div>
                    <div class="mb-3">
                        <label for="no" class="form-label">学生番号</label>
                        <input type="text" id="no" name="no" class="form-control" value="<c:out value='${no}'/>" required maxlength="7" placeholder="7桁の半角数字">
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">氏名</label>
                        <input type="text" id="name" name="name" class="form-control" value="<c:out value='${name}'/>" required>
                    </div>
                    <div class="mb-3">
                        <label for="classNum" class="form-label">クラス</label>
                        <select id="classNum" name="classNum" class="form-select">
                            <option value="">-----</option>
                            <c:forEach var="classNumItem" items="${classNumList}">
                               <option value="${classNumItem}" <c:if test="${classNumItem eq classNum}">selected</c:if>>${classNumItem}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" id="isAttend" name="isAttend" value="true" class="form-check-input" ${isAttend ? 'checked' : ''}>
                        <label for="isAttend" class="form-check-label checkbox-label">在学中</label>
                    </div>
                    <button type="submit" class="btn btn-primary">登録</button>
                    <a href="list" class="btn btn-link text-secondary">戻る</a>
                </form>
            </div>
        </div>
    </main>

    <%-- menu.jspで開始したレイアウト用divをここで閉じる --%>
    </div>

</body>
</html>
