$(document).on('turbolinks:load', function() {
    // If we're in the correct page
    if ($('.offers.index').length > 0) {
        setInterval(function() {
            $('span[data_ends_at!=\'\'][data-ends_at]').each(updateOfferTimeCounter);
        }, 1000);
    }
});

const ONE_HOUR = 1000 * 60 * 60;

function updateOfferTimeCounter() {
    var span = $(this);
    var endsAt = moment(span.data('ends_at'), 'YYYY-MM-DD hh:mm:ss z');
    var millisecondsToEnd = endsAt - moment();
    if (millisecondsToEnd > (ONE_HOUR * 48)) return;
    var timeToEndString = formatOfferEndTime(moment(millisecondsToEnd));
    span.text(timeToEndString);
}

function formatOfferEndTime(timeToEnd) {
    var hours = ('00' + Math.floor(timeToEnd / ONE_HOUR)).slice(-2);
    var minutes = ('00' + timeToEnd.minutes()).slice(-2);
    var seconds = ('00' + timeToEnd.seconds()).slice(-2);
    return 'Ends in ' + hours + 'h:' + minutes + 'm:' + seconds + 's';
}
