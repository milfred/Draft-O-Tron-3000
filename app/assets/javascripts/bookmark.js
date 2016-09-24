function bookmarksite(title,url) {
   // Internet Explorer
   if(document.all)
   {
       window.external.AddFavorite(url, title);
   }
   // Google Chrome
   else if(window.chrome){
      alert("Press Ctrl+D to add bookmark");
   }
   // Firefox
   else if (window.sidebar)
   {
       window.sidebar.addPanel(title, url, "");
   }
   // Opera
   else if(window.opera && window.print)
   {
      var elem = document.createElement('a');
      elem.setAttribute('href',url);
      elem.setAttribute('title',title);
      elem.setAttribute('rel','sidebar');
      elem.click();
   }
} 
