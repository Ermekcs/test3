
<?php require_once './templates/header.tpl'; ?>

<script type="text/javascript">
  $(document).ready(function() {
    var list_delay = 2000;
    var $lists = $('.home-widgets ul');
    var groups_count = $lists.length;

    for (var i = 0; i < $($lists[groups_count - 1]).find('li').length; i++) {
      for (var j = 0; j < groups_count; j++) {
        try {
          var $player = $($lists[j]).find('li')[i];
        } catch (e) {
          var $player = false;
        }

        if (!$player) {
          continue;
        }

        bindAnimation($player, list_delay);
        list_delay += 700;
      }
    }

    $('#tt_champ_btn').animate({'opacity': 0.3}, list_delay, function() {
      $('#tt_champ_btn').animate({'opacity': 1, 'cursor': 'pointer'}, 1000);
    });
  });

  function bindAnimation($player, list_delay) {
    window.setTimeout(function() {
      $($player).find('label').animate({'opacity': 1, 'queue': true});
    }, list_delay);
  }
</script>

<div id="featured" class="grid col-940">
  <h1 class="featured-title">Tournament # <?php echo $new_champ_num?></h1>
</div><!-- end of #featured -->

<div id="widgets" class="home-widgets">

  <?php foreach ($group_players as $group_num => $players) : ?>
  <div class="grid col-220 <?php echo (($group_num % 4) === 0) ? 'fit' : ''; ?>">
    <div class="widget-wrapper">
      <div class="widget-title-home"><h3>Group - <?php echo champ::get_group_sign($group_num); ?></h3></div>
      <div class="textwidget">
        <ul id="group_<?php echo $group_num; ?>">
          <?php foreach ($players as $player) : ?>
          <li class="player_list col-940 grid">
            <label id="player_<?php echo $player['player_id']; ?>" style="opacity: 0;"><?php echo $player['name']; ?></label>
          </li>
          <?php endforeach; ?>
        </ul>
      </div>
    </div><!-- end of .widget-wrapper -->
  </div><!-- end of .col-300 -->
  <?php endforeach; ?>

</div><!-- end of #widgets -->

<div id="featured" class="grid col-940" style="padding-bottom: 30px;">
  <br/>
  <div class="call-to-action">
    <input type="text" id="tmp_champ_name" name="tmp_champ_name" value="Tournament #<?php echo $new_champ_num; ?>"/>
    <br/>
    <br/>
    <a href="javascript://" id="tt_champ_btn" onclick="<?php if ($is_admin) : ?>$('#champ_name').val($('#tmp_champ_name').val()); $('#submit_form').trigger('click');<?php else : ?>alert('You are not a King! Fuck you!!!');<?php endif; ?>" class="blue button" style="opacity: 0; cursor: default;">Start a new Tournament</a>
    <form method="post" style="display: none;">
      <input type="hidden" id="champ_name" name="champ_name" value="Tournament #<?php echo $new_champ_num; ?>"/>
      <input type="hidden" name="groups" value='<?php echo json_encode($group_players); ?>'/>
      <button type="submit" name="action" value="save" style="display: none;" id="submit_form"/>
    </form>
  </div><!-- end of .call-to-action -->
</div><!-- end of #featured -->

<?php require_once './templates/footer.tpl'; ?>