
//        4???
let page = 4;
let loading = false;
let hasMore = true;
let loadedReplyNum = [];
let scrollTimeout;

// 맨처음 리스트를 불러올 때 실행되는 함수
$(document).ready(function() {
	// 함수 실행되는지 확인
	console.log("document ready");
	
	
	// 클래스에 공백이 있으면 인식을 못하므로 여러개의 클래스값을 쓰려면 공백대신
	// .을 삽입
	$('.flex.flex-col.gap-4.text-sm').each(function(){
		let replyNum = $(this).attr('id');
		if (replyNum) {
			// 초기에 출력된 댓글들 넘버를 삽입
			loadedReplyNum.push(replyNum);
			console.log("loaded more ReplyNum : "+loadedReplyNum);
		}
	});
});


// 스크롤이 최하단으로 갔을 때 실행되는 함수
$(window).scroll(function() {
	console.log("scroll down");
	// 스크롤이 일어날때마다 타이머가 실행되면 안되니 이전 타이머 취소
	clearTimeout(scrollTimeout);
	scrollTimeout =setTimeout(function (){
		// 스크롤이 하단 100px 이내에 진입하면
		if ($(window).scrollTop() + $(window).height() > $(document).height() - 100){
			console.log("arrived end");
			// 로딩이 true?? false야 되는거 아닌가..and 불러올 댓글이 있다면 
			// loadMoreReply 함수를 호출해 댓글을 더 출력한다. 
			if (!loading && hasMore) {
				loadMoreReply();
			}
		}		
	},100);
});

// 무한스크롤 함수(댓글을 더 불러오는 함수)
function loadMoreReply(){
	console.log("loadMoreReply in");
	// 더 불러올 댓글이 없거나 로딩중이 아니라면(???)
	// 하면 함수 취소
	if (loading || !hasMore) return;
	
	// 로딩 상태를 로딩중으로 바꾼다
	loading = true;
	
	// 로딩중 아이콘 출력
	$('.loading-spinner').show();
	console.log("loading start");
	
	// 글번호값 가져와야함	
	var lesson_number = document.getElementsByName('lesson_number')[0].value;
	console.log("lesson num : " + lesson_number);
	
	$.ajax({
		url: 'loadMoreReply',
		method: 'GET',
		data: {
			"page": page,
			"lesson_number": lesson_number,
			"loadedReplyNum": loadedReplyNum			
		},
		success: function(response){
			console.log("loaded success");
			console.log("response : "+response);
			if (response && response.length > 0){
				console.log("댓글 불러왓을 때 if문 실행됨");
				setTimeout(function(){
					response.forEach(function(reply){
						let replyHtml =
							'<div id='+reply.reply_number+'class="flex flex-col gap-4 text-sm ">'+
								'<div id="rlist" class="border border-taling-gray-200 p-4 md:px-6 rounded-lg">'+								
									'<div class="flex gap-3">'+
										'<div class="shrink-0">'+
//											<!-- 프사 넣을곳 -->
											'<img src="/static/img/profile/Default.png">'+
										'</div>'+
										'<div class="w-full">'+
											'<div>'+
												'<div class="flex justify-between">'+
													'<div class="flex space-x-1 gap-1 ml-1.5">'+
//														<!-- 닉네임 -->
														reply.member_nickname+
													'</div>'+
													'<div class="flex items-center gap-2">'+
//														<!-- 작성일 -->
														reply.write_date+
													'</div>'+
												'</div>'+
												'<div class="flex items-center mt-1">'+
//													<!-- 별점 공간 -->
													'<c:forEach var="i" begin="1" end="5">'+			
						  								'<c:if test="${i <= cl.reply_score}" >'+
						 									'<span class="star_on">★</span>'+
						 								'</c:if>'+ 
						 								'<c:if test='+reply.reply_score+'>'+ 
						 									'<span class="star_off">★</span>'+ 
						 								'</c:if>'+ 
						 							'</c:forEach>'+
												'</div>'+
											'</div>'+				
										'</div>'+			
									'</div>'+
									'<div class="flex">'+
										'<div class="mt-4 leading-relaxed whitespace-pre-wrap break-all text-sm sm:text-base">'+reply.reply_content+'</div>'+			
									'</div>'+
//									'<c:if test='+reply.member_email+'+ '=='+' userSession.email+'>'+
//										<div class="flex justify-end mt-4 text-xs text-gray hover:text-taling-gray-800 gap-3">
//											<button>삭제</button>
//										</div>
//									</c:if>
								'</div>'+
							'</div>';
						// 불러온 댓글을 아래에 삽입하고 불러온 댓글목록에 댓글번호를 추가한다
						$('#reply_listSection').append(replyHtml);
						loadedReplyNum.push(reply.reply_number);
					});
					page++;
					// 불러왓으니 로딩상태 false
					loading = false;
					// 로딩표시 숨김
					$('.loading-spinner').hide();
				}, Math.random() * 1000 + 1000);
			}else{
				console.log("else문 실행됨");
				// 데이터가 없으면 바로 처리
				hasMore = false;
				loading = false;
				$('.loading-spinner').hide();
			}
		},
		error: function(xhr, status, error) {
			console.error('Error:', error);
			loading = false;
			$('.loading-spinner').hide();
		}		
	});	
}



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
			if(data == 1){
//				alert("한개의 리뷰만 작성할 수 있습니다.");
				Swal.fire({
					text: "한개의 리뷰만 작성할 수 있습니다.",
					icon: "warning",
					confirmButtonText: "확인",
					confirmButtonColor: "#9832A8"					
				});				
//				return false;	
			}else if (data == 0){
				var member_email = $("input[name='member_email']").val();
				var reply_score = $("input[name='reply_score']").val(); 
				var reply_content = $("textarea[name='reply_content']").val();
				var lesson_number = $("input[name='lesson_number']").val();
				
				location.href="reply_insert?member_email="+member_email+
					"&reply_score="+reply_score+ 
					"&reply_content="+reply_content+
					"&lesson_number="+lesson_number;
				
			}else if (data == 2){
//				alert("구매자만 리뷰를 달 수 있습니다.");
				Swal.fire({
					text: "구매자만 리뷰를 작성할 수 있습니다.",
					icon: "error",
					confirmButtonText: "확인",
					confirmButtonColor: "#9832A8"
				});
			}
		},
		error: function(e){
			alert("data error" +e);
		}		
	})	
}


// 댓글 삭제 확인 모달창
function redelete(rnum,lnum){
	alert("redelete in");
	
	alert("reply_number : " +rnum);
	
	Swal.fire({
	      text: "정말로 삭제하시겠습니까?",
	      icon: 'question',
	      showCancelButton: true,
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      confirmButtonColor: '#007bff',
	      cancelButtonColor: '#d33'
	    }).then((result) => {
	      if (result.isConfirmed) {
	        // replyNumber를 URL에 추가하여 삭제 요청을 보냅니다.
	        window.location.href = "/reply_delete?reply_number=" + rnum+"&lesson_number="+lnum;
	      } else if(result.isDismissed){
	        console.log("취소되었습니다.");
	      }
	    });
	
}


