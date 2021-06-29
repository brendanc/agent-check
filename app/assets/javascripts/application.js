/** 
 * BEGIN HITS SEARCH/FILTER
 */
(function(document) {
    'use strict';

    var TableFilter = (function(myArray) {
        var search_input;

        function _onInputSearch(e) {
            search_input = e.target;
            var tables = document.getElementsByClassName(search_input.getAttribute('data-table'));
            myArray.forEach.call(tables, function(table) {
                myArray.forEach.call(table.tBodies, function(tbody) {
                    myArray.forEach.call(tbody.rows, function(row) {
                        var text_content = row.textContent.toLowerCase();
                        var search_val = search_input.value.toLowerCase();
                        row.style.display = text_content.indexOf(search_val) > -1 ? '' : 'none';
                    });
                });
            });
        }

        return {
            init: function() {
                var inputs = document.getElementsByClassName('search-input');
                myArray.forEach.call(inputs, function(input) {
                    input.oninput = _onInputSearch;
                });
            }
        };
    })(Array.prototype);

    document.addEventListener('readystatechange', function() {
        if (document.readyState === 'complete') {
            TableFilter.init();
        }
    });

})(document);
/** 
 * END HITS SEARCH/FILTER
 */

/** 
 * BEGIN DELETE HITS
 */
$(document).on('click','.delete-hit', function() {
var hitId = $(this).attr('data-hit-id'); 
$.ajax({
type: 'POST',
url: '/hits/delete/' + hitId,
success: function(){
    $('#tr-for-hit-' + hitId).fadeOut();
}
});
});

/** 
 * END DELETE HITS
 */

 /** 
 * BEGIN ADD LINK
 */
$(document).on('click','.add-link', function() {
    let linkUrl = prompt('Enter a url to create a link for:');
    let isConfirmed = confirm('Are you sure you want to create a link for ' + linkUrl + ' ?');
    if(!isConfirmed)
    {
        return;
    }

    $.ajax({
        type: 'POST',
        url: '/links/new/',
        data: {url: linkUrl},
        dataType: 'json',
        success: function(data){
           console.log(data);
           $('#links-table').find('tbody')
            .prepend('<tr><td>' + data.id + '</td>'
            + '<td>' + data.url + '</td>'
            + '<td>' + data.slug + '</td>'
            + '<td>' + data.created_at + '</td>'
            + '</tr>');
        }
        });
});
  /** 
 * END ADD LINK
 */

 /**
  * BEGIN CUSTOMIZE SAMPLE EMAIL
  */

function swapEmailValue(tag, newValue)
{
    var email = $('#sampleEmail').text();
    var r = ''; // regex
    var v = '' // replace value
    if(tag == 't')
    {
        r = /t=(img|dyn|eng|css)/g;
        v = 't=' + newValue;
    }
    else
    {
        r = /code=.*\"/g;
        v = 'code=' + newValue + '"';
    }

    var newEmail = email.replaceAll(r,v);
    $('#sampleEmail').text(newEmail);
}

$(document).on('change','#assetType',function(){
    swapEmailValue('t',$('#assetType').val());
});

$(document).on('input','#assetCode',function(){
    console.log('in change');
    swapEmailValue('code',$('#assetCode').val());
});
   /**
  * END CUSTOMIZE SAMPLE EMAIL
  */

/**
 * BEGIN MAKE EMAIL COPYABLE
 */

$(document).ready(function(){

    var copyText = 'Click to copy. <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard" viewBox="0 0 16 16"><path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"/><path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"/></svg>';
    $('#sampleEmail').mouseenter(function() {
        $('.hoverText').html(copyText);
        $('.hoverText').css("visibility","visible");
      });
      
      $('#sampleEmail').mouseout(function() {
        $('.hoverText').css("visibility","hidden");
      });

    $('#sampleEmail').on('ready').append('<span class="command-copy" ><i class="fa fa-clipboard" aria-hidden="true"></i></span>');

    $('#sampleEmail').click(function(e) {
        var text = $(this).parent().text().trim();
        var cleanText = text.replace(/\n/g, "")
        .replace(/[\t ]+\</g, "<")
        .replace(/\>[\t ]+\</g, "><")
        .replace(/\>[\t ]+$/g, ">")
        .replace('Click to copy.','');
        var copyHex = document.createElement('input');
        copyHex.value = cleanText;
        document.body.appendChild(copyHex);
        copyHex.select();
        document.execCommand('copy');
        document.body.removeChild(copyHex);
        $('.hoverText').text('Copied!');
      });
});

 /**
 * END MAKE EMAIL COPYABLE
 */