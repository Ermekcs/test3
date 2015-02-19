
<?php require_once './templates/header.tpl'; ?>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
    window.my_chart_types = {
        'count': ['Party Members', <?php echo json_encode($this->party_count); ?>],
        'scores': ['Party Scores', <?php echo json_encode($this->party_scores); ?>],
        'won': ['Party Won', <?php echo json_encode($this->party_won); ?>],
        'lost': ['Party Lost', <?php echo json_encode($this->party_lost); ?>],
        'gf': ['Party Goal For', <?php echo json_encode($this->party_goal_for); ?>],
        'ga': ['Party Goal Against', <?php echo json_encode($this->party_goal_against); ?>]
    };

    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart() {
        var type = 'scores';
        var data = google.visualization.arrayToDataTable(window.my_chart_types[type][1]);
        var options = {title: my_chart_types[type][0]};

        var chart = new google.visualization.PieChart(document.getElementById('my_chart'));
        chart.draw(data, options);

        window.chart = chart;


    }

    function reDrawChart(type) {
        if (!type) {
            type = 'count';
        }

        chart.clearChart();
        var data = google.visualization.arrayToDataTable(window.my_chart_types[type][1]);
        var options = {title: my_chart_types[type][0]};
        chart.draw(data, options);
    }
</script>



<div id="featured" class="grid col-940">

  <h1 class="featured-title">Parties</h1>
  <div class="clear"></div>

  <div>
      <div class="grid col-700">
          <div class="party_charts" id="my_chart" style="width: 100%; height: 500px;"></div>
      </div>
      <div class="grid col-220 fit">
          <h4>Chart Types</h4>
          <ul>
              <li style="cursor: pointer;" onclick="reDrawChart('count');">Members Count Chart</li>
              <li style="cursor: pointer;" onclick="reDrawChart('scores')">Parties Scores Chart</li>
              <li style="cursor: pointer;" onclick="reDrawChart('won')">Parties Won Chart</li>
              <li style="cursor: pointer;" onclick="reDrawChart('lost')">Parties Lost Chart</li>
              <li style="cursor: pointer;" onclick="reDrawChart('gf')">Parties Goal For Chart</li>
              <li style="cursor: pointer;" onclick="reDrawChart('ga')">Parties Goal Against Chart</li>
          </ul>

          <h4>Parties</h4>
          <ul>
              <?php foreach ($this->party_members as $key => $party) : ?>
              <li>
                  <span style="cursor: pointer;" onclick="$('.party_members').not('#party_key_<?php echo $key; ?>').addClass('display_none'); $(this).next().toggleClass('display_none')"><?php echo $party['title']; ?></span>
                  <ul id="party_key_<?php echo $key; ?>" class="party_members display_none">
                      <?php foreach ($party['members'] as $member) : ?>
                      <li><?php echo $member; ?></li>
                      <?php endforeach; ?>
                  </ul>
              </li>
              <?php endforeach; ?>
          </ul>
      </div>
      <div class="clear"></div>
  </div>

</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>