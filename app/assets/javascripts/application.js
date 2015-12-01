// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .

function makeNull() {
  document.getElementById("notification-counter").innerHTML = 0;
}

// function markSeen() {
     	
//       url: 'http://localhost:3000',
//       type: 'POST',


      
//   success: function(){ 
//     alert('success!');
//   },
  
//   error: function(){
//     alert('error!');
//   }
// })

// Notification.where(user_id: current_user).update(seen: "true")


// if(!($movieInfo = mysql_query($insertMovie, $dbc))){
//     echo mysql_error();
//     echo mysql_errno();
//     exit();
// }


// var xmlHttp;

// function showUser(str)
// { 
// xmlHttp=GetXmlHttpObject();
// if (xmlHttp==null)
//  {
//  alert ("Browser does not support HTTP Request");
//  return;
//  }
// var url="getuser.php";
// url=url+"?q="+str;
// url=url+"&sid="+Math.random();
// xmlHttp.onreadystatechange=stateChanged;
// xmlHttp.open("GET",url,true);
// xmlHttp.send(null);
// }

// function stateChanged() 
// { 
// if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
//  { 
//  document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
//  } 
// }

// function GetXmlHttpObject()
// {
// var xmlHttp=null;
// try
//  {
//  // Firefox, Opera 8.0+, Safari
//  xmlHttp=new XMLHttpRequest();
//  }
// catch (e)
//  {
//  //Internet Explorer
//  try
//   {
//   xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
//   }
//  catch (e)
//   {
//   xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
//   }
//  }
// return xmlHttp;
// }


