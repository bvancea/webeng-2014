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
				<div class="hotel-suggestion">
					<article >
						<header>
					        <h3><?php the_title(); ?></h3>
						</header>
						<div>
							<div id="panorama-div" class="hotel-suggestion-images" >
							</div>
							<div id="small-image-wrapper" class="hotel-suggestion-images">
								<div>
									<span id="black-frame-container">
										<canvas id="black-frame"></canvas>
									</span>
									<img id="small-image"  src='<?php echo bloginfo('template_directory');?>/images/sydney-harbour-panorama1bl-thumbnail.jpg'/>
								</div>
							</div>
							<?php the_content('<br><span class="more">Read more...</span>'); ?>
							<aside class="reviewer">
								<a href="#"><?php the_time('M j') ?> by <?php the_author();?></a>
								<span><?php if(function_exists('the_views')) { the_views(); } ?></span>
							</aside>
						</div>
			        </article>
				</div>
			<?php
			endwhile;
			?>
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
