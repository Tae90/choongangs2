var version = 1.2;
var server = null;
server = "https://janus.jsflux.co.kr/janus"; //jsflux janus server url

var janus = null;
var sfutest = null;
var opaqueId = "videoroomtest-"+Janus.randomString(12);

var feeds = [];
var bitrateTimer = [];

var doSimulcast = (getQueryStringValue("simulcast") === "yes" || getQueryStringValue("simulcast") === "true");
var doSimulcast2 = (getQueryStringValue("simulcast2") === "yes" || getQueryStringValue("simulcast2") === "true");
var subscriber_mode = (getQueryStringValue("subscriber-mode") === "yes" || getQueryStringValue("subscriber-mode") === "true");


$(document).ready(function() {

	// Initialize the library (all console debuggers enabled)
	Janus.init({debug: "all", callback: function() {
			janus = new Janus(
				{
					server: server,
					success: function() {
						// Attach to VideoRoom plugin
						janus.attach(
							{
								/*
									start -> stop
									밑에 부분에 Room Name, My Name, 대화방 참여 나타남
								*/
								plugin: "janus.plugin.videoroom",
								opaqueId: opaqueId,
								success: function(pluginHandle) {
									$('#details').remove();
									sfutest = pluginHandle;
									Janus.log("Plugin attached! (" + sfutest.getPlugin() + ", id=" + sfutest.getId() + ")");
									Janus.log("  -- This is a publisher/manager");

                    		Janus.log("Room List > ");
                   
								} ,
								error: function(error) {
									Janus.error("  -- Error attaching plugin...", error);
									bootbox.alert("Error attaching plugin... " + error);
								},
							});
					},
					error: function(error) {
						Janus.error(error);
						bootbox.alert(error, function() {
							window.location.reload();
						});
					},
					destroyed: function() {
						window.location.reload();
					}
				});
	}});
});

function checkEnter(field, event) {
	var theCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	if(theCode == 13) { //keyCode 13 => endter키
		registerUsername();
		return false;
	} else {
		return true;
	}
} 

// [jsflux] 방생성 및 조인
function registerUsername() {

	var username = "tempid" //앞쪽에서 받아와야 하는데 임시로 설정

	let mode = document.getElementById('broadcastModeSelect').value;
		let room = document.getElementById('room').value.trim();

		if (room === "") {
			alert("방 번호를 입력해주세요."); // 방 제목이 비어있을 때 경고 메시지
			return;
		}

		if(isNaN(room)){
			alert("방 번호는 숫자만 가능합니다.");
			return;
		}

		$('#broadcastModal').modal('hide');

	myroom = Number(room); //사용자 입력 방 아이디

	var createRoom = {
		request : "create",
		room : myroom,
		permanent : false,
		record: false,
		publishers: 6,
		bitrate : 128000,
		fir_freq : 10,
		ptype: "publisher",
		description: "test",
		is_private: false
	}

	sfutest.send({ message: createRoom, success:function(result){
		var event = result["videoroom"]; Janus.debug("Event: " + event);
		if(event != undefined && event != null) {
				//야누스 서버에 방 생성
				if(mode === "1"){ //개인 방송일 때만 방 유무 체크, 회의는 입장 가능 해야한다.
					if(result.error_code === 427){
						alert("개인 방송 방이 이미 존재합니다.");
						$('#broadcastModal').modal('show');
						return;
					}
				}

				console.log("Room Create Result: " + result);
				console.log("error: " + result["error"]);
				room = result["room"];
				console.log("Screen sharing session created: " + room);

				if(mode === "0"){  //회의 모드
					location.href = "/webrtc/webrtc_detailMeeting?username="+username+"&room="+room;
				}else if(mode === "1"){ //개인 방송
					location.href = "/webrtc/myVideoRoom?username="+username+"&room="+room;
				}else{

				}

				//화면 공유 링크
				//location.href = "./shareMyVideoRoom.html?username="+username+"&room="+room;
		}
	}});
}

// Helper to parse query string
function getQueryStringValue(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
