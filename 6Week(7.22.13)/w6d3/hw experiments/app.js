$(function() {
	$('button').click(function() {
		var newElement = $("<div>")
                      .html('Click me to remove')
                      .addClass('removeme');
	  $(this).append(newElement);
	});
});