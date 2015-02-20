<?php

include_once './config.php';

$champ_id = isset($_REQUEST['champ_id']) ? $_REQUEST['champ_id'] : 0;
if (!$champ_id) {
  $champ_id = champ::get_current_champ();
}

$champ_info = champ::get_champ_info($champ_id);
$groups = champ::find_playoff_groups($champ_id);
$rounds = champ::prepare_playoff_groups($groups);
$games = champ::find_playoff_games($champ_id, 'group_id');
$players = champ::find_playoff_players($champ_id, 'player_id');
$clubs = champ::get_champ_clubs($champ_id, 'player_id');

$view->champ_info = $champ_info;
$view->rounds = $rounds;
$view->games = $games;
$view->players = $players;
$view->clubs = $clubs;

$view->render('champ_playoff');