var curr = 1;
changeBackground(curr);

function changeBackground(curr){
    if(curr > 3) {
        curr = 1;
    }
    $(".background").css("background-image", "url(../assets/regisslide" + curr +".jpg)");
    setTimeout(function(){
      changeBackground(curr + 1);
    },5000);
}

function validate(){

  var username = document.getElementById("Username").value.indexOf(" ");
  var email = document.getElementById("Email").value.indexOf("@");
  var password = document.getElementById("Password").value.length;
  var region = document.getElementById("Region").value;
  var date = document.getElementById("DOB").value;

  if(username >= 0){
    alert("Username must not contain white space");
    return;
  }else{
    if(email == -1){
      alert("Email must have @ symbol");
      return;
    }else{
      if(password < 8){
        alert("Password must be 8 characters or more");
        return;
      }else{
        if(region == -1){
          alert("Region must be chosen");
          return;
        }else{
          if(!date){
            alert("DOB must be filled");
            return;
          }else{
            alert("Account registered");
          }
        } 
      }
    }
  }
}