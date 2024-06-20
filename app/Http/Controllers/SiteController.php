<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Page;

final class SiteController extends Controller {
    public function page(string $slug) {
        if ($page = Page::getBySlug($slug)) {
            return view('page', compact('page'));
        }

        return view('pages.'.$slug);
    }

    public function articles() {
        return view('articles', ['articles' => Article::all()]);
    }

    public function article(string $slug) {
        $article = Article::getBySlug($slug);

        return view('article', compact('article'));
    }

    public function home() {
        return view('home');
    }
}
