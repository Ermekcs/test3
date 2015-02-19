<?php

class team_champ
{
  const WHITE_TEAM = 1;
  const BLACK_TEAM = 2;

  const WHITE_TEAM_STR = 'white';
  const BLACK_TEAM_STR = 'black';

  public static $game_list = array();

  public static function draw_rand_teams($player_ids)
  {
    $count = count($player_ids);
    if ($count < 2) {
      return false;
    }

    $teams = self::get_rand_teams($player_ids);
    $team_details = self::get_member_titles($teams);

    return $team_details;
  }

  public static function get_rand_teams($player_ids)
  {
    $count = count($player_ids);
    $player_ids = self::sort_by_rating($player_ids);
    $first_count = (int)($count / 2);
    if ($first_count % 2 == 1) {
      $first_count--;
    }

    $second_basket = $player_ids;

    $first_basket = array();
    for ($i = 0; $i < $first_count; $i++) {
      $first_basket[] = array_shift($second_basket);
    }

    shuffle($first_basket);
    shuffle($second_basket);

    $team1 = rand(0, 1);
    $team2 = (int)($team1 != 1);
    $teams = array();
    while (count($first_basket) != 0 || count($second_basket) != 0) {
      if (count($first_basket) > 0) {
        $teams[$team1][] = array_shift($first_basket);
      }
      if (count($first_basket) > 0) {
        $teams[$team2][] = array_shift($first_basket);
      }

      if (count($second_basket) > 0) {
        $teams[$team1][] = array_shift($second_basket);
      }
      if (count($second_basket) > 0) {
        $teams[$team2][] = array_shift($second_basket);
      }
    }

    ksort($teams);

    return $teams;
  }

  public static function get_member_titles($teams)
  {
    $white_team = array_shift($teams);
    $black_team = array_shift($teams);
    shuffle($white_team);
    shuffle($black_team);

    $white_leader = 0;
    $black_leader = 0;
    $white_joker = 0;
    $black_joker = 0;

    if (count($white_team) == count($black_team) && count($white_team) % 2) {
      //black and white teams need jokers
      $white_joker = $white_team[rand(0, count($white_team) - 2)];
      $black_joker = $black_team[rand(0, count($black_team) - 2)];
    }
    elseif (count($white_team) < count($black_team) && count($white_team) % 2) {
      // white team need leader and joker
      $white_leader = $white_team[rand(0, count($white_team) - 1)];
      $white_joker = $white_team[rand(0, count($white_team) - 2)];
    }
    elseif (count($white_team) < count($black_team) && count($white_team) % 2 != 1) {
      // white team need leader and joker
      // black team need joker
      $white_leader = $white_team[rand(0, count($white_team) - 1)];
      $tmp = array_rand($white_team, 2);
      $white_joker = ($white_leader != $white_team[$tmp[0]]) ? $white_team[$tmp[0]] : $white_team[$tmp[1]];
      $black_joker = $black_team[rand(0, count($black_team) - 2)];
    }
    elseif (count($white_team) > count($black_team) && count($white_team) % 2) {
      // white team need joker
      // black team need leader and joker
      $white_joker = $white_team[rand(0, count($white_team) - 2)];
      $black_leader = $black_team[rand(0, count($black_team) - 1)];
      $black_joker = $black_team[rand(0, count($black_team) - 2)];
    }
    elseif (count($white_team) > count($black_team) && count($white_team) % 2 != 1) {
      // black team need leader and joker
      $black_leader = $black_team[rand(0, count($black_team) - 1)];
      $black_joker = $black_team[rand(0, count($black_team) - 2)];
    }

    $result = array(
      'white' => array('players' => $white_team, 'leader' => $white_leader, 'joker' => $white_joker),
      'black' => array('players' => $black_team, 'leader' => $black_leader, 'joker' => $black_joker),
    );

    return $result;
  }

  public static function sort_by_rating($player_ids = array())
  {
    $champ_stats = champ::stats_rating();
    $total = array();
    $exp = 2 * count($champ_stats);
    foreach ($champ_stats as $key => $player_stats) {
      foreach ($player_stats as $player_id => $point) {
        if (in_array($player_id, $player_ids)) {
          $total[$player_id] += $point + $point / pow(10, $exp);
        }
      }
      $exp -= 2;
    }

    arsort($total);
    $player_ids = array_keys($total);

    return $player_ids;
  }

