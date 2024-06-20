@php use Illuminate\Support\Facades\Storage; @endphp
@extends('theme')

@section('content')
    @if(!$page->is_frontpage)
        <div class="bg-white px-6 py-12 lg:px-8">
            <div class="mx-auto max-w-3xl text-base leading-7 text-gray-700">
                @if($page->header_image && strlen($page->header_image) > 10) <div class="mb-12"><img class="aspect-[2/1] w-full mb-4 flex-none rounded-2xl object-cover" src="{{Storage::url($page->header_image)}}" alt=""></div> @endif
                <h1 class="mt-2 mb-8 text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">{{$page->title}}</h1>
                {!! $page->render() !!}
            </div>
        </div>
    @endif

    {!! $blocks !!}
@endsection
