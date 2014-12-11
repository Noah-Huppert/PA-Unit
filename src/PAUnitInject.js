"use strict";

var files = [];

if(document.addEventListener){
  document.addEventListener("DOMContentLoaded", function DOMLoaded(){
    document.removeEventListener("DOMContentLoaded", arguments.callee, false);

    for(file in files){
      loadScript(file);
    }
  }, false);
}
