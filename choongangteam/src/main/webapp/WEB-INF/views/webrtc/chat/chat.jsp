<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
   <title>Chatting</title>

  <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
   
</head>
<body>
   <input type="text" id="sender" placeholder="Your name">
   <input type="text" id="message" placeholder="input message">
   <button onclick='sendMessage()'>SEND</button>
   <div id="messages"></div>

   <script>

      let stompClient = null;
     
      function connect(){
         
         const socket = new SockJS("/chat");
         stompClient = Stomp.over(socket);
         //topic : 서버에서 보낸 메세지
         stompClient.connect({}, (frame) => {
            stompClient.subscribe('/topic/messages', (message) => {
               showMessage(JSON.parse(message.body))
            })
         })
      }

      function sendMessage(){
         const sender = document.getElementById("sender").value;
         const contents = document.getElementById("message").value;
         //app : 클라이언트에서 보내느 메세지
         stompClient.send('/app/sendMessage', {} , JSON.stringify({sender, contents}));
      }

      function showMessage(message){
         let messageDiv = document.getElementById("messages");
         const messageElem = document.createElement('p');
         messageElem.contentEditable = true;

         //message = JSON.parse(message);
         let sender = message.sender;
         let contents = message.contents;

         messageElem.textContent = sender + " : " + contents;

         console.log(message)
         console.log(messageElem)
         messageDiv.appendChild(messageElem);

         document.getElementById("message").value = "";
      }

     
      connect();
   </script>
</body>
</html>