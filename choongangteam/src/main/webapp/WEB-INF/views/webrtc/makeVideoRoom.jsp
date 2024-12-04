<%@ page contentType="text/html; charset=UTF-8" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>makeVideoRoom</title>
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
    alert("makeVideoRoom")
    $(function () {
      
      var msg = "${msg}";
      if(msg == "undefined"){
        alert("방이 존재합니다.");
      }

      $(".navbar-static-top").load("navbar.html", function () {
        $(".navbar-static-top li.dropdown").addClass("active");
        $(".navbar-static-top a[href='videoroomtest.html']").parent().addClass("active");
      });
      $(".footer").load("footer.html");
    });
  </script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/3.4.0/cerulean/bootstrap.min.css"
    type="text/css" />
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
      </div>
    </div>
    <hr>
    <div class="footer">
    </div>
  </div>
</body>
</html>