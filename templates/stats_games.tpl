<h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;">Games</h1>
<p></p>


<div style="margin-left: 30px;">
  <div>
    <table style="margin: auto; width: 80%;" class="champ_tbl">
      <thead>
        <tr><td colspan="8"><h3 style="margin: 0px; font-size: 15px;">All players</h3></td></tr>
        <tr>
          <th class="label">Player</th>
          <th title="Won">W</th>
          <th title="Draw">D</th>
          <th title="Lost">L</th>
          <th title="Goal For">GF</th>
          <th title="Goal Against">GA</th>
          <th title="Goal Difference">GD</th>
          <th title="Position">Pos</th>
        </tr>
      </thead>
      <tbody>
      <?php $pos = 1; ?>
      <?php foreach ($this->player_stats as $player_id => $player) : ?>
        <tr>
          <td class="label"><?php echo $this->helper_player($this->players[$player_id]); ?></td>
          <td><?php echo $player['won']; ?></td>
          <td><?php echo $player['draw']; ?></td>
          <td><?php echo $player['lost']; ?></td>
          <td><?php echo $player['goal_for']; ?></td>
          <td><?php echo $player['goal_against']; ?></td>
          <td><?php echo $player['goal_for'] - $player['goal_against']; ?></td>
          <td><?php echo $pos++; ?></td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>

<br/>