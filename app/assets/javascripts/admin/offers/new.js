$(document).on('turbolinks:load', function() {
    // If we're in the correct page
    if ($('.admin_offers.new').length > 0) {
        $(document).on('keydown keypress keyup paste', '#offer_description', function() {
            updateCharacterCounter($('#offerDescriptionCounter'), $(this), 500);
        });
    }
});

function updateCharacterCounter(counterSpan, input, limit) {
    var remaining = limit - input.val().length;
    counterSpan.text(remaining);
    if (remaining / limit < 0.1) counterSpan.css('color', '#C82636');
    else if (remaining / limit < 0.33) counterSpan.css('color', '#E1A61F');
    else counterSpan.css('color', '#6B747C');
}
