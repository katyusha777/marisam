@php use App\Models\Article; @endphp
@php
    /**
     * @var Article $article
     */
@endphp
@extends('theme')

@section('content')

{{$article->body}}
@endsection
