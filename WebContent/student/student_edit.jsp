<%-- FILE: WebContent/student/student_edit.jsp --%>
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
    <title>学生情報変更 | 得点管理システム</title>

    <%@ include file="/menu.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main-content { padding: 30px; width: 100%; box-sizing: border-box; }
        .form-area { max-width: 700px; margin: 0 auto; }
        .main-title-row {
            background-color: #f8f9fa; border: 1px solid #dee2e6; border-bottom: none;
            border-radius: 8px 8px 0 0; padding: 14px 25px;
            font-weight: bold; font-size: 1.18em;
        }
        .form-body {
            background: #fff; border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6; padding: 30px 40px;
        }
    </style>
</head>
<body>
    <main class="main-content">
        <div class="form-area">
            <div class="main-title-row">
                <span>学生情報変更</span>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                    </div>
                </c:if>
                <form method="post" action="update">
                    <input type="hidden" name="no" value="<c:out value='${student.no}'/>">
                    <input type="hidden" name="entYear" value="<c:out value='${student.entyear}'/>">

                    <div class="mb-3">
                        <label class="form-label">入学年度</label>
                        <input type="text" class="form-control" value="<c:out value='${student.entyear}'/>" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">学籍番号</label>
                        <input type="text" class="form-control" value="<c:out value='${student.no}'/>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">氏名</label>
                        <input type="text" id="name" name="name" class="form-control" value="<c:out value='${student.name}'/>" required>
                    </div>
                    <div class="mb-3">
                        <label for="classNum" class="form-label">クラス</label>
                        <select id="classNum" name="classNum" class="form-select">
                            <c:forEach var="classNumItem" items="${classNumList}">
                               <option value="${classNumItem}" <c:if test="${classNumItem eq student.classNum}">selected</c:if>>${classNumItem}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" id="isAttend" name="isAttend" value="true" class="form-check-input" ${student.attend ? 'checked' : ''}>
                        <label for="isAttend" class="form-check-label">在学中</label>
                    </div>
                    <button type="submit" class="btn btn-primary">変更</button>
                    <a href="list" class="btn btn-link text-secondary">戻る</a>
                </form>
            </div>
        </div>
    </main>
    </div>
</body>
</html>
