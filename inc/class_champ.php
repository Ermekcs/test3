<?php

class champ
{
  public static $game_list = array();

  public static function get_players($where_cond = false)
  {
    $where_cond = ($where_cond) ? $where_cond : 1;
    $sql = "SELECT * FROM `players` WHERE {$where_cond} ORDER BY player_id";

    return he_database::fetch_array($sql);
  }

  public static function find_all()
  {
    $sql = "SELECT * FROM `champs` WHERE 1 ORDER BY champ_id";

    return he_database::fetch_array($sql);
  }

  public static function get_players_by_ids($ids = array())
  {
    if (!$ids) {
      return array();
    }

    foreach ($ids as $key => $id) {
      $ids[$key] = intval($id);
    }

    $player_ids_str = implode(',', $ids);
    $sql = "SELECT * FROM `players` WHERE `player_id` IN ({$player_ids_str})";

    return he_database::fetch_array($sql);
  }

  public static function add_player($name)
  {
    $sql = he_database::placeholder("INSERT IGNORE INTO `players` (`name`) VALUE('?')", $name);
    he_database::query($sql);

    return he_database::insert_id();
  }

  public static function draw_rand_groups($players)
  {
    $count = count($players);
    if ($count < 3) {
      return false;
    }

    // get group count
    $tmp_group_count = intval($count/3);
    $exp = intval(log($tmp_group_count, 2));
    $group_count = pow(2, $exp);

    $groups = array_fill(1, $group_count, array());
    $i = $group_count;
    shuffle($players);
    foreach ($players as $player) {
      $groups[$i--][] = $player;
      $i = ($i <= 0) ? $group_count : $i;
    }

    return $groups;
  }

  public static function get_groups($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM `groups` WHERE `champ_id` = ?", $champ_id);

    return he_database::fetch_array($sql);
  }

  public static function create_champ_scheme($champ_id)
  {
    $group_list = champ::get_groups($champ_id);
    $group_count = count($group_list);
    $level_count = log($group_count, 2) + 1;

    for ($level = 1; $level <= $level_count; $level++) {
      $new_groups = array();
      foreach ($group_list as $index => $group) {
        if ($level != 1 && $index % 2 !== 0) {
          continue;
        }

        if ($level == 1) {
          $group2 = ($index + 1 <= $group_count / 2) ? $group_list[$index + $group_count / 2] : $group_list[$index - $group_count / 2];
        } else {
          $group2 = $group_list[$index + 1];
        }

        $group_info = array(
          'title' => $index + 1,
          'target_id1' => $group['group_id'],
          'target_id2' => $group2['group_id'],
          'level' => $level,
          'champ_id' => $champ_id,
          'playoff' => 1,
          'final' => (int)($level == $level_count)
        );

        $group_id = champ::add_group($group_info);
        $group_info['group_id'] = $group_id;

        $new_groups[] = $group_info;
      }

      $group_list = $new_groups;
    }

  }

  public static function get_group_sign($number)
  {
    $number = ($number <= 0) ? 1: $number;
    $chars = array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
      'p','q','r','s','t','u','v','w','x','y','z');

    $level = ceil($number/count($chars));
    $char_number = $number - count($chars) * ($level - 1) - 1;
    $char = ucwords($chars[$char_number]) . (($level == 1) ? '' : $level);

