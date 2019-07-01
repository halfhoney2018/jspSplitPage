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
%>
<%
	try {
		currentPage = Long.parseLong(request.getParameter("cp")) ;
	} catch (Exception e) {}
	try {
		lineSize = Integer.parseInt(request.getParameter("ls")) ;
	} catch (Exception e) {}
%>
<%
	String sql = "SELECT mid,name,note FROM member LIMIT ?,?" ; 
	Class.forName(DBDRIVER) ;
	Connection conn = DriverManager.getConnection(DBURL,USER,PASSWORD) ;
	PreparedStatement pstmt = conn.prepareStatement(sql) ;
	pstmt.setLong(1, (currentPage - 1) * lineSize) ;
	pstmt.setInt(2, lineSize) ;
	ResultSet rs = pstmt.executeQuery() ;
%>
<body class="container">
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
	<div style="float:right">
		<ul class="pagination"> 
			<li class="active"><a>1</a></li>
			<li class="disabled"><a>2</a></li>
			<li><a>3</a></li>
			<li><a>4</a></li>
		</ul>
	</div>
<%
	conn.close() ;
%>
</body>
</html>