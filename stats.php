<?php

include_once './config.php';

$type = (isset($_GET['type']) && $_GET['type']) ? $_GET['type'] : 'rating';

if ($type == 'rating') {
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
  $players = champ::find_players($player_ids, 'player_id');

  $view->players = $players;
  $view->total = $total;
  $view->champ_stats = $champ_stats;
  $view->ranks_history = champ::get_rank_history($champ_stats, $player_ids);
}

if ($type == 'games') {
  $player_stats = champ::stats_players();
  $player_ids = array_keys($player_stats);
  $players = champ::find_players($player_ids, 'player_id');

  $view->players = $players;
  $view->player_stats = $player_stats;
}

if ($type == 'medals') {
  $player_stats = champ::stats_medals();

  $player_ids = array_keys($player_stats['medals']);
  $players = champ::find_players($player_ids, 'player_id');

  $view->players = $players;
  $view->medals = $player_stats['medals'];
  $view->player_list = $player_stats['points'];
}


$view->type = $type;

$view->render('stats');