    return $char;
  }

  public static function save_rand_groups($champ_id, $groups)
  {
    foreach ($groups as $group_num => $players) {
      $group_info = array(
        'champ_id' => $champ_id,
        'title' => self::get_group_sign($group_num)
      );

      $group_id = self::add_group($group_info);

      self::add_group_members($group_id, $players);
    }
  }

  public static function get_new_champ_num()
  {
    $sql = "SELECT MAX(`champ_id`) FROM `champs`";
    $champ_id = he_database::fetch_field($sql);

    return intval($champ_id) + 1;
  }

  public static function new_champ($name)
  {
    $sql = he_database::placeholder("INSERT INTO `champs` (`title`, `start_date`) VALUES('?', NOW())", $name);
    he_database::query($sql);

    return he_database::insert_id();
  }

  public static function add_group($group_info)
  {
    $cols = array();
    foreach ($group_info as $field => $value) {
      $cols[] = he_database::placeholder("`{$field}` = '?'", $value);
    }

    $sql = "INSERT INTO `groups` SET " . implode(', ', $cols);
    he_database::query($sql);

    return he_database::insert_id();
  }

  public static function add_group_members($group_id, $players)
  {
    $player_ids = array();
    $player_list = array();
    foreach ($players as $player) {
      $player_list[] = he_database::placeholder('(?, ?)', $group_id, $player['player_id']);
      $player_ids[] = $player['player_id'];
    }
    $players_str = implode(',', $player_list);

    $sql = "INSERT INTO `group_players` (`group_id`, `player_id`) VALUES {$players_str}";
    he_database::query($sql);

    //create matches list
    $players_count = $count = count($player_ids);
    $games_count = 0;
    while ($count > 0) { $games_count += --$count; }

    $index1 = 0;
    $index2 = 1;
    $games = array();
    for ($i = 0; $i < $games_count; $i++) {
      if ($index2 == $players_count) {
        $index1++;
        $index2 = $index1 + 1;
      }

      $player_id1 = $player_ids[$index1];
      $player_id2 = $player_ids[$index2];

      $games[] = he_database::placeholder('(?, ?, ?)', $group_id, $player_id1, $player_id2);

      $index2++;
    }

    $games_str = implode(',', $games);

    $sql = "INSERT INTO `games` (`group_id`, `player1`, `player2`) VALUES {$games_str}";
    he_database::query($sql);
  }

  public static function get_current_champ()
  {
    $sql = "SELECT MAX(`champ_id`) FROM `champs` WHERE `finished` = 0";
    $champ_id = he_database::fetch_field($sql);

    return $champ_id;
  }

  public static function get_group_players($champ_id, $level = 0)
  {
    $sql = he_database::placeholder("SELECT * FROM `groups` WHERE `champ_id` = ? AND level = {$level}", $champ_id);
    $groups = he_database::fetch_array($sql);

    $sql = he_database::placeholder("SELECT gp.*, p.`name`, g.`title`  FROM `groups` AS g "
      . "INNER JOIN `group_players` AS gp ON (g.`group_id` = gp.`group_id`) "
      . "WHERE g.champ_id = ? AND g.level = {$level}", $champ_id);

    $group_players = he_database::fetch_array($sql);

    $player_list = array();
    foreach ($group_players as $player) {
      $player_list[$player['group_id']][] = $player;
    }

    $group_list = array();
    foreach ($groups as $group) {
      $group['players'] = $player_list[$group['group_id']];
      $group_list[] = $group;
    }

    return $group_list;
  }

  public static function get_champ_info($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM champs WHERE champ_id = ?", $champ_id);

    return he_database::fetch_row($sql);
  }

  public static function get_games($champ_id, $level = 0)
  {
    $sql = he_database::placeholder("SELECT games.*, players.name FROM games "
      . "INNER JOIN groups ON (games.group_id = groups.group_id) "
      . "WHERE groups.champ_id = ? AND groups.level = ?", $champ_id, $level);

    return he_database::fetch_array($sql);
  }

  public static function find_champ_groups($champ_id, $level = 0, $field_index = null)
  {
    $sql = he_database::placeholder("SELECT * FROM groups WHERE champ_id = ? AND level = ? "
      . "ORDER BY group_id", $champ_id, $level);

    return he_database::fetch_array($sql, $field_index);
  }

  public static function find_gps_by_group_ids($group_ids = array(), $field_index = null)
  {
    $where = 1;

    if ($group_ids) {
      $where = he_database::placeholder('group_id IN (?@)', $group_ids);
    }

    $sql = "SELECT * FROM group_players WHERE {$where} ORDER BY points DESC, won DESC, goal_for - goal_against DESC, goal_for DESC, player_id";

    return he_database::fetch_array($sql, $field_index);
  }

  public static function find_group($group_id)
  {
    $sql = he_database::placeholder("SELECT * FROM groups WHERE group_id = ?", $group_id);

    return he_database::fetch_row($sql);
  }

  public static function find_playoff_groups($champ_id)
  {
    $sql = he_database::placeholder("SELECT * FROM groups WHERE champ_id = ? AND playoff = 1", $champ_id);

    return he_database::fetch_array($sql, 'group_id');
  }

  public static function prepare_playoff_groups($groups)
  {
    $rounds = array();
    foreach ($groups as $group_id => $group) {
      $rounds[$group['level']][$group_id] = $group;
    }

    ksort($rounds);

    return $rounds;
  }

  public static function find_playoff_games($champ_id, $field_index = null)
  {
    $sql = he_database::placeholder("SELECT gm.* FROM games AS gm "
      . "INNER JOIN groups AS gr ON (gm.group_id = gr.group_id) "
      . "WHERE gr.champ_id = ? AND gr.playoff = 1", $champ_id);

    return he_database::fetch_array($sql, $field_index);
  }

  public static function find_playoff_players($champ_id, $field_index = null)
  {
    $sql = he_database::placeholder("SELECT p.* FROM players AS p "
      . "INNER JOIN group_players AS gp ON (p.player_id = gp.player_id) "
      . "INNER JOIN groups AS g ON (gp.group_id = g.group_id) "
      . "WHERE g.champ_id = ? AND g.playoff = 1", $champ_id);

    return he_database::fetch_array($sql, $field_index);
  }

  public static function stats_rating()
  {
    $champs = self::find_all();

    $main_sql = "SELECT gp.player_id, "
      . "(SUM(gp.points) + SUM(gp.qualified * 3) + IF (SUM(gp.qualified) = ?, 0, 0)) AS points "
      . "FROM group_players AS gp "
      . "INNER JOIN players AS p ON (gp.player_id = p.player_id AND p.status = 1)"
      . "INNER JOIN groups AS g ON (gp.group_id = g.group_id)"
      . "WHERE g.champ_id = ? "
      . "GROUP BY gp.player_id";

    $stats = array();
    foreach ($champs as $champ) {
      $sql = he_database::placeholder("SELECT level FROM groups WHERE champ_id = ? AND final = 1", $champ['champ_id']);
      $level_count = he_database::fetch_field($sql) + 1;

      $sql = he_database::placeholder($main_sql, $level_count, $champ['champ_id']);
      $players_stat = he_database::fetch_column($sql, true);

      $stats[$champ['champ_id']] = $players_stat;
    }

    return $stats;
  }

  public static function find_players($player_ids = array(), $field_index = null, $status = null)
  {
    $where = 1;

    if ($player_ids) {
      $where = he_database::placeholder('player_id IN (?@)', $player_ids);
    }

    if ($status) {
      $where .= ' AND status = 1 ';
    }

    $sql = "SELECT * FROM players WHERE {$where}";

    return he_database::fetch_array($sql, $field_index);
  }

  public static function get_rank_history($champ_stats, $player_ids)
  {
    $exp = 2 * count($champ_stats);
    foreach ($champ_stats as $champ_id => $players) {
      foreach ($player_ids as $player_id) {
        if (!isset($players[$player_id])) {
          $champ_stats[$champ_id][$player_id] = 0;
          $players[$player_id] = 0;
        }
      }

      if ($champ_id == 1) {
        arsort($champ_stats[$champ_id]);
        continue;
      }

      foreach ($players as $player_id => $point) {
        $champ_stats[$champ_id][$player_id] += $point / pow(10, $exp) + $champ_stats[$champ_id - 1][$player_id];
      }

      $exp -= 2;
      arsort($champ_stats[$champ_id]);
    }

    $ranks = array();
    $ranks_history = array();
    foreach ($champ_stats as $champ_id => $players) {
      $pos = 1;
      foreach ($players as $player_id => $point) {
        $ranks[$champ_id][$player_id] = $pos++;

        if ($champ_id == 1) {
          continue;
        }

        if ($ranks[$champ_id][$player_id] != $ranks[$champ_id - 1][$player_id]) {
          $status = ($ranks[$champ_id][$player_id] < $ranks[$champ_id - 1][$player_id]) ? 'up' : 'down';
          $ranks_history[$champ_id][$player_id] = array('rank' => $ranks[$champ_id][$player_id], 'status' => $status);
        }
      }
    }

    return $ranks_history;
  }

  public static function stats_players()
  {
    $sql = "SELECT gp.player_id, SUM(gp.points) AS points, SUM(gp.won) AS won, SUM(gp.draw) AS draw, SUM(gp.lost) AS lost, SUM(gp.goal_for) AS goal_for, "
      . "SUM(gp.goal_against) AS goal_against "
      . "FROM group_players AS gp "
      . "INNER JOIN players AS p ON (gp.player_id = p.player_id AND p.status = 1) "
      . "WHERE 1 "
      . "GROUP BY gp.player_id "
      . "ORDER BY points DESC, won DESC, goal_for DESC, lost";

    return he_database::fetch_array($sql, 'player_id');
  }

  public static function stats_medals()
  {
    $champs = he_database::fetch_array("SELECT * FROM champs WHERE 1 ORDER BY champ_id", 'champ_id');

    $points = array();
    $exp = 2 * count($champs);
    foreach ($champs as $champ_id => $champ) {
      if (!$champ['finished']) {
        continue;
      }
      $points[$champ['champion']] += 1*10000 + 1 / pow(10, $exp);
      $points[$champ['finalist']] += 1*100 + 1 / pow(10, $exp);
      $exp -= 2;
    }

    $sql = "SELECT g.champ_id, gp.player_id FROM group_players AS gp "
      . "INNER JOIN groups AS g ON (gp.group_id = g.group_id) "
      . "INNER JOIN groups AS gf ON (gf.final = 1 AND (gf.target_id1 = g.group_id || gf.target_id2 = g.group_id)) "
      . "WHERE gp.qualified = 0 "
      . "ORDER BY g.champ_id;";
    $bronze_medals = he_database::fetch_array($sql);

    $exp = 2 * count($champs);
    foreach ($bronze_medals as $bronze) {
      if (!isset($cur_champ_id)) {
        $cur_champ_id = $bronze['champ_id'];
      } elseif ($cur_champ_id != $bronze['champ_id']) {
        $cur_champ_id = $bronze['champ_id'];
        $exp -= 2;
      }

      $points[$bronze['player_id']] += 1 + 1 / pow(10, $exp);
    }

    arsort($points);

    //gold
    $sql = "SELECT champion, COUNT(champion) AS medals FROM champs "
      . "WHERE finished = 1 GROUP BY champion ORDER BY medals DESC";
    $gold_medals = he_database::fetch_column($sql, true);

    //silver
    $sql = "SELECT finalist, COUNT(finalist) AS medals FROM champs "
      . "WHERE finished = 1 GROUP BY finalist ORDER BY medals DESC";
    $silver_medals = he_database::fetch_column($sql, true);

    $medals = array();

    foreach ($gold_medals as $player_id => $count) {
      $medals[$player_id]['gold'] = $count;
    }

    foreach ($silver_medals as $player_id => $count) {
      $medals[$player_id]['silver'] = $count;
    }

    foreach ($bronze_medals as $medal) {
      $medals[$medal['player_id']]['bronze'] += 1;
    }

    return array('medals' => $medals, 'points' => $points);
  }

  public static function prepare_games($games)
  {
    foreach ($games as $game) {
      self::$game_list[$game['group_id']][$game['player1']][$game['player2']] = $game;
    }
  }

  public static function find_games_by_group_ids($group_ids = array(), $field_index = null)
  {
    $where = 1;

    if ($group_ids) {
      $where = he_database::placeholder('group_id IN (?@)', $group_ids);
    }

    $sql = "SELECT * FROM games WHERE {$where}";

    return he_database::fetch_array($sql, $field_index);
  }

  public static function save_game_result($game_info)
  {
    $game1 = array($game_info['player1'], $game_info['point1'], $game_info['point2']);
    $game2 = array($game_info['player2'], $game_info['point2'], $game_info['point1']);

    $penalty = false;
    if (isset($game_info['penalty1']) && $game_info['penalty1'] && isset($game_info['penalty2']) && $game_info['penalty2']) {
      $pen1 = array($game_info['player1'], $game_info['penalty1'], $game_info['penalty2']);
      $pen2 = array($game_info['player2'], $game_info['penalty2'], $game_info['penalty1']);
      $penalty = true;
    }

    if ($game_info['point1'] < 0 || $game_info['point2'] < 0) {
      $reset = true;
      $sql = he_database::placeholder("UPDATE games SET point1 = NULL, point2 = NULL, played_date = NULL, extra = 0, penalty1 = NULL, penalty2 = NULL, status = 0 "
        . "WHERE game_id = ?", $game_info['game_id']);
    } else {
      $reset = false;

      $sql = he_database::placeholder("UPDATE games SET point1 = IF(player1 = ?@), point2 = IF(player2 = ?@), played_date = NOW(), status = 1 "
        . "WHERE game_id = ?", $game1, $game2, $game_info['game_id']);
    }

    he_database::query($sql);
    $result = he_database::affected_rows();

    if (!$reset && $penalty) {
      $sql = he_database::placeholder("UPDATE games SET penalty1 = IF(player1 = ?@), penalty2 = IF(player2 = ?@) "
        . "WHERE game_id = ?", $pen1, $pen2, $game_info['game_id']);
      he_database::query($sql);
      $result += he_database::affected_rows();
    }

    if ($result) {
      self::update_group_players($game_info);
    }

    return ($reset) ? -1 : $result;
  }

  public static function update_group_players($game_info)
  {
    $sql = he_database::placeholder("SELECT `group_id`, {player_id} AS player_id, "
      . "SUM( IF( `player1` = {player_id}, `point1` , `point2` ) ) AS goal_for, "
      . "SUM( IF( `player1` = {player_id}, `point2` , `point1` ) ) AS goal_against, "
	    . "SUM( IF( `player1` = {player_id}, IF ((`point1` - `point2`) > 0, 1, 0), IF ((`point2` - `point1`) > 0, 1, 0)) ) AS won, "
	    . "SUM( IF((`point1` - `point2`) = 0, 1, 0) ) AS draw, "
	    . "SUM( IF( `player1` = {player_id}, IF ((`point1` - `point2`) < 0, 1, 0), IF ((`point2` - `point1`) < 0, 1, 0)) ) AS lost "
      . "FROM `games` "
      . "WHERE `group_id` = ? AND `status` = 1 AND (`player1` = {player_id} "
      . "OR `player2` = {player_id})", $game_info['group_id']);

    // playoff corrections
    $playoff_sql = he_database::placeholder("SELECT playoff FROM groups WHERE group_id = ?", $game_info['group_id']);
    $playoff = he_database::fetch_field($playoff_sql);
    $penalty_win = false;
    if ($playoff) {
      $correct_sql = he_database::placeholder("SELECT * FROM games WHERE group_id = ? AND status = 1 AND point1 = point2", $game_info['group_id']);
      $correct = he_database::fetch_row($correct_sql);
      if ($correct) {
        $penalty_win = ($correct['penalty1'] > $correct['penalty2']) ? $correct['player1'] : $correct['player2'];
      }
    }

    //update player1
    $info_sql = str_replace('{player_id}', $game_info['player1'], $sql);
    $info = he_database::fetch_row($info_sql);

    if ($penalty_win && $penalty_win == $info['player_id']) {
      $info['won']++;
      $info['draw']--;
    }

    $update_query = he_database::placeholder("UPDATE group_players "
        . "SET goal_for = ?, goal_against = ?, won = ?, lost = ?, draw = ?, points = ? "
        . "WHERE group_id = ? AND player_id = ?", $info['goal_for'], $info['goal_against'], $info['won'], $info['lost'],
        $info['draw'], (3*$info['won'] + $info['draw']), $info['group_id'], $info['player_id']);
    he_database::query($update_query);

    //update player2
    $info_sql = str_replace('{player_id}', $game_info['player2'], $sql);
    $info = he_database::fetch_row($info_sql);

    if ($penalty_win && $penalty_win == $info['player_id']) {
      $info['won']++;
      $info['draw']--;
    }

    $update_query = he_database::placeholder("UPDATE group_players "
        . "SET goal_for = ?, goal_against = ?, won = ?, lost = ?, draw = ?, points = ? "
        . "WHERE group_id = ? AND player_id = ?", $info['goal_for'], $info['goal_against'], $info['won'], $info['lost'],
        $info['draw'], (3*$info['won'] + $info['draw']), $info['group_id'], $info['player_id']);
    he_database::query($update_query);
  }

  public static function get_game_result($group_id, $player_id, $opponent_id)
  {
    if (isset(self::$game_list[$group_id][$player_id][$opponent_id])
      && $game = self::$game_list[$group_id][$player_id][$opponent_id])
    {
      return $game['point1'];
    } else if (isset(self::$game_list[$group_id][$opponent_id][$player_id])
      && $game = self::$game_list[$group_id][$opponent_id][$player_id])
    {
      return $game['point2'];
    }

    return '-';
  }

  public static function check_group_stage($group_id)
  {
    $sql = he_database::placeholder("SELECT COUNT(*) FROM games WHERE group_id = ? AND status = 0", $group_id);
    if (he_database::fetch_field($sql)) {
      return;
    }

    $group = self::find_group($group_id);
    $group_players = champ::find_gps_by_group_ids(array($group_id));
    foreach ($group_players as $index => $g_player) {
      $position = $index + 1;
      $unqualified = ($group['level'] == 0) ? 3 : 2;
      $qualified = (int)($position < $unqualified);

      $sql = he_database::placeholder("UPDATE group_players SET position = ?, qualified = ? "
        . "WHERE group_player_id = ?", $position, $qualified, $g_player['group_player_id']);
      he_database::query($sql);
    }
  }

  public static function check_qualified_players($group_id)
  {
    $group = self::find_group($group_id);

    if ($group['final'] == 1) {
      self::set_champ_finished($group['champ_id'], $group_id);
      return;
    } elseif ($group['playoff'] == 1) {
      self::check_playoff_players($group_id);
      return;
    }

    $group_players = champ::find_gps_by_group_ids(array($group_id));

    $index = 0;
    foreach ($group_players as $group_player) {
      if ($group_player['qualified'] != 1) {
        continue;
      }

      $player_id = $group_player['player_id'];

      if ($index == 0) {
        $target_field = 'target_id1';
        $sort_order = 'ASC';
        $player_field = 'player1';
      } elseif ($index == 1) {
        $target_field = 'target_id2';
        $sort_order = 'DESC';
        $player_field = 'player2';
      }

      $sql = he_database::placeholder("SELECT group_id FROM groups WHERE {$target_field} = ?", $group_id);
      $new_group_id = he_database::fetch_field($sql);

      $sql = he_database::placeholder("SELECT * FROM group_players "
        . "WHERE group_id = ? ORDER BY group_player_id {$sort_order} LIMIT 1", $new_group_id);
      $old_gp = he_database::fetch_row($sql);

      if ($old_gp && ($old_gp['player_id'] == 0 || $old_gp['player_id'] != $player_id)) {
        // update group_players
        $sql = he_database::placeholder("UPDATE group_players SET "
          . "goal_against = 0, "
          . "goal_for = 0, "
          . "lost = 0, "
          . "position = NULL, "
          . "qualified = 0, "
          . "player_id = ? "
          . "WHERE group_player_id = ?", $player_id, $old_gp['group_player_id']);

        he_database::query($sql);

        // update games
        $sql = he_database::placeholder("UPDATE games SET "
          . "played_date = NULL, "
          . "point1 = NULL, "
          . "point2 = NULL, "
          . "status = 0, "
          . "{$player_field} = ? "
          . "WHERE group_id = ?", $player_id, $new_group_id);

        he_database::query($sql);
      } elseif (!$old_gp) {
        $new_group_players = array(
          array('player_id' => 0),
          array('player_id' => 0)
        );

        $new_group_players[$index]['player_id'] = $player_id;
        self::add_group_members($new_group_id, $new_group_players);
      }

      $index++;
    }
  }

  public static function check_playoff_players($group_id)
  {
    $group_players = champ::find_gps_by_group_ids(array($group_id));
    foreach ($group_players as $group_player) {
      if ($group_player['qualified'] == 1) {
        $player_id = $group_player['player_id'];
        break;
      }
    }

    // new group
    $sql = he_database::placeholder("SELECT * FROM groups WHERE target_id1 = ? OR target_id2 = ?", $group_id, $group_id);
    $new_group = he_database::fetch_row($sql);

    if ($new_group['target_id1'] == $group_id) {
      $index = 0;
      $sort_order = 'ASC';
      $player_field = 'player1';
    } else {
      $index = 1;
      $sort_order = 'DESC';
      $player_field = 'player2';
    }

    $sql = he_database::placeholder("SELECT * FROM group_players "
      . "WHERE group_id = ? ORDER BY group_player_id {$sort_order} LIMIT 1", $new_group['group_id']);
    $old_gp = he_database::fetch_row($sql);

    if ($old_gp && ($old_gp['player_id'] == 0 || $old_gp['player_id'] != $player_id)) {
      // update group_players
      $sql = he_database::placeholder("UPDATE group_players SET "
        . "goal_against = 0, "
        . "goal_for = 0, "
        . "lost = 0, "
        . "position = NULL, "
        . "qualified = 0, "
        . "player_id = ? "
        . "WHERE group_player_id = ?", $player_id, $old_gp['group_player_id']);

      he_database::query($sql);

      // update games
      $sql = he_database::placeholder("UPDATE games SET "
        . "played_date = NULL, "
        . "point1 = NULL, "
        . "point2 = NULL, "
        . "status = 0, "
        . "{$player_field} = ? "
        . "WHERE group_id = ?", $player_id, $new_group['group_id']);

      he_database::query($sql);
    } elseif (!$old_gp) {
      $new_group_players = array(
        array('player_id' => 0),
        array('player_id' => 0)
      );

      $new_group_players[$index]['player_id'] = $player_id;
      self::add_group_members($new_group['group_id'], $new_group_players);
    }
  }

  public static function set_champ_finished($champ_id, $group_id)
  {
    $group_players = champ::find_gps_by_group_ids(array($group_id));
    foreach ($group_players as $group_player) {
      if ($group_player['qualified'] == 1) {
        $champion = $group_player['player_id'];
      } else {
        $finalist = $group_player['player_id'];
      }
    }

    $sql = he_database::placeholder("UPDATE champs SET "
      . "champion = ?, "
      . "finalist = ?, "
      . "end_date = NOW(), "
      . "finished = 1 "
      . "WHERE champ_id = ?", $champion, $finalist, $champ_id);
    he_database::query($sql);
  }

  public static function find_player($player_id)
  {
    $sql = he_database::placeholder("SELECT * FROM players WHERE player_id = ?", $player_id);

    return he_database::fetch_row($sql);
  }

  public static function get_player_games($player_id)
  {
    $sql = he_database::placeholder("SELECT * FROM games WHERE player1 = ? OR player2 = ? ORDER BY game_id",
      $player_id, $player_id);

    return he_database::fetch_array($sql);
  }

  public static function find_all_parties($field_index = null)
  {
    $sql = "SELECT * FROM parties WHERE 1";

    return he_database::fetch_array($sql, $field_index);
  }

  public static function find_party_member_count()
  {
    $sql = "SELECT COUNT(player_id) AS member_count, party_id FROM players WHERE status = 1 "
      . "GROUP BY party_id ORDER BY member_count DESC, party_id ASC";

    return he_database::fetch_array($sql);
  }

  public static function delete_champ($champ_id)
  {
    //delete games
    $sql = he_database::placeholder("DELETE FROM `games` "
      . "WHERE `group_id` IN (SELECT `group_id` FROM `groups` WHERE `champ_id` = ?)", $champ_id);
    he_database::query($sql);

    //delete group players
    $sql = he_database::placeholder("DELETE FROM `group_players` "
      . "WHERE `group_id` IN (SELECT `group_id` FROM `groups` WHERE `champ_id` = ?)", $champ_id);
    he_database::query($sql);

    // delete groups
    $sql = he_database::placeholder("DELETE FROM `groups` WHERE `champ_id` = ?", $champ_id);
    he_database::query($sql);

    // delete champ
    $sql = he_database::placeholder("DELETE FROM `champs` WHERE `champ_id` = ?", $champ_id);
    he_database::query($sql);

    return true;
  }

  public static function set_game_extra($game_id, $extra)
  {
    if (!$game_id) { return -1; }
    $sql = he_database::placeholder("UPDATE `games` SET `extra` = ? WHERE `game_id` = ?", $extra, $game_id);
    he_database::query($sql);

    return he_database::affected_rows();
  }
}