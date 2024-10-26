<?php

use App\Http\Controllers\SiteController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('dev', fn () => Auth::user());
Route::controller(SiteController::class)
    ->group(function () {
        Route::get('/', 'home')->name('home');
        Route::get('/site', 'site');
        Route::get('/settings', 'settings');
        Route::get('/news/{slug}', 'article');
        Route::get('history', 'timeline');
        Route::get('annual-report', 'annualReport');
        Route::get('map', 'map');
        Route::get('faq', 'faq');
        Route::get('/{slug}', 'page');
    });
