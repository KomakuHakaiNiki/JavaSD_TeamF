<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績管理 | 得点管理システム</title>

<!-- ✅ Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .main-area {
        margin: 35px 0 0 240px;
        min-width: 600px;
    }
    .main-title-row {
        background: #ededed;
        border-radius: 8px 8px 0 0;
        padding: 13px 30px;
        font-weight: bold;
        font-size: 1.17em;
        margin-bottom: 0;
    }
    .form-box {
        background: #fff;
        border-radius: 0 0 12px 12px;
        box-shadow: 0 2px 8px #ddd;
        padding: 26px 40px 28px 40px;
        margin-bottom: 24px;
    }
</style>
</head>
<body>
<div class="main-area">
    <!-- タイトル -->
    <div class="main-title-row">成績管理</div>

    <!-- 検索フォーム -->
    <div class="form-box">
        <form action="<%=request.getContextPath()%>/grade/search" method="get">
            <div class="row g-3 align-items-end">
                <!-- 入学年度 -->
                <div class="col-md-2">
                    <label for="entYear" class="form-label">入学年度</label>
                    <select class="form-select" id="entYear" name="entYear">
                        <option value="">------</option>
                        <option value="2022">2022</option>
                        <option value="2023">2023</option>
                        <option value="2024">2024</option>
                    </select>
                </div>

                <!-- クラス -->
                <div class="col-md-2">
                    <label for="classNum" class="form-label">クラス</label>
                    <select class="form-select" id="classNum" name="classNum">
                        <option value="">------</option>
                        <option value="101">101</option>
                        <option value="131">131</option>
                        <option value="201">201</option>
                    </select>
                </div>

                <!-- 科目 -->
                <div class="col-md-3">
                    <label for="subjectCd" class="form-label">科目</label>
                    <select class="form-select" id="subjectCd" name="subjectCd">
                        <option value="">------</option>
                        <option value="A01">Python1</option>
                        <option value="B02">Java1</option>
                        <option value="C02">データベース</option>
                    </select>
                </div>

                <!-- 回数 -->
                <div class="col-md-2">
                    <label for="times" class="form-label">回数</label>
                    <select class="form-select" id="times" name="times">
                        <option value="">------</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                </div>

                <!-- 検索ボタン -->
                <div class="col-md-auto">
                    <button type="submit" class="btn btn-dark">検索</button>
                </div>
            </div>
        </form>

        <!-- ✅ 検索されたときのみ表示する登録ボタン -->
        <c:if test="${not empty param.entYear or not empty param.classNum or not empty param.subjectCd or not empty param.times}">
            <div class="mt-4 text-end">
                <a href="${pageContext.request.contextPath}/grade/register" class="btn btn-secondary">登録して終了</a>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
