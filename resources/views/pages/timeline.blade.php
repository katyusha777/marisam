@php use App\Models\Timeline; @endphp
@php
/** @var Timeline[] $timelines */
@endphp

@extends('app')

@section('body')
    <div class="timeline-container" id="timeline-1">
        <div class="timeline-header hidden">
            <h2 class="timeline-header__title">Mustafa Kemal Atatürk</h2>
            <h3 class="timeline-header__subtitle">FATHER OF THE TURKS</h3>
        </div>
        <div class="timeline">
            @foreach($timelines as $timeline)
                <div class="timeline-item" data-text="{{$timeline->title}}">
                    <div class="timeline__content"><img class="timeline__img" src="/storage/{{$timeline->image}}"/>
                        <h2 class="timeline__content-title">{{$timeline->year}}</h2>
                        <p class="timeline__content-desc">{{$timeline->text}}</p>
                    </div>
                </div>
            @endforeach
        </div>
    </div>

@endsection

