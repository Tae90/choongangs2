

// 이미 리뷰를 작성했는지 판단하는 기능
function replychk(event){
	
	alert("replchk in");
	event.preventDefault();
	
	var formData = $("form[name=form]").serialize();
		
	$.ajax({
		type: "POST",
		url: "reply_check",
		data: formData,
		success: function(data){
			if(data > 0){
				
				alert("한개의 리뷰만 작성할 수 있습니다.");				
				
				return false;	
			}else if (data == 0){
				location.href="reply_insert?member_email="+member_email+"&reply_score="+reply_score+ "&reply_content="+reply_content;
				
			}			
		},
		error: function(e){
			alert("data error" +e);
		}		
	})	
}