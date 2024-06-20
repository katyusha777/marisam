<?php

use App\Http\Controllers\SiteController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('dev', fn () => Auth::user());
Route::controller(SiteController::class)
    ->group(function () {
        Route::get('/', 'home');
        Route::get('/site', 'site');
        Route::get('/settings', 'settings');
        Route::get('/articles/{slug}', 'article');
        Route::get('/articles/', 'articles');
        Route::get('/{slug}', 'page');
    });
