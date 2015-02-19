<?php

include_once './config.php';


$players = champ::get_players();
$champs = champ::find_all();

$last_champ = array();
$prev_champ = array();

// Champ Rating

$champ_stats = champ::stats_rating();
$total = array();
$exp = 2 * count($champ_stats);
foreach ($champ_stats as $key => $player_stats) {
  foreach ($player_stats as $player_id => $point) {
    $total[$player_id] += $point + $point / pow(10, $exp);
  }
  $exp -= 2;
}

arsort($total);
$player_ids = array_keys($total);
$stats_players = champ::find_players($player_ids, 'player_id');

// Champ Rating END

$view->total = $total;
$view->stats_players = $stats_players;
$view->render('index');