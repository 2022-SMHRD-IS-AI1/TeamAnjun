<%@page import="java.util.ArrayList"%>
<%@page import="Model.UserDTO"%>
<%@page import="Model.AttendenceDAO"%>
<%@page import="Model.AttendenceDTO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">





body {
	padding:1.5em;
	background: #f5f5f5
}
h1 {
	text-align: center;
}
table {
	margin: auto;
	border: 1px #a39485 solid;
	font-size: .9em;
	box-shadow: 0 2px 5px rgba(0,0,0,.25);
	border-collapse: collapse;
	border-radius: 5px;
	overflow: hidden;
}
th {
	text-align: center;
}
td {
	text-align: right;
	vertical-align: text-top; 
	width: 100px;
	height: 100px;
}
thead {
	font-weight: bold;
	color: #fff;
	background: #73685d;
}
  
td, th {
	padding: 1em .5em;
}
  
td {
	border-bottom: 1px solid rgba(0,0,0,.1);
	background: #fff;
}
a {
	color: #73685d;
}
#sat {
	color: blue;
}
#sun {
	color: red;
}
.good {
	float: left;
}
  
/*  @media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  th {
    text-align: right;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
  }
  
  thead {
    float: left;
    white-space: nowrap;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    white-space: nowrap;
  }
  
  tr {
    display: inline-block;
    vertical-align: top;
  }
  
  th {
    border-bottom: 1px solid #a39485;
  }
  
  td {
    border-bottom: 1px solid #e5e5e5;
  }
  
  
  } */
  
</style>
</head>
<body>
<%
	// ���� ��¥ ���ϱ� (�ý��� �ð�, �ý��� Ÿ����)
	LocalDate now = LocalDate.now();
	int year = now.getYear();
	int month = now.getMonthValue();
	int day = 1;
	
	
	// Calendar ��ü ���� (������ ���� ����)
	Calendar cal = Calendar.getInstance();
	// ��� ����, ��, �� ����
	// ���� ������ 0~11 �̱� ������ ������ -1
	// ���� �޷��� 1�Ϻ��� �����ϱ� ������ 1�Ϸ� ����
	// ���� ���ϱ�(���� ù��)
		cal.set(year, month-1, day);
	
	// ���� ������ ��¥�� ���� 
	int lastOfDate = cal.getActualMaximum(Calendar.DATE);
	// �ָ�  ���� 1�Ͽ��� ,2������
	int week = cal.get(Calendar.DAY_OF_WEEK);
	// ���ǹ޾ƿ´�
	request.getSession();
	// �ӽ÷� �����Է��ص�(���߿�����)
	UserDTO smhrd = new UserDTO("smhrd", "1234", "smhrd", "smhrd", "smhrd@smhrd,com", "123456-7890123", "C"); 
	session.setAttribute("info", smhrd);
	
	// ��¥���ǰ�(����������)
	UserDTO info = (UserDTO)session.getAttribute("info");
	
	// ����������¥ ����Ʈ�� ����
	ArrayList<Integer> stampList = new ArrayList<>(); 
	
	// �̹��� 1�Ϻ��� �����ϱ��� üũ
	for(int i=1; i<=lastOfDate; i++){
	AttendenceDTO dto = new AttendenceDTO();
	AttendenceDAO dao = new AttendenceDAO();
		
	// ���ǿ��� id �ޱ�
	String user_id = info.getId();
	// �̹��� ��¥ ��¥ ���ڿ��� ��ȯ�� ������ �ֱ�
	String stday = "";
	if(i<10){
		stday = "0"+i;
	}else{
		stday = ""+i;
	}
	
	String at_time = (year+"-"+month+"-"+stday);
	
	// dto��ü�� id, ����ð� ���� ����
	dto.setUser_id(user_id);
	dto.setAt_time(at_time);
	
/* 	System.out.println(dto.getUser_id());
	System.out.println(dto.getAt_time()); */
	
	// ��¥ ���ؼ� �⼮���� 1, �Ἦ���� -1�� ���
	int stampAllCheck = dao.stampAllCheck(dto);
	stampList.add(stampAllCheck);
	}
	
/* 	System.out.print(stampList); */
	
%>

	<h1><%=month%>�� �⼮üũ</h1>
	<table>
    <thead>
    <tr>
        <th id="sun">��</th>
        <th>��</th>
        <th>ȭ</th>
        <th>��</th>
        <th>��</th>
        <th>��</th>
        <th id="sat">��</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    
<%
	// ù°�� �����ϸ�ŭ ��ĭ ����
	int cnt=0;
	for(int i=1; i<week; i++){
%>		<td></td>
<%		cnt++;
	}
%>

<%
	// ù°�� �޷� ���� �� ���� Ȯ��
	day = 1;
	int nextweek = 7;
	if (cnt>1){
		nextweek-=cnt;
	}
	cnt=0;
	for(int i=day; i<=nextweek; i++){%>
		<td>
		<%if(stampList.get(i-1)==1){%>
			<div  class="good"><img src="img/good80.jpg"></div>
		<%} %><%=i%></td><%
		day++;
		cnt++;
	}
		%></tr><tr><%
	nextweek-=cnt;
	
	// ��°�ֺ��� �޷� ���� �� ���� Ȯ��
	for(int i=day; i<=lastOfDate; i++){
		if(nextweek%7==0){
			%></tr><tr><%
		}%>
				<td>
		<%if(stampList.get(i-1)==1){%>
			<div class="good"><img src="img/good80.jpg"></div>
		<%} %><%=i%></td><%
		nextweek++; 
	}
		%>
	</tr>
    </tbody>
</table>
</body>
</html>