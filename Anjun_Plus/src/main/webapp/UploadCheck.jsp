<%@page import="Model.PostDAO"%>
<%@page import="Model.UserDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Model.FileDAO"%>
<%@page import="Model.FileDTO"%>
<%@page import="Model.PostDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer = response.getWriter();
	UserDTO info = (UserDTO) session.getAttribute("info");

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

	String str, post_file, media_real_file, media_ext;

	try {
		//�̹��� ���ε�
		MultipartRequest multiRequest = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		// multiRequest�� 3��° size�� 20MB ��������� ���� ���ε尡�� , 5��°�� �ߺ� ���� �̸��� ���� ��� ���ϸ� �ڿ� ���ڰ� �ٰԲ� ����.
		Enumeration files = multiRequest.getFileNames();

		str = (String) files.nextElement(); // �Ķ���� �̸�(String str�� ���� �̸� ����)

		post_file = multiRequest.getFilesystemName(str); // ����� ���� �̸�(������ ������ ���ϸ�)

		media_real_file = multiRequest.getOriginalFileName(str); // ���� ���ϸ�(���ε� ���ϸ�)

		media_ext = multiRequest.getContentType(str); // ���� Ȯ����(��������/Ȯ���ڸ�)

		System.out.println("str : " + str);
		System.out.println("filename : " + post_file);
		System.out.println("media_real_file : " + media_real_file);
		System.out.println("media_ext : " + media_ext);
		System.out.println("path : " + path);

		int post_seq = new PostDTO().getPost_seq();
		String media_file = "C:\\Users\\user\\first_project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Anjun_Plus2\\uploadedFiles";

		FileDTO dto = new FileDTO(post_seq, media_file, media_real_file, media_ext);
		FileDAO dao = new FileDAO();
		
		int cnt2 = dao.uploadFile(dto);

		// �Խñ� ����, �ؽ��±�, ���̵�
		String post_content = multiRequest.getParameter("post_content");
		String id = info.getId();
		String post_hashtag2 = multiRequest.getParameter("post_hashtag");
		
		
		String post_hashtag = post_hashtag2.substring(11, 13);
		
		System.out.println(post_content);
		System.out.println(id);
		System.out.println(post_hashtag);
		
		
		PostDTO dto2 = new PostDTO(post_content, id, post_hashtag);
		PostDAO dao2 = new PostDAO();
		
		System.out.println("post_content:"+dto2.getPost_content());
		System.out.println("user_id:"+dto2.getUser_id());
		System.out.println("post_hashtag:"+dto2.getPost_hashtag());

		PostDTO dto3 = dao2.post(dto2);
		if (dto3 != null) {
			writer.println("<script>alert('���������� �Խ��Ͽ����ϴ�.');</script>");
			response.sendRedirect("Blog.jsp?post_seq="+dto3.getPost_seq());
		} else {
			writer.println("<script>alert('�Խù� �ۼ��� �����Ͽ����ϴ�..');</script>");
		}
		writer.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>