$(document).ready(beginTyping)

function beginTyping () {

  function toType(){
    $('input#search-bar').attr('placeholder', '');
    var chars = sentencesToAutofill[index].split('');
    var charIndex = 0;
    var printChars = setInterval(function() {
      if(charIndex == chars.length-1) clearInterval(printChars);
      var currentHolder = $('input#search-bar').attr('placeholder');
      $('input#search-bar').attr('placeholder', currentHolder+chars[charIndex]);
      charIndex++;
    }, 50);
    if (index < sentencesToAutofill.length - 1){
      index++;
    }
    else{
      index = 0;
    }
  }

  index = 0
  sentencesToAutofill = ['What would you like to make?', 'Tom Collins', 'Side Car', 'Manhattan', 'Jager Bomb']
  setInterval(function() {toType()}, 2500)

}
