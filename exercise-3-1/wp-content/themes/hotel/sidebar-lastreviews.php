<header>
    <h3>Our last reviews!</h3>
</header>
<?php
    $loop = new WP_Query(
        array(
            'post_type' => 'post',
            'posts_per_page' => 2,
            'orderby' => 'date', 
            'order' => 'DESC' 
        )
    );

    while ($loop->have_posts()):
        $loop->the_post();
?>
<div style="text-align: center">
        <?php the_post_thumbnail('full') ?>
        <span><?php echo get_split_title($post->ID); ?></span>
    </div>

<?php
    endwhile;
?>
