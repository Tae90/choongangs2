let slideIndex = 1;
let slideInterval;

function plusSlides(n) {
    showSlides(slideIndex += n);
}

function currentSlide(n) {
    showSlides(slideIndex = n);
}

function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    if (n > slides.length) { slideIndex = 1 }
    if (n < 1) { slideIndex = slides.length }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
    
    resetTimer();
}

function autoSlide() {
    plusSlides(1);
}

function resetTimer() {
    clearInterval(slideInterval);
    slideInterval = setInterval(autoSlide, 5000);
}

document.addEventListener("DOMContentLoaded", function() {
    showSlides(slideIndex);
    // resetTimer() 호출 제거
});

// 화살표 클릭 이벤트에 대한 리스너 추가
document.querySelector('.prev').addEventListener('click', function() {
    plusSlides(-1);
});
document.querySelector('.next').addEventListener('click', function() {
    plusSlides(1);
});

// 점(dot) 클릭 이벤트에 대한 리스너 추가
let dots = document.getElementsByClassName("dot");
for (let i = 0; i < dots.length; i++) {
    dots[i].addEventListener('click', function() {
        currentSlide(i + 1);
    });
}
