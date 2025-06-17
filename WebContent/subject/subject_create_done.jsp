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
    <title>科目情報登録完了</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%-- menu.jsp は<body>タグ内に配置するのが一般的です --%>
<%@include file="../common/menu.jsp" %>

<%-- containerクラスで全体を囲み、左右に適切な余白を設けます --%>
<div class="container mt-4">

    <%-- ① 見出し: 元の背景色を維持し、Bootstrapのパディングクラス(p-3)で余白を追加 --%>
    <h2 style="background-color: #ededed;" class="p-3 mb-3">科目情報登録</h2>

    <%-- ② 完了メッセージ: こちらも元の背景色を維持し、パディング(py-2)と中央揃え(text-center)クラスを追加 --%>
    <div style="background-color: #a5d6a7;" class="text-center py-2 mb-4">
        登録が完了しました
    </div>

    <%-- ③, ④ リンク: BootstrapのFlexboxユーティリティで横並びに配置 --%>
    <%-- 
        d-flex: 横並びにする
        gap-4: リンク間の隙間を空ける
        ps-3: 左側にパディングを設け、見出しと左端を合わせる
    --%>
    <div class="d-flex gap-4 ps-3">
        <a href="subject_create.jsp">戻る</a>
        <a href="subject_list.jsp">科目一覧</a>
    </div>

</div>


<%-- Bootstrap JS (必要に応じて) --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>