/**
 * Created with JetBrains PhpStorm.
 * User: eldargaliev
 * Date: 8/18/12
 * Time: 12:58 AM
 * To change this template use File | Settings | File Templates.
 */

var champ = {

  champ_id: 0,
  team_champ: false,
  play_off: (location.href.indexOf('champ_playoff') > -1),

  construct : function() {
    if (this.team_champ) {
      this.bind_team_games();
    } else {
      this.bind_games();
      this.bind_groups();
    }
    if (this.play_off) {
      this.bind_extra();
      this.bind_penalties();
    }
  },

  bind_groups: function () {
    var self = this;
    $('.champ_group .refresh_btn').unbind('click').bind('click', function() {
      var group_id = $(this).attr('id').split('_')[1];
      var $group = $(this).parents('.champ_tbl').parent();
      $group.load('champ.php?action=refresh_group', {'group_id': group_id}, function() {
        self.bind_groups();
      });
    });
  },

  bind_extra: function () {
    var self = this;
    $('.champ_group .extra').unbind('click').bind('click', function() {
      var $game = $(this);
      $game.toggleClass('active');
      var game_id = $game.data('game_id');
      var extra = $game.hasClass('active') ? 1 : 0;
      $.ajax({
        'type': 'post',
        'dataType': 'json',
        'url': 'champ.php?action=set_extra',
        'data': {game_id: game_id, extra: extra},
        'success': function(response) {
          if (response.result == -1) {
            $game.toggleClass('active');
          }
        }
      });
    });
  },

  bind_games: function() {
    var self = this;
    $('.game_point').bind('change', function() {
      var $opp1 = $(this);
      var $parent = $opp1.parents('.champ_game');

      var opp_sel = $opp1.hasClass('player1') ? '.player2' : '.player1';
      var $opp2 = $parent.find(opp_sel);

      //check value;
      var point1 = parseInt($opp1.val().trim());
      point1 = (point1) ? point1 : 0;
      $opp1.val(point1);
      var point2 = parseInt($opp2.val().trim());

      if ((!point1 && point1 != 0) || (!point2 && point2 != 0)) {
        return;
      }

      if (self.play_off && point1 == point2) {
        $parent.find('.extra').removeClass('active').click();
        $parent.find('.game_penalty').css('visibility', 'visible');
        return;
      } else {
        $parent.find('.game_penalty').css('visibility', '');
      }

      self.set_winner(point1, point2, $opp1, $opp2);

      var game_id = $opp1.attr('name').split('_')[1];
      var opp_id1 = $opp1.attr('name').split('_')[2];
      var opp_id2 = $opp2.attr('name').split('_')[2];

      var group_id = $opp1.parents('.champ_group').attr('id').split('_')[1];

      $.ajax({
        'type': 'post',
        'dataType': 'json',
        'url': 'champ.php?action=save_game',
        'data': {
          'game_id': game_id, 'player1': opp_id1, 'point1': point1,
          'player2': opp_id2, 'point2': point2, 'group_id': group_id
        },
        'success': function(response) {
          if (response.result == -1) {
            $opp1.val('');
            $opp2.val('');
          }
        }
      });
    });
  },

  bind_penalties: function() {
    var self = this;
    $('.game_penalty').bind('change', function() {
      var $pen1 = $(this);
      var $parent = $pen1.parents('.champ_game');
      var opp_sel = $pen1.hasClass('penalty1') ? '.penalty2' : '.penalty1';

      var $opp1 = $pen1.prev();
      var $pen2 = $parent.find(opp_sel);
      var $opp2 = $pen2.prev();

      //check value;
      var point1 = parseInt($opp1.val().trim());
      point1 = (point1) ? point1 : 0;
      $opp1.val(point1);
      var point2 = parseInt($opp2.val().trim());

      if ((!point1 && point1 != 0) || (!point2 && point2 != 0)) {
        return;
      }

      var pen1 = parseInt($pen1.val().trim());
      pen1 = (pen1) ? pen1 : 0;
      $pen1.val(pen1);
      var pen2 = parseInt($pen2.val().trim());

      if ((!pen1 && pen1 != 0) || (!pen2 && pen2 != 0)) {
        return;
      }

      var val1 = 1, val2 = 1;
      val1 = (pen1 > pen2) ? 2 : 0;

      self.set_winner(val1, val2, $opp1, $opp2);

      var game_id = $opp1.attr('name').split('_')[1];
      var opp_id1 = $opp1.attr('name').split('_')[2];
      var opp_id2 = $opp2.attr('name').split('_')[2];

      var group_id = $opp1.parents('.champ_group').attr('id').split('_')[1];

      $.ajax({
        'type': 'post',
        'dataType': 'json',
        'url': 'champ.php?action=save_game',
        'data': {
          'game_id': game_id, 'group_id': group_id,
          'player1': opp_id1, 'point1': point1, 'penalty1': pen1,
          'player2': opp_id2, 'point2': point2, 'penalty2': pen2
        },
        'success': function(response) {
          if (response.result == -1) {
            $pen1.val('');
            $pen2.val('');
          }
        }
      });
    });
  },

  set_winner: function(point1, point2, $opp1, $opp2) {
    if (point1 < 0 || point2 < 0) {
      $opp1.parents('tr').removeClass('winner').removeClass('draw');
      $opp2.parents('tr').removeClass('winner').removeClass('draw');
    } else if (point1 == point2) {
      $opp1.parents('tr').removeClass('winner').addClass('draw');
      $opp2.parents('tr').removeClass('winner').addClass('draw');
    } else if (point1 > point2) {
      $opp1.parents('tr').removeClass('draw').addClass('winner');
      $opp2.parents('tr').removeClass('winner').removeClass('draw');
    } else if (point1 < point2) {
      $opp1.parents('tr').removeClass('winner').removeClass('draw');
      $opp2.parents('tr').removeClass('draw').addClass('winner');
    }
  },

  bind_team_games: function() {
    var self = this;
    $('.game_point').bind('change', function() {
      var $opp1 = $(this);
      var $parent = $opp1.parents('.champ_game');
      var pair_game = $parent.hasClass('pair_game') ? 1 : 0;

      var opp_sel = $opp1.hasClass('player1') ? '.player2' : '.player1';
      var $opp2 = $parent.find(opp_sel);

      //check value;
      var point1 = parseInt($opp1.val().trim());
      point1 = (point1) ? point1 : 0;
      $opp1.val(point1);

      var win_point = (pair_game) ? 21 : 11;

      //set opponent result
      if (point1 != win_point) { $opp2.val(win_point); }
      var point2 = $opp2.val();
      if (point1 == win_point && point2 == win_point) {$opp2.val(''); point2 = '';}
      if (point2 == '') {
        return false;
      }

      if (parseInt(point1) == win_point) {
        $opp1.parents('td').addClass('winner');
        $opp2.parents('td').removeClass('winner');
      } else {
        $opp2.parents('td').addClass('winner');
        $opp1.parents('td').removeClass('winner');
      }

      if (parseInt(point1) > win_point || parseInt(point2) > win_point) {
        $opp1.parents('td').removeClass('winner');
        $opp2.parents('td').removeClass('winner');
      }

      var game_id = $opp1.attr('name').split('_')[1];
      var opp_id1 = $opp1.attr('name').split('_')[2];
      var opp_id2 = $opp2.attr('name').split('_')[2];


      $.ajax({
        'type': 'post',
        'dataType': 'json',
        'url': 'team_champ.php?action=save_game',
        'data': {
          'game_id': game_id, 'player1': opp_id1, 'point1': point1,
          'player2': opp_id2, 'point2': point2, 'champ_id': self.champ_id, 'pair_game': pair_game
        },
        'success': function(response) {
          if (response.result == -1) {
            $opp1.val('');
            $opp2.val('');
          }
        }
      });
    });
  }
};


function show_news(direction, $node) {
  if (direction == 'prev') {
    if ($node.parent().parent().prev().length == 0) {
      return;
    }
    $node.parent().parent().hide();
    $node.parent().parent().prev().show();
  } else {
    if ($node.parent().parent().next().length == 0) {
      return;
    }
    $node.parent().parent().hide();
    $node.parent().parent().next().show();
  }
}