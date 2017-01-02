$(document).on('turbolinks:load', function () {
    var $events = $(".events");
    if ($events.length) {
        $events.infinitescroll({
            navSelector: "nav.pagination",
            nextSelector: "nav.pagination a[rel=next]",
            itemSelector: ".events .event"
        })
    }
});
