<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<%
    String path = request.getRealPath("uploadedFiles");
    int size = 1024 * 1024 * 20; //20MB
    String str, filename, original_filename;
    try{
    	MultipartRequest multiRequest = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
    	// multiRequest�� 3��° size�� 20MB ��������� ���� ���ε尡�� , 5��°�� �ߺ� ���� �̸��� ���� ��� ���ϸ� �ڿ� ���ڰ� �ٰԲ� ����.
    	Enumeration files = multiRequest.getFileNames();
    	str = (String)files.nextElement();
    	filename = multiRequest.getFilesystemName(str);
    	original_filename = multiRequest.getOriginalFileName(str);
    	
    	System.out.println("str : "+str);
    	System.out.println("filename : "+filename);
    	System.out.println("original_filename : "+original_filename);
    } catch (Exception e){
    	e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	SUCCESS!!! <a href = "Upload.jsp"  >���ư���</a>
</body>
</html>