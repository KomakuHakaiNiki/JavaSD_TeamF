<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績管理 | 得点管理システム</title>
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
            min-height: 70px;
            margin-bottom: 24px;
        }
        .search-row {
            display: flex;
            align-items: flex-end;
            gap: 18px;
        }
        .form-label {
            font-size: 1em;
            margin-bottom: 6px;
            font-weight: bold;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            min-width: 120px;
        }
        .form-select {
            font-size: 1em;
            padding: 7px 10px;
            border-radius: 6px;
            border: 1px solid #bbb;
            background: #fafafa;
        }
        .search-btn {
            background: #4d93ff;
            color: #fff;
            font-size: 1em;
            padding: 10px 26px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-left: 4px;
            transition: background 0.15s;
        }
        .search-btn:hover {
            background: #1976d2;
        }
</style>
</head>
<body>
<div class="main-area">
<!-- ① タイトル -->
<div class="main-title-row">成績管理</div>
<div class="form-box">
<form action="<%=request.getContextPath()%>/grade/search" method="get">
<div class="search-row">
<!-- ② 入学年度 -->
<div class="form-group">
<label class="form-label" for="entYear">入学年度</label>
<select name="entYear" id="entYear" class="form-select">
<option value="">------</option>
<option value="2022">2022</option>
<option value="2023">2023</option>
<option value="2024">2024</option>
<!-- JSTLで年度リスト出力に変更もOK -->
</select>
</div>
<!-- ④ クラス -->
<div class="form-group">
<label class="form-label" for="classNum">クラス</label>
<select name="classNum" id="classNum" class="form-select">
<option value="">------</option>
<option value="101">101</option>
<option value="201">201</option>
<option value="301">301</option>
<!-- JSTLでクラスリスト出力に変更もO -->
</select>
</div>
<!-- ⑥ 科目 -->
<div class="form-group">
<label class="form-label" for="subjectCd">科目</label>
<select name="subjectCd" id="subjectCd" class="form-select">
<option value="">------</option>
<option value="A01">国語</option>
<option value="B02">数学</option>
<option value="C02">英語</option>
<!-- JSTLで科目リスト出力に変更もOK -->
</select>
</div>
<!-- ⑧ 回数 -->
<div class="form-group">
<label class="form-label" for="times">回数</label>
<select name="times" id="times" class="form-select">
<option value="">------</option>
<option value="1">1回目</option>
<option value="2">2回目</option>
<option value="3">3回目</option>
<!-- JSTLで回数リスト出力に変更もOK -->
</select>
</div>
<!-- ⑩ 検索ボタン -->
<div>
<button type="submit" class="search-btn">検索</button>
</div>
</div>
</form>
</div>
</div>
</body>
</html>