<?php

date_default_timezone_set('Europe/London');

include_once('includes/class.phpmailer.php');

class dbStuff {

	var $connection;
	//var $ideaTime = 864000; // 10 days
	//var $ideaTime = 36000; // 10 min
	//var $jobTime = 864000; // 10 days
	//var $jobTime = 36000; // 10 min

	function Connect($host, $name, $pass, $db){
		$this->connection = mysql_connect("$host","$name","$pass");
		mysql_select_db("$db", $this->connection);
	}
	
	function Close(){
		mysql_close($this->connection);
	}
	
	function FetchRow($query){
		$rows = mysql_fetch_row($query);
		return $rows;
	}

  	function FetchArray($query){
  		$array = mysql_fetch_array($query);
  		return $array;
  	}

  	function FetchNum($query){
  		$num = mysql_num_rows($query);
  		return $num;
  	}

  	function Query($sql){
  		$query = mysql_query($sql) or die(mysql_error());
		if (strpos(trim(strtolower($sql)), 'insert') == 0) $this->id = mysql_insert_id(); 
  		return array($query, $this->id);
  	}
  
	function getRating($pid)
	{
		$getRating = $this->Query("select count(rating), sum(rating) from rating where personID = '".$pid."'");
		$ans = $this->FetchRow($getRating[0]);
		if ($ans[0] == 0) {$rating = 0;} else {$rating = (($ans[1]/$ans[0])/3) * 100;}
		return round($rating,2);
	}

	function getSkill($skill)
	{
		$getRating = $this->Query("select skill from skills where id = '".$skill."'");
		$row = $this->FetchRow($getRating[0]);
		return $row[0];
	}

function updDots($rater, $person, $dots)
	{
		$result = $this->Query("select dots from dots where personID = '".$rater."'");
		$row = $this->FetchRow($result[0]);
		$newValue = $row[0] - $dots;
		$result = $this->Query("update dots set dots = '".$newValue."' where personID = '".$rater."'");
		
		$result = $this->Query("select dots from dots where personID = '".$person."'");
		$row = $this->FetchRow($result[0]);
		$newValue = $row[0] + $dots;
		$result = $this->Query("update dots set dots = '".$newValue."' where personID = '".$person."'");
	}
	
	function rate($jobid,$person,$score,$comment)
	{
		$result = $this->Query("insert into rating values ('$person','".$_SESSION['valid_user']."','$jobid','$score','$comment',now())");
	}
	
	function getStuff($n,$id)
	{
		switch ($n)
		{
			case 0:
			$query = $this->Query("SELECT count(*) FROM thing where flag = 'j'");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 1:
			$query = $this->Query("SELECT count(*) FROM person");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 2:
			$query = $this->Query("SELECT count(*) FROM thing");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 3:
			$reply = 0;
			$query = $this->Query("select dots from dots where dots <> 100");
			//$query = $this->Query("SELECT sum(bids.bid) FROM bids, dateTbl where dateTbl.dateComplete <> '0000-00-00 00:00:00' and dateTbl.thingID = bids.jobID");
			while ($row = $this->FetchRow($query[0]))
			{
				if ($row[0] > 100)
				{
					$reply += $row[0] - 100;
				}
				else
				{
					$reply += 100 - $row[0];
				}
			}
			break;
			case 4:
			$query = $this->Query("Select dots FROM dots where personID = '$id'");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 5:
			$query = $this->Query("select count(*) from bids where jobID = '".$id."'");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 6:
			$query = $this->Query("select count(*) from dateTbl where dateComplete <> '0000-00-00 00:00:00'");
			$ans = $this->FetchRow($query[0]);
			$reply = $ans[0];
			break;
			case 7:
			$query = $this->Query("select sum(bids.bid),count(personID) from bids");
			$ans = $this->FetchRow($query[0]);
			if ($ans[0] > 0) {$reply = number_format($ans[0]/$ans[1],1);} else {$reply = 0;}
			break;
		}
		return $reply;
	}
	
	function getBank($id)
	{
		$query = $this->Query("Select dots FROM dots where personID = '$id'");
		$ans = $this->FetchRow($query[0]);
		return $ans[0];
	}
	
	function getActive($n)
	{
		$now = time();
		switch ($n)
		{
			case 0:
			$query = $this->Query("select thing.id, thing.title, person.firstName from thing, person where thing.flag = 'i' and  thing.personID = person.id order by thing.id desc limit 10");
			echo "<ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = ($row[3] + $this->ideaTime()) - $now;
				echo "<li><a href='?pid=6&amp;id=$row[0]' title='Link to idea'>".stripslashes($row[1])." - ".stripslashes($row[2])."</a></li>";
			}
			echo "</ul>";
			break;
			
			case 1:
			$query = $this->Query("select thing.id, thing.title, person.firstName, UNIX_TIMESTAMP(dateTbl.dateClose) from thing, person, dateTbl where thing.flag = 'j' and thing.id = dateTbl.thingID and thing.personID = person.id order by dateTbl.dateAdded desc");
			echo "<ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[3] - $now;
				echo "<li><a href='?pid=7&amp;id=$row[0]' title='Link to job'>".stripslashes($row[1])." - ".stripslashes($row[2])." - ".$this->workoutTime($remain)."</a></li>";
			}
			echo "</ul>";
			break;
			
