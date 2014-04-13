<?php
/*
Plugin Name: Panorama
Plugin URI: http://localhost/hotel
Description: Contains the panorama image
Version: 1.00
Author: Bogdan Vancea, Alexandra Trif, Jakub Szymanek
Author URI: http://localhost/hotel
Text Domain: panorama
*/
if (isset($_POST['panorama_options'])) {
    update_option('panorama_options', $_POST['panorama_options']);
}

function panorama_image() {
	$small_image = get_option('panorama_options');
    $plugin_url = plugins_url();
    $output = "<script src=\"{$plugin_url}/panorama/js/jquery.multitouch.js\"></script>";
    $output .= "<script src=\"{$plugin_url}/panorama/js/script.js\"></script>";
    $output .= "<script src=\"{$plugin_url}/panorama/js/navigation.js\"></script>";
    $output .= "<div id=\"panorama-div\" class=\"hotel-suggestion-images\" style=\"background-image: url('".$small_image."')\">";
    $output .= '</div>';
    $output .= '<div id="small-image-wrapper" class="hotel-suggestion-images">';
    $output .= '<div>';
    $output .= '        <span id="black-frame-container">';
    $output .= '            <canvas id="black-frame"></canvas>';
    $output .= '        </span>';
    $output .= "<img id=\"small-image\"  src=\"{$small_image}\"/>";
    $output .= '</div>';
    $output .= '</div>';
    echo $output;
}

function panorama_plugin_activate() {
	//Activation code

	//set an option for the panorama image
	update_option('panorama_options', get_bloginfo('template_directory').'/images/sydney-harbour-panorama1bl-thumbnail.jpg');
}
register_activation_hook(__FILE__, 'panorama_plugin_activate');

//add a menu entry for the settings
add_action('admin_menu', 'panorama_create_settings_menu');

function panorama_register_settings() {
	register_setting(
		'panorama_options',
		'panorama_options'
	);
}
add_action('panorama_register_settings','panorama_register_settings');

function panorama_create_settings_menu() {
	//create custom top-level menu
	add_menu_page( 'Panorama Settings',
					'Panorama Settings',
					'manage_options',
                    __FILE__,
					'panorama_settings_page' );
}

function panorama_settings_page() {
	$panorama_options = get_option('panorama_options');
	?>
	<div class="wrap">
		<h2> Panorama Plugin Settings </h2>
		<form action="" method="post">
			<?php settings_fields('panorama_options'); ?>
			<input type="text" id="panorama_url" name='panorama_options' value="<?php echo esc_url( $panorama_options ); ?>" />
			<input id="upload_panorama_button" type="button" class="button" value="Choose a file..." />
			<span class="description">Upload an image for the panorama.</span>

			<div id="upload_panorama_preview" style="min-height: 100px;">
				<img style="max-width:100%;" src="<?php echo esc_url( $panorama_options ); ?>" />
			</div>

			<p class="submit">
				<input id="submit_options_form" type="submit" class="button-primary" value="Save Settings" />
			</p>

		</form>
	</div>
<?php
}

function panorama_options_enqueue_scripts() {
	wp_register_script( 'panorama-upload', plugins_url() .'/panorama/js/panorama-upload.js', array('jquery','media-upload','thickbox') );

	//if ( 'appearance_page_wptuts-settings' == get_current_screen() -> id ) {
		wp_enqueue_script('jquery');

		wp_enqueue_script('thickbox');
		wp_enqueue_style('thickbox');

		wp_enqueue_script('media-upload');
		wp_enqueue_script('panorama-upload');

	//}

}
add_action('admin_enqueue_scripts', 'panorama_options_enqueue_scripts');