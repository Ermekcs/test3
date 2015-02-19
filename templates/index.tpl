
<?php require_once './templates/header.tpl'; ?>

<div id="featured" class="grid col-940">
  <div style="display:none">
    <div class="grid col-460">
      <h2 class="featured-subtitle">Главные новости - Январь</h2>
      <p>I Чемпионат по PES 2012</p>
      <img class="aligncenter" src="static_files/champ_1.jpg" style="height: 200px; display: block"  alt="" height="300">
      <p>Бавария - чемпион!!!</p>
    </div>

    <div id="featured-image" class="grid col-460 fit">
        <img class="aligncenter" src="static_files/main.jpg" alt="" height="300" width="420">
    </div><!-- end of #featured-image -->

    <div class="grid col-940" style="padding: 2px 0px;">
      <a style="float: left; margin-left: 400px;" href="javascript://" onclick="show_news('prev', $(this));">Prev</a>
      <a style="float: right; margin-right: 400px;" href="javascript://" onclick="show_news('next', $(this));">Next</a>
      <div class="clear"></div>
    </div>
  </div>
  
  <div style="">
    <div class="grid col-460">
      <h2 class="featured-subtitle">Главные новости - Февраль</h2>
      <p>II Чемпионат по PES 2012</p>
      <img class="aligncenter" src="static_files/champ_2.jpg" style="height: 200px; display: block"  alt="" height="300">
      <p>Волевая победа!!!</p>
    </div>

    <div id="featured-image" class="grid col-460 fit">
        <img class="aligncenter" src="static_files/main.jpg" alt="" height="300" width="420">
    </div><!-- end of #featured-image -->

    <div class="grid col-940" style="padding: 2px 0px;">
      <a style="float: left; margin-left: 400px;" href="javascript://" onclick="show_news('prev', $(this));">Prev</a>
      <a style="float: right; margin-right: 400px;" href="javascript://" onclick="show_news('next', $(this));">Next</a>
      <div class="clear"></div>
    </div>
  </div>  



</div><!-- end of #featured -->





<div id="widgets" class="home-widgets">
  <div class="grid col-300">

    <div class="widget-wrapper">

      <div class="widget-title-home"><h3>Чемпионы Лиги</h3></div>
      <div class="textwidget">
          <ul>
              <li>Равшан (Бавария)</li>
              <li>Медер (Реал Мадрид)</li>			  
          </ul>
      </div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 -->

  <div class="grid col-300">

    <div class="widget-wrapper">

        <div class="widget-title-home"><h3>Факты чемпионата</h3></div>
        <div class="textwidget">
            <ul>
                <li>Медер - действующий чемпион</li>
                <li>Равшан - предыдущий чемпион</li>
                <li title="Всегда выходит в финал">Супер стабильные игроки - Равшан, Медер</li>	
				<li titkle="Всегда выходит из группы">Стабильные игроки - Равшан, Медер, Эльдар</li>				
            </ul>
        </div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 -->

  <div class="grid col-300 fit">

    <div class="widget-wrapper">

        <div class="widget-title-home"><h3>Рейтинг чемпионата</h3></div>
        <div class="textwidget">
            <ul>
                <?php $count = 0; foreach ($this->total as $player_id => $point) : ?>
                <?php if ($count == 5) { break; }?>
                <li><?php echo $this->stats_players[$player_id]['name']; ?> - <?php echo (int)$point; ?></li>
                <?php $count++; endforeach; ?>
            </ul>
        </div>

    </div><!-- end of .widget-wrapper -->

  </div><!-- end of .col-300 fit -->
</div><!-- end of #widgets -->

<?php require_once './templates/footer.tpl'; ?>