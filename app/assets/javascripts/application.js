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
        success: function(){
            alert('yes');
        }
        });
});
  /** 
 * END ADD LINK
 */