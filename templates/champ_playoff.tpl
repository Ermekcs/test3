
<?php require_once './templates/header.tpl'; ?>

<div id="featured" class="grid col-940">

  <h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;"><?php echo $this->champ_info['title']; ?> - Playoff</h1>
  <a style="float: right; margin-right: 30px;" href="champ.php?champ_id=<?php echo $this->champ_info['champ_id']; ?>">Go to Group Stage</a>
  <div class="clear"></div>

  <div>
  <?php foreach ($this->rounds as $groups) : ?>
    <div style="float : left; width: <?php echo round(100/count($this->rounds)) - 5; ?>%; margin-left: 4%;">
      <div><?php echo "1/" .  count($groups) . ' final'; ?></div>
      <div class="playoff_tbl">
        <?php foreach ($groups as $group_id => $group) : ?>
          <?php $game = $this->games[$group_id]; ?>
          <?php $winner1 = ($game['status'] && ($game['point1'] > $game['point2'] || $game['penalty1'] > $game['penalty2'])); ?>
          <?php $winner2 = ($game['status'] && !$winner1); ?>
          <?php $penalty = ($game['status'] && ($game['penalty1'] || $game['penalty1'] === 0)); ?>
          <table class="champ_game_tbl champ_game champ_group" id="group_<?php echo $group_id; ?>">
            <tr>
              <td colspan="2">Group - <?php echo $group['title'] ?><span class="extra <?php echo ($game['extra']) ? 'active' : ''?>" data-game_id="<?php echo $game['game_id'] ?>" >extra</span></td>
            </tr>
              <tr class="<?php echo ($winner1) ? 'winner' : '' ?>">
              <td class="label"><?php echo $this->players[$game['player1']]['name'] . (isset($this->clubs[$game['player1']]) ? ' (' . $this->clubs[$game['player1']] . ')' : ''); ?></td>
              <td>
                  <input type="text" class="game_point player1" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player1'];?>" value="<?php echo $game['point1']; ?>"/>
                  <input type="text" class="game_penalty penalty1" <?php if ($penalty) : ?>style="visibility: visible"<?php endif; ?> size="2" name="penalty_<?php echo $game['game_id'] . '_' . $game['player1'];?>" value="<?php echo $game['penalty1']; ?>"/>
              </td>
            </tr>
              <tr class="<?php echo ($winner2) ? 'winner' : '' ?>">
              <td class="label"><?php echo $this->players[$game['player2']]['name'] . (isset($this->clubs[$game['player2']]) ? ' (' . $this->clubs[$game['player2']] . ')' : ''); ?></td>
              <td>
                  <input type="text" class="game_point player2" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player2'];?>" value="<?php echo $game['point2']; ?>"/>
                  <input type="text" class="game_penalty penalty2" <?php if ($penalty) : ?>style="visibility: visible"<?php endif; ?> size="2" name="penalty_<?php echo $game['game_id'] . '_' . $game['player2'];?>" value="<?php echo $game['penalty2']; ?>"/>
              </td>
            </tr>
          </table>
        <?php endforeach; ?>
      </div>
    </div>
  <?php endforeach; ?>
  </div>

</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>