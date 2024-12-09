


function emailchk(event) {
	event.preventDefault(); // 기본 폼 제출을 막음

	var member_email = $("#member_email").val();
//	var form = $("#form")[0];
//	alert("member_email : " + member_email);
	
	$.ajax({
		type: "POST",
		url: "member_emailcheck",
		data: {"member_email": member_email},
		success: function(data){
//			alert("data:"+ data);
			if (data == 0) {
				var msg = '<font color="red">입력하신 계정을 찾을 수 없습니다.</font>';		
//				alert(msg);		
				$("#msg").html(msg).show();
				return false;
			}else if (data == 1){
//				alert("이메일전송");
				
				location.href="find_pass_ok?member_email="+member_email;
				
//				alert(form);
//				$("#form").off('submit');
//				form.submit();
			}
		},
		error: function(e) {
				alert("data error" + e);
		}
	})	
}

function member_check(event) {
	
	event.preventDefault(); // 기본 폼 제출을 막음

	var formData = $("form[name=form]").serialize();
	
//	console.log(formData);
	
//	alert("formData : " +formData);
	
	$.ajax({
		type: "POST",
		url: "member_check",
		data: formData,
		success: function(data){
//			alert("data:"+ data);
			if (data == 0) {
				var msg = '<font color="red">입력하신 계정을 찾을 수 없습니다.</font>';		
//				alert(msg);		
				$("#msg").html(msg).show();
				return false;
			}else if (data == 1){
//				alert("로그인 성공");
							
				$("#form").off('submit');
				form.submit();
				
			}else if (data == 2){
//				alert("비밀번호 틀림");
				
				var msg = '<font color="red">회원정보가 일치하지 않습니다.</font>';
//				alert(msg);
				$("#msg").html(msg).show();

//				alert(form);
//				$("#form").off('submit');
//				form.submit();
			}
		},
		error: function(e) {
				alert("data error" + e);
		}
	})	
	
	
}