  public static function get_new_champ_num()
  {
    $sql = "SELECT MAX(`champ_id`) FROM `team_champs`";
    $champ_id = he_database::fetch_field($sql);

    return intval($champ_id) + 1;
  }

  public static function new_champ($name)
  {
    $sql = he_database::placeholder("INSERT INTO `team_champs` (`title`, `start_date`) VALUES('?', NOW())", $name);
    he_database::query($sql);

    return he_database::insert_id();
  }

  public static function save_rand_teams($champ_id, $teams)
  {
    foreach ($teams as $team_name => $team_info) {
      $team_id = ($team_name == self::WHITE_TEAM_STR) ? self::WHITE_TEAM : self::BLACK_TEAM;
      $row = array(
        'champ_id' => $champ_id,
        'team' => $team_id
      );

      self::add_team($row);

      self::add_team_members($champ_id, $team_id, $team_info);
    }
  }

  public static function add_team($team_info)
  {
    $cols = array();
    foreach ($team_info as $field => $value) {
      $cols[] = he_database::placeholder("`{$field}` = '?'", $value);
    }

    $sql = "INSERT INTO `team_results` SET " . implode(', ', $cols);
    he_database::query($sql);
  }

  public static function add_team_members($champ_id, $team_id, $team_info)
  {
    $player_list = array();
    foreach ($team_info['players'] as $player_id) {
      $is_joker = (int)($player_id == $team_info['joker']);
      $is_leader = (int)($player_id == $team_info['leader']);
      $player_list[] = he_database::placeholder('(?, ?, ?, ?, ?)', $team_id, $champ_id, $player_id, $is_leader, $is_joker);
    }
    $players_str = implode(',', $player_list);

    $sql = "INSERT INTO `team_players` (`team`, `champ_id`, `player_id`, `leader`, `joker`) VALUES {$players_str}";
    he_database::query($sql);
  }

  public static function create_games($champ_id, $teams)
  {
    $white_team = array_shift($teams);
    $black_team = array_shift($teams);

    $white_players = $white_team['players'];
    $black_players = $black_team['players'];

    $i = 0;
    $k = 0;
    $game_list = array();
    $white_pairs = array();
    $black_pairs = array();
    while ($i < count($white_players) || $i < count($black_players)) {
      $white_player = isset($white_players[$i]) ? $white_players[$i] : $white_team['leader'];
      $black_player = isset($black_players[$i]) ? $black_players[$i] : $black_team['leader'];

      if (!isset($white_pairs[$k]) || count($white_pairs[$k]) != 2) {
        $white_pairs[$k][] = isset($white_players[$i]) ? $white_players[$i] : $white_team['joker'];
        $black_pairs[$k][] = isset($black_players[$i]) ? $black_players[$i] : $black_team['joker'];
      }

      if (count($white_pairs[$k]) == 2) {
        $k++;
      }

      // add single game
      if ($white_player && $black_player) {
        $game_list[] = he_database::placeholder('(?, ?, ?, ?, ?)', $champ_id, $white_player, $black_player, 0, 0);
      }

      $i++;
    }

    foreach ($white_pairs as $key => $white_pair) {
      $black_pair = $black_pairs[$key];

      $white_player = isset($white_pair[0]) ? $white_pair[0] : $white_team['joker'];
      $white_partner = isset($white_pair[1])
        ? $white_pair[1]
        : (($white_player != $white_team['joker']) ? $white_team['joker'] : $white_team['leader']);

      $black_player = isset($black_pair[0]) ? $black_pair[0] : $black_team['joker'];
      $black_partner = isset($black_pair[1])
        ? $black_pair[1]
        : (($black_player != $black_team['joker']) ? $black_team['joker'] : $black_team['leader']);

      $game_list[] = he_database::placeholder('(?, ?, ?, ?, ?)', $champ_id, $white_player, $black_player, $white_partner, $black_partner);
    }

    $games_str = implode(',', $game_list);

    $sql = "INSERT INTO `team_games` (`champ_id`, `player1`, `player2`, `partner1`, `partner2`) VALUES {$games_str}";
    he_database::query($sql);
  }

  public static function get_current_champ()
  {
    $sql = "SELECT MAX(`champ_id`) FROM `team_champs` WHERE `finished` = 0";
    $champ_id = he_database::fetch_field($sql);

    return $champ_id;
  }

