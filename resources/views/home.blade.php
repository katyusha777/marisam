@extends('app')

@section('body')
    <div class="relative h-screen">
        <video autoplay loop muted playsinline class="absolute inset-0 w-full h-full object-cover">
            <source src="/videos/home/video.mp4" type="video/mp4">
            <source src="/videos/home/video.webm" type="video/webm">
        </video>
        <div class="absolute inset-0 bg-black bg-opacity-30"></div>
        <div class="absolute bottom-10 left-10 text-white  font-bold "><span class="text-9xl block">Justice</span><span class="flood-std block text-7xl">No matter what</span></div>
    </div>

    <div class="container">
        <livewire:articles-grid :limit="5" />
       @php /**  <div id="app-stats"></div> */ @endphp
        @include('sections.quotes')
    </div>

    @php /**  <div id="app-gallery"></div> */ @endphp

@endsection
