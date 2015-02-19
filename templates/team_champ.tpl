
<?php require_once './templates/header.tpl'; ?>

<script type="text/javascript">
    champ.team_champ = true;
    champ.champ_id = <?php echo $this->champ_info['champ_id']; ?>;
</script>

<div id="featured" class="grid col-940 team_champ">

  <h1 class="featured-title" style="width: 90%; margin: auto; text-align: left; font-size: 30px;"><?php echo $this->champ_info['title']; ?></h1>
  <div class="clear"></div>

  <div style="padding: 5px; 30px;">
      <?php foreach ($this->teams as $team => $team_info) : ?>
      <div class="grid col-460 team_champ_box <?php echo ($team == 2) ? 'fit' : ''; ?>">
          <h3 style="margin: 0px; font-size: 20px; margin: 5px 20px;"><?php echo ucfirst(team_champ::get_team_title($team)); ?> Team</h3>
          <table style="width: 70%" class="champ_tbl">
              <thead>
              <tr>
                  <th title="Won">W</th>
                  <th title="Lost">L</th>
                  <th title="Goal For">GF</th>
                  <th title="Goal Against">GA</th>
                  <th title="Goal Difference">GD</th>
                  <th title="Points">Pts</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                  <td id="team_won_<?php echo $team; ?>"><?php echo $team_info['won']; ?></td>
                  <td id="team_lost_<?php echo $team; ?>"><?php echo $team_info['lost']; ?></td>
                  <td id="team_goal_for_<?php echo $team; ?>"><?php echo $team_info['goal_for']; ?></td>
                  <td id="team_goal_against_<?php echo $team; ?>"><?php echo $team_info['goal_against']; ?></td>
                  <td id="team_goal_dif_<?php echo $team; ?>"><?php echo $team_info['goal_for'] - $g_player['goal_against']; ?></td>
                  <td id="team_point_<?php echo $team; ?>"><?php echo $team_info['won']; ?></td>
              </tr>
              </tbody>
          </table>
          <?php /* ?>
          <h3 style="margin: 0px; font-size: 20px; margin: 5px 20px;">Players</h3>
          <ul>
              <?php foreach ($this->team_players[$team] as $player_id => $t_player): ?>
              <li class="">
                  <label id="player_<?php echo $player_id; ?>">
                      <?php echo $this->players[$player_id]['name']; ?>
                      <?php if ($t_player['leader']): ?><img class="team_leader" title="Team Leader" style="margin-bottom: -3px; height: 16px;;" src="static_files/icon_leader.png"/><?php endif; ?>
                      <?php if ($t_player['joker']): ?><img class="team_leader" title="Team Joker" style="margin-bottom: -3px; height: 16px;" src="static_files/icon_joker.png"/><?php endif; ?>
                  </label>
              </li>
              <?php endforeach; ?>
          </ul>
          <?php */ ?>
      </div>
      <?php endforeach; ?>
      <div style="clear: both"></div>
  </div>


  <div class="champ_games">
      <table style="margin: auto; width: 70%">
          <thead>
            <tr>
                <th colspan="2"><b>White Team</b></th>
                <th colspan="2"><b>Black Team</b></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($this->games as $game) : ?>
            <tr class="champ_game_tbl champ_game <?php echo ($game['partner1']) ? 'pair_game' : ''; ?>">
                <td class="label">
                    <?php echo $this->players[$game['player1']]['name'] ?>
                    <?php if ($game['partner1']) { echo ' / ' . $this->players[$game['partner1']]['name']; } ?>
                </td>
                <td class="<?php echo ($game['point1'] == 21 || $game['point1'] == 11) ? 'winner' : ''; ?>">
                    <input type="text" class="game_point player1" style="padding: 0; width: auto;" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player1'];?>" value="<?php echo $game['point1']; ?>"/>
                </td>
                <td class="<?php echo ($game['point2'] == 21 || $game['point2'] == 11) ? 'winner' : ''; ?>">
                    <input type="text" class="game_point player2" style="padding: 0; width: auto;" size="2" name="game_<?php echo $game['game_id'] . '_' . $game['player2'];?>" value="<?php echo $game['point2']; ?>"/>
                </td>
                <td class="label">
                    <?php echo $this->players[$game['player2']]['name'] ?>
                    <?php if ($game['partner2']) { echo ' / ' . $this->players[$game['partner2']]['name']; } ?>
                </td>
            </tr>
            <?php endforeach; ?>
          </tbody>
      </table>
  </div>

</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>