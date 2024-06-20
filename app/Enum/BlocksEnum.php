<?php

namespace App\Enum;

enum BlocksEnum: string {
    case HeroSplitWithImages = 'heroes.split_with_image';
    case HeroWithImageTiles  = 'heroes.with_image_tiles';
    case AlertBanner         = 'alert_banner';
    case Team                = 'team';
    case Testimonials        = 'testimonials';
    case Content             = 'content';
    case Stats               = 'stats';
    case ImageTextGrid       = 'image_text_grid';
    case Incentives          = 'incentives';
    case PricingSimple       = 'pricing.simple';
    case PricingTiers        = 'pricing.tiers';
    case DescriptionList     = 'description_list';
    case Features            = 'features';
    case CtaWithImageTiles   = 'cta_with_image_tiles';
    case Logos               = 'logos';
    case Faq                 = 'faq';
}
