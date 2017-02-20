-- phpMyAdmin SQL Dump
-- version 3.5.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 12, 2013 at 08:25 AM
-- Server version: 5.5.30-log
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `web78-co-os`
--

-- --------------------------------------------------------

--
-- Table structure for table `archive`
--

CREATE TABLE IF NOT EXISTS `archive` (
  `pagename` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `flags` int(11) NOT NULL DEFAULT '0',
  `author` varchar(100) DEFAULT NULL,
  `lastmodified` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `content` mediumtext NOT NULL,
  `refs` text,
  PRIMARY KEY (`pagename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `archive`
--

INSERT INTO `archive` (`pagename`, `version`, `flags`, `author`, `lastmodified`, `created`, `content`, `refs`) VALUES
('FrontPage', 1, 0, 'The PhpWiki programming team', 1000702928, 1000702928, '* What is a WikiWikiWeb? A description of this application.\n* Learn HowToUseWiki and learn about AddingPages.\n* Use the SandBox page to experiment with Wiki pages.\n* Please sign your name in RecentVisitors.\n* See RecentChanges for the latest page additions and changes.\n* Find out which pages are MostPopular.\n* Read the ReleaseNotes\n* Administer this Wiki in PhpWikiAdministration.', 'a:0:{}');

-- --------------------------------------------------------

--
-- Table structure for table `auditTrail`
--

CREATE TABLE IF NOT EXISTS `auditTrail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personID` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `activity` enum('n','c','b','v','r','m') NOT NULL,
  `ideaID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `auditTrail`
--

INSERT INTO `auditTrail` (`id`, `personID`, `dateTime`, `activity`, `ideaID`) VALUES
(1, 2, '2010-07-05 11:24:44', 'n', 1),
(2, 2, '2010-07-05 12:22:29', 'n', 2),
(3, 2, '2010-07-12 14:59:48', 'b', 0),
(4, 2, '2010-07-12 15:01:06', 'n', 2),
(5, 2, '2010-08-05 10:52:10', 'v', 1),
(6, 2, '2010-08-05 11:24:18', 'n', 3),
(7, 2, '2010-08-16 11:38:31', 'm', 1),
(8, 2, '2010-08-16 11:38:47', 'm', 2),
(9, 2, '2010-08-16 11:51:25', 'n', 3),
(10, 2, '2010-08-19 10:19:02', 'm', 3),
(11, 2, '2010-08-19 10:28:48', 'm', 4),
(12, 2, '2010-08-19 10:42:07', 'm', 5),
(13, 2, '2010-08-19 10:43:23', 'm', 5),
(14, 2, '2010-08-19 11:44:19', 'n', 4),
(15, 2, '2010-08-19 12:59:45', 'n', 5),
(16, 2, '2010-08-19 13:44:28', 'n', 6),
(17, 2, '2010-08-20 09:24:51', 'n', 6),
(18, 3, '2010-11-24 09:37:23', 'c', 4),
(19, 3, '2010-11-24 09:37:23', 'v', 4),
(20, 3, '2010-11-24 09:37:52', 'c', 3),
(21, 3, '2010-11-24 09:39:35', 'n', 7),
(22, 3, '2010-11-24 09:49:53', 'n', 7),
(23, 15, '2011-03-16 13:41:40', 'n', 8),
(24, 15, '2011-03-16 13:42:02', 'v', 8),
(25, 2, '2011-03-16 13:44:16', 'c', 8),
(26, 2, '2011-03-16 13:44:16', 'v', 8),
(27, 2, '2011-03-16 13:52:31', 'c', 8),
(28, 15, '2011-03-16 13:52:55', 'c', 8);

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personID` int(11) NOT NULL,
  `jobID` int(11) NOT NULL,
  `bid` float NOT NULL,
  `offer` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `personID`, `jobID`, `bid`, `offer`) VALUES
(1, 114, 2, 5, 'a:1:{i:0;s:3:"PHP";}'),
(2, 3, 3, 6, 'a:1:{i:0;s:14:"new resource 2";}');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `thingID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `comment` mediumtext NOT NULL,
  `dateTime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`thingID`, `personID`, `title`, `comment`, `dateTime`) VALUES
(4, 3, '', 'i like it', '2010-11-24 09:37:23'),
(3, 3, '', 'great', '2010-11-24 09:37:52'),
(7, 15, '', 'test', '2010-12-01 14:59:38'),
(8, 2, '', 'yes it needs some work', '2011-03-16 13:44:16'),
(8, 2, '', 'but only a VERY little bit of work :)', '2011-03-16 13:52:31'),
(8, 15, '', 'ok lets do this', '2011-03-16 13:52:55');

-- --------------------------------------------------------

--
-- Table structure for table `dateTbl`
--

CREATE TABLE IF NOT EXISTS `dateTbl` (
  `thingID` int(11) NOT NULL,
  `dateAdded` datetime NOT NULL,
  `dateClose` datetime NOT NULL,
  `dateComplete` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dateTbl`
--

INSERT INTO `dateTbl` (`thingID`, `dateAdded`, `dateClose`, `dateComplete`) VALUES
(8, '2011-03-16 13:41:40', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, '2010-11-24 09:39:35', '2010-12-02 00:00:00', '0000-00-00 00:00:00'),
(6, '2010-08-19 13:44:27', '2010-10-31 00:00:00', '0000-00-00 00:00:00'),
(5, '2010-08-19 12:59:45', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, '2010-08-19 11:44:19', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, '2010-08-05 11:23:24', '2011-01-01 00:00:00', '0000-00-00 00:00:00'),
(2, '0000-00-00 00:00:00', '2011-01-01 00:00:00', '2010-08-16 14:48:09'),
(1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `docs`
--

CREATE TABLE IF NOT EXISTS `docs` (
  `thingID` int(11) NOT NULL,
  `doc` varchar(254) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dots`
--

CREATE TABLE IF NOT EXISTS `dots` (
  `personID` int(11) NOT NULL,
  `dots` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dots`
--

INSERT INTO `dots` (`personID`, `dots`) VALUES
(2, 30),
(3, 88),
(4, 100),
(5, 100),
(6, 100),
(7, 100),
(13, 0),
(12, 0),
(11, 0),
(10, 10),
(8, 167),
(14, 0),
(15, 0),
(16, 0),
(17, 0),
(18, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0),
(38, 0),
(39, 0),
(43, 0),
(44, 0),
(45, 0),
(46, 0),
(47, 0),
(48, 0),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0),
(56, 0),
(57, 0),
(58, 0),
(59, 0),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 0),
(68, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(75, 0),
(76, 0),
(77, 0),
(78, 0),
(79, 0),
(80, 0),
(81, 0),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0),
(97, 0),
(98, 0),
(99, 0),
(100, 0),
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 0),
(106, 0),
(107, 0),
(108, 0),
(109, 0),
(110, 0),
(111, 0),
(112, 0),
(113, 0),
(114, 5);

-- --------------------------------------------------------

--
-- Table structure for table `extra`
--

CREATE TABLE IF NOT EXISTS `extra` (
  `jobID` int(11) NOT NULL,
  `more` mediumtext NOT NULL,
  `skill` varchar(254) NOT NULL,
  `resource` varchar(254) NOT NULL,
  `job` varchar(254) NOT NULL,
  `image` varchar(254) NOT NULL,
  `jobLoc` varchar(254) NOT NULL,
  `loc` varchar(254) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `skillrequirement` mediumtext NOT NULL,
  `resourcerequirement` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `extra`
--

INSERT INTO `extra` (`jobID`, `more`, `skill`, `resource`, `job`, `image`, `jobLoc`, `loc`, `start`, `end`, `skillrequirement`, `resourcerequirement`) VALUES
(1, '', 'a:0:{}', 'a:0:{}', '', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'a:0:{}', 'a:0:{}'),
(2, '', 'a:1:{i:0;s:1:"2";}', 'a:0:{}', 'test', '', 'anywhere', 'everywhere', '2011-02-01 00:00:00', '2011-12-31 00:00:00', 'a:1:{i:0;s:19:"must understand oop";}', 'a:0:{}'),
(3, 'nice and easy so even sepp blatter can understand', 'a:3:{i:0;s:2:"79";i:1;s:2:"96";i:2;s:3:"111";}', 'a:2:{i:0;s:2:"70";i:1;s:2:"71";}', 'sport', '', 'the world', 'anywhere', '2011-02-01 00:00:00', '2012-02-01 00:00:00', 'a:3:{i:0;s:5:"maybe";i:1;s:10:"definitely";i:2;s:16:"more than likely";}', 'a:2:{i:0;s:7:"perhaps";i:1;s:15:"could be useful";}'),
(4, '', '', '', 'test', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', ''),
(5, '', '', '', 'test', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', ''),
(6, 'no thank-you', 'a:2:{i:0;s:3:"107";i:1;s:3:"111";}', 'a:1:{i:0;s:2:"61";}', 'test', '', 'here', 'there', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'a:2:{i:0;s:19:"must be really good";i:1;s:21:"must have heard of it";}', 'a:1:{i:0;s:13:"REALLY needed";}'),
(7, 'This is a test project', 'a:2:{i:0;s:2:"93";i:1;i:130;}', 'a:1:{i:0;s:2:"23";}', 'testing', '0602704.JPG', 'Plymouth', 'Plymouth', '2010-12-02 00:00:00', '2010-12-07 00:00:00', 'a:2:{i:0;s:5:"games";i:1;s:9:"very good";}', 'a:1:{i:0;s:5:"1 day";}'),
(8, '', '', '', 'Website / Online account', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `personID` int(11) NOT NULL,
  `friendID` int(11) NOT NULL,
  `yorn` enum('y','n','') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `general`
--

CREATE TABLE IF NOT EXISTS `general` (
  `name` varchar(254) NOT NULL,
  `value` int(11) NOT NULL,
  `txt` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `general`
--

INSERT INTO `general` (`name`, `value`, `txt`) VALUES
('idea', 1209600, '14 days'),
('job', 1209600, '14 days'),
('suggest', 0, 'Join the Co-os community, where you can make ideas happen without the need for cash.<br /><br />I set up a Co-os profile, I want to invite you as a member. CO-OS is a community for technologists, digital artists and creatives making ideas happen without the need for cash, where ideas can be shared, evaluated and developed collaboratively through trading units of time for skills. Once you join, you can also make your ideas happen.'),
('i', 0, 'idea state'),
('j', 0, 'collaboration state'),
('p', 0, 'project state'),
('c', 0, 'completed state'),
('r', 0, 'rejected state'),
('b', 0, 'bidding ended'),
('d', 0, 'rejected collaboration - bids not accepted'),
('v', 0, 'voting ended'),
('w', 0, 'withdrawn');

-- --------------------------------------------------------

--
-- Table structure for table `groupPerson`
--

CREATE TABLE IF NOT EXISTS `groupPerson` (
  `groupID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `dateTime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groupPosts`
--

CREATE TABLE IF NOT EXISTS `groupPosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `post` mediumtext NOT NULL,
  `previousPost` int(11) NOT NULL,
  `removed` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `blurb` mediumtext NOT NULL,
  `moderator` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hitcount`
--

CREATE TABLE IF NOT EXISTS `hitcount` (
  `pagename` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pagename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hitcount`
--

INSERT INTO `hitcount` (`pagename`, `hits`) VALUES
('FrontPage', 12),
('PhpWikiAdministration', 1),
('HowToUseWiki', 1),
('RecentVisitors', 1),
('RecentChanges', 1);

-- --------------------------------------------------------

--
-- Table structure for table `hottopics`
--

CREATE TABLE IF NOT EXISTS `hottopics` (
  `pagename` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `lastmodified` int(11) NOT NULL,
  PRIMARY KEY (`pagename`,`lastmodified`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ideaImg`
--

CREATE TABLE IF NOT EXISTS `ideaImg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ideaID` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `imgLibrary`
--

CREATE TABLE IF NOT EXISTS `imgLibrary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personID` int(11) NOT NULL,
  `image` varchar(254) NOT NULL,
  `active` enum('y','n') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `imgLibrary`
--

INSERT INTO `imgLibrary` (`id`, `personID`, `image`, `active`) VALUES
(1, 2, '21255203819.jpg', 'y'),
(9, 5, '51265476723.jpg', 'y'),
(4, 3, '31255510720.jpg', 'y'),
(8, 5, '51265476665.jpg', 'n'),
(7, 4, '41259076120.jpg', 'n'),
(10, 12, '121265734987.jpg', 'n'),
(11, 13, '131265797662.jpg', 'n'),
(12, 15, '151265815379.jpg', 'n'),
(13, 13, '131265834381.jpg', 'n'),
(14, 13, '131265834486.jpg', 'n'),
(15, 21, '211267130842.jpg', 'y'),
(16, 23, '231267185002.jpg', 'y'),
(17, 18, '181267524251.jpg', 'y'),
(18, 18, '181267524494.jpg', 'n'),
(19, 18, '181267524946.jpg', 'n'),
(20, 30, '301269427511.jpg', 'n'),
(21, 31, '311269436042.jpg', 'n'),
(22, 11, '111269780532.jpg', 'n'),
(23, 85, '851274429675.jpg', 'n'),
(24, 110, '1101276334541.jpg', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `interests`
--

CREATE TABLE IF NOT EXISTS `interests` (
  `personID` int(11) NOT NULL,
  `interests` varchar(254) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interests`
--

INSERT INTO `interests` (`personID`, `interests`) VALUES
(3, ' technology'),
(11, ' inter-medial'),
(2, 'being a ghost'),
(6, ' breathing'),
(6, ' sitting'),
(6, 'standing'),
(5, 'monkeys'),
(5, ' hippies'),
(5, ' ninjas '),
(2, 'eating'),
(3, 'Innovation'),
(4, ' interaction design'),
(4, ' design'),
(4, ' digital art'),
(4, 'architecture'),
(4, ' intelligent architecture'),
(11, ' performance'),
(11, ' interactive'),
(11, ' telematics'),
(2, 'going \\"yup yup\\"'),
(12, 'design'),
(12, ' art'),
(12, ' telematics'),
(12, ' interdisciplinarity'),
(12, ' internet of things'),
(13, ' This is just a test'),
(14, 'fred'),
(15, ' Arch-OS'),
(13, 'This is just a test'),
(13, ' This is just a test'),
(15, ' eco-os'),
(15, ' internet of things'),
(15, ' digital art & Technology'),
(15, 'Interdisciplinary art'),
(3, ' design & media'),
(10, 'football'),
(20, 'to follow'),
(20, 'to follow'),
(20, 'to follow'),
(20, 'to follow'),
(21, 'digital art'),
(21, ' technology'),
(21, ' software'),
(19, 'urbanism'),
(19, ' data visualisation'),
(19, ' data evaluation'),
(19, ' performace'),
(19, ' language'),
(19, ' cognitive science'),
(19, ' publishing'),
(30, 'web design'),
(30, ' web development'),
(30, ' flash'),
(30, ' ui'),
(15, ' operating systems'),
(11, 'responsive environments'),
(11, ' life'),
(35, 'drawing'),
(35, ' painting'),
(35, ' conceptual art.'),
(51, 'public art'),
(51, ' technology'),
(51, ' public engagement'),
(51, ' rural contexts'),
(51, ' public realm'),
(51, ' events'),
(51, ' experiences'),
(59, 'Cognitive Science'),
(59, ' Design Science'),
(59, ' Visual Language'),
(59, ' Xenolinguistics'),
(59, ' Projective Geometry'),
(59, ' Geodesics'),
(59, ' Bio-Mimicry'),
(59, ' Integral Theory'),
(59, ' Informatics'),
(59, ' Interface Philosophy'),
(59, ' Conceptual Spaces'),
(59, ' Pattern Languages'),
(59, ' Semantic Web'),
(59, ' Social Networks'),
(59, ' Game Theory'),
(59, ' Virtual Reality'),
(59, ' Artificial Intelligence'),
(59, ' Biofeedback'),
(59, ' Cognitive Semantics'),
(59, ' Semiotics'),
(59, ' Ontological Engineering'),
(59, ' Symbolic Systems'),
(59, ' Trans-Symbolic Communication Systems'),
(59, ' Computational Metaphysics'),
(59, ' Technoetics'),
(59, ' Synthetic Biology'),
(59, ' Bioinformatics'),
(59, ' Neuroinformatics'),
(59, ' Biophotonics'),
(59, ' Archetypal Psychology'),
(59, ' Transpersonal Psychology'),
(59, ' Archetypal Cosmology'),
(59, ' Noospherics'),
(59, ' Collective Intelligence'),
(59, ' Synchronicity.'),
(65, 'art'),
(65, ' engagement strategy'),
(65, ' idea generation and concept development'),
(65, ' curation and project management'),
(96, ' noise'),
(96, ' sound'),
(96, ' interactivity'),
(96, ' networks'),
(110, ' photography'),
(110, ' video'),
(110, ' performance-art'),
(110, 'visual arts'),
(110, ' music'),
(2, 'running');

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE IF NOT EXISTS `library` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(254) NOT NULL,
  `type` enum('i','d','f','v') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `library`
--

INSERT INTO `library` (`id`, `filename`, `type`) VALUES
(1, 'DSC00020.JPG', 'i'),
(2, 'DSC00021.JPG', 'i'),
(3, '2008-09 Grid Calendar.xls', 'f');

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `personID` int(11) NOT NULL,
  `link` varchar(254) NOT NULL,
  `title` varchar(254) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu` varchar(20) NOT NULL,
  `prio` int(2) NOT NULL,
  `display` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `menu`, `prio`, `display`) VALUES
(1, 'Home', 1, 'y'),
(2, 'Marketplace', 6, 'y'),
(3, 'Research', 3, ''),
(4, 'Ideas Exchange', 7, 'y'),
(5, 'Groups', 5, 'y'),
(9, 'Trading Exchange', 2, 'y'),
(10, 'People', 4, 'y'),
(11, 'Profile', 3, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `msg`
--

CREATE TABLE IF NOT EXISTS `msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` int(11) NOT NULL,
  `from` int(11) NOT NULL,
  `subject` varchar(254) NOT NULL,
  `msg` mediumtext NOT NULL,
  `sent` datetime NOT NULL,
  `reader` enum('n','y') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `msg`
--

INSERT INTO `msg` (`id`, `receiver`, `from`, `subject`, `msg`, `sent`, `reader`) VALUES
(1, 15, 3, 'testing', 'hi mike', '2010-11-24 09:36:18', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `msgBoard`
--

CREATE TABLE IF NOT EXISTS `msgBoard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `title` varchar(254) NOT NULL,
  `content` mediumtext NOT NULL,
  `dateTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `msgBoard`
--

INSERT INTO `msgBoard` (`id`, `parent`, `personID`, `title`, `content`, `dateTime`) VALUES
(1, 0, 2, 'test post', 'blah blah blah', '2010-08-16 11:38:31'),
(2, 1, 2, 'RE: test post', 'that\\''s easy 4 u 2 say :)', '2010-08-16 11:38:47'),
(3, 2, 2, 'RE: RE: test post', 'la la la test test test', '2010-08-19 10:19:02'),
(4, 1, 2, 'RE: test post', 'another reply', '2010-08-19 10:28:48'),
(5, 3, 2, 'RE: RE: RE: test post', 'testing testing 1...2...3', '2010-08-19 10:43:23');

-- --------------------------------------------------------

--
-- Table structure for table `openid`
--

CREATE TABLE IF NOT EXISTS `openid` (
  `openid_url` varchar(256) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`openid_url`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(254) NOT NULL,
  `content` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `content`) VALUES
(1, 'About', '<p><strong>About</strong></p>\r\n<p>&nbsp;</p>\r\n<p>This is the beta of the CO-OS platform, which will launch in June 2010.</p>\r\n<p>CO-OS is a growing community of creators and do-ers, all coming together to collaborate and exchange creative ideas, skills and resources in a cashless system based on the concept of timebanking.  This community is based on mutual and reciprocal relationships of trading time and is dependent on all members respecting others, their time, their skills, their ideas and their opinions, and offering access to their ideas, knowledge, skills and resources.</p>\r\n<p>Everyone''s time is equal: one hour of your time earns you a one hour credit to spend when you need skills or resources to develop your idea. The more hours you put in the more you can take out from the community.</p>\r\n<p><strong>Why</strong></p>\r\n<p>The purpose of CO-OS is to explore the possibility of creating a global network of collaborators partaking in a money-less system for creative and artistic production.</p>\r\n<p>By facilitating online exchanges beyond small, localised communities, CO-OS enables users to grow their networks, and support a more equal access to opportunities for innovation, irrelevant of geographical location and cash flow.</p>\r\n<p>CO-OS is not a replacement for the established economy ''cash for your time'' but a complementary economy, to foster collaboration, knowledge exchange and collective innovation across communities and cultures</p>\r\n<p><strong>Who</strong></p>\r\n<p>CO-OS belongs to its community, and has been developed through generous support from its members and by the <a href="http://www.artscouncil.org.uk/">Arts Council England</a>, <a href="http://www.britishcouncil.org">British Council</a>, and <a href="http://www.i-dat.org">i-DAT</a>, University of Plymouth.</p>\r\n<p><strong>Who is it for</strong></p>\r\n<p>CO-OS is aimed at emerging and established creators and do-ers who play, design, experiment, develop, produce, imagine and invent with digital technologies, software, and materials (media).</p>\r\n<p><strong>CO-OS Ignite Commissions</strong></p>\r\n<p>The Co-OS community are commissioning new collaborative work from a selection of international creatives to be launched alongside the CO-OS platform in June 2010.  The comissions, CO-OS Ignite, are part of <a href="http://www.britishcouncil.org/creativecollaboration">''Creative Collaboration''</a> a British Council arts initiative that build networks for dialogue and debate across the arts communities of South East Europe and the UK. The programme aims to enrich the cultural life of Europe and its surrounding countries, as well as fostering understanding, skills development, trust and respect across borders.</p>\r\n<p>These commissions will be developed through the CO-OS community, offering you the opportunity to collaborate with these creatives and become part of the commission.</p>\r\n<p>The CO-OS Ignite commissions are developed with <a href="http://www.amorphy.org">Amorphy</a>, <a href="http://www.galeriavermelho.com">Galeria Vermelho</a> (Brazil), <a href="http://www.i-dat.org">i-DAT</a> (UK), <a href="http://www.plymouthartscentre.org">Plymouth Arts Centre</a> (UK), <a href="http://www.scansite.org">SCAN</a> (UK), and <a href="http://www.tat-ort.net">tat ort</a> (Austria).</p>'),
(2, 'Help', '<p>Help stuff goes here</p>'),
(3, 'Contact', '<p><strong>Contacting us</strong></p><p>\r\nIf you have any questions, need assistance, or wish to report a violation of Site Terms, please contact\r\nCO-OS Support, (delivered by i-DAT on behalf of CO-OS) as follows:</p><p>\r\nEmail: <a href=''mailto:contact@i-dat.org''>contact@i-dat.org</a></p><p>Phone: (Mon-Fri, 9 a.m. - 5 p.m. GMT): (++44) 01752 86201</p><p>\r\nOnline Help: <a href=''http://beta.co-os.org?pid=22''>http://beta.co-os.org</a></p>'),
(4, 'Terms', '<p><strong>Terms of Service</strong></p><p>These Terms of Service (\\"Terms\\") govern your access to and use of the CO-OS website (the \\"Service\\"), and any information, text, graphics, or other materials uploaded, downloaded or appearing on the Service (collectively referred to as \\"Content\\"). Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. By accessing or using the Service you agree to be bound by these Terms.</p><p><strong>Disclaimer</strong></p><p>i-DAT (here know as \\''CO-OS\\'') on behalf of the CO-OS community makes every possible effort to ensure that the information published on this website is accurate and up to date, but does not accept any responsibility for errors or omissions and reserves the right to make amendments at any time and without prior notice. CO-OS does not accept responsibility for the information provided by members of the community within the community or through external sites reached via links from any of CO-OS web pages.</p><p><strong>Basic Terms</strong></p><p>\r\nYou are responsible for your use of the Service, for any content you post to the Service, and for any consequences thereof. The Content you submit, post, or display will be able to be viewed by other users of the Service. You should only provide Content that you are comfortable sharing with others under these Terms.</p><p>The Services that CO-OS provides are always evolving and the form and nature of the Services that CO-OS provides may change from time to time without prior notice to you. In addition, CO-OS may stop (permanently or temporarily) providing the Service (or any features within the Service) to you or to users generally and may not be able to provide you with prior notice.</p><p>We also retain the right to create limits on use and membership at our sole discretion at any time without prior notice to you.</p><p><strong>Content on the Services</strong></p><p>All Content, whether publicly posted or privately transmitted, is the sole responsibility of the person who originated such Content. We may not monitor or control the Content posted via the Services and, we cannot take responsibility for such Content. Any use or reliance on any Content or materials posted via the Services or obtained by you through the Services is at your own risk.</p><p>We do not endorse, support, represent or guarantee the completeness, truthfulness, accuracy, or reliability of any Content or communications posted via the Services or endorse any opinions expressed via the Services. You understand that by using the Services, you may be exposed to Content that might be offensive, harmful, inaccurate or otherwise inappropriate, or in some cases, postings that have been mislabeled or are otherwise deceptive. Under no circumstances will CO-OS or partners be liable in any way for any Content, including, but not limited to, any errors or omissions in any Content, or any loss or damage of any kind incurred as a result of the use of any Content posted, emailed, transmitted or otherwise made available via the Services or broadcast elsewhere.</p><p><strong>Freedom of Information</strong></p><p>i-DAT has a commitment to openness and transparency, and has always been concerned to make relevant information available wherever possible to individuals who may request it, subject to safeguarding the privacy of individuals and to legitimate considerations of national security, law enforcement and commercial interests where relevant.</p><p><strong>Copyright</strong></p><p>\r\nExcept where otherwise noted, content on this site is licensed under a Creative Commons (http://creativecommons.org/) Attribution-Noncommercial-Share Alike 3.0 license (http://creativecommons.org/licenses/by-nc-sa/3.0/)</p>\r\n<p style=''margin:10px''><strong>You are free:</strong><br />\r\nto Share - to copy, distribute and transmit the work<br />\r\nto Remix - to adapt the work</p><p style=''margin:10px''><strong>Under the following conditions:</strong><br />Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).\\"What does ''Attribute this work\\"''mean?\\" The page you came from contained embedded licensing metadata, including how the creator wishes to be attributed for re-use. You can use the HTML here to cite the work. Doing so will also include metadata on your page so that others can find the original work as well.</p><p style=''margin:10px''><strong>Noncommercial. You may not use this work for commercial purposes.</strong><br />Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.<br />For any reuse or distribution, you must make clear to others the license terms of this work. The best way to do this is with a link to this web page.<br />Any of the above conditions can be waived if you get permission from the copyright holder.<br />Nothing in this license impairs or restricts the author\\''s moral rights.<br />\r\nThe permission to reproduce material does not extend to anything on this site identified as being the copyright of a third party. Authorisation to reproduce such material must be obtained from the copyright holders concerned.</p><p><strong>Dispute Resolution Process</strong></p><p>How to avoid disputes<br />Disputes may arise due to miscommunication and can often be resolved amicably between the parties.</p><p>CO-OS recommend its members to conduct all transactions and general communication  in a professional manner, treating others as you expect to be treated. Maintain open lines of communication, be clear about your expectations and check in frequently with collaborators and milestone deliverables. This is a community and also as strong as the sum of its members, be courteous, supportive and giving.</p><p>What if I have a dispute with another member?<br />If you have used the Site in accordance with the CO-OS Terms and you have a dispute with another member you should first try to resolve this through communication with the opposing party. If this fails contact us and we will take it up with the community to resolve the situation.</p><p>CO-OS reserves the right to make the final decision on resolving any disputes.</p>'),
(5, 'Privacy', '<p><strong>Privacy Statement</strong></p><p>\r\nThis statement covers the services provided by the CO-OS website:</p><p>The Data Controller for this web site is <a href=''http://www.i-datorg''>i-DAT</a></p><p>The purpose of this statement is to inform users of this web site, about the information that is collected from them when they visit this site, how this information is used, if it is disclosed and the ways in which we protect users\\'' privacy.</p><p><strong>Data Protection Act 1998:</strong></p><p>The Data Protection Act 1998 establishes rights for individuals who disclose their personal information - where personal information is widely defined - to any organisation for any purposes involving processing of that information. Any organisation which processes information about living individuals is a data controller for the purposes of the Act; that is a person who determines the purposes for which and the manner in which any personal data are, or are to be, processed. A data controller is required by the Act to ensure that the data subject has, is provided with, or has made readily available to her/him certain specified information, including the data controller\\''s identity, the identity of any other person to whom she/he may disclose the information, and the purpose or purposes for which the data are intended to be processed. The data controller in relation to this website is i-DAT. The purposes for which the data are intended to be processed are as follows:</p><p><strong>Your Data</strong></p><p>All communication with you, the user, will be conducted through the details provided and only relating to CO-OS.</p><p>If you register on this site, your personal details will be used only for the purpose of CO-OS related activities. CO-OS will respect the privacy of your personal information and undertakes to comply with all applicable Data Protection legislation currently in force.</p><p>We reserve the right to use the data for CO-OS related purposes, but will NOT give, share, sell or transfer any personal information collected distribute your details to third parties to be used for anything other than related to CO-OS.</p><p>This privacy statement relates only to the CO-OS website. The CO-OS website may contain links to other sites where information practices may be different to ours. You should consult the other sites\\'' privacy notices as we are not responsible for and have no control over information that is submitted to, or collected by, third party Web sites.</p><p><strong>Amendment</strong></p><p>\r\nThis may be amended from time to time and we will inform you of any (unlikely) changes to your privacy rights when you use the CO-OS site.</p>'),
(6, 'Time Balance', 'This is your time balance, and is calculated by the amount of \\''hours\\'' you have traded with the community, and = \\''hours\\'' given minus \\''hours\\'' received.');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `pwd` varchar(254) NOT NULL,
  `firstName` varchar(254) NOT NULL,
  `lastName` varchar(254) NOT NULL,
  `about` mediumtext NOT NULL,
  `bio` mediumtext NOT NULL,
  `location` varchar(254) NOT NULL,
  `job` varchar(254) NOT NULL,
  `flag` enum('r','w','a','l') NOT NULL,
  `deadline` datetime NOT NULL,
  `bodKey` varchar(254) NOT NULL,
  `recommend` int(11) NOT NULL,
  `description1` mediumtext NOT NULL,
  `url1` varchar(254) NOT NULL,
  `description2` mediumtext NOT NULL,
  `url2` varchar(254) NOT NULL,
  `description3` mediumtext NOT NULL,
  `url3` varchar(254) NOT NULL,
  `getMail` enum('y','n') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=115 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `email`, `pwd`, `firstName`, `lastName`, `about`, `bio`, `location`, `job`, `flag`, `deadline`, `bodKey`, `recommend`, `description1`, `url1`, `description2`, `url2`, `description3`, `url3`, `getMail`) VALUES
(1, 'admin', 'qwerty', 'admin', '', '', '', '', '', 'a', '0000-00-00 00:00:00', '58a4b5e16f0340829a9e9d80608330ec', 0, '', '', '', '', '', '', 'n'),
(2, 'chris.saunders@plymouth.ac.uk', 'derek', 'chris', 'saunders', 'i don\\''t like fish!', 'naturally left footed winger who is lacking a bit of pace now', 'Plymouth', 'pacman stunt double', 'a', '2008-07-02 09:28:22', '', 1, '1', 'www.pl9design.co.uk', '2', 'www.boxel.co.uk', '3', 'www.ohdear.me.uk', 'y'),
(3, 'birgitte.aga@plymouth.ac.uk', 'splutt', 'B', 'Aga', 'B [Birgitte] Aga is an independent creative producer, working across disciplines at the intersection point of culture, research/HE, industry and public sector. At the core of her work is the emphasis of contributing to a culture that encourages innovative practices through the open exchange and sharing of knowledge across disciplines, sectors as well as cultures, where art, innovation and entrepreneurialism can function in a synergetic relationship.rn	', 'My experience is situated at the intersection point between industry and research with a focus on the potential of digital technologies and software, in the context of R&D. Particularly interest lies in the potential of cross-disciplinary and open models for collaborative innovation and creativity.rnrnI am experienced in negotiating, securing funding, managing and developing work with academics, researchers, industry representatives and artists, through my employment and consultancy for a range of organisations [ Arts Council England, Creative & Cultural Skills, Futurelab, The Institute of Digital Art & Technology, Plymouth City Council, South West Screen, Submerge, Watershed Media Centre, Lottolab ]. I thrive in bringing together, negotiating between these parties to see projects evolve and achieve their desired results.', 'Plymouth, Uk', 'Creative Producer', 'a', '0000-00-00 00:00:00', '', 2, 'i-DAT is a â€˜Centre of Expertiseâ€™ located in the Faculty of Technology at the University of Plymouth, and acts as a catalyst for creative research and innovation across the fields of Art, Science and Technology, facilitating regional, national and international collaborations and cultural projects.', 'www.i-dat.org', 'Lottolab, a hybrid art studio and science lab. With glowing, interactive sculpture.', 'http://www.lottolab.org/', '', '', 'y'),
(5, 'ollie@playnicely.co.uk', 'qwerty', 'Ollie', 'Lindsey', 'Curabitur non quam et nulla faucibus suscipit. In lobortis, tellus a rhoncus egestas, ligula ipsum porta justo, ut dictum justo magna id nisl. Vestibulum fermentum, sem et scelerisque semper, erat ipsum vestibulum augue, vel ullamcorper ligula nisi quis est. Pellentesque imperdiet, lacus at sagittis elementum, sem nisl porta purus, hendrerit tristique odio arcu nec diam. Mauris viverra consectetur porta! Proin ut dui eros. Praesent ac molestie magna. Aliquam erat volutpat. Nam felis tellus, volutpat ac malesuada eu, ultrices sit amet ante amet.rn', 'Cras suscipit augue gravida sem posuere at euismod risus blandit. Nunc quis odio iaculis sem suscipit tempus vitae a turpis. In id metus in purus euismod hendrerit! Donec laoreet varius erat, ac sagittis diam porta id. Aliquam id tincidunt mi. Etiam vehicula lacus sit amet quam pellentesque vulputate. Sed dapibus, neque at fermentum dignissim, mauris nunc commodo velit, nec elementum enim urna ac elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam sem nisl, pharetra sed iaculis nec cras amet.rn', 'Bristol', 'Graphic Design', 'a', '0000-00-00 00:00:00', '', 1, '', '', '', '', '', '', 'n'),
(15, 'mike.phillips@plymouth.ac.uk', 'TROUTY', 'Mike', 'Phillips', 'Professor Mike Phillips is the director of i-DAT [The Institute of Digital Art and Technology], a component of the Aâˆ‘TEC [Arts Science Technology] Research Consortium. Phillips initiated and coordinated the BSc (Hons) MediaLab Arts Programme [1992] (now b-DAT) at the University of Plymouth, with the support of Macromedia and more recently founded the On-Line MSc Digital Futures (now m-DAT) programme. He is a Senior Supervisor in the Planetary Collegium and a Fellow at the Centre for Sustainable Futures. Current activities include Arch-OS and the i-500 Project in Perth Australia.rnrnPrivate and public sector grant funded R&D orbits digital architectures and transmedia publishing, and is evident in two key research projects: Arch-OS [www.arch-os.com], an \\''Operating System\\'' for contemporary architecture (\\''software for buildings\\'') which makes manifest the social and ecological life of a building and provide artists, engineers and scientists with a unique environment for transdisciplinary research; and the LiquidPress [www.liquidpress.net] which explores the evolution and mutation of publishing and broadcasting technologies and the kinds of collaborative spaces that emerge through human interaction with(in) them. These projects and other work can be found on the i-DAT web site at: www.i-dat.org.rn', 'Private and public sector grant funded R&D orbits digital architectures and transmedia publishing, and is evident in two key research projects: Arch-OS [www.arch-os.com], an \\''Operating System\\'' for contemporary architecture (\\''software for buildings\\'') which makes manifest the social and ecological life of a building and provide artists, engineers and scientists with a unique environment for transdisciplinary research; and the LiquidPress [www.liquidpress.net] which explores the evolution and mutation of publishing and broadcasting technologies and the kinds of collaborative spaces that emerge through human interaction with(in) them. These projects and other work can be found on the i-DAT web site at: www.i-dat.org.', 'Plymouth, UK', 'Director of i-DAT', '', '0000-00-00 00:00:00', '', 0, 'i-DAT, research group and pseudo arts organisation... ', 'http://www.i-dat.org', 'Arch-OS OperatingSystem, software for buildings. for architectire', 'http://www.arch-os.com', 'i-500: application of Arch-OS to a nano technology research building in Perth, WA.', 'http://www.i-500.org', 'y'),
(19, 'fiel@tat-ort.net', 'wiegwofi', 'Wolfgang', 'Fiel', 'Co-founder and current member of tat ort, a collaborative practice involved in cross-disciplinary projects that incorporate visual arts, architecture and urbanism. Lecturer at the Vienna University of Technology.', 'Alexandra Berlinger, born 1970 in Bregenz, lives in Vienna, 1992-1998 University of Applied Arts Vienna, Bernhard Leitner, 2000-2004 Tutor at the University of Applied Arts Vienna; Andreas Berlinger (Belringer), born 1977 in Bregenz, lives in Munich, 1997-2001 Media and Communication Design, Fachhochschule Vorarlberg, Dornbirn, 2003-2005 Master of Interaction Design at the Royal College of Art, London, 2006-2008 Senior Designer at Virtual Identity AG, Munich, 2009- Interaction Designer at Tieto, Munich; Wolfgang Fiel, born 1973 in Alberschwende, lives in Vienna, 1994-2001 Architecture and Regional Planning, Vienna University of Technology, Helmut Richter, 2001-2002 Master of Architecture in Architectural Design at The Bartlett/UCL - University College London, Sir Peter Cook, 2006- Doctoral Candidate at the Centre for Advanced Inquiry in the Interactive Arts, University of Plymouth/UK.', 'Vienna, Austria', 'Member of tat ort', '', '0000-00-00 00:00:00', '', 0, 'full overview to be found on www.tat-ort.net', 'www.tat-ort.net', '', '', '', '', 'n'),
(11, 'ash@amorphy.org', '1313', 'Ash', 'Bulayev', 'Ash Bulayev is an independent director/choreographer and media artist, and is a co-Artistic Director of amorphy.org (www.amorphy.org) in collaboration with choreographer Tzeni Argyriou. He has lived in New York City from 1991-2003, where he has created multiple original productions ranging from site-specific/multi-location work, interactive installations to dance/theater projects which where presented in U.S.A., Spain, Germany, Egypt, Portugal, Bulgaria, Holland, and Greece.', '', 'Athens, Greece & Amsterdam, Netherlands', 'Co-Artistic Director, amorphy.org', '', '0000-00-00 00:00:00', '', 0, 'Alpha/Omega - Live Cinema performance', 'http://www.ashbulayev.com/?page_id=43', 'See You in Wahalla - interactive, distributed performance', 'http://www.ashbulayev.com/?page_id=199', 'Psycho/Cycle - dance theater installation/performance', 'http://www.ashbulayev.com/?page_id=282', 'n'),
(21, 'birgitte.aga@plymouth.ac.uk', 'idat', 'i-DAT', '', 'i-DAT is a research group located in the Centre for Art, Media and Design Research, Faculty of Art at the University of Plymouth, and acts as a catalyst for creative research and innovation across the fields of Art, Science and Technology, facilitating regional, national and international collaborations and cultural projects.<br /><br />As a networked organisation and cultural broker i-DAT\\''s transdisciplinary agenda fosters open innovation, Knowledge Transfer and mutually beneficial relationships between companies, institutions, communities and individuals. Through a rich interaction with teaching, research and enterprise it provides access to new technologies, knowledge and ideas, further breaching academia\\''s ivory walls.', '', 'Plymouth, UK', 'i-DAT is a research group', '', '0000-00-00 00:00:00', '', 0, 'Our website', 'http://www.i-dat.org', '', '', '', '', 'n'),
(18, 'paula@plymouthartscentre.org', 'james', 'Paula', 'Orrell', 'Plymouth Arts Centre is the leading organisation for contemporary arts and independent cinema in the city. Through its overall programme of exhibitions, films, events, residencies and education, Plymouth Arts Centre encourages critical debate and questions the role that art plays in the wider culture. It is dedicated to independent film, artists and curatorial practice and has a special interest in artwork that engages with human interaction and social context.  <br /> <br />Plymouth Arts Centre was one of the first arts centres in the UK and in 2007/08 celebrated its 60th anniversary of delivering a multi-art form programme. It remains an independent organisation through its ethos of public participation with the development of new and diverse audiences and practices. <br /><br />Plymouth Arts Centre aims to be the South Westâ€™s pre-eminent international arena for risk, innovation, inspiration, creativity and participation in contemporary arts practice and the moving image, in a setting which is passionate, inclusive and welcoming.<br /><br />Its artistic direction consolidates and extends Plymouth Arts Centreâ€™s core values; widening participation; transparency and inclusively; creativity and experimentation. These are set out for Plymouth Arts Centre to explore the vibrant and provocative nature of contemporary art practice, visual culture and cinema.<br /><br />The centre has pledged its commitment to creating new thinking and approaches to gallery and outreach education by engaging with all levels of education, focusing on an experimental approach to learning.  At the core of this activity will be the development, support and understanding needed to nurture talent in art and design. <br /><br />Plymouth Arts Centre believes it can have a central role and act as a major catalyst for regeneration through collaborations across the creative industries in Plymouth and the South West of England.    <br /><br />Visual Arts Programme  <br />The Visual Arts Programme aims to encourage critical debate and to question the role that art plays in wider culture. It maintains a special interest in artwork that engages with human interaction and social context, and places emphasis on research, interdisciplinary, collaboration, internationalism, criticality and social exchange through a process based approach.<br /><br />Artist and Curators Residency Programme <br />Plymouth Arts Centre artistsâ€™ and curatorial residencies provide research and commissioning opportunities for creative practitioners in the region, nationally and internationally. The programme aims to facilitate creative dialogues and collaborations between artists and curators, create new opportunities for emerging practices and become a platform for young artists in the region.  <br /> <br />The programme emphasises the exploration of new ideas and commissions through research, professional development and a mentoring programme. <br /><br />Cinema<br />Plymouth Arts Centre has operated a cinema since the 1970â€™s and has the only full time screen dedicated to offering art-house cinema - British, World and Independent product within the city. <br /><br />Education and Outreach Programme  <br />Creative exploration and critical enquiry are the focus for a programme, which aims to contribute to visual literacy and cultural democracy by establishing dialogues within Plymouth. This inclusive programme values the diverse interpretations, which emerge through an open exchange of experience and offers opportunities to learn and collaborate with practicing artists.  <br /> <br />Talks, events, workshops, projects and supported visits encourage active and reflective engagement with the visual art and film programme, the city of Plymouth and the ideas and processes within contemporary culture. <br />', 'Paula Orrell<br />Since 2006, Paula Orrell is Curator of Plymouth Arts Centre, establishing a visual arts programme that has a special interest in artwork that engages with human interaction and social context, and places emphasis on research, interdisciplinary practice and collaboration. She has curated a new programme of residencies, exhibitions and an offsite programme, focussing on new commissioning that blurs the boundaries between artist and curatorial practice, nationally and internationally including recent major project \\''The Pigs of Today Are the Hams of Tomorrow\\'' curatorial collaboration with Marina Abramovic. Other artist; Cadu, Committee for Radical Diplomacy, 16 Beaver, Anna Best, Ricardo Basbaum, Tom Dale, Barbara Holub, William Furlong, Tim Knowles, Lau Thiam Kok, Low Profile, withyou.co.uk and Ultra-red. The programme includes new media and technology focus recent major retrospective of the pioneering cybernetic artist Roy Ascott and fundamental collaborations with practitioners in proximity to the arts centre and the locationâ€™s visual arts ecology. Created a socially engaged programme with a community interest partnership in a socially deprived area of the city commissioning since 2006 and is ongoing. Forthcoming public art commission with Wokenklauser, Sophie Hope and Mark Vernon. <br /><br />Past curated projects include a solo exhibition of Lucy Orta at the Barbican, London, 2005; a new commission by Tim Brennan at the British Museum for the 250th anniversary, 2002-2003; and a solo exhibition of acclaimed performance artists Noble and Silver curated in collaboration at Beaconsfield, London, 2002. Founder of an interdisciplinary Masters programme in Fashion Curation at the London College of Fashion, University of the Arts London, 2004, she continues to lecturer at academic institutions across the country. Graduated in MA Creative Curating, Goldsmith College, 2002. Publications include editor of Lucy + Jorge Orta Pattern Book: An Introduction to Collaborative Practice, published by Black Dog and Fashion Theory, The Journal of Dress, Body and Culture edited in collaboration with Alistair O\\''Neill published by Berg, 2008 and Between the vanguard and the peripheral, published by Plymouth Arts Centre, 2009 and recent publication editor of The Future of Performance Art, Marina Abramovic, Prestel, 2010.', 'Plymouth, UK', 'Curator, Plymouth Arts Centre', '', '0000-00-00 00:00:00', '', 0, 'Plymouth Arts Centre', 'www.plymouthartscentre.org', '', '', '', '', 'n'),
(20, 'baga@plymouth.ac.uk', 'bob', 'Bob', 'Roberts', 'to follow', 'to follow', 'London', 'Artist', '', '0000-00-00 00:00:00', '', 0, 'to follow', 'to follow', 'to follow', 'to follow', 'to follow', 'to follow', 'n'),
(22, 'gianni.corino@plymouth.ac.uk', 'co124no', 'Gianni', 'Corino', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(23, 'helen@scansite.org', 'Scanning1', 'Helen', 'Sloan', 'SCAN is an agency developing media arts in the South of England. It works in partnership with a broad range of individuals, groups and institutions nationally and internationally to commission innovative projects that cross and merge disciplines drawn from arts, media, humanities, science and technology. SCAN explores ideas, sites and tools showing the creative potential that media arts offer in our changing society.<br /><br />SCAN welcomes approaches from organisations or individuals who wish to develop their ideas or would like to be involved in SCANâ€™s initiatives. Contact +44(0)1202 961451 info@scansite.org.', 'Helen Sloan has worked as a curator, researcher, writer, editor and producer in media arts and culture since late 1980s. Since 2003, she has been Director of SCAN, a networked organisation and creative development agency for media arts in the South of England working on media arts projects and strategic initiatives in arts organisations, academic institutions and further aspects of the public realm. Helen has worked both freelance and as a curator at organisations such as Camerawork, FACT, ICA and Site Gallery as well as directing festivals such as Across Two Cultures in Newcastle 1996 (an early conference on the overlapping practice of creative thinking in arts and science) and Metapod, Birmingham 2001 - 2. Current areas of interest and curatorial work include the points of intersection of science and culture, immersive environments, media arts and the creative economy, nanotechnology, and wearable and soft technologies.', 'Bournemouth University, Talbot Campus, BH12 5BB', 'Director, SCAN', '', '0000-00-00 00:00:00', '', 0, '', 'http://www.scansite.org', '', '', '', '', 'n'),
(24, 'felipe.norkus@gmail.com', 'fanta1987', 'Felipe', 'Norkus', '', 'Felipe Norkus has been working as an artists, designer and programmer in Rio de Janeiro, Brazil since 2005. He has worked with companies such as  TÃ¡til Design on aspects of sustainable design,  Redley, Rio based fashion brand, on visual prints of their collection, and branding campaigns for magazines such as Rolling Stones, MAG, Vogue and many others. Heâ€™s latestâ€™s work has involved experimental musical improvisation that uses patches and instruments programmed in Pure Data, as well as the utilization of objects that can interact with the software such as midi controllers, Arduino, sensors, LED\\''s, digital cameras and electronic circuits.', 'Rio de Janeiro, Brasil', '', '', '0000-00-00 00:00:00', '', 0, '', 'www.felipenorkus.com', '', '', '', '', 'n'),
(25, 'mail@timknowles.com', 'coostalot', 'Tim', 'Knowles', '', '', 'London', 'Artist', '', '0000-00-00 00:00:00', '', 0, 'Windwalk - Five walks from Charing Cross', 'http://www.timknowles.co.uk/Work/Windwalks/CharingCross/tabid/502/Default.aspx', 'Grass & Bottle Windvanes\r\n@ Mobile research station', 'http://www.simonfaithfull.org/MobileResearch1/blog/category/timknowles', 'Windbarbs 2009\r\nA series of ten white flags installed on Plymouth Hoe.  Each flag carries simple black meteorological symbols, called windbarbs, which are used to indicate wind speeds. The flags appear similar, but are constructed of different fabrics, of different weight so that they fully fly at the wind speeds equal to or greater than that indicated on the flag.\r\n\r\n\r\nThis artwork is a celebration of the wind, acting as a cross between an art installation and meteorological device communicating wind speed and direction. Wind Barbs follows on from a number of works by Tim Knowles, which utilise, explore and reveal the wind, its behaviour and effect.', 'http://www.timknowles.co.uk/Work/Windbarbs/tabid/509/Default.aspx', 'n'),
(26, 'vivacqua@gmail.com', 'fassbinder', 'Paulo', 'Vivacqua', '', '', 'Rio de Janeiro, Brasil', 'artist', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(27, 'cadu.costa@oi.com.br', 'coos', 'Cadu', 'Costa', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(28, 'eduardoberliner@hotmail.com', 'eduardo', 'eduardo', 'berliner', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(35, 'cadu.costa@oi.com.br', 'cavalo', 'cadu', 'costa', '', 'Artist Cadu lives and works in Rio de Janeiro. Some of his recent collective exhibitions are â€œ7a Mercosul Biennaleâ€ (Porto Alegre â€“ Brazil), â€œAfter Utopiaâ€ (Istituto Internazionale Di Studi Sul Futurismo. Prato â€“ Italy), â€œEstrategiaâ€ (Plymouth Arts Centre. Plymouth â€“ UK), â€œNova Arte Novaâ€ (Centro Cultural Banco do Brasil. Rio / SÃ£o Paulo/ Brazil). Solo exhibitions: â€œProcesos y Procedimientosâ€ (Galeria D21. Santiago â€“ Chile), â€œAvalancheâ€ (Galeria Vermelho â€“ SÃ£o Paulo) â€œPlymouth - Barbicanâ€ (Laura Marsiaj Arte ContemporÃ¢nea â€“ Rio) <br /><br />In-between intellect and sensitivity, project and result, the rule and its application, the artist conceives and accomplishes his work. Conversely as to a confessional subjectivism prevailing in contemporary artistic output, the artist creates each work from an explicit rule, like in a game, whose results are always visual. He subsequently applies it, as he has been his one and only player. His poetics is characterized by the subordination of the plastic action to the idea (or concept), therefore by the belief that, in respect to his work, creation should take place at the limit lying between the ideation of the rules and the facture â€“ not in the pure and simple making of it.<br /><br />From this viewpoint, and referring to a remote genealogy, Caduâ€™s artistic investigation might be traced back to Leonardo da Vinciâ€™s assertion that painting is but mental stuff. Nonetheless, the closest historic antecedent to his artistic action is that search towards the dematerialization of the artwork carried out by conceptual artists in various countries around the late 60s and early 70s of the last century. The motto â€œart as an idea, as an idea, as an ideaâ€ coined by Joseph Kosuth â€“ a major artist of his trend â€“ aptly condenses this historic project. <br /><br /><br /><br />', '', 'artist', '', '0000-00-00 00:00:00', '', 0, 'Avalanche', 'www.galeriavermelho.com', '', '', '', '', 'n'),
(30, 'alex@mutantlabs.co.uk', 'coos_riz', 'alex', 'ryley', 'I am a graduate from Digital Art and Technology course at Plymouth University, and Managing Director of Mutant Labs Ltd. We specialise in  iPhone apps, web and Flash development.', '', 'Plymouth, UK', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(31, 'ben@mutantlabs.co.uk', 'remember', 'Ben', 'Reynhart', '', '', 'Plymouth', 'Creative Director', '', '0000-00-00 00:00:00', '', 0, '', '', '', 'http://reynhart.com', '', '', 'n'),
(32, 'david@ammeba.org', 'melanio', 'DAVID', 'PASTOR', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(33, 'Athens, Greece & Amsterdam, Netherlands', '131313', 'Ash', 'Bulayev', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(36, 'eduardoberliner@hotmail.com', 'eduardo', 'eduardo ', 'berliner', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(37, 'akio@galeriavermelho.com.br', 'akio0404', 'Akio', 'Aoki', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(38, 'mike.phillips.net@googlemail.com', 'TROUTY', 'Kilgore', 'Trout', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(39, 'b@submerge.org.uk', 'splutt', 'Cathrine', 'Reith', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(40, 'baga@plymouth.ac.uk', '', 'B', '', '', '', '', '', 'r', '0000-00-00 00:00:00', '53b6e4f52b7a8abd93767614fd0c0e32', 39, '', '', '', '', '', '', 'n'),
(41, 'Nema.El-Nahas@artscouncil.org.uk', '', 'Nema', 'El-Nahas', '', '', '', '', 'r', '0000-00-00 00:00:00', '31a8771f63222486f4dd20e3dba3943d', 3, '', '', '', '', '', '', 'n'),
(42, 'b@submerge.org.uk', '', 'B', 'Aga', '', '', '', '', 'r', '0000-00-00 00:00:00', '4a0da8c3e58fb79a8c108fa2329cc914', 3, '', '', '', '', '', '', 'n'),
(43, 'eduardoberliner@hotmail.com', 'eduardo', 'eduardo ', 'berliner', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(44, 'ian@plymouthartscentre.org', 'Butt3rfly', 'Ian ', 'Hutchinson', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(45, 'pablo@ammeba.org', 'melanio', 'pablo', 'berzal', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(46, 'info@scansite.org', 'Drudgery', 'David ', 'Jones', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(47, 'helen@scansite.org', 'Scanning2', 'Helen ', 'Sloan', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(48, 'david@davidgl.com', 'master', 'David', 'Garzon', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(49, 'ojoana@gmail.com', 'babela', 'Joana', 'Oliveira', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(50, 'miryo2125@naver.com', 'vnice8', 'oh', 'min taek', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(51, 'carolyn@carolyn-black.co.uk', 'fore8t', 'carolyn', 'black', 'Hailing from a background as an arts practitioner, since 2000 I have initiated and delivered numerous public art works â€“ ranging from scattered-site urban international exhibitions to singular sculptures in a rural context. I have substantial experience of fundraising, networking, marketing and of course working with artists on the ground. I see myself as a producer rather than a curator and my public art project management work benefits from my experience of being both an artist and commissioner. Should you require references, I will gladly provide contact details for artists I have worked with, partners I have worked alongside, and organisations I have worked for.', '', 'UK', 'artist, writer and producer', '', '0000-00-00 00:00:00', '', 0, 'Projects Director for Forest of dean Sculpture Trust', 'www.forestofdean-sculpture.org.uk', 'coordinator for Luke Jerram Project Aeolus', 'www.aeolus.org.uk', 'my website\r\n', 'www.carolyn-black.co.uk', 'n'),
(52, 'andrew.prior@plymouth.ac.uk', 'deborah', 'Andrew ', 'Prior', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(53, 'jacqueline.turner@plymouth.ac.uk', 'collaborate', 'jacqueline', 'turner', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(104, 'marisam@ugr.es', 'wuapito', 'marisa', 'mancilla', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(55, 'david_g_johns@hotmail.com', 'coos9902247', 'David', 'Woodbridge-Johns', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(56, 'faz-tv@hotmail.com', 'instigator', 'PAUL', 'LITTLER', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(57, 'hmjones99@hotmail.com', 'cabbana1', 'Hannah', 'Jones', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(58, 'berno.odo.polzer@gmail.com', 'co-osbop', 'Berno Odo', 'Polzer', 'Berno Odo Polzer is a freelance curator and dramaturge in the fields of contemporary music and performance. Studies in archaeology, musicology, philosophy and German literature. He lives in Vienna and Brussels and works internationally.', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(59, 'm@michaelgaio.com', '142857coo', 'Michael', 'Gaio', 'I\\''m an evolutionary social entrepreneur, interaction designer, experience designer, information architect, ontological engineer, philosopher, archetypal cosmologist, noospheric researcher, inventor, hacker, and multimedia artist.<br /><br />PURPOSE: to inform, involve, and inspire evolution in culture, communications, and consciousness.<br /><br />MISSION: to design, develop, and innovative projects for collective intelligence and social evolution.<br /><br />FOCUS: Experience Design, Interaction Design, User Interface Design, Information Architecture, Game Design, Semantic Web, Ontological Engineering, Cognitive Science, Collective Intelligence, Virtual Spaces, Semiotics, Trans-Symbolic Communication Systems, Bio-Engineering, Neuro-Engineering.', 'http://www.michaelgaio.com<br /><br />blog: http://blog.michaelgaio.com', 'California and Hawaii', 'Interaction / experience designer, programmer, inventor', '', '0000-00-00 00:00:00', '', 0, 'Portfolio: over a decade of information design, interaction design and programming (Flash/ActionScript) for the web.  nearly 100% of my projects have been involved with ecological and/or sociological sustainability and advancement initiatives.', 'http://www.michaelgaio.com/portfolio', 'CogSpace is an interactive, multimodal, and collectively formulated 3D visual mind map of Cognitive Science and Consciousness Studies.', 'http://www.cogspace.net', 'MetaTone is a game to exercise memory and train the musical ear using a color-coordinated harmonic hexagonal grid matrix.', 'http://www.jalaka.com/games/metatone/', 'n'),
(60, 'ellie@ellieharrison.com', 'NNNQUU', 'Ellie', 'Harrison', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(61, 'mark@beaford-arts.org.uk', 'rav1l10us', 'Mark', 'Wallace', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(62, 'dreamproject1@hotmail.com', 'bambara2', 'Papantonis', 'Grigorios', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(63, 'sybrig.dokter@tele2.se', 'dancer1', 'Sybrig', 'Dokter', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(64, 'info@fullhousepromotion.gr', 'fullhousepromotion', 'Christina', 'Polychroniadou', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(65, 'stephanie@spacepilots.net', 'olivertwist', 'stephanie', 'brandt', '', 'Stephanie Brandt is a London based architect/artist and teacher working parallel in practice and academia for about 8 years.<br />In 2008 Stephanie founded SPACEPILOTS, a collaborative practice of<br />architecture and art [www.spacepilots.net]. Her individual and collective work with SPACEPILOTS focuses on cross-disciplinary approaches of experience-driven and interaction design and the creative transformation of places through design and engagement strategies.<br /><br />Stephanie has run several design workshops in GB and Spain, and published a number of reviews & articles in international architecture and design magazines & books.<br />She is an active member of The Art and Architecture Association, London; and the multidisciplinary and international research group (INTER)SECCIÃ“N, investigating shifts and notions concerning Space and Spatial Experiences of and in our contemporary cities.<br />[www.interseccion.es/espacio_y_subjetividad.htm]<br />Her design and research projects have been shown at various international events among others at Generative Art International, Exhibition, Milan, Italy; at the 6th International Design & Emotion Conference, The School of Design, Polytechnic University, Hong Kong; at The Market Estate Project, Exhibition, London, GB; at Sensory Urbanism, Exhibition, Glasgow, GB; at eme3, Exhibition as part of the Festival Internacional de Arquitectura, Barcelona, Spain; the International Conference, Ethics and the Professional Culture,<br />Cluj-Napoca, Romania; the International Conference, Architecture and<br />Phenomenology, Technion â€“ Israel Institute of Technology, Israel; in<br />E.R.R.A., UHF05, Spain; and the Conference, Making use of Culture, Cultural Theory Institute, The University of Manchester, GB.', '', '', '', '0000-00-00 00:00:00', '', 0, 'art project - sound installation @ The Market Estate Project, London', 'http://spacepilots.net/projects/naked-voices?pg', 'Curation of Living Landscapes Lecture Series @ The Building Centre, Store Street, London', 'http://spacepilots.net/news/living-landscapes-02-session-1', 'Creative Collaboration: Urban Rituals - art and the public realm', 'http://spacepilots.net/projects/urban-rituals?pg', 'n'),
(66, 'anthrwpos@hotmail.com', 'nikolaos', 'Nikolas', 'Makris', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(67, 'esther@project28.nl', 'test1234', 'esther', 'verhamme', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(68, 'moviesdontgrowontrees@gmail.com', 'parasite', 'Barbara', 'Dukas', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(69, 'kdiapouli@yahoo.gr', '', 'busart', '', '', '', '', '', 'r', '0000-00-00 00:00:00', 'd46dd13db6c71452d3594adfcda33845', 68, '', '', '', '', '', '', 'n'),
(70, 'sparask@otenet.gr', 'N008658', 'stathis', 'Paraskevopoulos', 'Hmmm ... these about you questions a riven with controversy as to whether I can define me...', 'Too little too Late', 'Athens', 'Management', 'r', '0000-00-00 00:00:00', '0c03a5e4c2b5d39d15955397fc76a0bd', 68, 'It all began with the appearance of a strange apparition in the guise of a cat wearing a rather smart red cap... The apparition had asked the simplest of questions ... yet the aura emanated by the typed words had disturbed the reader. A hoax? or a simple request to exchange dark delicacies ... The reader imagined the apparition differently. The butcher was extremely suspicious but the reader wanted to pursue. He expected the apparition to continue the story........', '', '', '', '', '', 'n'),
(71, 'bencollins544@googlemail.com', 'lolpasscoos', 'Ben', 'Collins', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(72, 'cara.jane.d@gmail.com', 'Hello123', 'Cara', 'Davies', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(73, 'euripidestheatre@yahoo.com', 'superlove', 'Euripides', 'Laskaridis', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(74, 'jossiedominique@gmail.com', 'siwelasonke', 'Dominique', 'Jossie', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(75, 'nayse@idanca.net', 'coos03', 'nayse', 'lopez', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(76, 'orrinward@gmail.com', 'ozzajw', 'Orrin', 'Ward', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(77, 'egrandelle@gmail.com', 'r2d2c3p0', 'Eduardo', 'Grandelle', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(78, 'diane.wiltshire@yahoo.co.uk', 'S10sep77', 'Diane', 'Wiltshire', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(79, 'zazpedro@gmail.com', 'killcore888', 'Pedro', 'Zaz', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(80, 'joescarffe@googlemail.com', 'dartington', 'Joe', 'Scarffe', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(81, 'adrianafc@gmail.com', 'dridredro', 'Adriana', 'Contopoulos', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(82, 'katarti@gmail.com', 'roditsa', 'katerina', 'katsifaraki', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(83, 'me@simonfaithfull.org', 'flushflit', 'simon', 'faithfull', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(84, 'nina@immaterial.net', 'M1n1mus', 'Nina', 'Katchadourian', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(85, 'artpill@hotmail.co.uk', 'cranberry', 'Eve', 'Woodbridge', '', '', 'Plymouth', '', '', '0000-00-00 00:00:00', '', 0, '', 'http://www.u1studios.co.uk/', '', '', '', '', 'n'),
(86, 'brunohagen@gmail.com', 'hagenn', 'Bruno', 'Drolshagen', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(87, 'moysessalomao@gmail.com', 'laranjada', 'moyses', 'levy', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(88, 'kammaljamil@gmail.com', 'zabra76883875', 'kammal', 'joÃ£o', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(89, 'guilherme.dable@gmail.com', 'fa5kner', 'Guilherme', 'Dable', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(90, 'beteesteves@globo.com', 'best2009', 'bete', 'esteves', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(91, 'gustard33@gmail.com', 'elfins', 'Augustine', 'Leudar', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(92, 'martha.nino@gmail.com', 'coos_jq45yq', 'Martha', 'Nino', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(96, 'davestrang78@gmail.com', 'biscuits', 'David', 'Strang', '', '', 'Plymouth', '', '', '0000-00-00 00:00:00', '', 0, '', 'www.davidstrang.co.uk', '', '', '', '', 'n'),
(95, 'katarti@gmail.com', 'roditsa', 'katerina', 'katsifaraki', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(97, 'eduardoberliner@hotmail.com', 'eduardo', 'eduardo ', 'berliner', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(98, 'katarti@gmail.com', 'roditsa', 'katerina', 'katsifaraki', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(99, 'joestanphil@gmail.com', '1hemulen2', 'Joe ', 'Phillips', 'joe-phillips.net<br />joephillips.tumblr.com', '', 'London', 'Designer', '', '0000-00-00 00:00:00', '', 0, '', 'superfad.com', '', '', '', '', 'n'),
(100, 'angeles@ammeba.org', '2323', 'angeles', 'mira', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(103, 'annabirch1@mac.com', 'biscuit', 'anna', 'birch', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(102, 'jeromecronin@hotmail.com', 'fuckoff', 'Jerome', 'Cronin', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(105, 'andreithomaz@gmail.com', 'mondrian51', 'Andrei', 'Thomaz', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(106, 'aceplymouth@hotmail.com', 'chess123', 'Aaron', 'Crowe', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(107, 'otavio.schipper@gmail.com', 'pericles', 'otavio', 'schipper', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(108, 'almirezlorelei@gmail.com', 'coospassword', 'Lorelei', 'Almirez', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(109, 'marisam@ugr.es', 'wuapito', 'marisa', 'mancilla', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(110, 'shimarts@gmail.com', 'bgt555???', 'Marcio', 'Shimabukuro', 'Object â€œOâ€ assumes the meaning â€œmâ€ in time â€œtâ€, place â€œpâ€, situation â€œsâ€ in relation to person/persons â€œxâ€ then and only then.<br />â€” Jan Swidzinski (1923 â€“ )<br /><br /><br />Since 2005, daily life and performance art are the main source of my research and art pieces. In my work I deconstruct ordinary quotidian practice to analyse patterns and traditional schemes of doing things. The performance art platform (time x space x action x context) is a powerful tool for me to think the process and the final result, which can be installations, objects, video, photography and also performance pieces. I like to create unusual ways to see the commom things, combining different disciplines and playing with itâ€™s similarities, differences, contrasts and harmony, to purpose new lenses to see/feel/think reality.<br /><br />Recurring themes<br />Â· factors of identity and belonging<br />Â· imagery of contemporary daily life<br />Â· (how) to be in the world<br />Â· permanent state of crisis', '', 'Sao Paulo, Currently in Europe', 'Visual Artist', '', '0000-00-00 00:00:00', '', 0, '', 'http://www.shima.art.br', '', '', '', '', 'n'),
(111, 'amytuesday@hotmail.com', 'tuesday', 'Amy', 'Burns', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(112, 'lnutbean@hotmail.co.uk', 'augmented', 'lee', 'nutbean', 'As a digital artist I build coherent interactive systems with open source design, to create responsive mediated spaces in art and architecture. These systems reside on the transdisciplinary intersections between emerging digital media and nanochemistry, environmental science, biotechnology, performance and art.  My skills include the design of both the physical spaces and the software/hardware that make the systems aware.', '', 'Plymouth - England', 'interactive arts', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(113, 'rgibbons@plymouthart.ac.uk', 'sunshine', 'Becky', 'Gibbons', '', '', 'Plymouth, England', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'n'),
(114, 'chris@boxel.co.uk', 'qwerty', 'chris', 'saunders-2', '', '', '', '', '', '0000-00-00 00:00:00', '', 0, '', '', '', '', '', '', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `personSkills`
--

CREATE TABLE IF NOT EXISTS `personSkills` (
  `personID` int(11) NOT NULL,
  `skillID` int(11) NOT NULL,
  `level` enum('b','i','a') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personSkills`
--

INSERT INTO `personSkills` (`personID`, `skillID`, `level`) VALUES
(5, 5, 'b'),
(2, 57, 'i'),
(6, 2, 'b'),
(5, 2, 'a'),
(5, 1, 'i'),
(2, 61, 'a'),
(21, 84, 'a'),
(5, 4, 'b'),
(5, 3, 'b'),
(5, 1, 'a'),
(5, 6, 'a'),
(2, 59, 'i'),
(5, 1, 'b'),
(2, 6, 'b'),
(2, 2, 'i'),
(20, 77, 'a'),
(2, 68, 'b'),
(21, 83, 'a'),
(2, 64, 'i'),
(20, 78, 'a'),
(2, 1, 'i'),
(4, 44, 'a'),
(11, 7, 'a'),
(2, 80, 'i'),
(12, 65, 'a'),
(2, 4, 'i'),
(20, 79, 'a'),
(14, 67, 'a'),
(2, 62, 'i'),
(3, 81, 'a'),
(14, 69, ''),
(3, 72, 'a'),
(13, 64, 'a'),
(15, 71, 'b'),
(3, 82, 'i'),
(17, 15, 'a'),
(21, 85, 'a'),
(21, 86, 'a'),
(21, 87, 'a'),
(21, 88, 'a'),
(23, 81, 'a'),
(23, 72, 'a'),
(18, 81, 'i'),
(18, 65, 'i'),
(18, 21, 'b'),
(18, 18, 'i'),
(18, 75, 'i'),
(24, 65, 'b'),
(24, 92, 'b'),
(24, 70, 'i'),
(24, 15, 'i'),
(30, 2, 'a'),
(30, 74, 'a'),
(31, 93, 'a'),
(31, 74, 'a'),
(25, 0, 'i'),
(25, 32, 'a'),
(25, 94, 'a'),
(25, 95, 'a'),
(25, 96, 'i'),
(26, 15, 'a'),
(11, 81, 'a'),
(11, 97, 'a'),
(35, 65, 'i'),
(35, 71, 'i'),
(35, 70, 'i'),
(24, 62, 'b'),
(25, 81, 'i'),
(25, 106, 'a'),
(51, 72, 'a'),
(51, 104, 'b'),
(51, 99, 'b'),
(51, 103, 'a'),
(51, 95, 'b'),
(59, 124, 'i'),
(59, 61, 'i'),
(59, 115, 'a'),
(59, 74, 'a'),
(59, 15, 'i'),
(59, 100, 'i'),
(59, 93, 'a'),
(59, 62, 'b'),
(59, 106, 'a'),
(59, 112, 'a'),
(59, 84, 'i'),
(59, 65, 'a'),
(59, 86, 'b'),
(70, 72, 'i'),
(84, 0, 'b'),
(85, 99, 'a'),
(96, 15, 'a'),
(96, 118, 'i'),
(96, 61, 'i'),
(96, 92, 'a'),
(96, 124, 'b'),
(96, 59, 'a'),
(96, 99, 'i'),
(96, 62, 'i'),
(96, 125, 'a'),
(99, 126, 'i'),
(99, 127, 'i'),
(110, 129, 'i'),
(110, 99, 'b'),
(110, 127, 'a'),
(110, 128, 'i'),
(112, 93, 'a'),
(112, 62, 'a'),
(112, 65, 'a'),
(113, 118, 'b'),
(113, 88, 'i'),
(113, 99, 'i'),
(2, 63, 'i');

-- --------------------------------------------------------

--
-- Table structure for table `progress`
--

CREATE TABLE IF NOT EXISTS `progress` (
  `thingID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `worker` enum('n','i','c','f','cc') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `progress`
--

INSERT INTO `progress` (`thingID`, `personID`, `worker`) VALUES
(2, 114, 'cc');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `personID` int(11) NOT NULL,
  `raterID` int(11) NOT NULL,
  `jobID` int(11) NOT NULL,
  `rating` float NOT NULL,
  `comment` mediumtext NOT NULL,
  `dateAdded` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`personID`, `raterID`, `jobID`, `rating`, `comment`, `dateAdded`) VALUES
(114, 2, 2, 3, 'liked his work', '2010-08-16');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE IF NOT EXISTS `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=73 ;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`id`, `resource`) VALUES
(1, 'Office space'),
(2, 'Web server space'),
(6, ' napkins'),
(5, 'dips'),
(11, 'editing suite'),
(8, 'camera'),
(10, 'dark room'),
(16, 'House'),
(17, ' lanterns'),
(18, 'table'),
(19, ' chairs'),
(22, 'Dome'),
(23, ' Cameras'),
(40, 'Studio'),
(32, 'nomore'),
(36, 'mask'),
(48, 'soldering iron'),
(49, 'mobile phones'),
(51, 'studio space'),
(52, 'Weather stations'),
(53, 'Trees'),
(61, 'new resource 1'),
(72, 'new resource 3'),
(71, 'new resource 4'),
(70, 'new resource 2');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE IF NOT EXISTS `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=131 ;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `skill`) VALUES
(1, 'Web design'),
(2, 'PHP'),
(4, 'Premier'),
(5, 'After Effects'),
(6, 'Final Cut'),
(7, 'Project management'),
(15, 'sound'),
(18, 'general admin'),
(101, 'Hardware Engineer'),
(21, 'food in general'),
(102, 'Meteorological Adviser'),
(99, 'Artist'),
(32, 'camera'),
(61, 'Processing'),
(59, 'Max/MSP'),
(57, 'soldering'),
(62, 'Arduino'),
(63, 'Wiring'),
(64, 'Mobile Processing'),
(65, 'ideas'),
(100, 'Software Engineer'),
(67, 'dogs'),
(68, 'Bid writitng'),
(69, 'freed'),
(70, 'Print design'),
(71, 'Professor'),
(72, 'Project Management'),
(103, 'Fundraising'),
(74, 'Web design'),
(75, 'production'),
(77, 'Webdesign'),
(78, 'Java'),
(79, 'Electronics'),
(80, 'Linux'),
(81, 'Curation'),
(82, 'Design print'),
(83, 'Coding'),
(84, 'Domes'),
(85, 'Urban media'),
(86, 'Mobile Applications'),
(87, 'Social systems'),
(88, 'Social networks'),
(130, 'Dreaming'),
(98, 'Iconografy expert'),
(92, 'Pure Data'),
(93, 'Actionscript Coding'),
(94, 'Wind'),
(95, 'Trees'),
(96, 'GPS'),
(97, 'Independent Director/Choreographer'),
(104, 'Critical writing & editorial'),
(105, 'PR, publicity & press'),
(106, 'Artist'),
(107, 'new skill 1'),
(108, 'new skill 2'),
(109, 'new skill 4'),
(110, 'n'),
(111, 'new skill 3'),
(112, 'Concept Development'),
(113, 'Writer'),
(114, 'writer'),
(115, 'Writer'),
(116, 'Historian of iconography'),
(117, 'Architect'),
(118, 'Video editing'),
(119, 'Historian of iconography'),
(120, 'Historian of iconography'),
(121, 'Historian of iconography'),
(122, 'Historian of iconography'),
(123, 'Processing (Java)'),
(124, 'openFrameworks (C++)'),
(125, 'make controller'),
(126, 'Animation'),
(127, 'Graphic Design'),
(128, 'Photographer'),
(129, 'Barman');

-- --------------------------------------------------------

--
-- Table structure for table `thing`
--

CREATE TABLE IF NOT EXISTS `thing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `blurb` mediumtext NOT NULL,
  `flag` enum('b','i','j','c','r','p','s','d','v','w') NOT NULL,
  `winBid` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `thing`
--

INSERT INTO `thing` (`id`, `personID`, `title`, `blurb`, `flag`, `winBid`) VALUES
(1, 2, 'remove the date deadline from ideas', 'this will allow ideas to be voted on forever and also let the poster to re-evaluate over time', 'i', '0'),
(2, 2, 'user generated date', 'allow the poster of a collaboration to decide on their own end date', 'c', 'a:1:{i:0;s:1:"1";}'),
(3, 2, 'goal line technology', 'camera, gpd, electro-magnetic force fields, extra linesmen.....i mean assistant referees ', 'j', '0'),
(4, 2, 'my test idea', 'no pitch for this', 'i', '0'),
(5, 2, 'zzzzzzz', 'another test idea', 'i', '0'),
(6, 2, 'test job', 'its only a test', 'j', '0'),
(7, 3, 'testing', 'test', 'j', '0'),
(8, 15, 'co-os redev', 'simplification process...', 'i', '0');

-- --------------------------------------------------------

--
-- Table structure for table `vote`
--

CREATE TABLE IF NOT EXISTS `vote` (
  `ideaID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `yorn` enum('y','n','s') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vote`
--

INSERT INTO `vote` (`ideaID`, `personID`, `yorn`) VALUES
(8, 2, 'y'),
(8, 15, 'y'),
(4, 3, 's'),
(1, 2, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `wiki`
--

CREATE TABLE IF NOT EXISTS `wiki` (
  `pagename` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `flags` int(11) NOT NULL DEFAULT '0',
  `author` varchar(100) DEFAULT NULL,
  `lastmodified` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `content` mediumtext NOT NULL,
  `refs` text,
  PRIMARY KEY (`pagename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiki`
--

INSERT INTO `wiki` (`pagename`, `version`, `flags`, `author`, `lastmodified`, `created`, `content`, `refs`) VALUES
('AddingPages', 1, 0, 'The PhpWiki programming team', 981656911, 981656911, 'To add a new page to Wiki, all you have to do is come up with a meaningful title, capitalize all the words and StringThemTogetherLikeThis. Wiki automagically recognizes it as a hyperlink. Alternatively, you can put\nanything into [square brackets].\n\nThen you can go ahead and ClickTheQuestionMark at the end of your new hyperlink, and the Wiki will give you a window for making the new page.\n\nIf you wish to add documents with complex markup to the Wiki, you might be better off providing a URL to it than trying to add the text of the document here, like so:\n\n PhpWiki project homepage: http://phpwiki.sourceforge.net/\n\nThe Wiki does not support HTML tags (see TextFormattingRules).  <tags>They will just render like text.</tags> Wiki is meant to be as simple as possible to encourage use.\n\nNote that there is a feature that your system administrator can enable to allow embedded HTML, but there are security risks involved.', 'a:0:{}'),
('ConvertSpacesToTabs', 1, 0, 'The PhpWiki programming team', 981084185, 981084185, 'You don''t need to use tabs anymore in PhpWiki. Consider this page obsolete. See TextFormattingRules for how to use PhpWiki markup.\n\n----\n\nVariousBrowsers have trouble with the tab character used in the TextFormattingRules.  If you can''t type a tab, or, if you are fixing up a page written by someone who didn''t type tabs, then you should have us convert spans of spaces to tabs for you.  You request space to tab conversion with the checkbox that appears near the bottom of EditText and EditCopy pages.  It looks something like this...\n\n [[o] I can''t type tabs.  Please ConvertSpacesToTabs for me when I save.\n\nA span of spaces must be at least __three__ spaces long to be recognized\nas a tab.  Use multiples of __eight__ spaces to make multiple tabs.\nEach span of eight spaces will convert to one tab.  If the\nlast span comes up a little short, that''s ok, as long as\nthere are at least three spaces in the last (only) span.\n\n__Check your work.__  This sort of heuristic can lead to unexpected results.\n-----\n[Maintenance note:  This page is seen when the user clicks on the\n"ConvertSpacesToTabs" link on any edit screen.  It describes what happens\nwhen you ask the system to do this, why you would want it to, and ways to\navoid the spaces-instead-of-tabs problem.]', 'a:0:{}'),
('EditText', 1, 0, 'The PhpWiki programming team', 959961544, 959961544, 'All pages (except search results) have an EditText link at the bottom. You can edit the page you are reading by clicking that link.', 'a:0:{}'),
('FindPage', 1, 0, 'The PhpWiki programming team', 974555435, 974555435, 'Here are some good starting points for browsing.\n\n* HowToUseWiki gives you the quick lowdown on Wiki markup.\n* RecentChanges recorded automatically\n* MoreAboutMechanics of browsing and editing on this server\n\nHere''s a title search.   Try something like ''''wiki''''\nor ''''sandwich''''.\n\n%%Search%%\n\nUse the following for a full text search. This takes a few seconds. The results will show all lines on a given page that contain a match.\n\n%%Fullsearch%%\n\n------\nSeparate words with a space. All words have to match.\n%%%To exclude words prepend a ''-''.\n%%%Example: ''wiki text -php'' looks for all pages containing the words ''wiki''\n__and__ ''text'', but __not__ containing the word ''php''.', 'a:0:{}'),
('FrontPage', 3, 0, '141.163.187.69', 1240324771, 1000702928, '* What is a WikiWikiWeb? A description of this application.\n* Learn HowToUseWiki and learn about AddingPages.\n* Use the SandBox page to experiment with Wiki pages.\n* Please sign your name in RecentVisitors.\n* See RecentChanges for the latest page additions and changes.\n* Find out which pages are MostPopular.\n* Read the ReleaseNotes\n* Administer this Wiki in PhpWikiAdministration.', 'a:0:{}'),
('GoodStyle', 1, 0, 'The PhpWiki programming team', 959961544, 959961544, '"Young writers often suppose that style is a garnish for the meat of\nprose, a sauce by which a dull dish is made palatable. Style has no such\nseparate entity; it is nondetachable, unfilterable. The beginner should\napproach style warily, realizing that it is himself he is approaching, no\nother; and he should begin by turning resolutely away from all devices\nthat are popularly believed to indicate style--all mannerisms, tricks,\nadornments. The approach to style is by way of plainness, simplicity,\norderliness, sincerity."\n\n--Strunk and White, "The Elements of Style"\n\n''''And thus an American textbook, typical required reading for 10th-grade English students, unknowingly extols some virtues of WabiSabi''''\n--scummings', 'a:0:{}'),
('HowToUseWiki', 1, 0, 'The PhpWiki programming team', 981656911, 981656911, '''''"Wiki wiki"'''' means "quick" in Hawai''ian.\n\n__All you really need to know is:__\n\n* To edit any page click on the Edit Text link at the bottom of the page. You should do that right now, and read the source code of this page. It will make more sense.\n* You get italics by surrounding words with two single quotes on either side ''''like this''''.\n* You get __bold text__ by using two underscores on either side.\n* And, __''''bold italics''''__ by using both.\n* You get bullets by using an asterisk * at the start of the line\n* To have plain monospaced font, indent with a space:\n\n this is a poem\n about monospacing\n nothing rhymes with poem\n nothing rhymes with monospacing\n\n* You can separate paragraphs with an extra blank line. Example:\n\nI am a paragraph.\n\nI am a paragraph too. We''re just very small paragraphs.\n\n\n* You can get horizontal rules with four or more dashes like this:\n---------\n* To create hyperlinks you just capitalize the words and string them together. Let''s say you want to create a page about how Steve Wainstead eats worms. All you have to do is capitalize each word and string them together like this: SteveWainsteadEatsWorms. If the page does not exist yet a question mark appears after the link, inviting you to create the page: ThisPageShouldNotExist. (And please don''t ruin the example by creating one.)\n* To link to pages outside the Wiki, you can just type in the URL and Wiki will link it for you: http://www.nytimes.com/\n* To put images in, just provide the hyperlink in brackets like this: [[http://www.yourhost.yourdomain/images/picture.png]. Image URLs not in brackets will just appear as hyperlinks to the image.\n* Now you are ready to begin AddingPages.\n\n----\nA WikiWikiWeb is meant to be fast and easy to edit. It has very simple markup that you can read about in TextFormattingRules.', 'a:0:{}'),
('MoreAboutMechanics', 1, 0, 'The PhpWiki programming team', 973527283, 973527283, 'PhpWiki is written in the server-side scripting language PHP, available from http://www.php.net/. PHP resembles C and Perl in its syntax, and functions much like ASP, EmbPerl or JSP.\n\nPhpWiki consists of a dozen or so files of mixed PHP and HTML. The web pages that make up a WikiWikiWeb based on PHP live in a DBM file with backup copies of previous versions of pages stored in a second DBM file.\n\nEvery time a user hits the site the page requested is pulled from the DBM and rendered on the fly. The user only ever requests the file index.php, which then decides which other php files to include.\n\nLinks to pages in the wiki are automatically linked: PhpWiki. This might be the single most compelling aspect of a wiki, the ability to add pages simply by linking to them. The next most compelling thing is how easily external URL''s link:\n# http://www.wcsb.org/\n# ftp://ftp.redhat.com/\n# news://news.mozilla.org/\n\nCombined with one namespace and a simple markup, a Wiki exhibits many of the characteristics of WabiSabi.\n\nPhpWiki is licensed under the Gnu General Public license, which you should be able to see here: http://www.gnu.org/copyleft/gpl.txt.', 'a:0:{}'),
('MostPopular', 1, 0, 'The PhpWiki programming team', 962054805, 962054805, 'The 20 most popular pages of this wiki:\n(hitcount, pagename)\n\n%%Mostpopular%%', 'a:0:{}'),
('PhpWiki', 1, 0, 'The PhpWiki programming team', 972447226, 972447226, 'You are using PhpWiki at this very moment. Incredible, ain''t it?\n\nVisit our home page at http://phpwiki.sourceforge.net/ and see PhpWiki\nin action at http://phpwiki.sourceforge.net/phpwiki/.', 'a:0:{}'),
('PhpWikiAdministration', 1, 0, 'The PhpWiki programming team', 998845913, 998845913, '!!! This works only if you are logged in as ADMIN.\nGo to !http://yourhost.yourdomain/yourwikidir/admin.php.\n\n-----------\n\n! ZIP files of database\n\n __[ZIP Snapshot | phpwiki:?zip=snapshot]__ : contains only the latest versions\n\n __[ZIP Dump | phpwiki:?zip=all]__ : contains all archived versions\n\nThese links lead to zip files, generated on the fly, which contain the most\nrecent versions of all pages in the PhpWiki. The pages are stored, one per\nfile, as MIME (RFC2045) e-mail (RFC822) messages, with the content type\napplication/x-phpwiki for the snapshot and content type multipart/mixed for\nthe dump. In the latter case, there is one subpart (with type\napplication/x-phpwiki) for each version of the\npage (in chronological order). The message body contains the page text,\nwhile the page meta-data is included as parameters in the\nContent-Type: header field.\n\n-----------\n\n! Load / Dump Serialized Pages\n\nHere you can load or dump pages of your Wiki into a directory of your\nchoice.\n\n__Dump__\n\n%%ADMIN-INPUT-dumpserial-Dump_serialized_pages%%\n\nPages will be written out as "serialized" strings of a PHP\nassociative array, meaning they will not be human readable. If\nthe directory does not exist PhpWiki will try to create one for you.\nEnsure that your server has write permissions to the directory!\n\n__Load__\n\n%%ADMIN-INPUT-loadserial-Load_serialized_pages%%\n\nIf you have dumped a set of pages from PhpWiki, you can reload them here.\nNote that pages in your database will be overwritten; thus, if you dumped\nyour FrontPage when you load it from this form it will overwrite the one\nin your database now. If you want to be selective just delete\nthe pages from the directory you don''t want to load.\n\n-----------', 'a:0:{}'),
('RecentChanges', 1, 0, 'The PhpWiki programming team', 1240324752, 998844268, 'The most recently changed pages are listed below.\n\n____April 21, 2009\r\n* [FrontPage] ([diff|phpwiki:?diff=FrontPage]) ..... 141.163.187.69\r\n\r\n____Day one (first day for this Wiki)\n* [AddingPages]\n* [ConvertSpacesToTabs]\n* [EditText]\n* [FindPage]\n* [GoodStyle]\n* [HowToUseWiki]\n* [MoreAboutMechanics]\n* [MostPopular]\n* [PhpWiki]\n* [PhpWikiAdministration]\n* [RecentChanges]\n* [RecentVisitors]\n* [ReleaseNotes]\n* [SandBox]\n* [SteveWainstead]\n* [TestPage]\n* [TextFormattingRules]\n* [WabiSabi]\n* [WikiWikiWeb]\n\nQuick title search:\n%%Search%%\n----', 'a:0:{}'),
('RecentVisitors', 1, 0, 'The PhpWiki programming team', 1101664150, 1101664150, 'Sign and date your name below!\n\nArno Hollosi, Aredridel Stauck, Jeff Dairiki, Steve Wainstead, Reini Urban, the PhpWiki authors.', 'a:0:{}'),
('ReleaseNotes', 1, 0, 'The PhpWiki programming team', 1205789210, 1205789210, 'PhpWiki 1.2.11:\n* support remove for $WhichDatabase = file\n* date => strftime by Pavel Zaichenko\n* localizable pcre_fix_posix_classes by Pavel Zaichenko,\n  make A & I word-begin english specific\n* added russian locale by Pavel Zaichenko\n* added chinese locale by ShiningRay\n\nPhpWiki 1.2.10:\n* support php5 with register_long_arrays = off\n\nPhpWiki 1.2.9 bugfix:\n* Jose Vina fixed MostPopular sorting for dba and dbm,\n  which was broken since 1.2.3\n\nPhpWiki 1.2.8 register_globals=off fix:\n* fix and centralize broken register_globals=off logic.\n* update message catalog\n* replace mysql_pconnect by mysql_connect\n\nPhpWiki 1.2.7 backport cvs release-1_2-branch enhancements never\nreleased with 1.2.4-1.2.6:\n* full xhtml conformity\n* split_pagename in title and header to help google\n* "INSTALL.Mac OS X" added from cvs\n* lib/zipfile.php: Content-Disposition: attachment\n* lib/config.php, lib/stdlib.php: support new USE_LINK_ICONS and AUTOSPLIT_WIKIWORDS, better i18n $!WikiNameRegexp\n* re-added images/* LINK_ICONS, pre-calculate DATA_PATH\n* locale/*: fix and update strings and templates esp. for german,\n* index.php: urlparser extended to omit &start_debug=1 and other args\n* added minor_edit checkbox\n* print more meta tags: robots, favicon, language and PHPWIKI_VERSION\n\nPhpWiki 1.2.6 flatfile fixes and enhancement:\n* fixed !TitleSearch and Backlinks for flatfile.\n* enable MostPopular (hitcount storage) for flatfile\n\nPhpWiki 1.2.5 supports now register_globals=off,\n* adds user/password to pgsql,\n* fix zip and dumpserial on dba, dbm, msql and file,\n* and fixes a minor (un)lock issue, displaying the (un)locked page afterwards and not the FrontPage.\n\nPhpWiki 1.2.4 improves possible deadlocks in DBA,\n* and fixes problems with DBA open failures.\n\nPhpWiki 1.2.3 just adds the RELATEDPAGES footer support to dba,\n* adds remove to dba,\n* and fixes one minor aesthetic error on info w/o "Show the page source"\n\n--[ReiniUrban|http://phpwiki.org/ReiniUrban]\n\nPhpWiki 1.2 is a huge advance over version 1.0:\n\n* Database support for MySQL, Postgresql, mSQL, flat file and the new dba_ library in PHP4 is included.\n* Internationalization: support for different languages, down to the source level, is included. German, Spanish, Swedish and Dutch are currently shipped with PhpWiki. An architecture is in place to easily add more languages.\n* New linking schemes using square brackets in addition to the old style !BumpyText.\n* Administration features include page locking, dumping the Wiki to a zip file, and deleting pages.\n* A MostPopular page showing the most frequently hit pages.\n* Full HTML compliance.\n* Links at the bottom of pages describing relationships like incoming links from other pages and their hits, outgoing and their hits, and the most popular nearby pages.\n* Color page diffs between the current and previous version.\n* An info page to view page metadata.\n* Far more customization capability for the admin.\n* A templating system to separate the page HTML from the PHP code.\n* New markup constructs for <B>, <I>, <DD>, <BR> and more.\n* Tabless markup to supercede the older markup (both still supported).\n\n\n----\n\nPhpWiki 1.1.9 includes Spanish language pages, a full implementation for\nPostgresql, numerous bug fixes and more. See the HISTORY file for more\ninfo: http://phpwiki.sourceforge.net/phpwiki/HISTORY\n\n----\n\nPhpWiki 1.1.6 is a major revision of PhpWiki. The ability to have themes (via an\neasy-to-edit template system) has been added; the schema for MySQL has been\ncompletely overhauled, breaking the page details into columns (for efficiency we\nagreed not to put references in a separate table, so it''s not completely\nnormalized. "Don''t let the best be the enemy of the good.")\n\nPostgresql support has been added and the markup language is evolving, now allowing\n!!!<h1>\n!!<h2>\n!<h3>\ntags and __a new way to make text bold__, and of course the\n[new linking scheme].\n\nThere is a new feature on all pages called ''''more info'''' that gives you a low level\ndetailed view of a page, which is probably more useful for debugging than anything.\n\nAs we move towards a 1.2 release we will be adding logging, top ten most active\npages and other new features with the new database schema (and yes, these features\nwill make it into the DBM version too). I also want to add mSQL support and test it\nunder Zend, the new PHP4.\n\nBelow are the release notes for version 1.03, the last release of the 1.0 PhpWiki\nseries. --Steve Wainstead, mailto:swain@panix.com\n\n----\n\nPhpWiki was written because I am so interested in WikiWikiWebs, and I haven''t used PHP since version 2.0. I wanted to see how it had advanced.\n\nVersion 1.0 is a near-perfect clone of the Portland Pattern Repository, http://c2.com/cgi-bin/wiki?WikiWikiWeb. In truth, I was using the Wiki script you can download from there as a model; that Wiki lacks a number of features the PPR has, like EditCopy. So in truth PhpWiki is a kind of hybrid of the PPR and the generic Wiki you can get from there (which is written in Perl).\n\nThe one caveat of PhpWiki is the allowance of HTML if the line is preceded by a bar (or pipe, which is how I usually say it). (That''s a ''|''). It was very simple to add, and the idea came from a posting somewhere on the PPR about how AT&T had an internal Wiki clone and used the same technique. The ability to embed HTML is disabled by default for security reasons.\n\nVersion 1.01 includes a patch that fixes a small error with rendering <hr> lines. Thanks to Gerry Barksdale.\n\nSee the HISTORY file for a rundown on the whole development process if that sort of thing really interests you :-)\n\n--SteveWainstead', 'a:0:{}'),
('SandBox', 1, 0, 'The PhpWiki programming team', 969720986, 969720986, 'You can try out Wiki in here.\n\nHave fun :-)', 'a:0:{}'),
('SteveWainstead', 1, 0, 'The PhpWiki programming team', 981083979, 981083979, 'Hi. I started building this WikiWikiWeb but many others help me now. I''m at http://wcsb.org/~swain/.\n\nPlease report bugs to mailto:phpwiki-talk@lists.sourceforge.net', 'a:0:{}'),
('TestPage', 1, 0, 'The PhpWiki programming team', 973703252, 973703252, '\n\n New lists: asterisks, hash marks, and ";text:def"\n* bullet\n* l1\n** l2\n** l2\n*** l3\n# one\n#two\n#three\n;Term1:definition1.1\n;: defintion1.2\n;Term2 :defintion2\n;; Term3:defintion3\n;;;Term4: definition4\n;;; : defintion4.2\n;;; Term5 : defintion5\n\nMixed:\n*ul1\n*#ul1-ol1\n*#ul1-ol2\n*#*ul1-ol2-ul1\n*#*ul1-ol2-ul2\n*#**ul1-ol2-ul2-ul1\n*#**ul1-ol2-ul2-ul1\n\n*l1\n preformatted text\n**    l2\n----\n old lists\n	* level 1\n	* l1\n		*l2\n		*l2\n			*l3\n			*l3\n				*l4\n			*l3\n					*l5\n			*l3\n	#one\n	#two\n		#one\n		#two\n	*l1\n		#three\n		#four\n	*l1\n		*l2\n		# one\n		# two\n\n preformatted text\n some more text\n\n	*l1\n				*l4\n	# number\n	# number\nthis is a plain paragraph\n	* bullet\nthis is a plain paragraph again\n	# number\n----\n__Link tests__\n# normal: FrontPage\n# in brackets: [FrontPage] -- named: [the front page|FrontPage]\n# Link in brackets: [http://phpwiki.sourceforge.net/]\n# Link outside brackets: http://phpwiki.sourceforge.net/\n# Link with Wiki word: http://phpwiki.sourceforge.net/phpwiki/index.php?FrontPage\n# Two consecutive links: http://phpwiki.sourceforge.net/ http://phpwiki.sourceforge.net/phpwiki/\n# [PhpWiki on Sourceforge | http://phpwiki.sourceforge.net/]\n# [URL with a WikiWord | http://phpwiki.sourceforge.net/phpwiki/index.php?RecentChanges]\n# Javascript: [boo! | javascript:alert(''oops'') ]  (is now: named internal link)\n# A [[Link] produces a [Link]\n# A [Link] looks like this: [[Link]\n# This is a [%%%] line break link\n# Also this page is [[not linked to], and this one is !NotLinkedTo and this one neither !http://not.linked.to/.\n#* WikiName - WikiNameSameStem -- !!WikiName - !!WikiNameSameStem\n#* !!WikiName - !!WikiNameSameStem -- WikiName - WikiNameSameStem\n#* WikiNameSameStem - WikiName -- !!WikiNameSameStem - !!WikiName\n#* !!WikiNameSameStem - !!WikiName -- WikiNameSameStem - WikiName\n\n----\nMarkup tests:\n\n__underscores for bold__\n\n''''''quotes for bold''''''\n\n''''quotes for italic''''\n\n__''''underscores bold italic''''__\n\n''''''''''five quotes bold italic''''''''''\n\n''''''''''''six quotes''''''''''''\n\n''''''''''Bold italic'''''' and italic'''' (buggy)\n\n''''''Bold and ''''bold-italic'''''''''' (also buggy)\n\n!!! h1\n\n!! h2\n\n! h3\n\nthis is plain text with <br>%%%\na line break\n\nlook at the <a href="http://phpwiki.sourceforge.net/">markup language</a>\n\nyou cannot use &, < or >\n\n----\nUsage in preformatted text:\n\n __underscores for bold__\n ''''''quotes for bold''''''\n ''''quotes for italic''''\n __''''underscores bold italic''''__\n ''''''''''five quotes bold italic''''''''''\n ''''''''''''six quotes''''''''''''\n !!! h1\n !! h2\n ! h3\n this is plain text with <br>%%%\n a line break\n look at the <a href="http://phpwiki.sourceforge.net/">markup language</a>\n you cannot use &, < or >', 'a:0:{}'),
('TextFormattingRules', 1, 0, 'The PhpWiki programming team', 998844188, 998844188, '! Paragraphs\n\n* Don''t indent paragraphs\n* Words wrap and fill as needed\n* Use blank lines as separators\n* Four or more minus signs make a horizontal rule\n* %%''''''''% makes a linebreak (in headings and lists too)\n\n\n! Lists\n\n* asterisk for first level\n** asterisk-asterisk for second level, etc.\n* Use * for bullet lists, # for numbered lists (mix at will)\n* semicolon-term-colon-definition for definition lists:\n;term here:definition here, as in the <DL><DT><DD> list\n* One line for each item\n* Other leading whitespace signals preformatted text, changes font.\n\n! Headings\n\n* ''!'' at the start of a line makes a small heading\n* ''!!'' at the start of a line makes a medium heading\n* ''!!!'' at the start of a line makes a large heading\n\n! Fonts\n\n* Indent with one or more spaces to use a monospace font:\n\n This is in monospace\nThis is not\n\n!Indented Paragraphs\n\n* semicolon-colon -- works like <BLOCKQUOTE>\n\n;: this is an indented block of text\n\n! Emphasis\n\n* Use doubled single-quotes (''____'') for emphasis (usually ''''italics'''')\n* Use doubled underscores (_''''''''_) for strong emphasis (usually __bold__)\n* Mix them at will: __''''bold italics''''__\n* ''''Emphasis'''' can be used ''''multiple'''' times within a line, but ''''cannot'''' cross line boundaries:\n\n''''this\nwill not work''''\n\n! References\n* Hyperlinks to other pages within the Wiki are made by placing the page name in square brackets: [this is a page link] or UsingWikiWords (preferred)\n* Hyperlinks to external pages are done like this: [http://www.wcsb.org/]\n* You can name the links by providing a name, a bar (|) and then the hyperlink or pagename: [PhpWiki home page | http://phpwiki.sourceforge.net/]  - [the front page | FrontPage]\n* You can suppress linking to old-style references and URIs by preceding the word with a ''!'', e.g. !NotLinkedAsWikiName, !http://not.linked.to/\n* [1], [2], [3], [4] refer to remote references. Click EditLinks on the edit form to enter URLs. These differ from the newer linking scheme; references are unique to a page.\n* Also, the old way of linking URL''s is still supported: precede URLs with "http:", "ftp:" or "mailto:" to create links automatically as in: http://c2.com/\n* URLs ending with .png, .gif, or .jpg are inlined if in square brackets, by themselves: [http://phpwiki.sourceforge.net/phpwiki/images/png.png]\n\n\n! HTML Mark-Up Language\n\n* Don''t bother\n* < and > are themselves\n* The & characters will not work\n* If you really must use HTML, your system administrator can enable this feature. Start each line with a bar (|). Note that this feature is disabled by default.', 'a:0:{}'),
('WabiSabi', 1, 0, 'The PhpWiki programming team', 973527283, 973527283, 'Since wabi-sabi represents a comprehensive Japanese world view or aesthetic system, it is difficult to explain precisely in western terms.  According to Leonard Koren, wabi-sabi is the most conspicuous and characteristic feature of what we think of as traditional Japanese beauty and it ''''"occupies roughly the same position in the Japanese pantheon of aesthetic values as do the Greek ideals of beauty and perfection in the West."''''\n\nWabi-sabi is a beauty of things imperfect, impermanent, and incomplete.\n\nIt is the beauty of things modest and humble.\n\nIt is the beauty of things unconventional.\n\nThe concepts of wabi-sabi correlate with the concepts of Zen Buddhism, as the first Japanese involved with wabi-sabi were tea masters, priests, and monks who practiced Zen. Zen Buddhism originated in India, traveled to China in the 6th century, and was first introduced in Japan around the 12th century. Zen emphasizes ''''"direct, intuitive insight into transcendental truth beyond all intellectual conception."'''' At the core of wabi- sabi is the importance of transcending ways of looking and thinking about things/existence.\n\n* All things are impermanent\n* All things are imperfect\n* All things are incomplete\n\nMaterial characteristics of wabi-sabi:\n\n* suggestion of natural process\n* irregular\n* intimate\n* unpretentious\n* earthy\n* simple\n\nFor more about wabi-sabi, see\nhttp://www.art.unt.edu/ntieva/artcurr/japan/wabisabi.htm', 'a:0:{}'),
('WikiWikiWeb', 1, 0, 'The PhpWiki programming team', 973527283, 973527283, 'A WikiWikiWeb is a site where everyone can collaborate on the content. The most well-known and widely used Wiki is the Portland Pattern Repository at http://c2.com/cgi-bin/wiki?WikiWikiWeb.\n\nI found these statements there particularly relevant:\n\n''''The point is to make the EditText form simple and the FindPage search fast.''''\n\n''''In addition to being quick, this site also aspires to Zen ideals generally labeled WabiSabi. Zen finds beauty in the imperfect and ephemeral. When it comes down to it, that''s all you need.''''\n\nYou can say hello on RecentVisitors, or read about HowToUseWiki and AddingPages. Go ahead, join the discussion, play with it, and have fun!\n\n--SteveWainstead', 'a:0:{}');

-- --------------------------------------------------------

--
-- Table structure for table `wikilinks`
--

CREATE TABLE IF NOT EXISTS `wikilinks` (
  `frompage` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `topage` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`frompage`,`topage`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wikilinks`
--

INSERT INTO `wikilinks` (`frompage`, `topage`) VALUES
('AddingPages', 'ClickTheQuestionMark'),
('AddingPages', 'PhpWiki'),
('AddingPages', 'StringThemTogetherLikeThis'),
('AddingPages', 'TextFormattingRules'),
('AddingPages', 'square brackets'),
('ConvertSpacesToTabs', 'EditCopy'),
('ConvertSpacesToTabs', 'EditText'),
('ConvertSpacesToTabs', 'PhpWiki'),
('ConvertSpacesToTabs', 'TextFormattingRules'),
('ConvertSpacesToTabs', 'VariousBrowsers'),
('FindPage', 'HowToUseWiki'),
('FindPage', 'MoreAboutMechanics'),
('FindPage', 'RecentChanges'),
('FrontPage', 'AddingPages'),
('FrontPage', 'HowToUseWiki'),
('FrontPage', 'MostPopular'),
('FrontPage', 'PhpWikiAdministration'),
('FrontPage', 'RecentChanges'),
('FrontPage', 'RecentVisitors'),
('FrontPage', 'ReleaseNotes'),
('FrontPage', 'SandBox'),
('FrontPage', 'WikiWikiWeb'),
('GoodStyle', 'WabiSabi'),
('HowToUseWiki', 'AddingPages'),
('HowToUseWiki', 'SteveWainsteadEatsWorms'),
('HowToUseWiki', 'TextFormattingRules'),
('HowToUseWiki', 'ThisPageShouldNotExist'),
('HowToUseWiki', 'WikiWikiWeb'),
('MoreAboutMechanics', 'EmbPerl'),
('MoreAboutMechanics', 'PhpWiki'),
('MoreAboutMechanics', 'WabiSabi'),
('MoreAboutMechanics', 'WikiWikiWeb'),
('PhpWikiAdministration', 'FrontPage'),
('PhpWikiAdministration', 'PhpWiki'),
('RecentChanges', 'AddingPages'),
('RecentChanges', 'ConvertSpacesToTabs'),
('RecentChanges', 'EditText'),
('RecentChanges', 'FindPage'),
('RecentChanges', 'FrontPage'),
('RecentChanges', 'GoodStyle'),
('RecentChanges', 'HowToUseWiki'),
('RecentChanges', 'MoreAboutMechanics'),
('RecentChanges', 'MostPopular'),
('RecentChanges', 'PhpWiki'),
('RecentChanges', 'PhpWikiAdministration'),
('RecentChanges', 'RecentVisitors'),
('RecentChanges', 'ReleaseNotes'),
('RecentChanges', 'SandBox'),
('RecentChanges', 'SteveWainstead'),
('RecentChanges', 'TestPage'),
('RecentChanges', 'TextFormattingRules'),
('RecentChanges', 'WabiSabi'),
('RecentChanges', 'WikiWikiWeb'),
('RecentVisitors', 'PhpWiki'),
('ReleaseNotes', 'EditCopy'),
('ReleaseNotes', 'FrontPage'),
('ReleaseNotes', 'MostPopular'),
('ReleaseNotes', 'PhpWiki'),
('ReleaseNotes', 'ShiningRay'),
('ReleaseNotes', 'SteveWainstead'),
('ReleaseNotes', 'WhichDatabase'),
('ReleaseNotes', 'WikiWikiWebs'),
('ReleaseNotes', 'new linking scheme'),
('SteveWainstead', 'WikiWikiWeb'),
('TestPage', '%%%'),
('TestPage', 'FrontPage'),
('TestPage', 'Link'),
('TestPage', 'WikiName'),
('TestPage', 'WikiNameSameStem'),
('TestPage', 'javascript:alert(''oops'')'),
('TextFormattingRules', 'EditLinks'),
('TextFormattingRules', 'FrontPage'),
('TextFormattingRules', 'UsingWikiWords'),
('TextFormattingRules', 'this is a page link'),
('WikiWikiWeb', 'AddingPages'),
('WikiWikiWeb', 'EditText'),
('WikiWikiWeb', 'FindPage'),
('WikiWikiWeb', 'HowToUseWiki'),
('WikiWikiWeb', 'RecentVisitors'),
('WikiWikiWeb', 'SteveWainstead'),
('WikiWikiWeb', 'WabiSabi');

-- --------------------------------------------------------

--
-- Table structure for table `wikiscore`
--

CREATE TABLE IF NOT EXISTS `wikiscore` (
  `pagename` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pagename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wikiscore`
--

INSERT INTO `wikiscore` (`pagename`, `score`) VALUES
('%%%', 1),
('AddingPages', 16),
('ClickTheQuestionMark', 4),
('ConvertSpacesToTabs', 2),
('EditCopy', 3),
('EditLinks', 4),
('EditText', 8),
('EmbPerl', 2),
('FindPage', 7),
('FrontPage', 11),
('GoodStyle', 2),
('HowToUseWiki', 14),
('Link', 1),
('MoreAboutMechanics', 4),
('MostPopular', 9),
('PhpWiki', 16),
('PhpWikiAdministration', 7),
('RecentChanges', 7),
('RecentVisitors', 12),
('ReleaseNotes', 7),
('SandBox', 7),
('ShiningRay', 2),
('SteveWainstead', 9),
('SteveWainsteadEatsWorms', 4),
('StringThemTogetherLikeThis', 4),
('TestPage', 2),
('TextFormattingRules', 11),
('ThisPageShouldNotExist', 4),
('UsingWikiWords', 4),
('VariousBrowsers', 1),
('WabiSabi', 10),
('WhichDatabase', 2),
('WikiName', 1),
('WikiNameSameStem', 1),
('WikiWikiWeb', 16),
('WikiWikiWebs', 2),
('javascript:alert(''oops'')', 1),
('new linking scheme', 2),
('square brackets', 4),
('this is a page link', 4);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
