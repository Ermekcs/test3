<?php require_once './templates/header.tpl'; ?>

<script type="text/javascript">
    $(document).ready(function() {
        $('.champ_tbl a').bind('click', function() {
            showAllGames($(this).text().trim());
        });
    });

    function showAllGames(opp_name) {
        var player_name = $('h1.featured-title').text().trim();
        if (opp_name == player_name) {
            $('.champ_tbl tr').show();
            return;
        }

        $('.champ_tbl tr').each(function(index, $item) {
            $item = $($item);

            var players = [$item.find('a').first().text().trim(), $item.find('a').last().text().trim()];
            if ($.inArray(opp_name, players) < 0) {
                $item.hide();
            }
        });
    }


</script>

<div id="featured" class="grid col-940">
    <h1 class="featured-title" style="width: 80%; margin-left: 30px; text-align: left; font-size: 30px;"><?php echo $this->player_info['name']; ?></h1>
    <p></p>


    <div style="margin-left: 30px;">
        <div>
            <table style="margin: auto; width: 80%;" class="champ_tbl">
            <?php foreach ($this->games as $game) : ?>
                <tr>
                    <td><?php echo $this->helper_player($this->players[$game['player1']], array('href' => 'javascript://')); ?></td>
                    <td><span <?php echo ($game['point1'] == 11) ? ' class="bold_text" ' : '' ?>><?php echo $game['point1']; ?></span></td>
                    <td><span <?php echo ($game['point2'] == 11) ? ' class="bold_text" ' : '' ?>><?php echo $game['point2']; ?></span></td>
                    <td><?php echo $this->helper_player($this->players[$game['player2']], array('href' => 'javascript://')); ?></td>
                </tr>
            <?php endforeach; ?>
            </table>
        </div>
    </div>

    <br/>
</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>