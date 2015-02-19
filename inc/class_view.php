<?php
/**
 * Created by JetBrains PhpStorm.
 * User: eldargaliev
 * Date: 8/17/12
 * Time: 11:53 PM
 * To change this template use File | Settings | File Templates.
 */
class view
{
  public function assign($key, $value)
  {
    $this->$key = $value;
  }

  public function render($tpl)
  {
    include './templates/' . $tpl . '.tpl';
  }

  public function helper_medal($medal, $count = 1)
  {
    $medal_str = '<img src="static_files/' . $medal . '.png" title="' . $medal . '" style="height: 20px;"/>';

    return str_repeat($medal_str, $count);
  }

  public function helper_player($player, $params = array())
  {
    if (is_array($player) && isset($player['player_id']) && $player['player_id'] && isset($player['name']) && $player['name']  ) {
      $player_id = $player['player_id'];
      $player_name = $player['name'];
    } elseif (is_array($player) && isset($player['player_id']) && $player['player_id']) {
      $player_id = $player['player_id'];
      $player = champ::find_player($player_id);
      $player_name = (isset($player['name']) && $player['name']) ? $player['name'] : '';
    } else {
      $player_id = $player;
      $player = champ::find_player($player_id);
      $player_name = (isset($player['name']) && $player['name']) ? $player['name'] : '';
    }

    if (!isset($params['href'])) {
      $params['href'] = 'player.php?player_id=' . $player_id;
    }

    $params_str = '';
    foreach ($params as $key => $value) {
      $params_str .= ' ' . $key . '="' . $value . '" ';
    }

    $user_str = '<a ' . $params_str . ' >' . $player_name . '</a>';

    return $user_str;
  }
}
