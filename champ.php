<?php

include_once './config.php';

if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'save_game') {
  if (!$is_admin) {
    exit();
  }
  $game_info = array();
  $game_info['game_id'] = (int)$_REQUEST['game_id'];
  $game_info['group_id'] = (int)$_REQUEST['group_id'];
  $game_info['player1'] = (int)$_REQUEST['player1'];
  $game_info['player2'] = (int)$_REQUEST['player2'];
  $game_info['point1'] = (int)$_REQUEST['point1'];
  $game_info['point2'] = (int)$_REQUEST['point2'];
  $game_info['penalty1'] = isset($_REQUEST['penalty1']) && $_REQUEST['penalty1'] ? (int)$_REQUEST['penalty1'] : false;
  $game_info['penalty2'] = isset($_REQUEST['penalty2']) && $_REQUEST['penalty2'] ? (int)$_REQUEST['penalty2'] : false;

  $result = champ::save_game_result($game_info);
  champ::check_group_stage($game_info['group_id']);
  champ::check_qualified_players($game_info['group_id']);


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

if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'set_extra') {
  if (!$is_admin) {
    exit();
  }

  $game_id = (int)$_REQUEST['game_id'];
  $extra = (int)$_REQUEST['extra'];
  $result = champ::set_game_extra($game_id, $extra);
  echo json_encode(array('result' => $result));

  exit();
}

$champ_id = isset($_REQUEST['champ_id']) ? $_REQUEST['champ_id'] : 0;
if (!$champ_id) {
  $champ_id = champ::get_current_champ();
}


$champ_info = champ::get_champ_info($champ_id);
$groups = champ::find_champ_groups($champ_id, 0, 'group_id');

$group_ids = array_keys($groups);
$group_player_list = champ::find_gps_by_group_ids($group_ids);
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


$view->champ_info = $champ_info;
$view->groups = $groups;
$view->group_players = $group_players;
$view->players = $players;
$view->games = $games;

$view->render('champ');