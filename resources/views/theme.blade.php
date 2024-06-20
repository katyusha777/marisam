@php
    use App\Models\Site;
    $site = Site::getCurrentSite();
    $settings = $site->settings();
@endphp

@extends('app')

@section('body')
    <body class="flex h-full flex-col">
    <header>
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
           @include('layout.nav', ['settings'=>$settings])
        </div>
    </header>
    <main>
        @yield('content')
    </main>

    @include('layout.footer')
    </body>
@endsection
