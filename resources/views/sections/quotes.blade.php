<!-- resources/views/components/quotes.blade.php -->
<div id="app-quotes" style="min-height: 400px;" class="relative">
    @foreach(App\Models\Quote::all() as $quote)
        <article class="testimonial hidden" style="margin-bottom:0;border-radius:0; position: absolute; top: 0; left: 0; right: 0;">
            <div class="inner flex items-center">
                <div class="photo">
                    <img src="/storage/{{ $quote->author_image }}" width="300" height="300" alt="Image alt text" loading="lazy">
                </div>
                <div class="text ml-4">
                    <p>{{ $quote->text }}</p>
                    <cite>- {{ $quote->author_name }}</cite>
                </div>
            </div>
        </article>
    @endforeach
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const quotes = document.querySelectorAll('.testimonial');
        let index = 0;

        function fadeOut(element) {
            let opacity = 1;
            const fade = setInterval(function () {
                if (opacity <= 0) {
                    clearInterval(fade);
                    element.classList.add('hidden');
                }
                element.style.opacity = opacity;
                opacity -= 0.1;
            }, 50);
        }

        function fadeIn(element) {
            let opacity = 0;
            element.classList.remove('hidden');
            const fade = setInterval(function () {
                if (opacity >= 1) {
                    clearInterval(fade);
                }
                element.style.opacity = opacity;
                opacity += 0.1;
            }, 50);
        }

        function showNextQuote() {
            if (quotes.length > 0) {
                fadeOut(quotes[index]);
                index = (index + 1) % quotes.length;
                fadeIn(quotes[index]);
            }
            setTimeout(showNextQuote, 3000);
        }

        // Initial setup to ensure all quotes are hidden and the first one is visible
        quotes.forEach((quote, i) => {
            quote.style.opacity = 0;
        });
        fadeIn(quotes[index]);

        showNextQuote();
    });
</script>
