<?php
function register_my_menu() {
  register_nav_menu('header-menu',__( 'Header Menu' ));
}
add_action( 'init', 'register_my_menu' );

/**
 * Post thumbnails are only supported if this function is called explicitly
 */
add_theme_support( 'post-thumbnails' );

/**
 * Custom reviewer type
 *
 */
if (!function_exists('create_reviewer_post_type')):
    function create_reviewer_post_type() {
        $labels = array(
            'name' => __( 'Reviewer'),
            'singular_name' => __( 'Reviewer'),
            'menu_name' => __( 'Reviewer'),
            'add_new' => __( 'Add reviewer'),
            'all_items' => __('All reviewers'),
            'add_new_item' => __('Add reviewer'),
            'edit_item' => __('Edit reviewer'),
            'new_item' => __('New reviewer'),
            'view_item' => __('View reviewer'),
            'search_items' => __('Search reviewers'),
            'not_found' => __('No reviewers found'),
            'not_found_in_thrash' => __('No reviewers found in thrash'),
            'parent_item_colon' => __('Parent reviewer')
        );
        $args = array(
            'labels' => $labels,
            'public' => true,
            'publicly_queryable' => true,
            'show_in_nav_menus' => true,
            'query_var' => true,
            'rewrite' => true,
            'capability_type' => 'post',
            'hierarchical' => false,
            'supports' => array(
                'title',
                'thumbnail'
            ),
            'menu_position' => 5,
            'register_meta_box_cb' => 'add_viewer_post_type_metabox'
        );

        register_post_type( 'reviewer', $args);

        register_taxonomy( 'reviewer_category', 'reviewer', array(
            'hierarchical' => true,
            'label' => 'Reviewer Role'
        ));
    }

    function add_viewer_post_type_metabox() {
        add_meta_box('reviewer_metabox', 'Reviewer Data', 'reviewer_metabox', 'reviewer', 'normal');
    }

    function reviewer_metabox() {
        global $post;
        $custom = get_post_custom($post->ID);
        $quote = $custom['reviewer_quote'][0];
        $relevance = $custom['reviewer_relevance'][0]; ?>

        <div class="reviewer">
            <p>
                <label>Relevance</label> <br/>
                <select name="relevance">
                    <?php
                        for ($i = 1; $i <= 10; $i++) { ?>
                        <option value="<?php echo $i; ?>" <?php selected($relevance, $i)?>> <?php echo $i?></option>
                    <?php
                        }
                    ?>
                </select>
            </p>
            <p>
                <label>Quote</label> <br/>
                <textarea name="quote" cols="50" role="10"><?php echo $quote ; ?></textarea>
            </p>
        </div>
<?php
    }

    function reviewer_post_save_meta( $post_id, $post) {
        if (!current_user_can('edit_post', $post->ID) ) {
            return $post->ID;
        }

        $reviewer_post_meta['reviewer_quote'] = $_POST['quote'];
        $reviewer_post_meta['reviewer_relevance'] = $_POST['relevance'];

        foreach ($reviewer_post_meta as $key => $value) {
            if (get_post_meta( $post->ID, $key, FALSE)) {
                update_post_meta($post->ID, $key, $value);
            } else {
                add_post_meta( $post->ID, $key, $value);
            }
            if (!$value) {
                delete_post_meta( $post->ID, $key);
            }
        }
    }
    add_action('save_post', 'reviewer_post_save_meta', 1, 2);

    add_filter('manage_edit-reviewer_columns', 'reviewer_taxonomy_columns');
    function reviewer_taxonomy_columns($defaults) {
        unset($defaults['date']);
        return $defaults + array(
            'reviewer_relevance' => __('Relevance')
        );
    }
    add_action('manage_posts_custom_column', 'reviewer_custom_column', 10, 2);
    function reviewer_custom_column($column, $id) {
        switch($column) {
            case 'reviewer_relevance':
                $relevance = get_post_meta($id, 'reviewer_relevance', true);
                if(!empty($relevance)) {
                    echo esc_html($relevance);
                }
                break;
            default:
                break;
        }
    }

    add_action( 'init', 'create_reviewer_post_type');
endif;
