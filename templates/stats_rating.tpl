<h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;">Ratings</h1>
<p></p>


<div style="margin-left: 30px;">
  <div>
    <table style="margin: auto; width: 80%;" class="champ_tbl">
      <thead>
      <tr><td colspan="9">
        <a href="javascript://" style="cursor: pointer; float: right" onclick="$('.stat_rank_up,.stat_rank_down').toggleClass('display_none');">details</a>
        <h3 style="margin: 0px; font-size: 15px;">All players</h3></td></tr>
      <tr>
        <th class="label">Player</th>
        <?php foreach ($this->champ_stats as $key => $champ_players) : ?>
        <th title="tournament">#<?php echo $key; ?></th>
        <?php endforeach; ?>
        <th title="Total">Total</th>
        <th title="Position">Pos</th>
      </tr>
      </thead>
      <tbody>
      <?php $pos = 1; ?>
      <?php foreach ($this->total as $player_id => $point) : ?>
      <tr>
        <td class="label"><?php echo $this->helper_player($this->players[$player_id]); ?></td>
        <?php foreach ($this->champ_stats as $key => $champ_players) : ?>
        <td>
          <?php echo (int)$champ_players[$player_id]; ?>
          <?php
            $rank = isset($this->ranks_history[$key][$player_id]) ? $this->ranks_history[$key][$player_id] : false;
            echo ($rank) ? '<span class="display_none stat_rank_' . $rank['status'] . '">'. ($rank['status'] == 'up' ? '⇧' : '⇩') . $rank['rank'] . '</span>' : '';
          ?>
        </td>
        <?php endforeach; ?>
        <td><?php echo (int)$point; ?></td>
        <td><?php echo $pos++; ?></td>
      </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>

<br/>