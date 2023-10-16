var index = 1;

showSlides(index);

function nextSlides(n) {
  showSlides(index += n);
}

function currentSlide(n) {
  showSlides(index = n);
}

function showSlides(n) {
  if(n > $(".Slides").length) {
      index = 1;
  }
  if(n < 1) {
      index = $(".Slides").length;
  }
  for(var i = 0; i < $(".Slides").length; i++) {
    $(".Slides")[i].style.display = "none";
  }
  for(var i = 0; i < $(".dot").length; i++) {
    $(".dot")[i].className = $(".dot")[i].className.replace(" active", "");
  }
  $(".Slides")[index-1].style.display = "block";
  $(".dot")[index-1].className += " active";
  setTimeout(function(){
      nextSlides(1);
  },5000);
}

