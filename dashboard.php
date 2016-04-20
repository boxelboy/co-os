<?php

	$dbStuff = new dbStuff();
	$connection = $dbStuff->Connect($dbhost, $dbuser, $dbpass, $dbname);
	$errmsg = "";
	
	if ($_SERVER['REQUEST_METHOD'] == "POST")
	{
	}
	
?>
<?php
	if (isset($_SESSION["valid_user"])) :
	coos_set_title('Welcome,&nbsp;' . $dbStuff->getName());
?>
       
	<div class="column column-6-6 column-first">
		<div class="column column-6-2 column-first">
            <h3 class="column-inner dgrey-inner info-box-title">Messageboard</h3>
            <div class="column-inner white-inner info-box">
                <p>Click <a href="?pid=36">here</a> to view all of the messages posted to the community.</p>
                <hr/>
				<?php $dbStuff->getActive(4); ?>
			</div>
            <h3 class="column-inner dgrey-inner info-box-title"><?php echo ACTIVEIDEAS; ?></h3>
            <div class="column-inner white-inner info-box">
                <p>Checkout these recent ideas, have you cast your vote?</p>
                <hr/>
				<?php $dbStuff->getActive(0); ?>
			</div>
            <h3 class="column-inner dgrey-inner info-box-title"><?php echo ACTIVEJOBS; ?></h3>
            <div class="column-inner white-inner info-box">
                <p>Bidding on these proposals is closing soon, make sure you don't miss out!</p>
                 <hr/>
				<?php $dbStuff->getActive(1); ?>
            </div>
            <h3 class="column-inner dgrey-inner info-box-title"><?php echo ACTIVEPROJECTS; ?></h3>
            <div class="column-inner white-inner info-box">
                <p>These projects are currently being worked on</p>
                 <hr/>
				<?php $dbStuff->getActive(2); ?>
            </div>
            <h3 class="column-inner dgrey-inner info-box-title">Archived Projects</h3>
            <div class="column-inner white-inner info-box">
                <p>These are completed projects</p>
                 <hr/>
				<?php $dbStuff->getActive(3); ?>
                <p><a href='?pid=9' title='link to archived projects'>Click for more</a></p>
            </div>
		</div>
		<div class="column column-6-2">
			<h3 class="column-inner dgrey-inner info-box-title">Latest Activity</h3>
			<div class="column-inner white-inner info-box" id="activity-feed">
				<?php $dbStuff->getActivity(); ?>
            </div>
		</div>    
        <div class="column column-6-2 column-last">
            
            <div class="column column-6-3 column-first" style="margin-bottom:10px;">
            <a href="?pid=20"><img src="../_assets/images/suggest.gif" alt="<?php echo SUGGEST; ?>" width="150" height="26" border="0" /></a>
          </div>
            <div class="column column-6-3 column-last" style="margin-bottom:10px;">
            <a href="?pid=2"><img src="../_assets/images/pitch.gif" alt="Pitch a new idea" width="151" height="27" /></a>
          </div>
      <div class="column column-6-6 column-first">
                <form action="?pid=23" method="post"  >
                  <h3 class="column-inner dgrey-inner info-box-title"><?php echo SEARCH; ?></h3>
                  <fieldset class="column-inner white-inner info-box">
                    <label for="find" class="column column-6-5 column-first"> Keyword(s): <span class="form-text-wrap">
                      <input type="text" class="form-input-text" name="find" />
                      </span> </label>
                    <!--<input type="submit" value="Go" class="form-button form-input-submit column column-6-1 column-last" id="search-button" />-->
            	<INPUT TYPE="image" SRC="../_assets/images/go.gif" HEIGHT="27" WIDTH="29" BORDER="0" ALT="Submit Form" value="Go" style="margin-top:10px;" />
                  </fieldset>
                </form>            
                
                <?php
					$no_ideas = $dbStuff->getYourStuff(0);
					$no_collab = $dbStuff->getYourStuff(1);
					$no_tenders = $dbStuff->getYourStuff(5);
				?>
                <h4 class="column-inner dgrey-inner info-box-title"><?php echo YOURIDEAS; ?></h4>
                <div class="column-inner white-inner info-box">
                    <p>You have <?php echo $no_ideas; ?> ideas on the go</p>
                	<?php if($no_ideas > 0) : ?>                    
                    <?php $dbStuff->getYourStuff(14); ?>
                    <?php endif; ?>
                </div>
                
                <h4 class="column-inner dgrey-inner info-box-title"><?php echo YOURJOBS; ?></h4>
                <div class="column-inner white-inner info-box">
                    <p>You have <?php echo $no_collab; ?> collaborations available for bidding</p>
                	<?php if($no_collab > 0) : ?>                    
                    <?php $dbStuff->getYourStuff(15); ?>
                    <?php endif; ?>
                </div>
                <h4 class="column-inner dgrey-inner info-box-title"><?php echo YOURTENDERS; ?></h4>
                <div class="column-inner white-inner info-box">                
                    <p>You are bidding on the following jobs:</p>
                  	<hr/><ul class='unstyled-list'>
                	<?php //if($no_tenders > 0) : ?>                    
                    <?php print $no_tenders; ?>
                    <?php //endif; ?>
                    </ul>
                </div>
            </div>                
        </div>
    </div>
<?php
endif;
?>
<?php if(!$_SESSION["valid_user"]) : ?>
<p>You need to be logged in to view this page. Please click <a title='link to login' href="/">here</a></p>
<?php
endif;
?>