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
                <h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
                <?php
                    
                    if ( has_post_thumbnail()) {
                      $large_image_url = wp_get_attachment_image_src( get_post_thumbnail_id(), 'large');
                      echo '<a href="' . $large_image_url[0] . '" title="' . the_title_attribute('echo=0') . '" >';
                      the_post_thumbnail('full',array('class' => 'hotel-review'));
                      echo '</a>';
                    }
                ?>
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
