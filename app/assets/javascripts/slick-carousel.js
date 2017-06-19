$(document).on('turbolinks:load', function(){

	$('.single-item').slick();

	$('.multiple-items').slick({
	  // infinite: true,
	  slidesToShow: 2,
	  slidesToScroll: 1,
	  adaptiveHeight:true,
	  variableWidth:true,
	  focusOnSelect:true
	});

	$('.responsive').slick({
	  dots: false,
	  infinite: false,
	  speed: 700,
	  slidesToShow: 5,
  slidesToScroll: 1,
	  responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        slidesToShow: 3,
	        slidesToScroll: 3,
	        infinite: true,
	        dots: true
	      }
	    },
	    {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 2
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
	    // You can unslick at a given breakpoint now by adding:
	    // settings: "unslick"
	    // instead of a settings object
	  ]
	});

	$('.variable-width').slick({
	  dots: true,
	  infinite: true,
	  speed: 300,
	  slidesToShow: 1,
	  centerMode: true,
	  variableWidth: true
	});

	$('.one-time').slick({
	  dots: true,
	  infinite: true,
	  speed: 300,
	  slidesToShow: 1,
	  adaptiveHeight: true
	});

	$('.center').slick({
	  centerMode: true,
	  centerPadding: '60px',
	  slidesToShow: 3,
	  responsive: [
	    {
	      breakpoint: 768,
	      settings: {
	        arrows: false,
	        centerMode: true,
	        centerPadding: '40px',
	        slidesToShow: 3
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        arrows: false,
	        centerMode: true,
	        centerPadding: '40px',
	        slidesToShow: 1
	      }
	    }
	  ]
	});
		
	$('.autoplay').slick({
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});

	$('.fade').slick({
	  dots: true,
	  infinite: true,
	  speed: 500,
	  fade: true,
	  cssEase: 'linear'
	});


	$('.add-remove').slick({
	  slidesToShow: 3,
	  slidesToScroll: 3
	});
	$('.js-add-slide').on('click', function() {
	  slideIndex++;
	  $('.add-remove').slick('slickAdd','<div><h3>' + slideIndex + '</h3></div>');
	});

	$('.js-remove-slide').on('click', function() {
	  $('.add-remove').slick('slickRemove',slideIndex - 1);
	  if (slideIndex !== 0){
	    slideIndex--;
	  }
	});
		

	$('.filtering').slick({
	  slidesToShow: 4,
	  slidesToScroll: 4
	});

	var filtered = false;

	$('.js-filter').on('click', function(){
	  if (filtered === false) {
	    $('.filtering').slick('slickFilter',':even');
	    $(this).text('Unfilter Slides');
	    filtered = true;
	  } else {
	    $('.filtering').slick('slickUnfilter');
	    $(this).text('Filter Slides');
	    filtered = false;
	  }
	});

	 $('.slider-for').slick({
	  slidesToShow: 1,
	  slidesToScroll: 1,
	  arrows: false,
	  fade: true,
	  asNavFor: '.slider-nav'
	});

	$('.slider-nav').slick({
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  asNavFor: '.slider-for',
	  dots: true,
	  centerMode: true,
	  focusOnSelect: true
	});

	$('.single-item-rtl').slick({
	  rtl: true
	});
});
