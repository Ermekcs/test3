<?php

include_once './config.php';

if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'save_game') {
  if (!$is_admin) {
    exit();
  }
  $game_info = array();
  $game_info['game_id'] = (int)$_REQUEST['game_id'];
  $game_info['champ_id'] = (int)$_REQUEST['champ_id'];
  $game_info['player1'] = (int)$_REQUEST['player1'];
  $game_info['player2'] = (int)$_REQUEST['player2'];
  $game_info['point1'] = (int)$_REQUEST['point1'];
  $game_info['point2'] = (int)$_REQUEST['point2'];
  $game_info['pair_game'] = (int)$_REQUEST['pair_game'];

  $result = team_champ::save_game_result($game_info);
  team_champ::check_champ_status($game_info['champ_id']);


  echo json_encode(array('result' => $result));

  exit();
}

if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'refresh_group') {
  if (!$is_admin) {
    exit();
  }
  $group_id = (int)$_REQUEST['group_id'];

  $group_player_list = champ::find_gps_by_group_ids(array($group_id));
  $group_players = array();
  $player_ids = array();
  foreach ($group_player_list as $group_player) {
    $group_players[$group_player['group_id']][] = $group_player;
    $player_ids[] = $group_player['player_id'];
  }

  $players = champ::find_players($player_ids, 'player_id');
  $game_list = champ::find_games_by_group_ids($group_ids);
  champ::prepare_games($game_list);
  $games = array();
  foreach ($game_list as $row) {
    $games[$row['group_id']][] = $row;
  }

  $view->group = champ::find_group($group_id);
  $view->group_players = $group_players;
  $view->players = $players;
  $view->games = $games;

  echo $view->render('tpl_group');
  exit();
}

$champ_id = isset($_REQUEST['champ_id']) ? $_REQUEST['champ_id'] : 0;
if (!$champ_id) {
  $champ_id = team_champ::get_current_champ();
}


$champ_info = team_champ::get_champ_info($champ_id);
$teams = team_champ::find_champ_results($champ_id, 'team');
$team_players = team_champ::get_team_players($champ_id);
$games = team_champ::get_games($champ_id);

$player_ids = array();
foreach ($team_players as $players) {
  $player_ids = array_merge($player_ids, array_keys($players));
}

$players = champ::find_players($player_ids, 'player_id');


$view->champ_info = $champ_info;
$view->teams = $teams;
$view->team_players = $team_players;
$view->players = $players;
$view->games = $games;

$view->render('team_champ');