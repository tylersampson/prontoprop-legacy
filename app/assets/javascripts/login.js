var Login = function() {

    return {
        //main function to initiate the module
        init: function() {
            if ($('.login-bg').length > 0) {
              // init background slide images
              $('.login-bg').backstretch($('.login-bg').data('images'), {
                    fade: 1000,
                    duration: 6000
                  }
              );
            }
        }

    };

}();

jQuery(document).ready(function() {
    Login.init();
});

jQuery(document).on('page:load', function() {
    Login.init();
});