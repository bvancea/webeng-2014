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
			<?php
			while ( have_posts() ) : the_post();
				?>
				<article class="hotel-review">
					<h3><?php the_title(); ?></h3>
					<p><?php the_content('<br><span class="more">Read more...</span>'); ?></p>
					<aside class="reviewer">
						<a href="#"><?php the_time('M j') ?> by <?php the_author();?></a>
						<span><?php if(function_exists('the_views')) { the_views(); } ?></span>
					</aside>
				</article>
			<?php
			endwhile;
			?>
			<article class="previous-reviews">
				<?php posts_nav_link('','Next reviews...','Previous reviews...'); ?>
			</article>
		</div>
	</section>
	<section id="col-right">
		<?php
		get_sidebar('right');
		?>
	</section>
</section>

<?php
get_footer();
?>
