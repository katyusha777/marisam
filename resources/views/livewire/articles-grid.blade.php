<section>
    <h1 class="text-6xl mt-12 mb-12">News</h1>
    <div class="line mt-8"></div>

    <div class="py-12">
        <div class="md:flex block justify-center mb-12">
            <button
                    wire:click="selectCategory('Latest')"
                    class="uppercase text-lg md:text-xl md:inline block md:mb-0 mb-6  border-b-2 mx-2 md:mx-12 text-center {{ $selectedCategory === 'Latest' ? ' border-indigo-500' : 'border-transparent' }}">
                Latest
            </button>
            @foreach ($categories as $category)
                <button
                        wire:click="selectCategory('{{ $category->title }}')"
                        class="uppercase text-lg md:text-xl md:inline block md:mb-0 mb-6  border-b-2 mx-2 md:mx-12 text-center {{ $selectedCategory === $category->title ? ' border-indigo-500' : 'border-transparent' }}">
                    {{ $category->title }}
                </button>
            @endforeach
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
            @foreach ($articles as $article)
                <div class="article-item">
                    <div class="line "></div>
                    <div class="hidden h-56 overflow-hidden  justify-center items-center bg-center bg-cover" style="background-image: url('{{ $article->image_url }}')">
                    </div>
                    <h5 class="mt-6">{{ $article->category->title }}</h5>
                    <a class="text-2xl text-white" href="{{ $article->url }}">{{ $article->title }}</a>
                </div>
            @endforeach
        </div>
    </div>

</section>
