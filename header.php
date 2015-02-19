<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Staff Hours Log
 * @copyright  Copyright Hire-Experts LLC
 * @license    http://www.hire-experts.com
 * @version    $Id: index.php 02.02.11 14:16 taalay $
 * @author     Taalay
 */

/**
 * @category   Application_Extensions
 * @package    Staff Hours Log
 * @copyright  Copyright Hire-Experts LLC
 * @license    http://www.hire-experts.com
 */
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>

  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>STAFF</title>
  <link rel="stylesheet" href="styles/style.css" media="screen">
  <link rel="stylesheet" href="styles/staff_client_styles.css" type="text/css">
  <link rel="stylesheet" href="styles/staff_area.css" type="text/css">
  <link rel="stylesheet" href="styles/staff.css" type="text/css">

  <script type="text/javascript" src="js/mootools.js"></script>

  <script type="text/javascript">

    var $refersh = null;
    var $current_staff_id = "<?=$current_staff['staff_id']?>";

    start_log = function(id) {
		new Ajax('ajax_request.php', {
			method : 'get',
			data : {
        'command' : 'start_dev_log',
        'staff_id' : id
      },
			onComplete : function(response) {
        response = Json.evaluate(response);
				if( response )
				{
          response = response + " - ";
          if($('my_stop_time_' + id)) {
            $('my_stop_time_' + id).style.display = "none";
            $('my_stop_time_' + id).disabled = false;
          }
					$('start_log_' + id).disabled = false;
					$('start_log_' + id).style.display = "none";
					$('stop_log_' + id).style.display = "";
          $('stop_time_' + id).style.display = "none";
					$('start_time_' + id).style.display = "";
					$('start_time_' + id).innerHTML = response.toString();
          auto_refresh(id);
				}
				else
				{
					alert("Failed... Please contact administrator.");
					location.reload();
				}
			}
		}).request();
	},

	stop_log = function(id) {
		new Ajax('ajax_request.php', {
			method : 'get',
			data : {
        'command' : 'stop_dev_log',
        'staff_id' : id
      },
			onComplete : function(response) {
				response = Json.evaluate(response);
				if( response )
				{
          if($('my_start_time_' + id)) {
            $('my_total_' + id).style.display = "none";
            $('my_start_time_' + id).style.display = "none";
          }
					$('stop_log_' + id).disabled = false;
					$('stop_log_' + id).style.display = "none";

          location.reload();
				}
				else
				{
					alert("Failed... Please contact administrator.");
					location.reload();
				}
			}
		}).request();
	},

  auto_refresh = function(id)
  {
    $refersh = setTimeout("refresh_result(" + id + ")", 60000);
  },

  refresh_result = function(id) {
    new Ajax('ajax_request.php', {
      method : 'post',
      data : {
        'command' : 'refresh_total',
        'staff_id' : id
      },
      onComplete : function(response) {
        response = Json.evaluate(response);
        if ( response )
        {
          if ($('start_log_' + id).style.display == "none") {
            if($('my_total_' + id)){
              $('my_total_' + id).style.display = "none";
            }
            $('total_' + id).style.display = "";
            $('total_' + id).innerHTML = 'total:' + response;
            window.clearTimeout($refersh);
            auto_refresh(id);
          }
        }
      }
    }).request();
  },

  window.addEvent('domready',function(){
    bind_full_day_checkbox($current_staff_id);
    auto_refresh($current_staff_id);
  });

	bind_full_day_checkbox = function(id) {

		var month_days = $$('.full_day_checkbox_' + id);

		if (month_days.length == 0 || $$('input[name="year"]').length == 0 || $$('input[name="month"]').length == 0) {
			return false;
		}

		var staff_year = $$('input[name="year"]')[0].getProperty('value');
		var staff_month = $$('input[name="month"]')[0].getProperty('value');
		var staff_id = id;

		month_days.addEvent('click', function()
		{
			var month_day = $(this).getProperty('id').substr(4);
			var result = $(this).checked ? 1 : 0;

			new Ajax('ajax_request.php', {
				method : 'get',
				data : {
					'command': 'set_part_time',
					'year': staff_year,
					'month': staff_month,
					'day': month_day,
					'full_day': result,
					'staff_id': staff_id,
					'no_cache': Math.random()
				},
				onComplete : function(response) {}
			}).request();
		});
	}
</script>
</head>
<body>