<h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;">Medals</h1>
<p></p>

<div style="margin-left: 30px;">
  <div>
    <table style="margin: auto; width: 80%;" class="champ_tbl">
      <thead>
      <tr><td colspan="8"><h3 style="margin: 0px; font-size: 15px;">Players</h3></td></tr>
      <tr>
        <th class="label">Player</th>
        <th title="Medals">Medals</th>
        <th title="Rank">Rank</th>
      </tr>
      </thead>
      <tbody>
      <?php $pos = 1; ?>
      <?php foreach ($this->player_list as $player_id => $points) : ?>
        <?php
            $medals = $this->medals[$player_id];
        ?>
        <tr>
          <td class="label"><?php echo $this->helper_player($this->players[$player_id]); ?></td>
          <td style="text-align: left">
            <?php echo isset($medals['gold']) ? $this->helper_medal('gold', $medals['gold']) : ''; ?>
            <?php echo isset($medals['silver']) ? $this->helper_medal('silver', $medals['silver']) : ''; ?>
            <?php echo isset($medals['bronze']) ? $this->helper_medal('bronze', $medals['bronze']) : ''; ?>
          </td>
          <td><?php echo $pos++; ?></td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>

<br/>