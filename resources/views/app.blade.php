@php
$isHome = request()->segment(1) == ''
@endphp
<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>@yield('title')</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/app.css?v={{md5(now())}}" rel="stylesheet"/>
    <link href="/styles.css?v={{md5(now())}}" rel="stylesheet"/>
    <link href="/fonts/verlag/stylesheet.css" rel="stylesheet"/>
    <link href="/fonts/verlag/stylesheet.css" rel="stylesheet"/>
    <link href="/fonts/flood-std.css" rel="stylesheet"/>
    <link href="/style/nav.css" rel="stylesheet"/>
    <link href="/style/basics.css" rel="stylesheet"/>
    <link href="/style/scss/app.css" rel="stylesheet"/>
    <link rel="stylesheet" href="{{ asset('vendor/laraberg/css/laraberg.css') }}">
    @livewireStyles

    <link rel="stylesheet" href="/vue/app.css">


    <script src="/vue/app.js" defer></script>
    <style>
        .grid {
            width:100%
        }

        #vueApp {
            max-width: 920px;
            margin: auto;
        }

        #vueApp.unset-width {
            max-width: unset;
        }

        #vueApp .carousel-slide .meta h2 {
            font-size: 18px;
            text-shadow: 0 0 BLACK;
        }

        .prisoner .info {
            margin-left: 0 !important;

        }

        .prisoner .text-left p {
            font-size: 16px;
            line-height: 23px;
            margin-bottom: 20px;
        }

        .prisoner .image img {
            width: 100%;
            height: auto;
        }

        .ant-select-dropdown {
            z-index: 99999;
        }

        #filters .ant-select-selector .ant-select-selection-search-input {
            border:none;
            outline:none;
        }

        #filters, .prisoner {
            width:unset !important;
        }
    </style>
</head>
<body @if ($isHome) class="home-page" @endif>

@include('layout.nav_desktop')
@include('layout.nav_mobile')

@if($isHome)
    @yield('body')
@else
    <main class="container">
        @yield('body')
    </main>
@endif

<div id="scrollTop" style="z-index: 2147483647; opacity: 1;">
    <svg
            fill="#000000"
            height="800px"
            width="800px"
            version="1.1"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 330 330"
            xml:space="preserve"
    >
        <path id="XMLID_224_" d="M325.606,229.393l-150.004-150C172.79,76.58,168.974,75,164.996,75c-3.979,0-7.794,1.581-10.607,4.394
	l-149.996,150c-5.858,5.858-5.858,15.355,0,21.213c5.857,5.857,15.355,5.858,21.213,0l139.39-139.393l139.397,139.393
	C307.322,253.536,311.161,255,315,255c3.839,0,7.678-1.464,10.607-4.394C331.464,244.748,331.464,235.251,325.606,229.393z"/>
    </svg>
</div>
<script>
    document.querySelector('#scrollTop').addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>
@include('layout.footer')

<script src="/js/nav.js"></script>
@livewireScripts
</body>

</html>
