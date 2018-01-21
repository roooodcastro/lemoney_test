$(document).on('turbolinks:load', function() {
    // If we're in the correct page
    if ($('.offers.index').length > 0) {
        setInterval(function() {
            $('span[data_ends_at!=\'\'][data-ends_at]').each(updateOfferTimeCounter);
        }, 1000);
    }
});

const ONE_HOUR = 1000 * 60 * 60;

// Updates the offer counter, which displays how much time the user has to
// access that specific offer. When the remaining time is longer than 2 days,
// this function will not update it, as it will only be displayed in days, not
// seconds.
function updateOfferTimeCounter() {
    var span = $(this);
    var endsAt = moment(span.data('ends_at'), 'YYYY-MM-DD hh:mm:ss z');
    var millisecondsToEnd = endsAt - moment();
    if (millisecondsToEnd > (ONE_HOUR * 48)) return;
    if (millisecondsToEnd < 0) { // Offer has ended, we must disable it
        span.text('Offer has ended!');
        return disableOffer(span.closest('.card-offer'));
    }
    var timeToEndString = formatOfferEndTime(moment(millisecondsToEnd));
    span.find('strong').text(timeToEndString);
}

// Formats the remaining time for an offer, in the format (example):
// "Ends in: 03h:20m:59s"
function formatOfferEndTime(timeToEnd) {
    var hours = ('00' + Math.floor(timeToEnd / ONE_HOUR)).slice(-2);
    var minutes = ('00' + timeToEnd.minutes()).slice(-2);
    var seconds = ('00' + timeToEnd.seconds()).slice(-2);
    return hours + 'h:' + minutes + 'm:' + seconds + 's';
}

// Disables an offer that has ended while the user was browsing the page.
// This is purely cosmetic, and blocks the user from clicking the offer link.
// When the user refreshes the page, this offer will no longer be displayed.
function disableOffer(offerCard) {
    offerCard.removeClass('border-success border-info card-offer');
    offerCard.addClass('border-danger');
    var offerButton = offerCard.find('a');
    offerButton.removeClass('btn-success btn-info');
    offerButton.addClass('btn-danger disabled');
    offerButton.attr('disabled', 'disabled');
}