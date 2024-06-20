<?php

namespace App\Blocks;

use App\Blocks\DTOs\ContentDTO;
use App\Blocks\DTOs\CtaWithImageTilesDTO;
use App\Blocks\DTOs\DescriptionListDTO;
use App\Blocks\DTOs\FaqDTO;
use App\Blocks\DTOs\FeaturesDTO;
use App\Blocks\DTOs\HeroSplitWithImageDTO;
use App\Blocks\DTOs\HeroWithImageTilesDTO;
use App\Blocks\DTOs\ImageTextGrid;
use App\Blocks\DTOs\IncentivesDTO;
use App\Blocks\DTOs\StatsDTO;
use App\Blocks\DTOs\TeamDTO;
use App\Blocks\DTOs\TestimonialsDTO;
use App\Blocks\DTOs\TextWithImage;
use Whitecube\NovaFlexibleContent\Flexible;

abstract class Blocks {
    public static function renderNovaBlocksFlexible(): Flexible {
        return Flexible::make('Blocks', 'blocks')
            ->addLayout('TextWithImage', TextWithImage::class, TextWithImage::novaFields())
            ->addLayout('ImageTextGrid', ImageTextGrid::class, ImageTextGrid::novaFields())
            ->addLayout('ContentDTO', ContentDTO::class, ContentDTO::novaFields())
            ->addLayout('CtaWithImageTilesDTO', CtaWithImageTilesDTO::class, CtaWithImageTilesDTO::novaFields())
            ->addLayout('DescriptionListDTO', DescriptionListDTO::class, DescriptionListDTO::novaFields())
            ->addLayout('FaqDTO', FaqDTO::class, FaqDTO::novaFields())
            ->addLayout('FeaturesDTO', FeaturesDTO::class, FeaturesDTO::novaFields())
            ->addLayout('HeroSplitWithImageDTO', HeroSplitWithImageDTO::class, HeroSplitWithImageDTO::novaFields())
            ->addLayout('HeroWithImageTilesDTO', HeroWithImageTilesDTO::class, HeroWithImageTilesDTO::novaFields())
            ->addLayout('IncentivesDTO', IncentivesDTO::class, IncentivesDTO::novaFields())
            ->addLayout('StatsDTO', StatsDTO::class, StatsDTO::novaFields())
            ->addLayout('TeamDTO', TeamDTO::class, TeamDTO::novaFields())
            ->addLayout('TestimonialsDTO', TestimonialsDTO::class, TestimonialsDTO::novaFields())
        ;
    }
}