			case 2:
			$query = $this->Query("select thing.id, thing.title, person.firstName, UNIX_TIMESTAMP(dateTbl.dateClose) from thing, person, dateTbl where thing.flag = 'p' and thing.id = dateTbl.thingID and thing.personID = person.id order by dateTbl.dateAdded desc");
			echo "<ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[3] - $now;
				echo "<li><a href='?pid=10&amp;id=$row[0]' title='Link to project'>".stripslashes($row[1])."</a></li>";//" - ".stripslashes($row[2])." - ".$this->workoutTime($remain)."</a></li>";
			}
			echo "</ul>";
			break;
			
			case 3:
			$query = $this->Query("select thing.id, thing.title, person.firstName, UNIX_TIMESTAMP(dateTbl.dateClose) from thing, person, dateTbl where thing.flag = 'c' and thing.id = dateTbl.thingID and thing.personID = person.id order by dateTbl.dateAdded desc limit 10");
			echo "<ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[3] - $now;
				echo "<li><a href='?pid=10&amp;id=$row[0]' title='Link to project'>".stripslashes($row[1])." - ".stripslashes($row[2])."</a></li>";
			}
			echo "</ul>";
			break;
			
			case 4:
			$query = $this->Query("select msgBoard.id, msgBoard.title, person.firstName, UNIX_TIMESTAMP(msgBoard.dateTime) from msgBoard, person, dateTbl where msgBoard.personID = person.id order by msgBoard.dateTime desc limit 1");
			echo "<ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[3] - $now;
				echo "<li><a href='?pid=36' title='Link to message'>".stripslashes($row[1])." - ".stripslashes($row[2])."</a></li>";
			}
			echo "</ul>";
			break;
		}
	}
	
	function getActivity()
	{
		$query = $this->Query("select auditTrail.activity, person.firstName, auditTrail.ideaID, thing.flag, person.id from person, auditTrail, thing where person.id=auditTrail.personID and thing.id=auditTrail.ideaID order by auditTrail.dateTime desc limit 0, 20");
		echo "<ul>";
		while ($row = $this->FetchArray($query[0]))
		{
			switch ($row[3]) {
				case "i":
					$state = "new idea";
					$pid = 6;
					break;
				case "v":
					$state = "new idea";
					$pid = 6;
					break;
				case "j":
					$state = "job";
					$pid = 7;
					break;
				case "b":
					$state = "job";
					$pid = 7;
					break;
				case "p":
					$state = "project";
					$pid = 10;
					break;
				case "c":
					$state = "project";
					$pid = 10;
					break;
				case "w":
					$state = "withdrawn";
					$pid = 33;
					break;
				default:
					$state = $row[3];
					break;
			}
			switch ($row[0]) {
				case "c":
					$verb = "commented on";
					break;
				case "v":
					$verb = "voted on";
					break;
				case "n":
					$verb = "posted";
					break;
				case "m":
					$verb = "posted to the messageboard";
					$pid = 36;
					break;
				default:
					$verb = "oopsie";
					break;
			}
			if ($row[0] == "m")
			{
				$res = $this->Query("select title from msgBoard where id = '".$row[2]."'");
				$msg = $this->FetchRow($res[0]);
				$blurb = "'<a href='?pid=".$pid."' title='view messageboard'>".stripslashes($msg[0])."</a>'";
			}
			else
			{
				$res = $this->Query("select title from thing where id = '".$row[2]."'");
				$msg = $this->FetchRow($res[0]);
				$blurb = "'<a href='?pid=".$pid."&amp;id=$row[2]' title='view idea'>".stripslashes($msg[0])."</a>'";
			}
			echo "<li><a href='?pid=16&amp;id=$row[5]' title='link to view profile'>".stripslashes($row[1])."</a> ".$verb." ".$blurb."</li>";
		}
		echo "</ul>";
	}
	
	function getName()
	{
		$query = $this->Query("select firstName from person where id = '".$_SESSION['valid_user']."'");
		$row = $this->FetchRow($query[0]);
		return $row[0];
	}
	
	function getYourStuff($n)
	{
		switch ($n)
		{
			case 0:
			// idea count
			$query = $this->Query("select count(*) from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'i'");
			$ans = $this->FetchRow($query[0]);
			return $ans[0];
			break;
			case 1:
			// bids count
			$query = $this->Query("select count(*) from thing where thing.personID = '".$_SESSION["valid_user"]."' and flag = 'j'");
			$ans = $this->FetchRow($query[0]);
			return $ans[0];
			break;
			case 2:
			// job count
			$query = $this->Query("select count(*) from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'j'");
			$ans = $this->FetchRow($query[0]);
			return $ans[0];
			break;
			case 3:
			// list of ideas
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and (flag = 'i' or flag = 's')");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=6&amp;id=$row[1]' title='view job'>".stripslashes($row[0])."</a> - <a href='withdraw.php?id=$row[1]' title='Withdraw'><img src='/_assets/images/withdraw.gif' alt='Withdraw idea' /></a></li>";}
			break;
			case 4:
			// list of jobs
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'j'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=7&amp;id=$row[1]' title='view job'>$row[0]</a> - <a href='withdrawJob.php?id=$row[1]' title='Withdraw'><img src='/_assets/images/withdraw.gif' alt='Withdraw collaboration' /></a></li>";}
			break;
			case 5:
			// list of bids
			$bids = '';
			$query = $this->Query("select distinct thing.title, thing.id from thing, bids where thing.flag = 'j'and bids.personID = '".$_SESSION["valid_user"]."' and bids.jobID = thing.id");
			if ($this->FetchNum($query[0]) > 0)
			{
				echo "<ul>";
				while ($row = $this->FetchArray($query[0])) { $bids .= "<li style='list-style:none'><a href='?pid=7&amp;id=$row[1]' title='view job'>".stripslashes($row[0])."</a></li>";}
				echo "</ul>";
				return $bids;
			}
			else
			{
				return "<p>No bids in progress</p>";
			}
			break;
			case 6:
			// list of projects
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'p'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=10&amp;id=$row[1]' title='Link to projectpage'>".stripslashes($row[0])."</a></li>";}
			break;
			case 7:
			// list of rejected ideas
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'r'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=11&amp;id=$row[1]'>".stripslashes($row[0])."</a> - <a title='amend and resubmit idea' href='?pid=12&amp;id=$row[1]'><img src='/_assets/images/advertise.gif' alt='amend and resubmit idea' /></a></li>";}
			break;
			case 8:
			// list of closed jobs
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'b'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=11&amp;id=$row[1]'>".stripslashes($row[0])."</a></li>";}
			break;
			case 9:
			// list of jobs with no bids
			$query = $this->Query("select title from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'd'");
			while ($row = $this->FetchArray($query[0])) {echo "<li>$row[0]</li>";}
			break;
			case 10:
			// projects you're working on
			$res = $this->Query("select title, id, winBid from thing where personID <> '".$_SESSION["valid_user"]."' and flag = 'p'");
			echo "<ul>";
			while ($row = $this->FetchArray($res[0]))
			{
				if (@unserialize($row[2]))
				{
					$query = $this->Query("select id from bids where bids.personID = '".$_SESSION["valid_user"]."'");
					while ($r = $this->FetchArray($query[0]))
					{
						if (in_array($r[0],unserialize($row[2]))) {echo "<li><a href='?pid=10&amp;id=$row[1]'>$row[0]</a></li>";}
					}
				}
			}
				
			echo "</ul>";
			break;
			case 11:
			// list of ideas to be upgraded to jobs
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'v'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=6&id=".$row[1]."'>".stripslashes($row[0])."</a> - <a href='?pid=14&amp;id=$row[1]' title='Upgrade to collaboration'><img src='/_assets/images/advertise.gif' alt='Upgrade to collaboration' /></a>&nbsp;<a href='withdraw.php?id=$row[1]' title='Withdraw'><img src='/_assets/images/withdraw.gif' alt='Withdraw idea' /></a></li>";}
			break;
			case 12:
			// list of withdrawn
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'w'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=6&id=".$row[1]."'>$row[0]</a> - <a href='?pid=12&amp;id=$row[1]' title='amend and resubmit'><img src='/_assets/images/advertise.gif' alt='amend and resubmit' /></a></li>";}
			break;
			case 13:
			// list of projects
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'c'");
			while ($row = $this->FetchArray($query[0])) {echo "<li><a href='?pid=10&amp;id=$row[1]' title='Link to projectpage'>".stripslashes($row[0])."</a></li>";}
			break;
			case 14:
			//
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'i' order by id desc");
			echo "<hr/><ul class='unstyled-list'>";
			while ($row = $this->FetchArray($query[0])) {echo "<li class='sortable'><a href='?pid=6&amp;id=$row[1]' title='view job'>".stripslashes($row[0])."</a></li>";}
			echo "</ul>";
			break;
			case 15:
			//
			$query = $this->Query("select title, id from thing where personID = '".$_SESSION["valid_user"]."' and flag = 'j' order by id desc");
			echo "<hr/><ul class='unstyled-list'>";
			while ($row = $this->FetchArray($query[0])) {echo "<li class='sortable'><a href='?pid=7&amp;id=$row[1]' title='view job'>".stripslashes($row[0])."</a></li>";}
			echo "</ul>";
			break;
			case 16:
			// projects you worked on that are now complete
			$res = $this->Query("select title, id, winBid from thing where personID <> '".$_SESSION["valid_user"]."' and flag = 'c'");
			echo "<ul>";
			while ($row = $this->FetchArray($res[0]))
			{
				if (@unserialize($row[2]))
				{
					$query = $this->Query("select id from bids where bids.personID = '".$_SESSION["valid_user"]."'");
					while ($r = $this->FetchArray($query[0]))
					{
						if (in_array($r[0],unserialize($row[2]))) {echo "<li><a href='?pid=10&amp;id=$row[1]'>$row[0]</a></li>";}
					}
					echo "<br />";
				}
			}
				
			echo "</ul>";
			break;
		}
	}
	
	function listPosts($sort)
	{
		$now = time();
		if (isset($sort))
		{$sql = "select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, person where thing.flag = 'i' and person.id = thing.personID order by thing.title asc";}
		else
		{$sql = "select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, person where thing.flag = 'i' and person.id = thing.personID order by thing.id desc";}
		$query = $this->Query($sql);
		if ($this->FetchNum($query[0]) <> 0)
		{
			while ($row = $this->FetchArray($query[0]))
			{
				//$remain = ($row[2] + $this->ideaTime()) - $now;
				echo "<tr><td><p><a href='?pid=6&amp;id=$row[0]' title='View idea'>".stripslashes($row[1])."</a></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[4])."' title='view profile'>".$row[2]." ".$row[3]."</a></p></td>";
					$views = $this->getViews($row[0]);
					echo "<td><p>".$views."</p></td></tr>";
			}
		}
		else
		{
			echo "<tr><td colspan='4'><p>No current ideas</p></td></tr>";
		}
		echo "<tr><td colspan='4'>&nbsp;</td></tr>";
		echo "<tr><td><h4>Old ideas</h4></td></tr>";
		echo "<tr><th><h4>Title</h4></th><th><h4>Proposer</h4></th><th><h4>Votes</h4></th><th>&nbsp;</th></tr>";
		$query = $this->Query("select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, dateTbl, person where (thing.flag <> 'i') and person.id = thing.personID and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		while ($row = $this->FetchArray($query[0]))
		{
			$remain = ($row[2] + $this->ideaTime()) - $now;
			echo "<tr><td><p><a href='?pid=33&amp;id=$row[0]' title='View idea'>".stripslashes($row[1])."</a></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[4])."' title='view profile'>".$row[2]." ".$row[3]."</a></p></td>";
				$views = $this->getViews($row[0]);
				echo "<td><p>".$views."</p></td></tr>";
		}
	}
	
	function listJobs($sort)
	{
		$now = time();
		if (isset($sort))
		{
			switch ($sort) {
				case "p":
					$sql = "select UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName, person.id from dateTbl, thing, person where thing.flag = 'j' and thing.personID = person.id and dateTbl.thingID = thing.id order by person.firstName asc";
					break;
				case "r":
					$sql = "select UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName, person.id from dateTbl, thing, person where thing.flag = 'j' and thing.personID = person.id and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc";
					break;
				case "t":
					$sql = "select UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName, person.id from dateTbl, thing, person where thing.flag = 'j' and thing.personID = person.id and dateTbl.thingID = thing.id order by thing.title asc";
					break;
			}
		}
		else
		{
			$sql = "select UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName, person.id from dateTbl, thing, person where thing.flag = 'j' and thing.personID = person.id and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc";
		}
		$query = $this->Query($sql);
		if ($this->FetchNum($query[0]) <> 0)
		{
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[0] - $now;
					echo "<tr><td><p>".$this->workoutTime($remain)."</p></td><td><p><a href='?pid=7&amp;id=$row[1]' title='View job'>".stripslashes($row[2])."</a></p></td><td><p><a href='?pid=16&amp;id=".$row[5]."' title='view profile'>".$row[3]." ".$row[4]."</a></p></td>";
					//echo "<td><p>".$this->getViews($row[1])."</p></td></tr>";
					echo "</tr>";
			}
		}
		else
		{
			echo "<tr><td colspan='4'><p>No current collaborations</p></td></tr>";
		}
		echo "<tr><td colspan='4'>&nbsp;</td></tr>";
		echo "<tr><td><h4>Old collaborations</h4></td></tr>";
		echo "<tr><th><h4>Title</h4></th><th><h4>Proposer</h4></th><th>&nbsp;</th></tr>";//<th><h4>Votes</h4></th><th>&nbsp;</th></tr>";
		$query = $this->Query("select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, dateTbl, person where (thing.flag = 'b' or thing.flag = 'd') and person.id = thing.personID and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		//while ($row = $this->FetchArray($query[0]))
		//{
		//	$remain = ($row[2] + $this->ideaTime()) - $now;
		//	echo "<tr><td><p><a href='?pid=7&amp;id=$row[0]' title='View idea'>".stripslashes($row[1])."</a></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[4])."' title='view profile'>".$row[2]." ".$row[3]."</a></p></td>";
		//		$views = $this->getViews($row[0]);
		//		echo "<td><p>".$views."</p></td></tr>";
		//}
	}
	
	function listProjects()
	{
		$now = time();
		$query = $this->Query("select thing.id, thing.title from thing where thing.flag = 'p'");
		if ($this->FetchNum($query[0]) <> 0)
		{
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<li><a href='?pid=10&amp;id=".$row[0]."' title='Link to project'>".stripslashes($row[1])."</a></li>";
			}
		}
		else
		{
			echo "<tr><td colspan='4'><p>No current projects</p></td></tr>";
		}
		echo "<p>&nbsp;</p>";
		echo "<table>";
		echo "<tr><td><h4>Old projects</h4></td></tr>";
		echo "<tr><th><h4>Title</h4></th><th><h4>Proposer</h4></th></tr>";
		$query = $this->Query("select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, person, dateTbl where (thing.flag = 'c' or thing.flag = 'cc') and person.id = thing.personID and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		if ($this->FetchNum($query[0]) <> 0)
		{
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<tr><td><p><a href='?pid=10&amp;id=".$row[0]."' title='Link to project'>".stripslashes($row[1])."</a></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[4])."' title='view profile'>".$row[2]." ".$row[3]."</a></p></td></tr>";
			}
		}
		echo "</table>";
	}
	
	function getSearch($word,$n)
	{
		$now = time();
		switch($n)
		{
			case 1:
			$query = $this->Query("select thing.id, thing.title, person.firstName, person.lastName from thing, person where (thing.flag = 'i' or thing.flag = 'r' or thing.flag = 'v') and thing.title like '%".$word."%' and thing.personID = person.id order by thing.id desc");
			while ($row = $this->FetchArray($query[0]))
			{
				//$remain = $this->ideaTime() + $row[0] - $now;
				echo "<tr><td><p><a href='?pid=6&amp;id=$row[0]' title='View idea'>".$row[1]."</a></td><td>".$row[2]."	 ".$row[3]."</p></td>";
				//$views = $this->getViews($row[0]);
				//echo "<td><p>".$views."</p></td></tr>";
				echo "</tr>";
			}
			break;
			
			case 2:
			echo "<table><tr><td><h4>Search results</h4></td></tr>";
			$query = $this->Query("select distinct UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName from dateTbl, thing, person, extra where thing.flag = 'j' and (thing.title like '%".$word."%' or extra.job like '%".$word."%') and thing.personID = person.id and dateTbl.thingID = thing.id AND thing.id = extra.jobID and thing.flag = 'j' order by dateTbl.dateAdded desc");
			echo "<tr><th><h4><a href='?pid=5&sort=r' title='sort by time remaining' style='text-decoration:underline'>Time Remaining</a></h4></th><th><h4><a href='?pid=5&sort=t' title='sort by title' style='text-decoration:underline'>Title</a></h4></th><th><h4><a href='?pid=5&sort=p' title='sort by time proposer' style='text-decoration:underline'>Proposer</a></h4></th></tr>";
			while ($row = $this->FetchArray($query[0]))
			{
				$remain = $row[0] - $now;
				echo "<tr><td><p>".$this->workoutTime($remain)."</p></td><td><p><a href='?pid=7&amp;id=$row[1]' title='View idea'>".stripslashes($row[2])."</a></p></td><td><p>".$row[3]."	 ".$row[4]."</p></td>";
				//$views = $this->getViews($row[1]);
				//echo "<td><p>".$views."</p></td></tr>";
				echo "</tr>";
			}
			echo "</table>";
			break;

			case 3:
			$query = $this->Query("select thing.id, thing.title from thing where (thing.flag = 'p' or thing.flag = 'c' or thing.flag = 'cc') and (thing.title like '%".$word."%' or thing.blurb like '%".$word."%')");
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<li><a href='?pid=10&amp;id=$row[0]' title='View project'>".$row[1]."</a></li>";
			}
			break;
		}
	}
	
	function getThing($n)
	{
		$query = $this->Query("select thing.title, person.firstName, person.lastName,thing.blurb, person.id, thing.flag, thing.winBid, UNIX_TIMESTAMP(dateTbl.dateClose) from thing, person, dateTbl where thing.id = '".$n."' and person.id = thing.personID");
		$row = $this->FetchRow($query[0]);
		return $row;
	}
	
	function getIdea($n)
	{
		$query = $this->Query("select thing.title, person.firstName, person.lastName,thing.blurb, person.id, thing.flag, extra.job from thing, person, extra where thing.id = '".$n."' and person.id = thing.personID and thing.id = extra.jobID");
		$row = $this->FetchRow($query[0]);
		return $row;
	}
	
	function workoutTime($remain)
	{
		$fullDays = floor($remain/(60*60*24));
		$fullHours = floor(($remain-($fullDays*60*60*24))/(60*60));
		$fullMinutes = floor(($remain-($fullDays*60*60*24)-($fullHours*60*60))/60);
		$timeRemaining = $fullDays." day ".$fullHours." hours ".$fullMinutes." minutes";
		return $timeRemaining;
	}
	
	function getViews($n)
	{
		$query = $this->Query("select count(1) from auditTrail where ideaID = '".$n."' and activity = 'v'");
		$ans = $this->FetchRow($query[0]);
		return $ans[0];
	}
	
	function getComments($n)
	{
		$getComments = $this->Query("select person.firstName, person.lastName, comment.title,comment.comment, date_format(comment.dateTime,'%d-%b-%Y'), person.id from person, comment where person.id = comment.personID and comment.thingID = '".$n."' order by comment.dateTime desc");
		if ($this->FetchNum($getComments[0]) > 0)
		{
			while($row = $this->FetchArray($getComments[0]))
			{
				echo "<div class='column-inner white-inner black-border'>" . ((stripslashes($row[2]) != '') ? "<h4>".stripslashes($row[2])."</h4>" : '') . '<p>'.stripslashes($row[3]).'</p>'. '<p>'."<em>Posted by <a href='?pid=16&amp;id=".$row[5]."'>".$row[0]." ".$row[1]."</a> on ".$row[4]."</em></p></div>";
			}
		}
		else
		{
			echo "<div class='column-inner white-inner black-border'>" . "<p>No comments</p>" . "</div>";
		}
	}
	
