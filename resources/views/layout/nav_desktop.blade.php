@php use App\Views\ViewSupport; @endphp
@php
    $menuItems = ViewSupport::getMenuItems();
@endphp
<section class="hidden md:block">
    <div class="bg-black  flex justify-between uppercase text-white">
        <div class="py-2 px-4">
            <a href="/" class="mr-4">NPPC</a>
            <a href="/donate">Donate</a>
        </div>
        <div>
            <a class="bg-indigo-700 block h-12 leading-10 px-8" href="/contact">Contact Us</a>
        </div>
    </div>

    <header class="globalNav noDropdownTransition">
        <div class="container-lg">
            <ul class="navRoot">

                <li class="navSection logo">
                    <a class="rootLink item-home colorize" href="/">
                        <h1>
                            <img id="headLogo" src="/logo.svg">
                        </h1>
                    </a>
                </li>

                <li class="navSection primary">
                    @foreach($menuItems as $item)
                        <a class="rootLink @if($item->children) hasDropdown @endif colorize" href="{{$item->href}}" @if($item->children) data-dropdown="{{$item->slug}}" @endif>{{$item->title}}</a>
                    @endforeach
                    <a class="rootLink item-support colorize btn" id="donateBtn" href="/donate">Donate</a>
                </li>

                <li class="navSection secondary" style="display: none;">
                    <a class="rootLink item-support colorize btn" id="donateBtn" href="/donate">Donate</a>
                </li>


            </ul>
        </div>

        <div class="dropdownRoot">
            <div class="dropdownBackground" style="transform: translateX(331px) scaleX(0.467308) scaleY(0.8);">
                <div class="alternateBackground" style="transform: translateY(400px);"></div>
            </div>
            <div class="dropdownArrow" style="transform: translateX(453px) rotate(45deg);"></div>
            <div class="dropdownContainer" style="transform: translateX(331px); width: 243px; height: 320px;">

                @foreach($menuItems as $item)
                    @if($item->children)
                        <div class="dropdownSection active" data-dropdown="{{$item->slug}}">
                            <div class="dropdownContent">
                                <ul class="linkGroup linkList aboutGroup">

                                    @foreach($item->children as $child)
                                        <li>
                                            <a class="linkContainer" href="{{$child->href}}">
                                                <h3 class="linkTitle">{{$child->title}}</h3>
                                            </a>
                                        </li>
                                    @endforeach


                                </ul>
                            </div>
                        </div>
                    @endif
                @endforeach

            </div>
        </div>
    </header>
</section>
