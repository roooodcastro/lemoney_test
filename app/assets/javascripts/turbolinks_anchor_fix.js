document.addEventListener('turbolinks:before-visit', function(e) {
    if (e.data.url.split(window.location.href)[1].length > 0) {
        e.preventDefault();
        window.location.href = e.data.url;
    }
});
