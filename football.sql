-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Янв 26 2015 г., 03:45
-- Версия сервера: 5.6.17
-- Версия PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `football`
--

-- --------------------------------------------------------

--
-- Структура таблицы `champs`
--

CREATE TABLE IF NOT EXISTS `champs` (
  `champ_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `champion` int(11) DEFAULT NULL,
  `finalist` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`champ_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `games`
--

CREATE TABLE IF NOT EXISTS `games` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  `point1` int(11) DEFAULT NULL,
  `point2` int(11) DEFAULT NULL,
  `extra` tinyint(4) NOT NULL DEFAULT '0',
  `penalty1` int(11) DEFAULT NULL,
  `penalty2` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `played_date` datetime DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `player1` (`player1`,`player2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `champ_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target_id1` int(11) DEFAULT NULL,
  `target_id2` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `playoff` tinyint(1) NOT NULL DEFAULT '0',
  `final` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `group_players`
--

CREATE TABLE IF NOT EXISTS `group_players` (
  `group_player_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `won` int(11) DEFAULT '0',
  `draw` int(11) DEFAULT '0',
  `lost` int(11) DEFAULT '0',
  `goal_for` int(11) NOT NULL DEFAULT '0',
  `goal_against` int(11) NOT NULL DEFAULT '0',
  `points` int(11) DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `qualified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_player_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `parties`
--

CREATE TABLE IF NOT EXISTS `parties` (
  `party_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`party_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `parties`
--

INSERT INTO `parties` (`party_id`, `name`) VALUES
(1, 'Barcelona'),
(2, 'Arsenal'),
(3, 'Juventus'),
(4, 'Atletico'),
(5, 'PSG');

-- --------------------------------------------------------

--
-- Структура таблицы `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `player_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `party_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `players`
--

INSERT INTO `players` (`player_id`, `name`, `status`, `party_id`) VALUES
(1, 'Ermek', 1, 1),
(2, 'Eldar', 1, 2),
(3, 'Azamat', 1, 1),
(4, 'Aybat', 1, 3),
(5, 'Meder', 1, 3),
(6, 'Adilet', 1, 4),
(7, 'Ravshan', 1, 5),
(8, 'Ulan', 0, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `team_champs`
--

CREATE TABLE IF NOT EXISTS `team_champs` (
  `champ_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `winner` tinyint(4) NOT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`champ_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `team_games`
--

CREATE TABLE IF NOT EXISTS `team_games` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `champ_id` int(11) NOT NULL,
  `player1` int(11) NOT NULL,
  `partner1` int(11) DEFAULT NULL,
  `player2` int(11) NOT NULL,
  `partner2` int(11) DEFAULT NULL,
  `point1` int(11) DEFAULT NULL,
  `point2` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `played_date` datetime DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`game_id`),
  KEY `player1` (`player1`,`player2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `team_players`
--

CREATE TABLE IF NOT EXISTS `team_players` (
  `team_player_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `team` tinyint(4) NOT NULL,
  `champ_id` int(11) NOT NULL,
  `leader` tinyint(1) NOT NULL DEFAULT '0',
  `joker` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`team_player_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `team_results`
--

CREATE TABLE IF NOT EXISTS `team_results` (
  `team` tinyint(1) NOT NULL DEFAULT '1',
  `champ_id` int(11) NOT NULL,
  `won` int(11) DEFAULT '0',
  `lost` int(11) DEFAULT '0',
  `goal_for` int(11) NOT NULL DEFAULT '0',
  `goal_against` int(11) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  UNIQUE KEY `champ_team` (`team`,`champ_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