/*	function emlComment($id,$user)
	{
		$getStuff = $this->Query("select thing.title, person.email, person.firstName, person.lastName from thing, person where thing.id = '".$id."' and person.id = thing.personID");
		$row = $this->FetchRow($getStuff[0]);
		$subject = "New comment";
		$mail = new PHPMailer();
		$mail->From = "admin@co-os.org";
		$mail->Subject = "New comment";
		$mail->MsgHTML("Someone has commented on your job ".$row[0].". Click <a href='http://alpha.co-os.org/index.php?pid=7&amp;id=".$id."'>here</a> to view it.");
		$mail->AddAddress($row[1], $row[2]." ".$row[3]);
		$mail->Send();
	}
*/	
	function eml($id,$user,$n)
	{

		if ($n <> 3)
		{
			$getStuff = $this->Query("select thing.title, person.email, person.firstName, person.lastName, thing.personID from thing, person where thing.id = '".$id."' and person.id = thing.personID");
			$row = $this->FetchRow($getStuff[0]);
		}
		else
		{
			$getStuff = $this->Query("select person.id, person.email, person.firstName, person.lastName, person.id from person where person.id = '".$user."'");
			$row = $this->FetchRow($getStuff[0]);
		}
		
		switch ($n) {
			case 1:
			$subject = "CO-OS: New comment";
			$txt = "Someone has commented on your job ".$row[0].". Click <a href='http://www.co-os.org/index.php?pid=7&amp;id=".$id."'>here</a> to view it.";
			break;
			case 2:
			$subject = "CO-OS: New bid";
			$txt = "Someone has placed a bid on your job ".$row[0].". Click <a href='http://www.co-os.org/index.php?pid=7&amp;id=".$id."'>here</a> to view it.";
			break;
			case 3:
			$subject = "CO-OS: New message";
			$txt = "Someone has sent you a message. Click <a href='http://www.co-os.org/index.php?pid=19'>here</a> to view it.";
			break;
			case 4:
			$subject = "CO-OS: Task completion for ".$row[0];
			$txt = "One of your collaborators has completed their task for ".$row[0]." Click <a href='http://www.co-os.org/index.php?pid=10&id=".$id."'>http://www.co-os.org/index.php?pid=10&id=".$id."</a> to view it.";
			break;
		}
		$extra = "<br /><br />Don't want to receive email notifications? Adjust your message settings in the <a href='http://www.co-os.org/?pid=3&id=$row[4]'>profile page</a> CO-OS values your privacy.";
		$mail = new PHPMailer();
		$mail->From = "admin@co-os.org";
		$mail->Subject = $subject;
		$mail->MsgHTML($txt.$extra);
		$mail->AddAddress($row[1], $row[2]." ".$row[3]);
		$mail->Send();
	}
	
	function emlPwd($email,$pwd)
	{
		$subject = "CO-OS: Your password";
		$txt = "Your password for CO-OS is $pwd. If you want to change it, you can do that via your Profile page.";
		$extra = "<br /><br />Don't want to receive email notifications? Adjust your message settings in the <a href='http://www.co-os.org/?pid=3&id=$row[4]'>profile page</a> CO-OS values your privacy.";
		$mail = new PHPMailer();
		$mail->From = "admin@co-os.org";
		$mail->Subject = $subject;
		$mail->MsgHTML($txt.$extra);
		$mail->AddAddress($email);
		$ans = $mail->Send();
	}
	
	function getProfile($n)
	{
		$getStuff = $this->Query("select firstName as firstName, lastName, bio, job, email, location, about, pwd, description1, url1, description2, url2, description3, url3, getMail from person where id = '".$n."'");
		$row = $this->FetchRow($getStuff[0]);
		return $row;
	}
	
	function keyProfile($n)
	{
		$getStuff = $this->Query("select firstName as firstName, lastName, bio, job, email, location, about, pwd, description1, url1, description2, url2, description3, url3, getMail, id from person where bodKey = '".$n."'");
		$row = $this->FetchRow($getStuff[0]);
		return $row;
	}
	
	function getUpgradeRes($m,$n)
	{
		if (sizeof($m) > 0)
		{
			$i = 0;
			foreach ($m as $s)
			{
				echo "<select name='updRes[$i]'>";
				$res = $this->Query("select * from resources order by resource");
				while($row = $this->FetchArray($res[0]))
				{
					echo "<option value='".$row['id']."'";
					if($s == $row['resource']) {echo "  selected='selected'";}
					echo ">".$row['resource']."</option>\n";
				}
				echo "</select>";
				echo " <input name='resReq[$i]' type='text' value='".$n[$i]."' size='50' maxlength='254' /><br />\n";
				$i++;
			}
		}
		$this->addResources($i);
	}
	
	function getUpgradeSkill($m,$n)
	{
		if (sizeof($m) > 0)
		{
			$i = 0;
			foreach ($m as $s)
			{
				echo "<select name='updSkill[$i]'>";
				$res = $this->Query("select * from skills order by skill");
				while($row = $this->FetchArray($res[0]))
				{
					echo "<option value='".$row['id']."'";
					if($s == $row['skill']) {echo "  selected='selected'";}
					echo ">".$row['skill']."</option>\n";
				}
				echo "</select>";
				echo " <input name='skillReq[$i]' type='text' value='".$n[$i]."' size='50' maxlength='254' /><br />\n";
				$i++;
			}
		}
		$this->addSkills($i);
	}
	
	function getSkills($n)
	{
		$get = $this->Query("select skillID, level from personSkills where personID = '".$n."'");
		$i = 0;
        while($skillRow = $this->FetchArray($get[0]))
        {
			echo "<select name='skill[$i]'>";
            echo "<option value=''>Select skill</option>";
            $skills = $this->Query("select * from skills order by skill");
            while($row = $this->FetchArray($skills[0]))
            {
				echo "<option ";
                if ($row['id'] == $skillRow['skillID']) {echo " selected ";}
                echo "value='".$row['id']."'>".$row['skill']."</option>";
            }
			echo "</select>";
			echo "Beginner <input name='level[$i]'";
			if ($skillRow['level'] == 'b') {echo " checked ";}
			echo "type='radio' value='b' />";
			echo "Intermediate <input name='level[$i]'";
			if ($skillRow['level'] == 'i') {echo " checked ";}
			echo "type='radio' value='i' />";
            echo "Advance <input name='level[$i]'";
			if ($skillRow['level'] == 'a') {echo " checked ";}
			echo "type='radio' value='a' /><br />";
			$i++;
		} 
	}
	
	function getInterests($n)
	{
		$interest = "";
		$getInterests = $this->Query("select interests from interests where personID = '".$n."'");
		while($row = $this->FetchArray($getInterests[0]))
		{
			$interest .= stripslashes($row[0]).",";
		}
		return $interest;
	}
	
