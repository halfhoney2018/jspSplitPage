<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
	<title>JavaWEB分页程序</title>
	<meta charset="UTF-8"/>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
</head>
<%!
	public static final String DBDRIVER = "com.mysql.cj.jdbc.Driver" ;
	public static final String DBURL = "jdbc:mysql://localhost:3306/test" ;
	public static final String USER = "root" ;
	public static final String PASSWORD = "090615Wzn" ;
%>
<%	// 与分页有关的变量定义
	long currentPage = 1 ; // 当前所在页编号
	int lineSize = 3 ; // 每页显示3行记录
	long allRecorders = 0 ; // 总的记录数
	long pageSize = 0 ; // 计算总页数
	String columnData = "用户编号:mid|用户姓名:name" ;
	String url = "member_list_d.jsp" ;
	String column = null ; // 表示要进行模糊查询的列名称
	String keyword = null ; // 模糊查询关键字
%>
<%
	try {
		currentPage = Long.parseLong(request.getParameter("cp")) ;
	} catch (Exception e) {}
	try {
		lineSize = Integer.parseInt(request.getParameter("ls")) ;
	} catch (Exception e) {}
	column = request.getParameter("col") ; // 接收模糊查询列
	keyword = request.getParameter("kw") ; // 接收模糊查询关键字
%>
<%
	Class.forName(DBDRIVER) ;
	Connection conn = DriverManager.getConnection(DBURL,USER,PASSWORD) ;
%>
<%
	String sql = null ;
	if (column == null || "".equals(column) || keyword == null || "".equals(keyword)) {	// 只要有一个是null
		sql = "SELECT COUNT(*) FROM member" ; 
	} else {
		sql = "SELECT COUNT(*) FROM member WHERE " + column + " LIKE ?" ; 	// 统计记录数
	}
	PreparedStatement pstmt = conn.prepareStatement(sql) ;
	if (!(column == null || "".equals(column) || keyword == null || "".equals(keyword))) {
		pstmt.setString(1, "%" + keyword + "%") ;
	}	
	ResultSet rs = pstmt.executeQuery() ;
	if (rs.next()) {
		allRecorders = rs.getLong(1) ; // 获取总记录数
	}
%>
<%
	if (column == null || "".equals(column) || keyword == null || "".equals(keyword)) {	// 只要有一个是null
		sql = "SELECT mid,name,note FROM member LIMIT ?,?" ; 
	} else {
		sql = "SELECT mid,name,note FROM member WHERE " + column + " LIKE ? LIMIT ?,?" ;
	}
	pstmt = conn.prepareStatement(sql) ;
	if (column == null || "".equals(column) || keyword == null || "".equals(keyword)) {	// 只要有一个是null
		pstmt.setLong(1, (currentPage - 1) * lineSize) ;
		pstmt.setInt(2, lineSize) ;
	} else {
		pstmt.setString(1, "%" + keyword + "%") ;
		pstmt.setLong(2, (currentPage - 1) * lineSize) ;
		pstmt.setInt(3, lineSize) ;	
	}
	rs = pstmt.executeQuery() ;
%>
<%	// 对接下来的数据要进行一些处理
	pageSize = (allRecorders + lineSize - 1) / lineSize ;
	if (pageSize == 0) {	// 没有任何的数据记录
		pageSize = 1 ; // 当前在第1页
	}
	if (column == null) {
		column = "" ;
	}
	if (keyword == null) {
		keyword = "" ;
	}
%>
<body class="container">
	<div id="searchDiv">
		<form ation="<%=url%>" class="form-horizontal" id="searchform" method="get">
			<div class="form-group" id="searchDiv">
				<div class="col-md-2">
					<select id="col" name="col" class="form-control">
<%
						String columnResult [] = columnData.split("\\|") ;
						for (int x = 0 ; x < columnResult.length ; x ++) {
							String temp [] = columnResult[x].split(":") ;
%>
							<option value="<%=temp[1]%>" <%=column.equals(temp[1])?"selected":""%>><%=temp[0]%></option>
<%
						}
%>
					</select>
				</div>
				<div class="col-md-9">
					<input type="text" id="kw" name="kw" class="form-control" placeholder="请输入模糊查询关键字" value="<%=keyword%>">
				</div>
				<div class="col-md-1">
					<input type="submit" class="btn btn-primary" value="搜索">
				</div>
			</div>
		</form>
	</div>
	<div class="row">
		<table class="table table-condensed">
			<thead>
				<tr>
					<td class="text-center"><strong>编号</strong></td>
					<td class="text-center"><strong>姓名</strong></td>
					<td class="text-center"><strong>介绍</strong></td>
				</tr>
			</thead>
			<tbody>
			<%
				while (rs.next()) {
					String mid = rs.getString(1) ;
					String name = rs.getString(2) ;
					String note = rs.getString(3) ;
			%>
				<tr>
					<td class="text-center"><%=mid%></td>
					<td class="text-center"><%=name%></td>
					<td class="text-center"><%=note%></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</div>
	<div id="pagebarDiv" style="float:right">
		<ul class="pagination"> 
<%
	for (int x = 1 ; x <= pageSize ; x ++) {
		if (currentPage == x) {
%>
			<li class="active"><span><%=x%></span></li>
<%
		} else {
%>
			<li><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyword%>"><%=x%></a></li>
<%
		}
	}
%>
		</ul>
	</div>
<%
	conn.close() ;
%>
</body>
</html>