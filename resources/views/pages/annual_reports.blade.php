@php
    use App\Models\AnnualReport;
    /** @var AnnualReport[] $reports */
@endphp

@extends('app')

@section('body')
    <main class="container">
        <div class="line mt-8"></div>
        <h1 class="text-6xl mt-12">Annual Reports</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">

            @foreach($reports as $report)
                <div class="article-item mb-6">
                    <a href="/storage/{{$report->file}}" class="h-[410px] rounded bg-no-repeat block overflow-hidden justify-center items-center bg-center bg-cover" style="background-image: url('/storage/{{$report->image}}')"></a>
                    <div class="line my-2"></div>
                    <a class="text-xl text-white text-center block" href="/storage/{{$report->file}}">{{$report->title}}</a>
                </div>
            @endforeach
        </div>
    </main>
@endsection
