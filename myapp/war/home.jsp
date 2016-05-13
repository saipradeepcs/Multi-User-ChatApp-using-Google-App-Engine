<!doctype html>
<html>
<head>
	<title>Chat Application</title>
	
	<!-- JS dependencies - jQuery is not required, but included to make DOM manipulation and Ajax easier -->
    <link rel="stylesheet" type="text/css" href="./style.css">
	<script type="text/javascript" src="/_ah/channel/jsapi"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
	<!-- A bit of style -->
	
	<!-- Just going to inline our app logic - that's cool with you, right? -->
	<script type="text/javascript" charset="utf-8">
	function onMessage(message) {
		var current = $('textarea').val();
		message && $('textarea').val(current + '\n' + message.data);
		var textarea = document.getElementById('textarea_id');
		textarea.scrollTop = textarea.scrollHeight;
	}
	
	
	$(function() {
		//Get a client token to use with the channel API
		$.get("/myapp", successfunc());
		});
	
	function successfunc(){
		
		console.log("<%= request.getAttribute("token") %>");
		var channel = new goog.appengine.Channel("<%= request.getAttribute("token") %>");
		var socket = channel.open();
		
		//Assign our handler function to the open socket
		socket.onmessage = onMessage;

	}
	
	function myFunction() {
		$.ajax('/myapp', {
			method:'POST',
			dataType:'text',
			data: {
				message:$('input').val(), chathistory:$('textarea').val(), docsurl: document.getElementById('result').innerHTML 
			},
			success:function(response) {
				$('input').val('').focus();
				console.log(response);
			}
		});	
	}
		
	</script>
</head>

<body>
	<div id="container">
		<header>
			<div id="header">
			<h4 class="section-heading">&nbsp;&nbsp;  <%= request.getAttribute("logininfo") %></h4>
				<h1 class="section-heading">MULTI CHAT APPLICATION</h1>
			</div>
		</header>
		<section>
			<div id="content">
				<!-- Chat inputs/output -->
				<table >
  				<tr>
  				<td>
				<textarea id="textarea_id" readonly="readonly" name="chat"   
				style="margin: 0px; width: 250px; height: 300px;" autofocus="autofocus"><%= request.getAttribute("chatHistory") %></textarea><br></br>
				<input placeholder="Enter your message " style="margin: 0px; width: 200px;"
				 onkeydown="if ((event.keyCode ? event.keyCode : event.which) ==13) myFunction();"/>
				<button type="button" class="button button1" onclick="myFunction(); ">Send</button>
     			</td><td><div>
     		
     			<iframe id="googledocs" hidden="true"
     			src="https://docs.google.com/viewer?url=" 
     			style="width:600px; height:325px;"></iframe>
 				<div id="result" hidden="true"></div>
				 <script type="text/javascript">
				
		          var isadmin=<%= request.getAttribute("isadmin") %>
		          
		          if(isadmin){
				 // The Browser API key obtained from the Google Developers Console.
			      var developerKey = 'AIzaSyCqKckkLFHOxJGrbYm77XrxbNLCdszCriQ';

			      // The Client ID obtained from the Google Developers Console. Replace with your own Client ID.
			      var clientId = "1060973150075-heag0u664heft21vtslqhgg8jau096gt.apps.googleusercontent.com"

			      // Scope to use to access user's photos.
			      var scope = ['https://www.googleapis.com/auth/drive.readonly'];

			      var pickerApiLoaded = false;
			      var oauthToken;

			      // Use the API Loader script to load google.picker and gapi.auth.
			      function onApiLoad() {
			        gapi.load('auth', {'callback': onAuthApiLoad});
			        gapi.load('picker', {'callback': onPickerApiLoad});
			      }

			      function onAuthApiLoad() {
			        window.gapi.auth.authorize(
			            {
			              'client_id': clientId,
			              'scope': scope,
			              'immediate': false
			            },
			            handleAuthResult);
			      }

			      function onPickerApiLoad() {
			        pickerApiLoaded = true;
			        createPicker();
			      }

			      function handleAuthResult(authResult) {
			        if (authResult && !authResult.error) {
			          oauthToken = authResult.access_token;
			          createPicker();
			        }
			      }

			      // Create and render a Picker object for picking user Photos.
			      function createPicker() {
			        if (pickerApiLoaded && oauthToken) {
			          var picker = new google.picker.PickerBuilder().
			              addView(google.picker.ViewId.DOCS).
			              setOAuthToken(oauthToken).
			              setDeveloperKey(developerKey).
			              setCallback(pickerCallback).
			              build();
			          picker.setVisible(true);
			        }
			      }

			      // A simple callback implementation.
			      function pickerCallback(data) {
			        var url = 'nothing';
			        if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
			          var doc = data[google.picker.Response.DOCUMENTS][0];
			          url = doc[google.picker.Document.URL];
			          var str = url.substring(0,url.lastIndexOf("/"));
			           url = str.substring(str.lastIndexOf("/")+1,str.length);
			          document.getElementById("googledocs").src="https://docs.google.com/viewer?srcid="+url+"&pid=explorer&efh=false&a=v&chrome=false&embedded=true";
			         document.getElementById("googledocs").hidden=false;
				 	
				     document.getElementById('result').innerHTML = url;
			        }
			      }
	 	}
		          else{
		        	  var url ="<%= request.getAttribute("docsUrl")%>"
		        	  if(url != 'nothing'){
		        		  document.getElementById("googledocs").src="https://docs.google.com/viewer?srcid="+url+"&pid=explorer&efh=false&a=v&chrome=false&embedded=true";
					         document.getElementById("googledocs").hidden=false;
						     document.getElementById('result').innerHTML = url;
					         	  
		        	  }
			         
		          }
			</script>   

    <!-- The Google API Loader script. -->
    <script type="text/javascript" src="https://apis.google.com/js/api.js?onload=onApiLoad"></script>
   </div>
     			<%-- Script for video feed, not in use currently 
     			<video id="video" width="400" height="300" autoplay="autoplay"  ></video> --%> 
			</td>
			</tr>
			</table>
			</div>
		</section>
	
	</div>

	<%-- Script for video feed, not in use currently
<script type="text/javascript" charset="utf-8"> 
(function(){
	var video = document.getElementById('video'),
	    vendorUrl = window.URL || window.webkitURL;
	
	navigator.getMedia = navigator.getUserMedia ||
	                     navigator.webkitGetUserMedia ||
	                     navigator.mozGetUserMedia ||
	                     navigator.msGetUserMedia;
	
	navigator.getMedia({
		video:true,
	    audio:true 
	}, function(stream){
		video.src =vendorUrl.createObjectURL(stream);
		video.play();
	},function(error){
	//	error.code
	});
	
	})();
</script> --%>
</body>

</html>