
$(document).ready(function () {
    // Function to update active year-select
    function updateActiveYear() {
        $('.timeline-item').each(function () {
            const itemTop = $(this).offset().top;
            const windowTop = $(window).scrollTop();
            const windowHeight = $(window).height();

            if (itemTop < windowTop + windowHeight / 2) {
                const year = $(this).data('year');
                $('.year-select').removeClass('active');
                $(`.year-select[data-year="${year}"]`).addClass('active');
            }
        });
    }

    // Initial update on page load
    updateActiveYear();

    // Update on scroll
    $(window).scroll(updateActiveYear);
});

(function($) {

    $('.year-select').on('click', function() {
        const year = $(this).data('year')
        $(`#timeline-year-${year}`).get(0).scrollIntoView({behavior: 'smooth'});
    })

    $.fn.timeline = function() {
        var selectors = {
            id: $(this),
            item: $(this).find(".timeline-item"),
            activeClass: "timeline-item--active",
            img: ".timeline__img"
        };
        selectors.item.eq(0).addClass(selectors.activeClass);
        selectors.id.css(
            "background-image",
            "url(" +
            selectors.item
                .first()
                .find(selectors.img)
                .attr("src") +
            ")"
        );
        var itemLength = selectors.item.length;
        $(window).scroll(function() {
            var max, min;
            var pos = $(this).scrollTop();
            selectors.item.each(function(i) {
                min = $(this).offset().top - 200;
                max = $(this).height() + $(this).offset().top ;
                var that = $(this);
                if (i === itemLength - 2 && pos > min + $(this).height() / 2) {
                    selectors.item.removeClass(selectors.activeClass);
                    selectors.id.css(
                        "background-image",
                        "url(" +
                        selectors.item
                            .last()
                            .find(selectors.img)
                            .attr("src") +
                        ")"
                    );
                    selectors.item.last().addClass(selectors.activeClass);
                } else if (pos <= max - 40 && pos >= min) {
                    selectors.id.css(
                        "background-image",
                        "url(" +
                        $(this)
                            .find(selectors.img)
                            .attr("src") +
                        ")"
                    );
                    selectors.item.removeClass(selectors.activeClass);
                    $(this).addClass(selectors.activeClass);
                }
            });
        });
    };
})(jQuery);

$("#timeline-1").timeline();