  public static function get_champ_info($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM team_champs WHERE champ_id = ?", $champ_id);

    return he_database::fetch_row($sql);
  }

  public static function find_champ_results($champ_id, $field_index = null)
  {
    $sql = he_database::placeholder("SELECT * FROM team_results WHERE champ_id = ? "
      . "ORDER BY team", $champ_id);

    return he_database::fetch_array($sql, $field_index);
  }

  public static function get_team_title($team)
  {
    return ($team == self::WHITE_TEAM) ? self::WHITE_TEAM_STR : self::BLACK_TEAM_STR;
  }

  public static function get_team_players($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM team_players WHERE champ_id = ? "
      . "ORDER BY team_player_id", $champ_id);

    $players = he_database::fetch_array($sql);
    $player_list = array();
    foreach ($players as $player) {
      $player_list[$player['team']][$player['player_id']] = $player;
    }

    return $player_list;
  }

  public static function get_games($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM team_games WHERE champ_id = ?", $champ_id);

    return he_database::fetch_array($sql);
  }

  public static function save_game_result($game_info)
  {
    $game1 = array($game_info['player1'], $game_info['point1'], $game_info['point2']);
    $game2 = array($game_info['player2'], $game_info['point2'], $game_info['point1']);

    $win_point = ($game_info['pair_game']) ? 21 : 11;

    if ($game_info['point1'] > $win_point || $game_info['point2'] > $win_point) {
      $reset = true;
      $sql = he_database::placeholder("UPDATE team_games SET point1 = NULL, point2 = NULL, status = 0 "
        . "WHERE game_id = ?", $game_info['game_id']);
    } else {
      $reset = false;
      $sql = he_database::placeholder("UPDATE team_games SET point1 = IF(player1 = ?@), point2 = IF(player2 = ?@), "
        . "status = 1, played_date = NOW() "
        . "WHERE game_id = ?", $game1, $game2, $game_info['game_id']);
    }

    he_database::query($sql);
    $result = he_database::affected_rows();

    if ($result) {
      self::update_team_result($game_info);
    }

    return ($reset) ? -1 : $result;
  }

  public static function update_team_result($game_info)
  {
    $sql = he_database::placeholder("SELECT * FROM team_games WHERE champ_id = ? AND status = 1", $game_info['champ_id']);
    $games = he_database::fetch_array($sql);

    $team_players = self::get_team_players($game_info['champ_id']);
    $team_results = array(
      self::WHITE_TEAM => array('won' => 0, 'lost' => 0, 'goal_for' => 0, 'goal_against' => 0, 'position' => 0),
      self::BLACK_TEAM => array('won' => 0, 'lost' => 0, 'goal_for' => 0, 'goal_against' => 0, 'position' => 0),
    );

    foreach ($games as $game) {
      if (isset($team_players[self::WHITE_TEAM][$game['player1']])) {
        $team1 = self::WHITE_TEAM;
        $team2 = self::BLACK_TEAM;
      } else {
        $team2 = self::WHITE_TEAM;
        $team1 = self::BLACK_TEAM;
      }

      $team_results[$team1]['won'] += (int)($game['point1'] > $game['point2']);
      $team_results[$team1]['lost'] += (int)($game['point1'] < $game['point2']);
      $team_results[$team1]['goal_for'] += (int)$game['point1'];
      $team_results[$team1]['goal_against'] += (int)$game['point2'];

      $team_results[$team2]['won'] += (int)($game['point1'] < $game['point2']);
      $team_results[$team2]['lost'] += (int)($game['point1'] > $game['point2']);
      $team_results[$team2]['goal_for'] += (int)$game['point2'];
      $team_results[$team2]['goal_against'] += (int)$game['point1'];
    }

    foreach ($team_results as $team => $result) {
      $sql = he_database::placeholder("UPDATE team_results SET won = ?, lost =?, goal_for = ?, goal_against = ? "
        . "WHERE team = ? AND champ_id = ?", $result['won'], $result['lost'], $result['goal_for'],
        $result['goal_against'], $team, $game_info['champ_id']);

      he_database::query($sql);
    }

    return;
  }

  public static function check_champ_status($champ_id)
  {
    $sql = he_database::placeholder("SELECT COUNT(*) FROM `team_games` WHERE champ_id = ? AND status = 1", $champ_id);

    return he_database::fetch_field($sql);
  }
}