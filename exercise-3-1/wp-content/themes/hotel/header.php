<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php bloginfo( 'title' ); ?></title>
    <link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" />
    <link href="<?php bloginfo('template_directory');?>/css/jquery.multitouch.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery.js"></script>
    <script>setNavigationOrder('weekly.html', 'reviewers.html');</script>

	<?php
		$background_color = get_option('background_color');
		$box_color = get_option('box_color');
		$navigation_color = get_option('navigation_color');
		$navigation_border_color = get_option('navigation_border_color');
		$posts_color = get_option('posts_color');
		$title_color = get_option('title_color');
		$headlines_color = get_option('headlines_color');
		$text_color = get_option('text_color');
		$other_text_color = get_option('other_text_color');
	?>
	<style>
		body { background-color:  <?php echo $background_color; ?>; }
		.orange-box { background-color: <?php echo $box_color; ?>; }
		#nav-top li { background-color: <?php echo $navigation_color; ?>;
					  border-color: <?php echo $navigation_border_color; ?>; }
		.hotel-review, .previous-reviews, .hotel-reviewers, .hotel-suggestion, #menu-title
					{ background-color: <?php echo $posts_color; ?>; }
		#col-left a { border-bottom-color: <?php echo $posts_color; ?>; }
		.title-top a { color: <?php echo $title_color; ?>; }
		#col-center h3 { color: <?php echo $headlines_color; ?>; }
		#col-center, .more, .reviewer a, .previous-reviews a { color: <?php echo $text_color; ?> !important; }
		#col-left, #col-right, #col-left a, #col-right a, #nav-top a {color:  <?php echo $other_text_color; ?> }
	</style>

    <?php wp_head(); ?>
</head>
<body>

    <section id="content">
        <header id="header">
            <h1 class="title-top">
                <a href="#"><?php bloginfo( 'title' ); ?></a>
            </h1>
            <h2 class="title-top"><?php bloginfo( 'description' ); ?></h2>
	        <img src="<?php header_image(); ?>"
	             alt=""
		         id="header-image" />

            <?php       
                 $defaults = array(
                    'theme_location'  => 'header-menu',
                    'menu'            => 'header-menu',
                    'container'       => 'nav',
                    'container_class' => '',
                    'container_id'    => 'C',
                    'menu_class'      => '',
                    'menu_id'         => 'nav-top',
                    'echo'            => true,
                    'fallback_cb'     => 'wp_page_menu',
                    'before'          => '',
                    'after'           => '',
                    'link_before'     => '',
                    'link_after'      => '',
                    'items_wrap'      => '<ul id="%1$s" class="%2$s">%3$s</ul>',
                    'depth'           => 0,
                    'walker'          => '',
	                'show_home'       => 'Home'
                );
                
                wp_nav_menu( $defaults );
                
            ?>
            <br>
        </header>
