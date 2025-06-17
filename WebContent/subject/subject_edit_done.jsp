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
    <title>科目情報変更完了</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%@include file="../common/menu.jsp" %>

<%-- containerクラスで全体を囲み、左右に適切な余白を設けます --%>
<div class="container mt-4">

    <%-- これまでのページと同じように、左マージンでコンテンツ全体を右に寄せます --%>
    <div style="margin-left: 7rem;">

        <%-- 見出し: 先頭に全角スペースを追加し、Bootstrapクラスで余白を整えます --%>
        <h2 style="background-color: #ededed;" class="p-3 mb-3">　科目情報変更</h2>

        <%-- 完了メッセージ: <p>を<div>に変更し、Bootstrapクラスでスタイルを適用します --%>
        <div style="background-color: #a5d6a7;" class="text-center py-2 mb-4">
            変更が完了しました
        </div>
        
        <%-- 空白行: <p>タグで空白行を作成します --%>
        <p>　</p>
        <p>　</p>

        <%-- リンク: <p>タグで囲み、体裁を整えます --%>
        <p><a href="subject_list.jsp">科目一覧</a></p>

    </div> 
</div>


<%-- Bootstrap JS (必要に応じて) --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>