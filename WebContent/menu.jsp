<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="menu-sidebar">
  <ul class="menu-nav">
    <li class="top-menu-item">
      <a href="${pageContext.request.contextPath}/top.jsp">メニュー</a>
    </li>
    <li><a href="${pageContext.request.contextPath}/student/list">学生管理</a></li>
    <li>
      <div class="menu-nav-title">成績管理</div>
      <ul class="sub-menu">
        <li><a href="${pageContext.request.contextPath}/grade/create">成績登録</a></li>
        <li><a href="${pageContext.request.contextPath}/grade/delete">成績削除</a></li>
        <li><a href="${pageContext.request.contextPath}/grade/search">成績参照</a></li>
      </ul>
    </li>
    <li><a href="${pageContext.request.contextPath}/subject/list">科目管理</a></li>
  </ul>
</nav>

<style>
  .menu-sidebar {
    width: 220px;
    padding: 20px;
    border-right: 1.5px solid #d3d5de;
    background-color: #fff;
    box-sizing: border-box;
  }
  .menu-nav {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  .menu-nav li {
    margin-bottom: 5px;
  }
  .menu-nav a {
    display: block;
    padding: 8px 10px;
    color: #0d6efd;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color .2s;
  }
  .menu-nav a:hover {
    background-color: #e9ecef;
  }
  .menu-nav .top-menu-item a {
    font-weight: bold;
    font-size: 1.1em;
    color: #333;
    margin-bottom: 15px;
  }
  .menu-nav-title {
    font-weight: bold;
    color: #6c757d;
    padding: 10px 0 5px;
  }
  .sub-menu {
    list-style: none;
    padding-left: 15px;
    margin: 0;
  }
</style>
