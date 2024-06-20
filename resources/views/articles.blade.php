@php use App\Models\Article; @endphp
@php
    /**
     * @var Article[] $articles
     */
@endphp
@extends('theme')

@section('content')
    <div class="bg-white py-24 sm:py-32">
        <div class="mx-auto max-w-7xl px-6 lg:px-8">
            <div class="mx-auto mt-16 grid max-w-2xl grid-cols-1 gap-x-8 gap-y-20 lg:mx-0 lg:max-w-none lg:grid-cols-3">
                @foreach($articles as $article)
                    <article class="flex flex-col items-start justify-between">
                        <div class="relative w-full">
                            <a href="{{$article->url}}"><img src="{{$article->image_url}}" alt="" class="aspect-[16/9] w-full rounded-2xl bg-gray-100 object-cover sm:aspect-[2/1] lg:aspect-[3/2]"></a>
                            <div class="absolute inset-0 rounded-2xl ring-1 ring-inset ring-gray-900/10"></div>
                        </div>
                        <div class="max-w-xl">
                            <div class="mt-8 flex items-center gap-x-4 text-xs">
                                <time datetime="2020-03-16" class="text-gray-500">{{$article->created_at->format('M d, Y')}}</time>
                                <a href="/articles/category/{{$article->category->slug}}" class="relative z-10 rounded-full bg-gray-50 px-3 py-1.5 font-medium text-gray-600 hover:bg-gray-100">{{$article->category->title}}</a>
                            </div>
                            <div class="group relative">
                                <h3 class="mt-3 text-lg font-semibold leading-6 text-gray-900 group-hover:text-gray-600">
                                    <a href="{{$article->url}}">{{$article->title}}</a>
                                </h3>
                                <p class="mt-5 line-clamp-3 text-sm leading-6 text-gray-600">{{$article->intro}}</p>
                            </div>
                        </div>
                    </article>
                @endforeach

                <!-- More posts... -->
            </div>
        </div>
    </div>

@endsection