/*	function getNewSkill()
	{
		echo "<select name='newSkill[0]'><option value=''>Select skill</option>";
        $skills = $this->Query("select * from skills order by skill");
        while($row = $this->FetchArray($skills[0]))
        {echo "<option value='".$row['id']."'>".$row['skill']."</option>\n";}
		echo "</select>";
		echo "Beginner <input name='newLevel[0]' type='radio' value='b' /> Intermediate <input name='newLevel[0]' type='radio' value='i' />Advance <input  name='newLevel[0]' type='radio' value='a' /><br />\n";
		echo "<span id='list'></span><br />";
		echo "<span id='box'><input type='text' name='freeTxt[0]' value='' size='17' maxlength='255' style='width: 143px;' />";
		echo "Beginner <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='b' /> Intermediate <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='i' />Advance <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='a' /><br /></span>";
	} */
	
	function getNewSkill()
	{
		echo "<select name='newSkill[0]'><option value=''>Select skill</option>";
        $skills = $this->Query("select * from skills order by skill");
        while($row = $this->FetchArray($skills[0]))
        {echo "<option value='".$row['id']."'>".$row['skill']."</option>\n";}
		echo "</select>";
		echo "Beginner <input onclick='moreList(0)' name='newLevel[0]' type='radio' value='b' /> Intermediate <input onclick='moreList(0)' name='newLevel[0]' type='radio' value='i' />Advance <input  onclick='moreList(0)' name='newLevel[0]' type='radio' value='a' /><br />\n";
		echo "<span id='list'></span><br />";
		echo "<span id='box'><input type='text' name='freeTxt[0]' value='' size='17' maxlength='255' style='width: 143px;' />";
		echo "Beginner <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='b' /> Intermediate <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='i' />Advance <input onclick='moreBox(0)' name='freeLevel[0]' type='radio' value='a' /><br /></span>";
	}
	
	function getImage($n)
	{
		$columns = 4;
		$getPic = $this->Query("select * from imgLibrary where personID = '".$n."'");
		if ($this->FetchNum($getPic[0]) == 0) {echo "No profile images";}
		$i = 0;
		while ($row = $this->FetchArray($getPic[0]))
		{
			echo "<a title='Set as profile image' href='setPic.php?id=$row[0]'><img src='./thumbNail.php?imgFile=".$row[2]."&size=100' alt='Profile image' ";
			if ($row[3] == 'y') {echo "style='border:solid 4px #ff6666;'";} else {echo "style='border:none'";}
			echo " /></a>";
			echo "<input name='imgdel[$i]' type='checkbox' value='1' /> ";
			echo "<input name='imgID[$i]' type='hidden' value='$row[0]' />\n";
			if((($i % $columns) == ($columns - 1)) || (($i + 1) == $this->FetchNum($getPic[0])))
			{
				echo "<br clear='left' />\n";
			}
			$i++;
		}
		echo "<input name='imgtotal' type='hidden' value='".$this->FetchNum($getPic[0])."' />\n";
	}
	
	function updProfile($first,$last,$email,$about,$bio,$location,$job,$pwd,$n,$desc,$url,$getEmail)
	{
		$recSql = "update person set email='$email', firstName='$first', lastName='$last', about='$about', bio='$bio', location='$location', job='$job', pwd='$pwd', getMail='$getEmail' where id = '".$n."'";
		$query = $this->Query($recSql);
		for ($i = 0; $i < sizeof($desc); $i++)
		{
			$descVar = mysql_real_escape_string($desc[$i]);
			$urlVar = mysql_real_escape_string($url[$i]);
			switch ($i) {
				case 0:
					$string = "update person set description1 = '$descVar', url1 = '$urlVar' where id = '$n'";
					break;
				case 1:
					$string = "update person set description2 = '$descVar', url2 = '$urlVar' where id = '$n'";
					break;
				case 2:
					$string = "update person set description3 = '$descVar', url3 = '$urlVar' where id = '$n'";
					break;
			}
			$res = $this->Query($string);
		}
	}
	
	function addProfile($first,$last,$email,$pwd)
	{
		echo "insert into person values ('','$email','$pwd','$first','$last','','','','','','','','','','','','','','','y')";
		$result = $this->Query("insert into person values ('','$email','$pwd','$first','$last','','','','','','','','','','','','','','','y')");
		$dots = $this->Query("insert into dots values ('$result[1]','0')");
		return $result;
	}
	
	function updImage($img, $imgID, $n)
	{
		$newImgPlace = $_SERVER['DOCUMENT_ROOT']."/library/members/";
		$img_name = $n.time().".jpg";
		if ($img)
		{
			$upfile = $newImgPlace.$img_name;
			move_uploaded_file($img,$upfile);
			$insImg = $this->Query("insert into imgLibrary values ('','".$n."','".$img_name."','n')");
		}
	}
	
	function imgDel($imgtotal, $imgdel)
	{
		for ($i = 0; $i < $imgtotal; $i++)
		{
			if ($imgdel[$i]) {$result = $this->Query("delete from imgLibrary where id = '".$imgID[$i]."'");}
		}
	}
	
	function updSkills($skill,$level,$n)
	{
		$result = $this->Query("delete from personSkills where personID = '".$n."'");
		for ($i = 0; $i < sizeof($skill); $i++)
		{
			$result = $this->Query("insert into personSkills values ('".$n."','".$skill[$i]."','".$level[$i]."')");
		}
	}
	
	function newSkill($newSkill, $newLevel,$n)
	{
		for ($i = 0; $i < sizeof($newSkill); $i++)
		{
			if (strlen($newLevel[$i]) > 0) {$result = $this->Query("insert into personSkills values ('".$n."','".$newSkill[$i]."','".$newLevel[$i]."')");}
		}
	}
	
	function updInterests($interest,$n)
	{
		$splitcontents = explode(",", $interest);
		$result = $this->Query("delete from interests where personID = '".$n."'");
		foreach ($splitcontents as $tag)
		{
			if (strlen($tag) > 0) {$result = $this->Query("insert into interests values ('".$n."','$tag')");}
		}
	}
	
	function chk4Bids($n)
	{
		$getStuff = $this->Query("select count(1) from bids, thing where thing.id = '".$n."' and bids.jobID = thing.id");
		if ($this->FetchNum($getStuff[0]) > 0) {$row = $this->FetchRow($getStuff[0]); $num = $row[0];}
		else
		{$num = 0;}
		return $num;
	}

	
	function getBids($n)
	{
		$getStuff = $this->Query("select bids.id ,person.firstName, person.lastName, bids.bid, bids.offer, person.id from bids, person where bids.jobID = '".$n."' and bids.personID = person.id");
		while ($row = $this->FetchArray($getStuff[0]))
		{
			echo "<li><a href='?pid=16&amp;id=".$row[5]."' title='view profile'>".$row[1]." ".$row[2]."</a> will do ";
			$offer = unserialize($row[4]);
			for ($i = 0;$i < sizeof($offer); $i++) {echo $offer[$i]; if (sizeof($offer) - $i <> 1) {echo ", ";}}
			echo " for ".$row[3]." hours - <input type='checkbox' name='bid[]' value='".$row[0]."' /></li>";
		}
		return $row;
	}
	
	function getMembers($n, $bod, $error,$winBid)
	{
		$proj = $this->getThing($n);
		$state = array("n" => "Not started yet", "i" => "In progress", "c" => "Completed", "f" => "No longer on project", "cc" => "Completed");
		$s = unserialize($winBid);
		$get = $this->Query("select person.id, person.firstName, person.lastName from person, bids where bids.id in (". join(",", $s) .") and bids.personID = person.id");
		while($r = $this->FetchArray($get[0]))
		{
			echo "<li><a href='?pid=16&amp;id=".$r[0]."'>".$r[1]." ".$r[2]."</a>";
			$g = $this->Query("select worker from progress where personID = '$r[0]' and thingID = '$n'");
			$q = $this->FetchRow($g[0]);
			echo " ".$state[$q[0]]." ";
			//echo "</td>";
	/*		if ($bod == $_SESSION['valid_user']) */
			if ($r[0] == $_SESSION['valid_user'] || $bod == $proj[5])
			{
				$res = $this->Query("select worker from progress where personID = '$r[0]' and thingID = '$n'");
				$k = $this->FetchRow($res[0]);
				echo "<select name='status[]'><option value='-1'></option><option value='i'";
				if ($k[0] == "i") {echo " selected";}
				echo ">In progress</option><option value='c'";
				if ($k[0] == "c") {echo " selected";}
				echo ">Completed</option><option value='f'";
				if ($k[0] == "f") {echo " selected";}
				echo ">Remove from project</option></select> ".$error;
				//if ($k[0] == "cc") {echo "<td><p><a href='#'>Rate/transfer hours</a></p></td>";}
				echo "<input type='hidden' name='member[]' value='$r[0]' />";   
			}  
	/*		{
				echo "number 2";
				echo "<select name='status[]'><option></option><option value='i'>In progress</option><option value='c'>Completed</option><option value='f'>Leave project</option></select>";
				echo "<input type='hidden' name='member[]' value='$r[0]' />";
			} */
			else
			{

			}
			echo "</li>";
		}
		
		$chk = $this->Query("select worker from progress where thingID = '$n'");
		$count = $this->FetchNum($chk[0]);
		while ($row = $this->FetchArray($chk[0])) {if ($row[0] == "cc" || $row[0] == "f") {$count -= 1;}}
		if ($count == 0) {$res = $this->Query("update thing set flag = 'c' where id = '$n'");}
	}
	
	function chkMember($n, $id)
	{
		$chk = $this->Query("select count(*) from progress where personID = '$n' and thingID = '$id'");
		$rowm = $this->FetchRow($chk[0]);
		if ($row[0] == 0) {return false;}
		else
		{return true;}
	}
	
	function showSkills($n)
	{
		$level = array();
		$level['a'] = "Advanced";
		$level['i'] = "Intermediate";
		$level['b'] = "Beginner";
		$skills = "";
		//$skills = "<ul>";
		$getSkill = $this->Query("select skills.skill, personSkills.level from skills, personSkills where skills.id = personSkills.skillID and personSkills.personID = '".$n."' order by skills.skill");
		while($skillRow = $this->FetchArray($getSkill[0]))
		{
			//$skills .= "<li>".$skillRow[0]." - ".$level[$skillRow[1]]."</li>";
			$skills .= $skillRow[0]." - ".$level[$skillRow[1]]."<br />";
		}
		//$skills .="</ul>";
		return $skills;
	}
	
	function showPic($n)
	{
		$getPic = $this->Query("select image from imgLibrary where personID = '".$n."' and active = 'y'");
		if ($this->FetchNum($getPic[0]) > 0)
		{
			$row = $this->FetchRow($getPic[0]);
			return $row[0];
		}
	}
	
	function getRatingTot($n)
	{
		$get = $this->Query("select comment from rating where personID = '".$n."'");
		return $this->FetchNum($get[0]);		
	}
	
	function getRatingComments($n)
	{
		$get = $this->Query("select comment, date_format(dateAdded,'%d-%b-%Y'), raterID from rating where rating.personID = '".$n."' order by dateAdded desc");
		if ($this->FetchNum($get[0]) > 0)
		{
			while($row = $this->FetchRow($get[0])) 
			{
				echo "<hr />".$row[0]." - <a href='?pid=16&id=".$row[2]."'>";
				$profile = $this->getProfile($row[2]);
				echo $profile[0]." ".$profile[1]."</a> ".$row[1]."";
			}
		}
	}
	
	function insSkill($n)
	{
		$return = array();
		foreach ($n as $skill)
		{
			if (strlen($skill) > 0)
			{
				$result = $this->Query("insert into skills values ('','$skill')");
				array_push($return, $result[1]);
			}
		}
		return $return;
	}
	
	function addSkills($n)
	{
		echo "<select onchange='updSkill($n)' name='updSkill[$n]'><option value=''>Select skill</option>";
        $skills = $this->Query("select * from skills order by skill");
        while($row = $this->FetchArray($skills[0]))
        {echo "<option value='".$row['id']."'>".$row['skill']."</option>\n";}
		echo "</select>";
		echo " <input name='skillReq[$n]' type='text' value='' size='50' maxlength='254' /><br />\n";
		echo "<span id='skillList'></span><br />";
		echo "<input onchange='moreNewSkill(0)' type='text' name='newSkillBox[0]' size='20' maxlength='254' value='' />";
		echo " <input name='newSkillReq[0]' type='text' value='' size='50' maxlength='254' /><br />\n";
		echo "<span id='newSkill'></span><br />";
	}
	
	function addResources($n)
	{
		echo "<select onchange='updRes($n)' name='updRes[$n]'><option value=''>Select resource</option>";
        $res = $this->Query("select * from resources order by resource");
        while($row = $this->FetchArray($res[0]))
        {echo "<option value='".$row['id']."'>".$row['resource']."</option>\n";}
		echo "</select>";
		echo " <input name='resReq[$n]' type='text' value='' size='50' maxlength='254' /><br />\n";
		echo "<span id='reqList'></span><br />";
		echo "<input onchange='moreNewRes(0)' type='text' name='newResource[0]' value='' /></br />";
		echo " <input name='newResReq[0]' type='text' value='' size='50' maxlength='254' /><br />\n";
		echo "<span id='newRes'></span><br />";
	}
	
	function addMore($more,$skills,$resource,$newSkill,$newResource,$n,$job,$image,$jobLoc,$loc,$start,$end,$skillReq,$resourceReq,$newSkillReq,$newResReq,$close)
	{
		$skillArr = array();
		$resArr = array();
		$sr = array();
		$rr = array();
		
		if (array_empty($skills)) {foreach ($skills as $s) {if (!empty($s)) {array_push($skillArr,$s);}}}
		if (array_empty($resource)) {foreach ($resource as $r) {if (!empty($r)) {array_push($resArr,$r);}}}
		if (array_empty($skillReq)) {foreach ($skillReq as $s) {if (!empty($s)) {array_push($sr,$s);}}}
		if (array_empty($resourceReq)) {foreach ($resourceReq as $r) {if (!empty($r)) {array_push($rr,$r);}}}
		
		for ($i = 0; $i < sizeof($newSkill); $i++)
		{
			if (strlen($newSkill[$i]) <> 0)
			{
				$inp = $this->Query("insert into skills values ('','$newSkill[$i]')");
				array_push($skillArr,$inp[1]);
				array_push($sr, $newSkillReq[$i]);
			}
		}

		for ($i = 0; $i < sizeof($newResource); $i++)
		{
			if (strlen($newResource[$i]) <> 0)
			{
				$inp = $this->Query("insert into resources values ('','$newResource[$i]')");
				array_push($resArr,$inp[1]);
				array_push($rr,$newResReq[$i]);
			}
		}

		$result = $this->Query("update extra set more='$more', skill='".serialize($skillArr)."', resource='".serialize($resArr)."', job='$job',image='$image',loc='$loc',jobLoc='$jobLoc',start='$start', end='$end',skillRequirement='".addslashes(serialize($sr))."',resourceRequirement='".addslashes(serialize($rr))."' where jobID='$n'");
		//$close = date('Y-m-d 00:00:00',strtotime("+14 day"));
		//echo "update dateTbl set dateClose = '$close' where thingID = '$n'";
		$result = $this->Query("update dateTbl set dateClose = '$close' where thingID = '$n'");
		//$result = $dbStuff->Query("insert into auditTrail values ('', '".$_SESSION['valid_user']."', now(),'v', '".$id."')");
	}
	
	function getExtra($n)
	{
		$return = array();
		$skills = array();
		$resources = array();
		$get = $this->query("select more,skill,resource,job,image,jobLoc,loc,date_format(start,'%d %b %Y'),date_format(end,'%d %b %Y'),skillrequirement, resourcerequirement from extra where jobID = '".$n."'");
		$row = $this->FetchRow($get[0]);
		array_push($return,$row[0],$row[3],$row[4],$row[5],$row[6],$row[7],$row[8]);
		if (strstr($row[9],"{")) {array_push($return,unserialize($row[9]));} else {array_push($return,$row[9]);}
		if (strstr($row[10],"{")) {array_push($return,unserialize($row[10]));} else {array_push($return,$row[10]);}
		$s = unserialize($row[1]);
		if (array_empty($s))
		{
			$query = "select skill from skills where id in (". join(",", $s) .")";
			$get = $this->Query($query);
			while($r1 = $this->FetchArray($get[0]))
			{
				array_push($skills,$r1[0]);
			}
		}
		else
		{
			$skills = NULL;
		}
		array_push($return,$skills);
		$r = unserialize($row[2]);
		if (array_empty($r))
		{
			$query = "select resource from resources where id in (". join(",", $r) .")";
			$get = $this->Query($query);
			while($r2 = $this->FetchArray($get[0]))
			{
				array_push($resources,$r2[0]);
			}
		}
		else
		{
			$resources = NULL;
		}
		array_push($return,$resources);


		$res = $this->Query("select date_format(dateAdded,'%d %b %Y'),date_format(dateClose,'%d %b %Y'),date_format(dateComplete,'%d %b %Y') from dateTbl where thingID = '".$n."'");
		$row = $this->FetchRow($res[0]);
		array_push($return,$row[0],$row[1],$row[2]);
		
		return $return;
	}
	
	function getPeople($n)
	{
		if (!$n)
		{$query = "select firstName, lastName, job, location, id from person where id <> '1' order by firstName";}
		else
		{$query = "select firstName, lastName, job, location, id from person where id in (". join(",", $n) .")";}
		$get = $this->Query($query);
		while ($r = $this->FetchArray($get[0]))
		{
			echo "<tr><td><p><a href='?pid=16&amp;id=$r[4]' title='Link to profile'>$r[0] $r[1]</a></p></td><td><p>$r[2]</p></td><td><p>$r[3]</p></td><td>".$this->getRating($r[5])."</td></tr>";
		}
	}
	
	function searchSkill()
	{
		$get = $this->Query("select skill, id from skills order by skill");
		$skills = '';
		while ($r = $this->FetchArray($get[0]))
		{
			//echo "<label class='block'><input type='checkbox' name='skills[]' value='$r[1]' />$r[0]</label>";
			$skills .= '<option value="'.$r[1].'" >'.$r[0].'</option>';
		}
		return $skills;
	}
	
	function findPeople($word,$skill)
	{
		$wordHash = array();
		$skillHash = array();
		$return = array();
		if ($word)
		{
			$get = $this->Query("select id from person where (firstName like '%$word%' or lastName like '%$word%' or location like '%$word%' or bio like '%$word%' or about like '%$word%' or job like '%$word%') and id > 1");
			if ($this->FetchNum($get[0]) > 0)
			{
				while ($r = $this->FetchArray($get[0])) {array_push($wordHash,$r[0]);}
			}
		}
		if ($skill)
		{
			//$query = "select personID from personSkills where skillID in (". join(",", $skill) .")";
			$query = "select personID from personSkills where skillID = '".$skill."'";
			$get = $this->Query($query);
			if ($this->FetchNum($get[0]) > 0)
			{
				while ($r = $this->FetchArray($get[0])) {array_push($skillHash,$r[0]);}
			}
		}
		if (empty($wordHash)) {$return = $skillHash;}
		elseif (empty($skillHash)) {$return = $wordHash;}
		else {$return = array_intersect($wordHash,$skillHash);}
		return $return;
	}
	
	function add2Progress($id, $n)
	{
		$get = $this->Query("select personID from bids where jobID = '$id' and id = '$n'");
		$r = $this->FetchRow($get[0]);
		$res = $this->Query("insert into progress values ('$id','$r[0]','n')");
	}
	
	function updProgress($thing,$member,$status)
	{
		if ($status <> "") {$res = $this->Query("update progress set worker = '$status' where thingId = '$thing' and personID = '$member'");}
	}
	
	function getVote($n)
	{
		//$get = $this->Query("(select count(*) from vote where ideaID = '".$n."' and yorn = 'y') as yes, (select count(*) from vote where ideaID = '".$n."' and yorn = 'n') as no, (select count(*) from vote where ideaID = '".$n."' and yorn = 's') as soso");
		$get1 = $this->Query("select count(*) from vote where ideaID = '".$n."' and yorn = 'y'");
		$get2 = $this->Query("select count(*) from vote where ideaID = '".$n."' and yorn = 'n'");
		$get3 = $this->Query("select count(*) from vote where ideaID = '".$n."' and yorn = 's'");
		$row1 = $this->FetchRow($get1[0]);
		$row2 = $this->FetchRow($get2[0]);
		$row3 = $this->FetchRow($get3[0]);
		$total = $row1[0] + $row2[0] + $row3[0];
		echo "<p>There have been ".$total." votes cast so far:<br />";
		echo $row1[0]." yes votes<br/>".$row3[0]." so,so votes<br />".$row2[0]." no votes</p>";
	}
	
	function chkStatus($n)
	{
		$result = $this->Query("(select count(*) as total, NULL AS subTotal from progress where thingID = '$n') union all (select NULL AS total, count(*) as subTotal from progress where thingID = '$n' and worker = 'c')");
		$i = 0;
		while($row = $this->FetchArray($result[0]))
		{
			if (is_numeric($row['total'])) {$total = $row['total'];}
			if (is_numeric($row['subTotal'])) {$subTotal = $row['subTotal'];}
		}
		if (intval($total) == intval($subTotal)) {return 1;}
		else
		{return 0;}
	}
	
	function listBids($n)
	{
		$result = $this->Query("select bids.bid, bids.offer, person.firstName, person.lastName, person.id from bids,person where bids.jobID = '".$n."' and bids.personID = person.id");
		if ($this->FetchNum($result[0]) > 0)
		{
			echo "<ul>";
			while($row = $this->FetchArray($result[0]))
			{
				$offer = unserialize($row[1]);
				echo "<li><a href='?pid=16&id=$row[4]' title='link to their profile'>".$row[2]." ".$row[3]."</a> offered ".$row[0]." hours for ";
				for ($i = 0; $i < sizeof($offer); $i++) {echo $offer[$i]." ";}
				echo "</li>";
			}
			echo "</ul>";
		}
	}
	
	function chkBid($n)
	{
		$result = $this->Query("select id, bid, offer from bids where jobID = '".$n."' and personID = '".$_SESSION['valid_user']."'");
		if ($this->FetchNum($result[0]) > 0)
		{
			echo "<p><strong>Your bids</strong><br />";
			while($row = $this->FetchArray($result[0]))
			{
				$offer = unserialize($row[2]);
				echo $row[1]." hours for ";
				for ($i = 0; $i < sizeof($offer); $i++) {echo $offer[$i]." ";}
				echo "<br /> - <a href='delbid.php?id=$row[0]&jid=$n' title='remove bid'><img src='../_assets/images/remBid.gif' alt='Remove bid' border='0' HEIGHT='27' WIDTH='105' /></a><br />";
			}
			echo "</p>";
		}
	}
	
	function completeJob($n)
	{
		$result = $this->Query("update progress set worker = 'cc' where thingID = '".$n."' and worker = 'c'");
		$result = $this->Query("update thing set flag = 'c' where id = '".$n."'");
		$result = $this->Query("update dateTbl set dateComplete = now() where thingID = '$n'");
	}
	
	function addRate($n)
	{
		$proj = $this->getThing($n);
		$s = unserialize($proj[6]);
		$get = $this->Query("select person.id, person.firstName, person.lastName, bids.bid from person, bids where bids.id in (". join(",", $s) .") and bids.personID = person.id");
		$i = 0;
		while($row = $this->FetchArray($get[0]))
		{
			echo "<p>".$row[1]." ".$row[2]."<br />Amount of bid: <input size='3' type='text' name='bid[$i]' value='".$row[3]."' /><br />";
			echo "Rating: Negative<input type='radio' name='rate[$i]' value='1' /> Neutral<input type='radio' name='rate[$i]' value='2' /> Positive<input type='radio' name='rate[$i]' value='3' /><br />";
			echo "Comment: <input type='text' size='50' maxlength='254' name='comment[$i]' /></p>";
			echo "<input type='hidden' name='bod[$i]' value='$row[0]' />";
			$i++;
		}
	}
	
	function rateLeader($n)
	{
		$proj = $this->getThing($n);
		echo "<p>Select rating: 1<input type='radio' name='rate' value='1' /> 2<input type='radio' name='rate' value='2' /> 3<input type='radio' name='rate' value='3' /><br />";
		echo "Comment: <input type='text' size='50' maxlength='254' name='comment' /></p>";
		echo "<input type='hidden' name='bod' value='$proj[5]' />";
	}
	
	function sendEmail($txt,$title)
	{
		$get = $this->Query("select email, id from person where getMail = 'y'");
		while($row = $this->FetchArray($get[0]))
		{
			$extra = "<br /><br />Don't want to receive email notifications? Adjust your message settings in the <a href='http://www.co-os.org/?pid=3&id=$row[1]'>profile page</a> CO-OS values your privacy.";
			$mail = new PHPMailer();
			$mail->From = "admin@co-os.org";
			$mail->Subject = $title;
			$mail->MsgHTML($txt.$extra);
			$mail->AddAddress($row[0],'$row[1]');
			$mail->Send();
		}
	}
	
	function newMsg($subject, $text, $id)
	{
		$insMsg = $this->Query("insert into msg values ('','$id','".$_SESSION['valid_user']."','$subject','$text',now(),'n')");
	}
	
	function getMsgs()
	{
		$getMsgs = $this->Query("select msg.id, person.firstName, person.lastName, msg.subject, msg.reader, date_format(msg.sent, '%D %M %Y'), msg.msg, msg.receiver from msg, person where msg.receiver = ".$_SESSION['valid_user']." and msg.from = person.id order by msg.sent desc");
		if ($this->FetchNum($getMsgs[0]) > 0)
		{
			while ($msgRow = $this->FetchArray($getMsgs[0]))
			{
				echo "<p>";
				if ($msgRow[4] == "n")
				{echo "<strong>".stripslashes($msgRow[3])."</strong>";}
				else
				{echo stripslashes($msgRow[3]);}
				echo "<br />".$msgRow[6]."<br /><em>Sent by ".$msgRow[1]." ".$msgRow[2]." on ".$msgRow[5]." </em>";
				echo "<br /><a href='?pid=26&mid=".$msgRow[0]."' params='lightwindow_width=300,lightwindow_height=300' class='lightwindow'>Reply</a>";
				echo "</p>";
			}
		}
		else
		{
			echo "No messages</p>";
		}
	}
	
	function submitBid($offer,$bid,$id)
	{
		$o = serialize($offer);
		$b = mysql_real_escape_string($bid);
		if (!is_numeric($b)) 
		{
			return "Invalid number of hours entered";
		}
		else
		{
			$query = $this->Query("insert into bids values ('', '".$_SESSION['valid_user']."','".$id."','".$b."','".$o."')");
			$this->eml($id, $_SESSION['valid_user'], 2);
			return 1;
		}
	}
	
	function addComment($title,$comment,$id)
	{
		$query = $this->Query("insert into comment values ('".$id."','".$_SESSION['valid_user']."','".$title."','".$comment."',now())");
		$this->eml($id, $_SESSION['valid_user'],1);
	}
	
	function suggestMsg()
	{
		$query = $this->Query("select txt from general where name = 'suggest'");
		$row = $this->FetchRow($query[0]);
		return stripslashes($row[0]);
	}
	
	function sendSuggestion($name,$email)
	{
		$key = generateKey($email);
		$friend = explode(' ',$name);
		$result = $this->Query("insert into person values ('','$email','','$friend[0]','$friend[1]','','','','','r','','$key','".$_SESSION['valid_user']."','','','','','','','y')");
		$person = $this->getProfile($_SESSION['valid_user']);
		$subject = "CO-OS’ invitation to join the community";
		$body = $this->suggestMsg()."<br /><br />Click <a href='http://www.co-os.org/?pid=21&key=$key'>here</a> to complete your registration<br /><br />".$person[0];
		$mail = new PHPMailer();
		$mail->From = $person[4];
		$mail->Subject = $subject;
		$mail->MsgHTML($body);
		$mail->AddAddress($email, $friend[0]." ".$friend[1]);
		$mail->Send();
		return true;
	}
	
	function skillCloud()
	{
		$min = 1;
		$max = 3;
		$displayminimum = .1;

		$idArr = array();
		$skillArr = array();
		$count = array();
		$i = 0;
		
		$cloud = '';
		
		$result = $this->Query("select id, skill from skills order by skill");
		while ($row = $this->FetchArray($result[0]))
		{
			array_push($idArr,$row[0]);
			array_push($skillArr,$row[1]);
		}
		$query = $this->Query("select count(*) from personSkills");
		$row = $this->FetchRow($query[0]);
		$total = $row[0];
		foreach($idArr as $id)
		{
			$ans = $this->Query("select count(*) from personSkills where skillID = '".$id."'");
			$row = $this->FetchRow($ans[0]);
			array_push($count,$row[0]);
		}
		for ($i = 0;$i < sizeof($skillArr); $i++)
		{
			$fontsize = ($count[$i] / $total) + $min;
            //if($fontsize < $min) {$fontsize = $min;} else if($fontsize > $max ) {$fontsize = $max;} else {$fontsize = $fontsize + $min;}
			$cloud .= "<a style=\"font-size: ".$fontsize."em\" href='?pid=15&amp;skills=".$idArr[$i]."'>".$skillArr[$i]."</a> ";
		}
		
		return $cloud;
	}
	
	function completeEml($n)
	{
		$result = $this->Query("select person.email, thing.title, person.id from person,thing, bids where thing.id = '".$n."' and bids.jobID = '".$n."' and person.id = bids.personID");
		while ($row = $this->FetchArray($result[0]))
		{
			$subject = "CO-OS: Project ".$row[1]." completion";
			$txt = "Hi, the project '".stripslashes($row[1])."' has completed. Please click on the link to add feedback on the project leader - <a href='http://www.co-os.org/?pid=10&amp;id=".$n."'>http://www.co-os.org/?pid=10&amp;id=".$n."</a>";
			$extra = "<br /><br />Don't want to receive email notifications? Adjust your message settings in the <a href='http://www.co-os.org/?pid=3&id=$row[2]'>profile page</a> CO-OS values your privacy.";
			$mail = new PHPMailer();
			$mail->From = "admin@co-os.org";
			$mail->Subject = $subject;
			$mail->MsgHTML($txt.$extra);
			$mail->AddAddress($row[0],"");
			$mail->Send();
		}
	}
	
	function bigSearch($n)
	{
		$query = $this->Query("select UNIX_TIMESTAMP(dateTbl.dateAdded), thing.id, thing.title, person.firstName, person.lastName from dateTbl, thing, person where thing.flag = 'i' and (thing.title like '%".$n."%' or thing.blurb like '%".$n."%') and thing.personID = person.id  and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		if ($this->FetchNum($query[0]) > 0)
		{
			echo "<h2>Ideas</h2><ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<li><a href='?pid=6&amp;id=$row[1]' title='View idea'>".stripslashes($row[2])."</a></li>";
			}
			echo "</ul>";
		}
		else
		{
			echo "<p>No ideas found matching '$n'</p>";
		}
			
		$query = $this->Query("select UNIX_TIMESTAMP(dateTbl.dateClose), thing.id, thing.title, person.firstName, person.lastName from dateTbl, thing, person where thing.flag = 'j' and (thing.title like '%".$n."%' or thing.blurb like '%".$n."%') and thing.personID = person.id and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		if ($this->FetchNum($query[0]) > 0)
		{
			echo "<h2>Collaborations</h2><ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<li><a href='?pid=7&amp;id=$row[1]' title='View collaboration'>".stripslashes($row[2])."</a></li>";
			}
			echo "</ul>";
		}
		else
		{
			echo "<p>No collaborations found matching '$n'</p>";
		}

		$query = $this->Query("select thing.id, thing.title from thing where thing.flag = 'p' and (thing.title like '%".$n."%' or thing.blurb like '%".$n."%')");
		if ($this->FetchNum($query[0]) > 0)
		{
			echo "<h2>Projects</h2><ul>";
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<li><a href='?pid=10&amp;id=$row[1]' title='View project'>".$row[1]."</a></li>";
			}
			echo "</ul>";
		}
		else
		{
			echo "<p>No projects found matching '$n'</p>";
		}
		
		$wordHash = array();
		//echo "select id from person where (firstName like '%$n%' or lastName like '%$n%') and id > 1";
		$get = $this->Query("select id from person where (firstName like '%$n%' or lastName like '%$n%') and id > 1");
		if ($this->FetchNum($get[0]) > 0)
		{
			while ($r = $this->FetchArray($get[0])) {array_push($wordHash,$r[0]);}
		}
		//echo "select person.id from person, skills, personSkills where skills.skill like '%$n%' and skills.id = personSkills.skillID";
		$get = $this->Query("select person.id from person, skills, personSkills where skills.skill like '%$n%' and skills.id = personSkills.skillID");
		if ($this->FetchNum($get[0]) > 0)
		{
			while ($r = $this->FetchArray($get[0])) {array_push($wordHash,$r[0]);}
		}
		//print_r($wordHash);
		if (!empty($wordHash))
		{
			$query = "select firstName, lastName, id from person where id in (". join(",", $wordHash) .")";
			$get = $this->Query($query);
			if ($this->FetchNum($get[0]) > 0)
			{
				echo "<h2>People</h2><ul>";
				while ($r = $this->FetchArray($get[0]))
				{
					echo "<li><a href='?pid=16&amp;id=$r[2]' title='Link to profile'>$r[0] $r[1]</a></li>";
				}
				echo "</ul>";
			}
		}
		else
		{
			echo "<p>No people found matching '$n'</p>";
		}
	}
	
	function oldProjects()
	{
		$query = $this->Query("select thing.id, thing.title, person.firstName, UNIX_TIMESTAMP(dateTbl.dateClose) from thing, person, dateTbl where thing.flag = 'c' and thing.id = dateTbl.thingID and thing.personID = person.id order by dateTbl.dateAdded desc");
		echo "<ul>";
		while ($row = $this->FetchArray($query[0]))
		{
			echo "<li><a href='?pid=10&amp;id=$row[0]' title='Link to project'>".stripslashes($row[1])." - ".stripslashes($row[2])."</a></li>";
		}
		echo "</ul>";
	}
	
	function ideaCloud()
	{
		$words = "";
		$min = 1;
		$max = 3;
		$displayminimum = .1;
		
		$result = $this->Query("select title from thing where flag = 'i' or flag = 'v' or flag = 'r'");
		while ($row = $this->FetchArray($result[0]))
		{
			$words .= $row[0]." ";
		}
		$total = str_word_count($words);
		$word_count = (array_count_values(str_word_count(strtolower($words),1)));
		ksort($word_count);
		foreach ($word_count as $key=>$val)
		{
			$fontsize = ($val / $total) + $min;
			echo "<a style=\"font-size: ".$fontsize."em\" href='?pid=4&search=".$key."'>".$key."</a> ";
		}
		//echo $key ."= ". $val."<br/>";
	}
	
	function getPage($n)
	{
		$query = $this->Query("select content from pages where id = '$n'");
		$ans = $this->FetchRow($query[0]);
		echo stripslashes($ans[0]);
	}
	
	function jobCloud()
	{
		$words = "";
		$min = 1;
		$max = 3;
		$displayminimum = .1;
		
		$result = $this->Query("select thing.title, extra.job from thing, extra where (thing.flag = 'j' or thing.flag = 'b' or thing.flag = 'd' or thing.flag = 'w') and extra.jobID = thing.id");
		while ($row = $this->FetchArray($result[0]))
		{
			$words .= $row[0]." ".$row[1]." ";
		}
		$total = str_word_count($words);
		$word_count = (array_count_values(str_word_count(strtolower($words),1)));
		ksort($word_count);
		foreach ($word_count as $key=>$val)
		{
			$fontsize = ($val / $total) + $min;
			echo "<a style=\"font-size: ".$fontsize."em\" href='?pid=5&search=".$key."'>".$key."</a> ";
		}
	}
	
	function projCloud()
	{
		$words = "";
		$min = 1;
		$max = 3;
		$displayminimum = .1;
		
		$result = $this->Query("select thing.title, extra.job from thing, extra where (flag = 'p' or flag = 'c' or flag = 'cc') and extra.jobID = thing.id");
		while ($row = $this->FetchArray($result[0]))
		{
			$words .= $row[0]." ".$row[1]." ";
		}
		$total = str_word_count($words);
		$word_count = (array_count_values(str_word_count(strtolower($words),1)));
		ksort($word_count);
		foreach ($word_count as $key=>$val)
		{
			$fontsize = ($val / $total) + $min;
			echo "<a style=\"font-size: ".$fontsize."em\" href='?pid=9&search=".$key."'>".$key."</a> ";
		}
	}
	
	function ideaTime()
	{
		$result = $this->Query("select value from general where name = 'idea'");
		$row = $this->FetchRow($result[0]);
		return $row[0];
	}
	
	function jobTime()
	{
		$result = $this->Query("select value from general where name = 'job'");
		$row = $this->FetchRow($result[0]);
		return $row[0];
	}
	
	function chkRating($n,$id)
	{
		$result = $this->Query("select * from rating where personID = '$n' and jobID = '$id'");
		if ($this->FetchNum($result[0]) > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function haveuRated($n,$id)	
	{
	echo "select * from rating where jobID = '$id' and personID = '$n' and raterID = '".$_SESSION['valid_user']."'";
		$result = $this->Query("select * from rating where jobID = '$id' and personID = '$n' and raterID = '".$_SESSION['valid_user']."'");
		if ($this->FetchNum($result[0]) > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function getDocs($id)
	{
		$res = $this->Query("select doc from docs where thingID = '".$id."'");
		if ($this->FetchNum($res[0]) > 0)
		{
			echo "<p><strong>Supporting documentation</strong><br />";
			while ($row = $this->FetchArray($res[0]))
			{
				echo "<a href='/library/file/$row[0]'>$row[0]</a><br />";
			}
			echo "</p>";
		}
	}
	
	function updFlag($n,$flag)
	{
		$result = $this->Query("update thing set flag = '".$flag."' where id='$n'");
	}
	
	function listMsgs($n,$m)
	{
		$now = time();
		$query = $this->Query("select msgBoard.id, msgBoard.title, date_format(msgBoard.dateTime,'%d-%b-%Y'), person.firstName, person.lastName, person.id, msgBoard.content from msgBoard, person where msgBoard.parent = '$n' and person.id = msgBoard.personID order by msgBoard.dateTime asc");
		if ($this->FetchNum($query[0]) <> 0)
		{
			while ($row = $this->FetchArray($query[0]))
			{
				echo "<tr><td><p><strong>";
				//if ($n > 0) {echo $row[1];}
				echo stripslashes($row[1])."</strong></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[5])."' title='view profile'>".$row[3]." ".$row[4]."</a></p></td><td><p>".$row[2]."</p></td><td><p>".stripslashes($row[6])."</p></td><td><p><a href='?pid=35&parent=$row[0]' title='reply'>Reply</a></p></td></tr>";
				$this->listMsgs($row[0],$row[1]);
			}
		}
	}
	
	function profileCompletion()
	{
		if ($_SESSION['valid_user'])
		{
			$result = $this->Query("select person.about, person.bio, person.location, person.job, person.url1, count(personSkills.skillID), count(interests.personID), count(imgLibrary.personID) from person, personSkills, interests, imgLibrary where person.id = ".$_SESSION['valid_user']." and imgLibrary.personID = ".$_SESSION['valid_user']." and interests.personID = ".$_SESSION['valid_user']." and personSkills.personID = ".$_SESSION['valid_user']);
			$row = $this->FetchRow($result[0]);
			$count = 0;
			for ($i = 0; $i < 5; $i++) {if (strlen($row[$i]) == 0) {$count++;}}
			for ($i = 5; $i < 8; $i++) {if ($row[$i] == 0) {$count++;}}
			
			if ($count > 0)
			{
				switch ($count) {
					case 1:
						$img = "10.png";
						$percent = "87.5%";
						break;
					case 2:
						$img = "20.png";
						$percent = "75%";
						break;
					case 3:
						$img = "30.png";
						$percent = "62.5%";
						break;
					case 4:
						$img = "40.png";
						$percent = "50%";
						break;
					case 5:
						$img = "50.png";
						$percent = "37.5%";
						break;
					case 6:
						$img = "60.png";
						$percent = "25%";
						break;
					case 7:
						$img = "70.png";
						$percent = "12.5%";
						break;
					case 8:
						$img = "80.png";
						$percent = "0%";
						break;
				}
				echo "<div style='margin: 0 0 0 300px;'><p>Profile completion: ".$percent." <img STYLE='vertical-align:middle' src='_assets/images/".$img."' width='200' height='10' /></p></div>";
			}
		}
	}
	
	function getMsgTitle($n)
	{
		$result = $this->Query("select title from msgBoard where id = '".$n."'");
		$row = $this->FetchRow($result[0]);
		return $row[0];
	}
	
	function listBySkills()
	{
		echo "<table><tr><th><h4>Skill</h4></th><th><h4>Title</h4></th></tr>";
		$skills = Array();
		$result = $this->Query("select * from skills order by skill asc");
		while ($skillRow = $this->FetchArray($result[0]))
		{
			$found = false;
			$string = "<tr><td><p>".$skillRow[1]."</p></td><td><p>";
			$sql = "select extra.skill, thing.id, thing.title from extra, thing where thing.flag = 'j' and extra.jobID = thing.id";
			$res = $this->Query($sql);
			while($row = $this->FetchArray($res[0]))
			{
				if (in_array($skillRow[0],unserialize($row[0])))
				{
					$string .= "<a href='?pid=7&id=".$row[1]."'>".$row[2]."</a><br />";
					$found = true;
				}
			}
			if ($found) {echo $string."</p></td></tr>";}
		}
		echo "</table>";
	}
	
	function listByResource()
	{
		echo "<table><tr><th><h4>Resource</h4></th><th><h4>Title</h4></th></tr>";
		$skills = Array();
		$result = $this->Query("select * from resources order by resource asc");
		while ($skillRow = $this->FetchArray($result[0]))
		{
			$found = false;
			$string = "<tr><td><p>".$skillRow[1]."</p></td><td><p>";
			$sql = "select extra.resource, thing.id, thing.title from extra, thing where thing.flag = 'j' and extra.jobID = thing.id";
			$res = $this->Query($sql);
			while($row = $this->FetchArray($res[0]))
			{
				if (in_array($skillRow[0],unserialize($row[0])))
				{
					$string .= "<a href='?pid=7&id=".$row[1]."'>".$row[2]."</a><br />";
					$found = true;
				}
			}
			if ($found) {echo $string."</p></td></tr>";}
		}
		echo "</table>";
	}
	
	function oldJobs()
	{
		echo "<table<tr><th><h4>Title</h4></th><th><h4>Proposer</h4></th><th>&nbsp;</th></tr>";//<th><h4>Votes</h4></th><th>&nbsp;</th></tr>";
		$query = $this->Query("select thing.id, thing.title, person.firstName, person.lastName, person.id from thing, dateTbl, person where (thing.flag = 'b' or thing.flag = 'd') and person.id = thing.personID and dateTbl.thingID = thing.id order by dateTbl.dateAdded desc");
		while ($row = $this->FetchArray($query[0]))
		{
		//	$remain = ($row[2] + $this->ideaTime()) - $now;
			echo "<tr><td><p><a href='?pid=7&amp;id=$row[0]' title='View idea'>".stripslashes($row[1])."</a></p></td><td><p><a href='?pid=16&amp;id=".stripslashes($row[4])."' title='view profile'>".$row[2]." ".$row[3]."</a></p></td></tr>";
		//		$views = $this->getViews($row[0]);
		//		echo "<td><p>".$views."</p></td></tr>";
		}
		echo "</table>";
	}
	
}
?>