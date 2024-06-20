<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>@yield('title')</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/app.css?v={{md5(now())}}" rel="stylesheet"/>
    <link href="/styles.css?v={{md5(now())}}" rel="stylesheet"/>
    <link rel="stylesheet" href="{{ asset('vendor/laraberg/css/laraberg.css') }}">
</head>

@yield('body')

<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

</html>
