var currentPage = 1;
var currentPageparams = window.location.search.substr("6");
var lastPage = 0
if (currentPageparams && $.isNumeric(currentPageparams)) currentPage = currentPageparams; 
var intervalID = -1000;

function checkScroll() {
  if ($('#tempload').length){
    return}
  else {
    if (nearBottomOfPage()) {
      currentPage++;
      if (currentPage > lastPage){
        $('.endless_movie').append("<div id='endofpages'>There are no more movies here.</div>")
		    clearInterval(intervalID);
        return
      } 
    console.log("Request Page " + currentPage);
      showLoadingtext();    
      $('nav.pagination a[rel=next]:first').click();
    }
  }
}

function showLoadingtext() {
  $('.endless_movie').append("<div id='tempload'><em>Loading...</em></div>");
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

$(document).ready(function(){
  $('.pagination').hide();
  if ($('nav.pagination span.last a').length) {
    lastPage = $('nav.pagination span.last a').attr('href').split("=").pop();
    intervalID = setInterval(checkScroll, 800);
  }
})
