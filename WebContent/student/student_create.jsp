<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報登録 | 得点管理システム</title>
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
        .form-input, .form-select {
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
        .flex-row {
            display: flex;
            gap: 12px;
        }
        @media (max-width: 640px) {
            .main-box { padding: 10px 4vw; }
            .main-title { font-size: 1.07em; }
        }
</style>
</head>
<body>
<div style="margin-left:230px;">
<form action="<%=request.getContextPath()%>/student/create" method="post" class="main-box">
<div class="main-title">学生情報登録</div>
<!-- ① 入学年度 -->
<label class="form-label" for="enrollmentYear">入学年度</label>
<select name="enrollmentYear" id="enrollmentYear" class="form-select">
<c:forEach var="year" items="${enrollmentYearList}">
<option value="${year}" <c:if test="${year eq param.enrollmentYear}">selected</c:if>>${year}</option>
</c:forEach>
</select>

        <!-- ② 学生番号 -->
<label class="form-label" for="studentId">学生番号</label>
<input type="text" name="studentId" id="studentId" class="form-input"
               placeholder="学生番号を入力してください"
               value="${param.studentId != null ? param.studentId : ''}"/>

        <!-- ③ 氏名 -->
<label class="form-label" for="studentName">氏名</label>
<input type="text" name="studentName" id="studentName" class="form-input"
               placeholder="氏名を入力してください"
               value="${param.studentName != null ? param.studentName : ''}"/>

        <!-- ④ クラス -->
<label class="form-label" for="classNum">クラス</label>
<select name="classNum" id="classNum" class="form-select">

</select>

        <!-- ⑤ 登録ボタン -->
<button type="submit" class="form-btn">登録して終了</button>
<!-- ⑥ 戻る -->
<a href="<%=request.getContextPath()%>/student/list" class="back-link">戻る</a>
</form>
</div>
</body>
</html>