<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;

/**
 * Class Faq.
 *
 * @property string $question
 * @property string $answer
 * @property string $type
 */
final class Faq extends Model {
    protected $fillable = ['question', 'answer', 'type'];

    /**
     * @return Collection<Faq>|Faq[]
     */
    public static function getAllMapFaq(): Collection {
        return self::where('type', 'map')->get();
    }
}
