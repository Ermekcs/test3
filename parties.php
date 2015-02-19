<?php

include_once './config.php';

$parties = champ::find_all_parties('party_id');
$players = champ::find_players(array(), 'player_id', true);

//count  START
$party_players = champ::find_party_member_count();
$member_count = array( array('Party', 'Count') );
foreach ($party_players as $party) {
  $party_id = $party['party_id'];
  $member_count[] = array($parties[$party_id]['name'], (int)$party['member_count']);
}
//count  END


//ratings  START
$champ_stats = champ::stats_rating();

$total = array();
$exp = 2 * count($champ_stats);

foreach ($champ_stats as $key => $player_stats) {
  foreach ($player_stats as $player_id => $point) {
    $party_id = $players[$player_id]['party_id'];
    $total[$party_id] += $point + $point / pow(10, $exp);
  }
  $exp -= 2;
}
arsort($total);

$party_scores = array( array('Party', 'Rating') );
foreach ($total as $party_id => $score) {
  $party_scores[] = array($parties[$party_id]['name'], (int)$score);
}
//ratings  END


//games  START
$player_stats = champ::stats_players();
$total = array();
foreach ($player_stats as $player_id => $info) {
  $party_id = $players[$player_id]['party_id'];

  if (!$party_id) {
    continue;
  }

  $total['won'][$party_id] += $info['won'];
  $total['lost'][$party_id] += $info['lost'];
  $total['goal_for'][$party_id] += $info['goal_for'];
  $total['goal_against'][$party_id] += $info['goal_against'];
}

arsort($total['won']);
arsort($total['lost']);
arsort($total['goal_for']);
arsort($total['goal_against']);

$party_won = array( array('Party', 'Won') );
$party_lost = array( array('Party', 'Lost') );
$party_goal_for = array( array('Party', 'Goal For') );
$party_goal_against = array( array('Party', 'Goal Against') );

foreach ($total['won'] as $party_id => $value) {
  $party_won[] = array($parties[$party_id]['name'], (int)$value);
  $party_lost[] = array($parties[$party_id]['name'], (int)$total['won'][$party_id]);
  $party_goal_for[] = array($parties[$party_id]['name'], (int)$total['goal_for'][$party_id]);
  $party_goal_against[] = array($parties[$party_id]['name'], (int)$total['goal_against'][$party_id]);
}
//games  END


$party_members = array();
foreach ($players as $player_id => $player) {
  $party_id = $player['party_id'];

  if (!isset($party_members[$party_id])) {
    $party_members[$party_id] = array('title' => $parties[$party_id]['name'], 'members' => array());
  }

  $party_members[$party_id]['members'][] = $player['name'];
}

ksort($party_members);

$view->party_members = $party_members;
$view->party_count = $member_count;
$view->party_scores = $party_scores;
$view->party_won = $party_won;
$view->party_lost = $party_lost;
$view->party_goal_for = $party_goal_for;
$view->party_goal_against = $party_goal_against;

$view->render('parties');