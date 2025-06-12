<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="../common/menu.jsp" %>
<%-- ★includeすると下の変更ボタン、戻るボタンが見えなくなってしまうので、menu.jspの修正待ちです。★ --%>

<style>
.form-btn {
    background: #4d93ff;
    color: #fff;
    font-size: 1em;
    padding: 10px 20px;
    border: none;
    border-radius: 8px;
    margin-top: 18px;
    cursor: pointer;
    transition: background 0.2s;
}

.form-input {
    width: 100%;
    box-sizing: border-box;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;

}
</style>
<h2 style="background-color: #ededed;">　科目情報変更</h2>
<p>科目コード</p>
<p>　F02</p> <%-- (仮)★ここは修正してください。★ --%>

<form action="subject_create.jsp" method="post"> <%-- フォームの開始: 送信先URLとメソッドを指定 --%>
    <p>科目名</p>
    <input type="text" name="subjectName" id="subjectid" class="form-input"
           value="${param.subjectName != null ? param.subjectName : ''}"/> <%-- subjectNameパラメータを参照するように --%>
    <button type="submit" class="form-btn">変更</button>
</form> <%-- フォームの終了 --%>

<p> <a href="subject_list.jsp">戻る</a></p> <%-- 科目一覧画面へのURL --%>