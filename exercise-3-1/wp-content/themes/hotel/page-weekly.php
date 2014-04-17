<?php

get_header();
?>
<section id="container">

	<section id="col-left">
		<?php get_sidebar('left'); ?>
	</section>

	<section id="col-center">
		<div class="orange-box">

            <?php
                $loop = new WP_Query(
                    array(
                        'tag' => 'winner',
                        'posts_per_page' => 1,
                        'orderby' => 'date',
                        'order' => 'DESC'
                    )
                );

                while ($loop->have_posts()):
                $loop->the_post();
            ?>
            <div class="hotel-suggestion">
                <article >
                    <header>
                        <h3>Location of the month</h3>
                    </header>
                    <div>
                        <?php
                        panorama_image();
                        ?>
                    </div>
                    <h3>And the winner is: <?php the_title()?></h3>
                    <?php the_content('<br><span class="more">Read more...</span>'); ?>
                    <aside class="reviewer">
                        <a href="#"><?php the_time('M j') ?> by <?php the_author();?></a>
                        <span><?php if(function_exists('the_views')) { the_views(); } ?></span>
                    </aside>
            </div>
            <?php
                endwhile;
            ?>
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
