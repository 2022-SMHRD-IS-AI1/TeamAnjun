<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%
// ���� path ����(���ε� ���� ���� ���)
String path = request.getRealPath("uploadedFiles");

// ���� ���� ��ο� �ش� ������ ������ �ڵ����� ������ �����ϴ� ���
// �������� ���� ������(�ѱ��� ������ ���� �� ����)
File Folder = new File(path);

if (!Folder.exists()) {
	try {
		Folder.mkdir(); // path ��� ���� ����
		System.out.println("������ �����Ǿ����ϴ�.");
	} catch (Exception e) {
		e.getStackTrace();
	}
} else {
	System.out.println("�̹� ������ �����Ǿ� �ֽ��ϴ�.");
}

// ���ε� ���� �ִ� �뷮
int size = 1024 * 1024 * 20; // 20MB

String str, filename, original_filename, type;

try {
	MultipartRequest multiRequest = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	// multiRequest�� 3��° size�� 20MB ��������� ���� ���ε尡�� , 5��°�� �ߺ� ���� �̸��� ���� ��� ���ϸ� �ڿ� ���ڰ� �ٰԲ� ����.
	Enumeration files = multiRequest.getFileNames();

	str = (String) files.nextElement(); // �Ķ���� �̸�(String str�� ���� �̸� ����)

	filename = multiRequest.getFilesystemName(str); // ����� ���� �̸�(������ ������ ���ϸ�)

	original_filename = multiRequest.getOriginalFileName(str); // ���� ���ϸ�(���ε� ���ϸ�)

	type = multiRequest.getContentType(str); // ���� Ȯ����(��������/Ȯ���ڸ�)
	
	if (str != null) {
		File oldFile = new File(Folder + "\\" + original_filename);
		File newFile = new File(Folder + "\\" + str + "����.jpg");
		oldFile.renameTo(newFile);
	}
	System.out.println("str : " + str);
	System.out.println("filename : " + filename);
	System.out.println("original_filename : " + original_filename);
	System.out.println("type : " + type);
	System.out.println("path : " + path);
} catch (Exception e) {
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
</body>
</html>