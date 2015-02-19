<?php

include_once './config.php';

$team = isset($_GET['team']) ? $_GET['team'] : 0;
$new_champ_num = ($team == 0) ? champ::get_new_champ_num() : team_champ::get_new_champ_num();

if (!$team && isset($_POST['action']) && $_POST['action'] == 'random') {
  $player_ids = isset($_POST['players']) ? $_POST['players'] : array();
  $players = champ::get_players_by_ids($player_ids);
  $group_players = champ::draw_rand_groups($players);

  require_once './templates/new_champ_groups.tpl';
  exit();
}

if (!$team && isset($_POST['action']) && $_POST['action'] == 'save' && $is_admin) {
  $name = trim($_POST['champ_name']);
  $groups = json_decode($_POST['groups'], true);
  $champ_id = champ::new_champ($name);
  champ::save_rand_groups($champ_id, $groups);
  champ::create_champ_scheme($champ_id);

  header("location: champ.php");
  exit();
}

if ($team && isset($_POST['action']) && $_POST['action'] == 'random') {
  $player_ids = isset($_POST['players']) ? $_POST['players'] : array();
  $players = champ::find_players($player_ids, 'player_id');
  $teams = team_champ::draw_rand_teams($player_ids);

  require_once './templates/new_champ_teams.tpl';
  exit();
}

if ($team && isset($_POST['action']) && $_POST['action'] == 'save' && $is_admin) {
  $name = trim($_POST['champ_name']);
  $teams = json_decode($_POST['teams'], true);
  $champ_id = team_champ::new_champ($name);
  team_champ::save_rand_teams($champ_id, $teams);
  team_champ::create_games($champ_id, $teams);

  header("location: team_champ.php");
  exit();
}


$players = champ::get_players('`status` = 1');

require_once './templates/new_champ.tpl';