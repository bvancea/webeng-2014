<header>
    <h3>Meet our reviewers!</h3>
</header>
<?php
    $loop = new WP_Query(
        array(
            'post_type' => 'reviewer',
            'posts_per_page' => 2,
            'meta_key' => 'reviewer_relevance',
            'orderby' => 'meta_value',
            'order' => 'ASC'
        )
    );

    while ($loop->have_posts()):
        $loop->the_post();
?>

    <div class="reviewer-right">
        <?php the_post_thumbnail('full') ?>
        <span><?php the_title() ?></span>
        <div>
            <?php the_terms(get_the_ID(), 'reviewer_category') ?>
        </div>
    </div>
<?php
    endwhile;
?>
<footer>
    <a href="#">Meet them all!</a>
</footer>
