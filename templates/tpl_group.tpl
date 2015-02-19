<?php
    $group_id = $this->group['group_id'];
    $group = $this->group;
?>
<table style="margin: auto;" class="champ_tbl">
  <thead>
  <tr><td colspan="<?php echo 8 + count($this->group_players[$group_id]); ?>" style="border-right-style: none;"><h3 style="margin: 0px; font-size: 15px;">Group <?php echo $group['title'] ?></h3></td><td><img title="refresh" id="refresh_<?php echo $group_id; ?>" class="refresh_btn" src="static_files/refresh.png"/></td></tr>
  <tr>
    <th class="label">Player</th>
    <?php foreach ($this->group_players[$group_id] as $num => $g_player) : ?>
    <th class="td_game"><?php echo $num + 1; ?></th>
    <?php endforeach; ?>
    <th title="Won">W</th>
    <th title="Draw">D</th>
    <th title="Lost">L</th>
    <th title="Goal For">GF</th>
    <th title="Goal Against">GA</th>
    <th title="Goal Difference">GD</th>
    <th title="Points">Pts</th>
    <th title="Position">Pos</th>
  </tr>
  </thead>
  <tbody>
  <?php foreach ($this->group_players[$group_id] as $num => $g_player) : ?>
  <tr>
    <td class="label <?php echo ($g_player['qualified'] == 1) ? 'group_qualified' : '' ?>"><?php echo $this->players[$g_player['player_id']]['name']; ?></td>
    <?php foreach ($this->group_players[$group_id] as $num2 => $pls) : ?>
    <?php if ($num == $num2) : ?>
      <td class="td_game" style="background-color: #EFEFEF;"></td>
      <?php else : ?>
      <?php $result = champ::get_game_result($group_id, $g_player['player_id'], $pls['player_id']); ?>
      <td class="td_game <?php echo ($result == 11) ? 'winner' : ''; ?>"><?php echo $result; ?></td>
      <?php endif; ?>
    <?php endforeach; ?>
    <td><?php echo $g_player['won']; ?></td>
    <td><?php echo $g_player['draw']; ?></td>
    <td><?php echo $g_player['lost']; ?></td>
    <td><?php echo $g_player['goal_for']; ?></td>
    <td><?php echo $g_player['goal_against']; ?></td>
    <td><?php echo $g_player['goal_for'] - $g_player['goal_against']; ?></td>
    <td><?php echo $g_player['points']; ?></td>
    <td><?php echo $g_player['position']; ?></td>
  </tr>
    <?php endforeach; ?>
  </tbody>
</table>