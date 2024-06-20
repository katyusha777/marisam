<?php

namespace App\Models;

use App\Models\Concerns\BelongsToSite;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * @property string              $title
 * @property string              $slug
 * @property Site                $site
 * @property Collection<Article> $articles
 */
final class Category extends Model {


    public function articles(): HasMany {
        return $this->hasMany(Article::class);
    }
}

