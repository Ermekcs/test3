
<?php require_once './templates/header.tpl'; ?>

<form action="" method="post">
<div id="featured" class="grid col-940">
  <div class="grid col-460">

    <h1 class="featured-title">New Champ</h1>
    <h2 class="featured-subtitle">Random Drawing</h2>

    <div class="call-to-action">

      <a href="#nogo" class="blue button">Start new Tournament</a>
    </div><!-- end of .call-to-action -->


  </div><!-- end of .col-460 -->

  <div class="grid col-460 fit">
    <h2 class="featured-subtitle">Players</h2>
    <ul>
      <?php foreach ($players as $player) : ?>
      <li class="player_list col-300 grid">
        <input type="checkbox" name="players[]" value="<?php echo $player['player_id']; ?>" id="player_<?php echo $player['player_id']; ?>">
        <label for="player_<?php echo $player['player_id']; ?>"><?php echo $player['name']; ?></label>
      </li>
      <?php endforeach; ?>
      <li class="col-300 grid fit"></li>
    </ul>
  </div><!-- end of #featured-image -->

</div><!-- end of #featured -->
</form>


<div id="widgets" class="home-widgets">
  <div class="grid col-220">

    <div class="widget-wrapper">

      <div class="widget-title-home"><h3>Home Widget 1</h3></div>
      <div class="textwidget">This is your first home widget
        box. To edit please go to Appearance &gt; Widgets and choose 6th widget
        from the top in area six called Home Widget 1. Title is also manageable
        from widgets as well.</div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 -->

  <div class="grid col-220">

    <div class="widget-wrapper">

      <div class="widget-title-home"><h3>Home Widget 2</h3></div>
      <div class="textwidget">This is your second home widget
        box. To edit please go to Appearance &gt; Widgets and choose 7th widget
        from the top in area seven called Home Widget 2. Title is also
        manageable from widgets as well.</div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 -->

  <div class="grid col-220">

    <div class="widget-wrapper">

      <div class="widget-title-home"><h3>Home Widget 3</h3></div>
      <div class="textwidget">This is your third home widget
        box. To edit please go to Appearance &gt; Widgets and choose 8th widget
        from the top in area eight called Home Widget 3. Title is also
        manageable from widgets as well.</div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 fit -->

  <div class="grid col-220 fit">

    <div class="widget-wrapper">

      <div class="widget-title-home"><h3>Home Widget 4</h3></div>
      <div class="textwidget">This is your third home widget
        box. To edit please go to Appearance &gt; Widgets and choose 8th widget
        from the top in area eight called Home Widget 4. Title is also
        manageable from widgets as well.</div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-301 fit -->

</div><!-- end of #widgets -->

<?php require_once './templates/footer.tpl'; ?>