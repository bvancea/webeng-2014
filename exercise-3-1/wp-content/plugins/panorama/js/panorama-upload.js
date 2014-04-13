jQuery(document).ready(function($) {
    $('#upload_panorama_button').click(function() {
        tb_show('Upload a panorama', 'media-upload.php?referer=panorama/panorama.php&type=image&TB_iframe=true&post_id=0', false);
        return false;
    });

    window.send_to_editor = function(html) {
        var image_url = $('img',html).attr('src');
        $('#panorama_url').val(image_url);
        tb_remove();

        $('#upload_panorama_preview img').attr('src',image_url);
    }
});

