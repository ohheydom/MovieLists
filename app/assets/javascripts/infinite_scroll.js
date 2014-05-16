$(document).ready(function(){
  $('#movies').infinitescroll({
    loading: {
      msgText: "<em>Loading more movies!</em>",
      finishedMsg: "<em>There are no more movies to show. Bummer.</em>"
    },
    navSelector: "nav.pagination",  
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "#movies tr[id$=tr]"
  });                      
});    
