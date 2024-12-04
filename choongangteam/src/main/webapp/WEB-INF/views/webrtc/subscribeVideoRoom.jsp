<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>videoroomtest_subscribe</title>
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
  <script type="text/javascript" src="/js/webrtc/subscriVideoRoom.js?ver=12"></script>
  
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
  <div class="container" id="videos">
    <input type="text" id="room">
    <button class="btn btn-success" autocomplete="off" id="buttonup">대화방 참여</button>
    <div class="row">
      <div class="col-md-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Remote Video #1 <span class="label label-info" id="remote1"></span></h3>
          </div>
          <div class="panel-body relative" id="videoremote1"></div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>