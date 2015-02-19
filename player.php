<?php

include_once './config.php';

$player_id = (int)$_REQUEST['player_id'];
$player_info = champ::find_player($player_id);

$games = champ::get_player_games($player_id);
$player_ids = array($player_id);
foreach ($games as $game) {
  if ($game['player1'] != $player_id && !in_array($game['player1'], $player_ids)) {
    $player_ids[] = $game['player1'];
  } elseif ($game['player2'] != $player_id && !in_array($game['player2'], $player_ids)) {
    $player_ids[] = $game['player2'];
  }
}

$players = champ::find_players($player_ids, 'player_id');

$view->player_info = $player_info;
$view->players = $players;
$view->games = $games;

//$view->groups = $groups;
//$view->group_players = $group_players;

$view->render('player');