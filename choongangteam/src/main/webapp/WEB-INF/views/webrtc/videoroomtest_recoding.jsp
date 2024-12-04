<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>videoroomtest_recoding</title>
  <script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/6.4.0/adapter.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.min.js"></script>
  <script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>

  <script type="text/javascript" src="/js/webrtc/janus.js"></script>
  <script type="text/javascript" src="/js/webrtc/makeVideoRoom.js?ver=12"></script>
  <script>
    $(function () {
      $(".navbar-static-top").load("navbar.html", function () {
        $(".navbar-static-top li.dropdown").addClass("active");
        $(".navbar-static-top a[href='videoroomtest.html']").parent().addClass("active");
      });
      $(".footer").load("footer.html");
    });
  </script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/3.4.0/cerulean/bootstrap.min.css"
    type="text/css" />
  <link rel="stylesheet" href="css/demo.css" type="text/css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.css" />
  <style>
    table {
      width: 100%;
      border-top: 1px solid #bdbcbc;
      border-collapse: collapse;
    }

    th,
    td {
      border-bottom: 1px solid #bdbcbc;
      padding: 10px;
    }
  </style>
</head>

<body>
  <nav class="navbar navbar-default navbar-static-top">
  </nav>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="page-header">
          <h1>화상회의
            <button class="btn btn-default" autocomplete="off" id="start">Start</button>
          </h1>
        </div>
        <div class="container" id="details">
          <div class="row">
            <div class="col-md-12">
              <h3>Start 버튼을 누르고 데모를 시작하세요</h3>
              <h4>채팅방 ID로 기존 채팅방을 연결하거나 새로 생성합니다.</h4>
              <h4>* ID는 영문 또는 숫자로 입력해야 합니다.</h4>
            </div>
          </div>
        </div>
        <div class="container hide" id="videojoin">
          <div class="row">
            <div class="col-md-12" id="controls">
              <div id="registernow">
                <span class="label label-info" id="room"></span>
                <div class="input-group margin-bottom-md " style="width: 100% !important;">
                  <input autocomplete="off" class="form-control" type="text" placeholder="Room Name" id="roomname" />
                </div>
                <span class="label label-info" id="you"></span>
                <div class="input-group margin-bottom-md ">
                  <span class="input-group-addon">대화명</span>
                  <input autocomplete="off" class="form-control" type="text" placeholder="My Name" id="username"
                    onkeypress="return checkEnter(this, event);" />
                  <span class="input-group-btn">
                    <button class="btn btn-success" autocomplete="off" id="register">대화방 참여</button>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="container hide" id="videos">
          <div class="row">
            <div class="col-md-4">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <button id="startRC">Start Recording</button>
                  <button id="stopRC">Stop Recording</button>
                  <h3 class="panel-title">Local Video <span class="label label-primary hide" id="publisher"></span>
                    <div class="btn-group btn-group-xs pull-right hide">
                      <div class="btn-group btn-group-xs">
                        <button id="bitrateset" autocomplete="off" class="btn btn-primary dropdown-toggle"
                          data-toggle="dropdown">
                          Bandwidth<span class="caret"></span>
                        </button>
                        <ul id="bitrate" class="dropdown-menu" role="menu">
                          <li><a href="#" id="0">No limit</a></li>
                          <li><a href="#" id="128">Cap to 128kbit</a></li>
                          <li><a href="#" id="256">Cap to 256kbit</a></li>
                          <li><a href="#" id="512">Cap to 512kbit</a></li>
                          <li><a href="#" id="1024">Cap to 1mbit</a></li>
                          <li><a href="#" id="1500">Cap to 1.5mbit</a></li>
                          <li><a href="#" id="2000">Cap to 2mbit</a></li>
                        </ul>
                      </div>
                    </div>
                  </h3>
                </div>
                <div class="panel-body" id="videolocal"></div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <video id="preview" width="300px" height="300px"></video>
                  <span id="rectext" style="display:none">recoding...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
    <hr>
    <div class="footer">
    </div>
  </div>

  <script>
    const preview = document.getElementById('preview');
    const startButton = document.getElementById('startRC');
    const stopButton = document.getElementById('stopRC');
    const rectext = document.getElementById('rectext');

    let mediaRecorder;
    let recordedChunks = [];

    // 카메라 스트림 가져오기 - 카메라 켜기 
    navigator.mediaDevices.getUserMedia({ video: true, audio: true })
        .then(stream => {
            preview.srcObject = stream; //<video> 태그에 실시간으로 보여줌

            /* 
            MediaRecorder 설정 <- 녹화 기능
            WebRTC - 실시간 전송 , RTCPeerConnection, RTCDataChannel
            MediaRecorder - 비디오/오디오 데이터를 파일로 저장, 실시간 불가능
            */
            mediaRecorder = new MediaRecorder(stream); //실시간 미디어 스트림을 녹화할 수 있게 해줍니다.

            // 녹화 데이터 처리
            mediaRecorder.ondataavailable = event => {
              if (event.data.size > 0) {
                  recordedChunks.push(event.data);
                  console.log(recordedChunks)
                  // 서버로 전송 (WebSocket 또는 HTTP POST 사용)
                  //sendToServer(event.data);
              }
            };

            mediaRecorder.onstart = () => {
              alert("녹화가 시작되었습니다.")
              rectext.style.display = "inline";
              preview.play() = true;
            }

            mediaRecorder.onstop = () => {
                /*  
                모든 데이터 병합 후 다운로드 - 녹화된 파일 다운
                녹화를 멈추면 recordedChunks 배열의 데이터를 병합하여 Blob 객체를 만듭니다.
                Blob을 URL로 변환하고, 다운로드 링크를 생성해 사용자가 녹화된 파일을 다운로드할 수 있게 합니다.
                */
                const blob = new Blob(recordedChunks, { type: 'video/webm' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                //a.style.display = 'none';
                a.href = url;
                a.download = 'recorded-video.webm';
                document.body.appendChild(a);
                a.click();
                URL.revokeObjectURL(url);
                preview.pause();
                preview.currentTime = 0;
                preview.style.display = "none";
                rectext.style.display = "none";
            };
        });

    // 녹화 시작
    startButton.addEventListener('click', () => {
      alert("startButton")
        recordedChunks = [];
        mediaRecorder.start(); 
        //start명령어는 onstart를 호출하는데 onstart메소드는 다른 처리를 하기 위해서고 start명령어만으로 바로 녹화는 실행된다.
        console.log("Recording started...");
    });

    // 녹화 중지
    stopButton.addEventListener('click', () => {
        mediaRecorder.stop(); //
        console.log("Recording stopped.");
    });

    // 서버로 데이터 전송
    function sendToServer(data) {
        const formData = new FormData();
        formData.append('video', data, 'recorded-video.webm');
        
        fetch('/upload', {
            method: 'POST',
            body: formData
        }).then(response => {
            console.log('Video uploaded successfully:', response);
        }).catch(err => {
            console.error('Error uploading video:', err);
        });
    } 
</script>
  
</body>
</html>