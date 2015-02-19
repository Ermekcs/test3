
<?php require_once './templates/header.tpl'; ?>

<div id="featured" class="grid col-940">

  <?php $this->render('stats_' . $this->type); ?>

</div><!-- end of #featured -->


<?php require_once './templates/footer.tpl'; ?>