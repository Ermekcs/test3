<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="no-js ie6" dir="ltr" lang="en-US"> <![endif]-->
<!--[if IE 7 ]>    <html class="no-js ie7" dir="ltr" lang="en-US"> <![endif]-->
<!--[if IE 8 ]>    <html class="no-js ie8" dir="ltr" lang="en-US"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class=" js no-flexbox canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths" dir="ltr" lang="en-US"><!--<![endif]--><head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">

  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title>Champions League</title>

  <meta name="robots" content="noindex,nofollow">
  <link rel="stylesheet" id="responsive-style-css" href="static_files/style.css" type="text/css" media="all">
  <link rel="stylesheet" id="custom-style-css" href="static_files/style_custom.css" type="text/css" media="all">
  <div class="fit-vids-style">
  ­<style>
    .fluid-width-video-wrapper{width:100%;position:relative;padding:0;}
    .fluid-width-video-wrapper iframe,.fluid-width-video-wrapper object,.fluid-width-video-wrapper embed{position:absolute;top:0;left:0;width:100%;height:100%;}
  </style>
  </div>
  <script type="text/javascript" src="static_files/jquery.js"></script>
  <script type="text/javascript" src="static_files/responsive-modernizr.js"></script>
  <script type="text/javascript" src="static_files/core.js"></script>
</head>

<script type="text/javascript">
  $(document).ready(function() {
    champ.construct();
  });
</script>

<body class="home blog">

<div id="container" class="hfeed">

  <div id="header">

    <ul id="menu-top" class="top-menu">
      <li id="menu-item-724" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-724">
        <a href="">Report</a>
      </li>
      <li id="menu-item-725" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-725">
        <a href="">Rules</a>
      </li>
    </ul>


    <div id="logo">
      <h1 class="header-title">Champions League</h1>
    </div><!-- end of #logo -->

    <?php $champ_str = (isset($_GET['champ_id']) && $_GET['champ_id']) ? '?champ_id=' . $_GET['champ_id'] : ''; ?>

    <ul id="menu-main" class="menu l_tinynavNaN">
      <li id="menu-item-761" class="menu-item menu-item-type-custom menu-item-object-custom current-menu-item current_page_item menu-item-home menu-item-761">
        <a href="index.php">Home</a>
      </li>
      <li id="menu-item-775" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-775">
        <a href="champ.php<?php echo $champ_str; ?>">Tournament</a>
        <ul class="sub-menu">
          <li id="menu-item-776" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-776"><a href="champ.php<?php echo $champ_str; ?>">Group Stage</a></li>
          <li id="menu-item-777" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-777"><a href="champ_playoff.php<?php echo $champ_str; ?>">Playoff</a></li>
        </ul>
      </li>
      <li id="menu-item-762" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-762">
        <a href="stats.php">Statistics</a>
        <ul class="sub-menu">
          <li id="menu-item-763" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-763">
            <a href="stats.php?type=rating">Rating</a>
          </li>
          <li id="menu-item-764" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-763">
            <a href="stats.php?type=games">Games</a>
          </li>
          <li id="menu-item-765" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-763">
            <a href="stats.php?type=medals">Medals</a>
          </li>
            <li id="menu-item-766" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-763">
                <a href="parties.php">Parties Charts</a>
            </li>
        </ul>
      </li>
      <li id="menu-item-780" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-775"><a href="">Start New Cup</a>
        <ul class="sub-menu">
          <li id="menu-item-781" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-776"><a href="new_champ.php">Personal</a></li>
          <li id="menu-item-782" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-777"><a href="new_champ.php?team=1">Team</a></li>
        </ul>
      </li>
      <li id="menu-item-781" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-775"><a href="team_champ.php">Battles</a>
      <li id="menu-item-781" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-775"><a href="logs.php">Logs</a>
    </ul>

    <?php
      $champs = champ::find_all();
    ?>

    <ul id="menu-sub" class="sub-header-menu">
      <?php foreach ($champs as $champ) : ?>
      <li id="menu-item-710" class="menu-item menu-item-type-taxonomy menu-item-object-category menu-item-710"><a href="champ.php?champ_id=<?php echo $champ['champ_id']; ?>"><?php echo $champ['title']; ?></a></li>
      <?php endforeach; ?>
    </ul>
  </div><!-- end of #header -->

  <div id="wrapper" class="clearfix">