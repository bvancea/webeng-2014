<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php bloginfo( 'title' ); ?></title>
    <link rel="stylesheet" href="<?php bloginfo( 'stylesheet_url' ); ?>" type="text/css" />
    <link href="css/jquery.multitouch.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/jquery.multitouch.js"></script>
    <script src="scripts/navigation.js"></script>
    <script>setNavigationOrder('weekly.html', 'reviewers.html');</script>
    <?php wp_head(); ?>
</head>
<body>

    <section id="content">
        <header id="header">
            <h1 class="title-top">
                <a href="#"><?php bloginfo( 'title' ); ?></a>
            </h1>
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
                    'walker'          => ''
                );
                
                wp_nav_menu( $defaults );
                
            ?>
            <br>
        </header>
