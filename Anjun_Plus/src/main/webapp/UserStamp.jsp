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

	// Calendar ��ü ���� (������ ���� ����)
	Calendar cal = Calendar.getInstance();
	// ��� ����, ��, �� ����
	// ���� ������ 0~11 �̱� ������ ������ -1
	// ���� �޷��� 1�Ϻ��� �����ϱ� ������ 1�Ϸ� ����
	// ���� ���ϱ�(���� ù��)
	cal.set(year, month-1,1);
	
	// ���� ������ ��¥�� ���� 
	int lastOfDate = cal.getActualMaximum(Calendar.DATE);
	// �ָ�  ���� 1�Ͽ��� ,2������
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
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
	
<%	int cnt=0;
	for(int i=1; i<week; i++){
%>		<td></td>
<%		cnt++;
	}
%>
<%	
	int day = 1;
	int nextweek = 7;
	if (cnt>1){
		nextweek-=cnt;
	}
	cnt=0;
	for(int i=day; i<=nextweek; i++){
		%><td><%=i%></td><%
		day++;
		cnt++;
	}
	
	%></tr><tr><%
	nextweek-=cnt;
	for(int i=day; i<=lastOfDate; i++){
		if(nextweek%7==0){
			%></tr><tr><%
		}%>
		<td><%=i%></td><%
		nextweek++;
	}
		%>
	</tr>
    </tbody>
</table>

</body>
</html>