<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<script type="text/javascript">
 		Swal.fire('${msg}').then((toContinue) => {
			      if (toContinue) {
			  			location.href = '${url}';
			        }
			      });
		//history.back();
	</script>
</body>
</html>