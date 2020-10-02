$(document).ready(function(){

	// Find TOC
	var toc = $("#TOC");
	if (toc.length === 0) {
	  return;
	}

//Find the original place of toc hugo academic
var x = document.getElementsByClassName("d-none d-xl-block col-xl-2 docs-toc");


// Find sidebar
//	var sidebar = $("div.flex-xl-nowrap");
//	if (sidebar.length !== 1) {
//	   return;
//	}

	// Generate html
	var htmltoc = '<ul class="nav toc-top"><li><a href="#" id="back_to_top" class="docs-toc-title">Contents</a></li></ul>' +
	'<nav id="TableOfContents" class="nav flex-column">' +
  toc.html() +
	'</nav>';
  x[0].innerHTML = htmltoc;
  toc.html("");



});
