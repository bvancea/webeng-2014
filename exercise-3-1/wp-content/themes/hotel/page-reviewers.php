<?php

get_header();
?>
<section id="container">

    <section id="col-left">
        <?php
        get_sidebar('left');
        ?>
    </section>

    <section id="col-center">
        <div class="orange-box">
            <div class="hotel-reviewers">
                <header>
                    <h1>Our reviewers </h1>
                </header>
                <?php
                $loop = new WP_Query(
                    array(
                        'post_type' => 'reviewer',
                        'posts_per_page' => -1,
                        'meta_key' => 'reviewer_relevance',
                        'orderby' => 'meta_value',
                        'order' => 'ASC'
                    )
                );
                $count = 0;
                while ( $loop->have_posts() ) : $loop->the_post();

                    ?>
                    <?php if ($count % 2 == 0): ?>
                    <div class="reviewers-group">
                    <?php endif; ?>
                        <article>
                            <?php the_post_thumbnail('thumbnail')?>
                            <span><?php the_title() ?></span>
                            <div class="reviewer-info">
                                <?php the_terms(get_the_ID(), 'reviewer_category', '<p>', '<br/>', '</p>') ?>

                                <?php echo get_post_meta(get_the_ID(), 'reviewer_quote', TRUE); ?>
                            </div>
                        </article>
                    <?php if ($count % 2 == 0): ?>
                    </div>
                    <?php endif; ?>
                <?php
                    $count += 1;
                endwhile;
                ?>
            </div>
        </div>
    </section>
    <section id="col-right">
        <?php
        get_sidebar('right-reviews');
        ?>
    </section>
</section>

<?php
get_footer();
?>
