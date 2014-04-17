<header>
    <h3>Weekly Location Contest</h3>
</header>
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
    <div style="text-align: center">
        <?php the_post_thumbnail('full') ?>
    </div>
    <div>
        This week's location is:<br>
        <span><?php the_title()?></span>
    </div>
    <footer>
        <a href="<?php the_permalink()?>">Have a look!</a>
    </footer>

<?php
endwhile;
?>
