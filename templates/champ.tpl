
<?php require_once './templates/header.tpl'; ?>

<div id="featured" class="grid col-940">

  <h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;"><?php echo $this->champ_info['title']; ?> - Group Stage</h1>
  <a style="float: right; margin-right: 30px;" href="champ_playoff.php?champ_id=<?php echo $this->champ_info['champ_id']; ?>">Go to Playoff</a>
  <div class="clear"></div>


  <?php foreach ($this->groups as $group_id => $group) : ?>
  <div style="margin-left: 30px;" class="champ_group" id="group_<?php echo $group_id; ?>">
    <div class="grid col-540">
      <?php $this->group = $group; ?>
      <?php $this->render('tpl_group'); ?>
    </div>
    <div class="grid col-300 fit champ_games">
      <?php foreach ($this->games[$group_id] as $game) : ?>
      <div class="grid col-220">
        <table class="champ_game_tbl champ_game">
          <tr class="<?php echo ($game['point1'] > $game['point2']) ? 'winner' : (($game['status'] && $game['point1'] === $game['point2']) ? 'draw' : ''); ?>">
            <td class="label"><?php echo $this->players[$game['player1']]['name'] ?></td>
            <td><input type="text" class="game_point player1" style="padding: 0; width: auto;" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player1'];?>" value="<?php echo $game['point1']; ?>"/></td>
          </tr>
          <tr class="<?php echo ($game['point1'] < $game['point2']) ? 'winner' : (($game['status'] && $game['point1'] === $game['point2']) ? 'draw' : ''); ?>">
            <td class="label"><?php echo $this->players[$game['player2']]['name'] ?></td>
            <td><input type="text" class="game_point player2" style="padding: 0; width: auto;" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player2'];?>" value="<?php echo $game['point2']; ?>"/></td>
          </tr>
        </table>
      </div>
      <?php endforeach; ?>
    </div>
  </div>

  <br/>
  <?php endforeach; ?>
  <div></div>

</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>