var currentPage = 1;
var currentPageparams = window.location.search.substr("6");
var lastPage = 0
if (currentPageparams) currentPage = currentPageparams; 
var intervalID = -1000;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    if (currentPage > lastPage){
			      clearInterval(intervalID);
            return
    }
    console.log("Requent Page " + currentPage);
    var prom = jQuery.ajax('?page=' + currentPage,{
                beforeSend: showLoadingtext 
                });
 
  prom.done(appendMovies);
  prom.always(removeLoadingtext);
  prom.fail(function(){ console.log("Something went wrong")});}

}

function appendMovies(data, textStatus, jqXHR){
		        $('.endless_movie').append(jQuery(data).find('.endless_movie').html());
	          }


function showLoadingtext() {
            $('.endless_movie').append("<div id='tempload'><em>Loading...</em></div>")
}

function removeLoadingtext() {
    $('#tempload').remove();
}
function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 50;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

$('document').ready(function(){
    lastPage = $('nav.pagination span.last a').attr('href').split("=").pop();
    //  $(window).scroll(checkScroll);
	  intervalID = setInterval(checkScroll, 800);
    $('.pagination').hide();
})

