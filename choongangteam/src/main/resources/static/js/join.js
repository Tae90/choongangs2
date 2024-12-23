

$(document).ready(function() {
	
	
//	입력한 비밀번호와 비밀번호 확인값이 맞는지 확인하는 기능
	const submit_color = document.getElementById("submit_color");		
	
	$("#passwordConfirm").keyup(function() {
	
	var pwconfirm = $.trim($("#passwordConfirm").val());
	var pw = $.trim($("#member_password").val());
	
	// 두 입력값이 일치하지 않으면 메시지를 띄움과 동시에 버튼을 비활성화
	if (pw != pwconfirm){
		var msg = '<font color="red">비밀번호가 일치하지 않습니다.</font>';
		$("#msg").html(msg).show();
		submit_color.classList.remove("purple");
		submit_color.classList.add("bg-gray-300");
		$("#submit_btn").attr("disabled", true); 		
	}else {
		// 두 입력값이 일치하면 메시지를 지우고 버튼 활성화
		$("#msg").hide();
		submit_color.classList.remove("bg-gray-300");
		submit_color.classList.add("purple");
		
		$("#submit_btn").attr("disabled", false);
	}
	
	})
})

// 회원가입할 때 db에 이미 회원정보가 있는지 확인하는 기능
function chk(event) {
	event.preventDefault(); // 기본 폼 제출을 막음 안하면 함수가 실행되다 submit된다

//	alert("chk call");
	var member_email = $("#member_email").val();
	var form = $("#form")[0];
	
	$.ajax({
		type: "POST",
		url: "member_emailcheck",
		data: {"member_email": member_email},
		success: function(data){
//			alert("data:"+ data);
			if (data == 1) {
				
				var msg = '<font color="red">사용할 수 없는 이메일입니다.</font>';
				$("#msg").html(msg).show();
				return false;
			}else{
				// 중복이 아니면 submit
				// submit을 하기전에 submit을 off하지 않으면 submit 되면서 다시 
				// onsubmit(chk(event))를 실행하면서 무한루프에 빠진다.
				$("#form").off('submit');
				form.submit();					
			}
		},
		error: function(e) {
				alert("data error" + e);
		}
	})	
}