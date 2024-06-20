<?php

namespace App\Http\Controllers;

use App\Blocks\BlocksRenderer;
use App\Models\Article;
use App\Models\Page;
use App\Models\Site;
use Illuminate\Http\Request;

final class SiteController extends Controller {
    protected Site $site;

    public function __construct() {
        $this->site = Site::getCurrentSite();
    }

    public function site() {
        return $this->site->toArray();
    }

    public function settings() {
        return $this->site->settings();
    }

    public function page(string $slug, Request $request) {
        $page = Page::getBySlug($this->site, $slug);
        $blocks = BlocksRenderer::renderBlocks($page, (bool) $request->get('demo'));

        return view('page', compact('page', 'blocks'));
    }

    public function articles() {
        return view('articles', ['articles' => $this->site->articles]);
    }

    public function article(string $slug) {
        $article = Article::getBySlug($this->site, $slug);

        return view('article', compact('article'));
    }

    public function home(Request $request) {
        $page   = $this->site->frontpage;
        $blocks = BlocksRenderer::renderBlocks($page, (bool) $request->get('demo'));

        return view('page', compact('page', 'blocks'));
    }
}
