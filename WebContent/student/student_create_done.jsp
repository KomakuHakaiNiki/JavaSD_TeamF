<%@ page contentType="text/html; charset=UTF-8" %>
<%-- 
  menu.jsp や共通のヘッダーファイルにBootstrapの読み込みがない場合は、
  以下の<head>セクションが必要です。
--%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生情報登録完了</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%@include file="../common/menu.jsp" %>

<%-- containerクラスで全体を囲み、左右に適切な余白を設けます --%>
<div class="container mt-4">

    <div style="margin-left: 7rem;">

        <%-- 見出し: 先頭に全角スペースを追加し、Bootstrapクラスで余白を整えます --%>
        <h2 style="background-color: #ededed;" class="p-3 mb-3">　学生情報登録</h2>

        <%-- 完了メッセージ: <p>を<div>に変更し、Bootstrapクラスでスタイルを適用します --%>
        <div style="background-color: #a5d6a7;" class="text-center py-2 mb-4">
            登録が完了しました
        </div>
        
        <%-- 空白行: <p>タグで空白行を作成します --%>
        <p>　</p>
        <p>　</p>

        <%-- リンク: d-flexとgapを使って横並びに配置します --%>
        <div class="d-flex" style="gap: 9rem;">
            <a href="student_create.jsp">戻る</a>
            <a href="student_list.jsp">学生一覧</a>
        </div>

    </div> 
</div>


<%-- Bootstrap JS (必要に応じて) --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>