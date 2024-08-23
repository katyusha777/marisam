@php use App\Models\Faq; @endphp
<section id="map_faq">
    <div class="container">
        <h2 style="font-size: 2rem; font-weight: bold;">Frequently Asked Questions</h2>
        <div class="accordion">

            @foreach(Faq::getAllMapFaq() as $faq)
                <div class="accordion-item">
                    <button id="accordion-button-1" aria-expanded="false"><span class="accordion-title">{{$faq->question}}</span><span class="icon" aria-hidden="true"></span></button>
                    <div class="accordion-content">
                        <p>{{$faq->answer}}</p>
                    </div>
                </div>
            @endforeach
        </div>
    </div>
</section>


<script>
    const items = document.querySelectorAll(".accordion button");

    function toggleAccordion() {
        const itemToggle = this.getAttribute('aria-expanded');

        for (i = 0; i < items.length; i++) {
            items[i].setAttribute('aria-expanded', 'false');
        }

        if (itemToggle == 'false') {
            this.setAttribute('aria-expanded', 'true');
        }
    }

    items.forEach(item => item.addEventListener('click', toggleAccordion));
</script>
