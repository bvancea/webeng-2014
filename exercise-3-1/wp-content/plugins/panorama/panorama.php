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

function panorama_image($small_image) {
    $output = '<div id="panorama-div" class="hotel-suggestion-images" >';
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