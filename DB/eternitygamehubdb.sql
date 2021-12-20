-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eternitygamehubdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `eternitygamehubdb` ;

-- -----------------------------------------------------
-- Schema eternitygamehubdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eternitygamehubdb` DEFAULT CHARACTER SET utf8 ;
USE `eternitygamehubdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `account_created` DATETIME NULL,
  `biography` TEXT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `profile_picture_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `max_players` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating_id` INT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_user1_idx` (`user_id` ASC),
  INDEX `fk_game_rating1_idx` (`rating_id` ASC),
  CONSTRAINT `fk_game_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_rating1`
    FOREIGN KEY (`rating_id`)
    REFERENCES `rating` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform` ;

CREATE TABLE IF NOT EXISTS `platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game_inventory` ;

CREATE TABLE IF NOT EXISTS `game_inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `game_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `description` TEXT NULL,
  `sale_price` DECIMAL(4,2) NULL,
  `available` TINYINT NOT NULL,
  `rent_price` DECIMAL(4,2) NULL,
  `platform_id` INT NOT NULL,
  `condition_new` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_inventory_game1_idx` (`game_id` ASC),
  INDEX `fk_game_inventory_user1_idx` (`user_id` ASC),
  INDEX `fk_game_inventory_platform1_idx` (`platform_id` ASC),
  CONSTRAINT `fk_game_inventory_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_inventory_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_inventory_platform1`
    FOREIGN KEY (`platform_id`)
    REFERENCES `platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sale` ;

CREATE TABLE IF NOT EXISTS `sale` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buyer_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `game_inventory_id` INT NOT NULL,
  `sale_date` DATETIME NULL,
  `rating_by_buyer` INT NULL,
  `comment_by_buyer` TEXT NULL,
  `rating_by_seller` INT NULL,
  `comment_by_seller` TEXT NULL,
  `return_by_date` DATE NULL,
  `date_returned` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sale_game_inventory1_idx` (`game_inventory_id` ASC),
  INDEX `fk_sale_seller_idx` (`seller_id` ASC),
  INDEX `fk_sale_buyer_idx` (`buyer_id` ASC),
  CONSTRAINT `fk_sale_game_inventory1`
    FOREIGN KEY (`game_inventory_id`)
    REFERENCES `game_inventory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_seller`
    FOREIGN KEY (`seller_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_buyer`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment` ;

CREATE TABLE IF NOT EXISTS `payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `payment_date` DATETIME NULL,
  `amount` DECIMAL(4,2) NULL,
  `sale_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_sale1_idx` (`sale_id` ASC),
  CONSTRAINT `fk_payment_sale1`
    FOREIGN KEY (`sale_id`)
    REFERENCES `sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre` ;

CREATE TABLE IF NOT EXISTS `genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game_genre` ;

CREATE TABLE IF NOT EXISTS `game_genre` (
  `game_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  INDEX `fk_game_genre_game1_idx` (`game_id` ASC),
  INDEX `fk_game_genre_genre1_idx` (`genre_id` ASC),
  CONSTRAINT `fk_game_genre_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS gamer@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'gamer'@'localhost' IDENTIFIED BY 'gamer';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'gamer'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (1, 'admin', 'admin', 'admin', 'admin', 'admin@fakeemail.com', '2021-12-11 3:24:53', 'The biography goes here.', 1, 'seller', 'profile picture url goes here.');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (2, 'user1', 'user', 'user', 'user', 'user@fakeemail.com', '2021-12-11 3:25:29', 'The biography goes here.', 1, 'buyer', 'profile picture url goes here.');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (3, '__catlady ', 'Ashe', 'Ubert', 'password', 'au@fake.com', '2021-12-11 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (4, 'keylimepie', 'Sylvain', 'Gautier', 'password', 'sg@fake.com', '2021-12-12 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (5, 'tatertots', 'Mercedes', 'Martriz', 'password', 'mm@fake.com', '2021-12-13 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (6, 'sourdoe', 'Ingrid', 'Fantine', 'password', 'if@fake.com', '2021-12-14 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (7, 'cobb', 'Ignatz', 'Galatea', 'password', 'ig@fake.com', '2021-12-15 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (8, 'potroast', 'Victor', 'Kirsten', 'password', 'vk@fake.com', '2021-12-16 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (9, 'twinkies', 'Felix', 'Credelia', 'password', 'fc@fake.com', '2021-12-17 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (10, 'fajitas', 'Marianne', 'Edmund', 'password', 'me@fake.com', '2021-12-18 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (11, 'cornbread', 'Yuri', 'Leclerc', 'password', 'yl@fake.com', '2021-12-19 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (12, 'biscuits', 'Annette', 'Dominic', 'password', 'ad@fake.com', '2021-12-20 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (13, 'User13', 'Raphael ', 'Kirsten', 'password', 'rk@fake.com', '2021-12-21 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (14, 'User14', 'Lysithea', 'Ordelia', 'password', 'lo@fake.com', '2021-12-22 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (15, 'User15', 'Duke', 'Aegir', 'password', 'duke@fake.com', '2021-12-23 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (16, 'User16', 'Ionius', 'IX', 'password', 'IX@fake.com', '2021-12-24 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (17, 'User17', 'Aelfric', 'Dahlman', 'password', 'dahh@fake.com', '2021-12-25 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (18, 'User18', 'Ashen', 'Wolves', 'password', 'ashen@wolves.com ', '2021-12-26 03:25:29', 'im cool n so r u', 1, 'seller', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (19, 'Gottacatchemall', 'Ash', 'Catchem', 'password', 'catchemash@fake.com', '2021-12-27 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `email`, `account_created`, `biography`, `enabled`, `role`, `profile_picture_url`) VALUES (20, 'iamuser20', 'Red', 'Redd ', 'password', 'reddddd@fake.com', '2021-12-28 03:25:29', 'im cool n so r u', 1, 'buyer', 'default.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (1, 'E', 'Generally suitable for all ages.');
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (2, 'E+10', 'Generally suitable for ages 10 and older.');
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (3, 'T', 'Generally suitable for ages 13 and older.');
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (4, 'M', 'Generally suitable for ages 17 and older.');
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (5, 'A', 'Only suitable for ages 18 and older.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (1, 'Super Mario Bros.', 'Players control Mario, or his brother Luigi in the multiplayer mode, as they travel the Mushroom Kingdom to rescue Princess Toadstool from Bowser (King Koopa). They traverse side-scrolling stages while avoiding hazards such as enemies and pits with the aid of power-ups such as the Super Mushroom, Fire Flower and Starman.', 2, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/0/03/Super_Mario_Bros._box.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (2, 'The Legend of Zelda', 'Set in the fantasy land of Hyrule, the plot centers on an elf-like boy named Link, who aims to collect the eight fragments of the Triforce of Wisdom in order to rescue Princess Zelda from the antagonist, Ganon.', 1, 1, 1, 'https://upload.wikimedia.org/wikipedia/commons/5/5b/Zelda_2017.svg');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (3, 'Mike Tyson\'s Punch-Out!', 'Punch-Out!! features a boxer known as Little Mac, fighting his way up through ranks of the World Video Boxing Association.', 1, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/3/3d/Punch-out_mrdream_boxart.PNG');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (4, 'Mega Man 2', 'Mega Man 2 is a platform and action game like its predecessor, Mega Man. The player controls Mega Man as he traverses eight stages to defeat the bosses, Dr. Wily\'s Robot Masters: Metal Man, Air Man, Bubble Man, Quick Man, Crash Man, Flash Man, Heat Man, and Wood Man.', 1, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/b/be/Megaman2_box.jpg');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (5, 'Ninja Gaiden', 'Ninja Gaiden features a ninja named Ryu Hayabusa who seeks revenge for the death of his father and gradually finds himself involved in a sinister plot that threatens the entire world.', 1, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/7/71/Ninja_Gaiden_logo.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (6, 'Super Mario Bros. 3', 'Super Mario Bros. 3 is a two-dimensional, side-scrolling platform game in which the player controls either Mario or Luigi. The game shares similar gameplay mechanics with previous games in the series.', 2, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/a/a5/Super_Mario_Bros._3_coverart.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (7, 'Prince of Persia', 'The game is set in medieval Persia. While the sultan is fighting a war in a foreign land, his vizier Jaffar, a wizard, seizes power. His only obstacle to the throne is the Sultan\'s daughter. Jaffar locks her in a tower and orders her to become his wife, or she would die within 60 minutes.', 1, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/0/0c/Princeofpersialogo.jpg');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (8, 'SimCity', 'The objective of SimCity is to build and design a city, without specific goals to achieve.', 1, 1, 2, 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Logo_of_SimCity.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (9, 'The Secret of Monkey Island', 'The Secret of Monkey Island is a 2D adventure game played from a third-person perspective. Via a point-and-click interface, the player guides protagonist Guybrush Threepwood through the game\'s world and interacts with the environment by selecting from twelve verb commands (nine in newer versions) such as talk to\" for communicating with characters and \"pick up\" for collecting items between commands and the world\'s objects in order to successfully solve puzzles and thus progress in the game.\"', 1, 1, 2, 'https://upload.wikimedia.org/wikipedia/en/a/a8/The_Secret_of_Monkey_Island_artwork.jpg');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (10, 'Super Mario World', 'Super Mario World is a side-scrolling platform game in which the player controls Mario or Luigi, the protagonists of the game. The game has similar gameplay to earlier games in the Super Mario series.', 2, 1, 1, 'https://upload.wikimedia.org/wikipedia/en/3/32/Super_Mario_World_Coverart.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (11, 'Civilization', 'Civilization is a turn-based single or multiplayer strategy game. The player takes on the role of the ruler of a civilization, starting with one (or occasionally two) settler units, and attempts to build an empire in competition with two to seven other civilizations. The game requires a fair amount of micromanagement (although less than other simulation games).', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (12, 'The Legend of Zelda: A Link to the Past', 'The story is officially set many years before the events of the first two Zelda games. The player assumes the role of Link as he journeys to save Hyrule, defeat the demon king Ganon, and rescue the descendants of the Seven Sages.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (13, 'Lemmings', 'The objective of the game is to guide a group of anthropomorphised lemmings through a number of obstacles to a designated exit. To save the required number of lemmings to win, one must determine how to assign a limited number of eight different skills to specific lemmings that allow the selected lemming to alter the landscape, to affect the behaviour of other lemmings, or to clear obstacles to create a safe passage for the rest of the lemmings.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (14, 'Monkey Island 2: LeChuck\'s Revenge', 'Monkey Island 2: LeChuck\'s Revenge is an adventure game developed and published by LucasArts in 1991. A sequel to 1990\'s The Secret of Monkey Island, it is the second game in the Monkey Island series. ', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (15, 'Sonic the Hedgehog', 'Sonic the Hedgehog is a 2D side-scrolling platform game. The gameplay centers on Sonic the Hedgehog\'s ability to run at high speed through levels that include springs, slopes, bottomless pits, and vertical loops.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (16, 'Street Fighter II', 'Street Fighter II: The World Warrior is a competitive fighting game developed by Capcom and originally released for arcades in 1991. It is the second installment in the Street Fighter series and the sequel to Street Fighter, released in 1987.', 2, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (17, 'Dune II', 'The player takes the role of the commander of one of the three interplanetary houses, the Atreides, the Harkonnen or the Ordos, with the objective of wresting control of Arrakis from the other two houses.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (18, 'Sonic the Hedgehog 2', 'Sonic the Hedgehog 2 is a 2D side-scrolling platform game.[1] The game stars Sonic the Hedgehog and his sidekick, Miles \"Tails\" Prower, who is described as having idolized Sonic as a child and wanting to keep up with him.', 2, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (19, 'Super Mario Kart', 'Super Mario Kart is a kart racing game featuring several single and multiplayer modes. During the game, players take control of one of eight Mario franchise characters, each with differing capabilities,[3] and drive karts around tracks with a Mario franchise theme. ', 2, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (20, 'Wolfenstein 3D', 'Wolfenstein 3D is a first-person shooter presented with rudimentary 3D graphics.[1] The game is broken up into levels, each of which is a flat plane divided into areas and rooms by a grid-based pattern of walls and doors, all of equal height.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (21, 'Day of the Tentacle', 'Day of the Tentacle follows the point-and-click two-dimensional adventure game formula, first established by the original Maniac Mansion. Players direct the controllable characters around the game world by clicking with the computer mouse.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (22, 'Doom', 'Doom is a first-person shooter presented with early 3D graphics. The player controls an unnamed space marine—later termed \"Doomguy\"—through a series of levels set in military bases on the moons of Mars and in Hell. To finish a level, the player must traverse through the area to reach a marked exit room.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (23, 'The Legend of Zelda: Link\'s Awakening', 'Link\'s Awakening is an action-adventure game focused on exploration and combat. The majority of the game takes place from an overhead perspective. The player traverses the overworld of Koholint Island while fighting monsters and exploring underground dungeons.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (24, 'Sam & Max Hit the Road', 'Sam & Max Hit the Road is a 2D adventure game where the player controls the actions of Sam from a third-person perspective. The player uses Sam to explore the pre-rendered cartoon environments of the game and solve a series of puzzles using a simple point-and-click interface.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (25, 'Secrets of Mana', 'Secret of Mana displays a top-down perspective, in which the player characters navigate the terrain and fight off hostile creatures.', 3, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (26, 'SimCity 2000', 'SimCity 2000 is played from an isometric perspective as opposed to the previous title, which was played from a top-down perspective. The objective of the game is to create a city, develop residential and industrial areas, build infrastructure and collect taxes for further development of the city.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (27, 'Star Fox', 'Star Fox is a rail shooter in a third-person and first-person 3D perspective. The player must navigate Fox\'s spacecraft, an Arwing, through environments while various enemies (spaceships, robots, creatures, etc.) attack them. Along the way, various power-ups are placed in the stage to help the player. The player receives a score at the end of each level based on how many enemies have been destroyed and how well the player has defended their teammates. At the end of each level there is a boss that the player must defeat before progressing to the next level.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (28, 'Donkey Kong Country', 'Donkey Kong Country is a side-scrolling platform game in which the player must complete 40 levels to recover the Kongs\' banana hoard, which has been stolen by the crocodilian Kremlings. ', 2, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (29, 'Doom II', 'Doom II, also known as Doom II: Hell on Earth, is a first-person shooter game by id Software.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (30, 'EarthBound', 'EarthBound features many traditional role-playing game elements: the player controls a party of characters who travel through the game\'s two-dimensional world composed of villages, cities, caves, and dungeons.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (31, 'Final Fantasy VI', 'Like previous Final Fantasy installments, Final Fantasy VI consists of four basic modes of gameplay: an overworld map, town and dungeon field maps, a battle screen, and a menu screen. The overworld map is a scaled-down version of the game\'s fictional world, which the player uses to direct characters to various locations. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (32, 'Star Wars: TIE Fighter', 'The game\'s plot begins soon after the Empire\'s victory on Hoth in The Empire Strikes Back. As with X-Wing, the player\'s character is unnamed in the game; however, an included novella and Prima Publishing\'s strategy guide name the character Maarek Stele and provide a background narrative. In addition to fighting Rebel Alliance forces, the player fights pirates, combatants in a civil war, and traitorous Imperial forces. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (33, 'Super Metroid', 'Super Metroid is a 2D, side-scrolling action-adventure game, which primarily takes place on the fictional planet Zebes from the original game—a large, open-ended world with areas connected by doors and elevators.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (34, 'Command & Conquer', 'Command & Conquer involves players operating as one of two playable factions on a map - the Global Defense Initiative (GDI), and the Brotherhood of Nod - developing bases, gathering resources and using them to produce troops, and then defeating their opponents by eliminating their army and either destroying or capturing their base.', 4, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (35, 'Warcraft II: Tides of Darkness', 'Warcraft II is a real-time strategy game. In Warcraft II one side represents the human inhabitants of Lordaeron and allied races, and the other controls the invading orcs and their allied races. Each side tries to destroy the other by collecting resources and creating an army. The game is played in a medieval setting with fantasy elements, where both sides have melee, ranged, naval and aerial units, and spellcasters.  ', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (36, 'Wipeout', 'Set in 2052, players compete in the F3600 anti-gravity racing league, piloting one of a selection of craft in races on several tracks around the world.', 2, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (37, 'Yoshi\'s Island', 'Yoshi\'s Island is a 2D side-scrolling platform game. In the Super Mario series platform game tradition, the player controls Yoshi with a two-button run and jump control scheme. The player navigates between platforms and atop some foes en route to the end of the increasingly difficult levels. The player controls one of many Yoshis, which take turns traveling through 48 levels across six worlds to rescue Baby Luigi and reunite the brothers.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (38, 'Civilization II', 'As a turn-based strategy game, Civilization II realistically models the historical development of human civilization. A player, when creating a game, may pick one of 21 historical civilizations or a custom-named civilization. The computer will intelligently control multiple rival civilizations.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (39, 'Duke Nukem 3D', 'As a first-person shooter whose gameplay is similar to Doom, the gameplay of Duke Nukem 3D involves moving through levels presented from the protagonist\'s point of view, shooting enemies on the way. The environments in Duke Nukem 3D are highly destructible and interactive; most props can be destroyed by the player.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (40, 'Pokemon Red and Blue', 'Pokémon Red and Blue are played in a third-person view, overhead perspective and consist of three basic screens: an overworld, in which the player navigates the main character; a side-view battle screen; and a menu interface, in which the player configures his or her Pokémon, items, or gameplay settings.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (41, 'Quake', 'Players explore levels, facing monsters and finding secret areas before reaching an exit. Switches or keys open doors, and reaching the exit takes the player to the next level. Before accessing an episode, there is a set of three pathways with easy, medium, and hard skill levels.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (42, 'Resident Evil', 'The player\'s character is a member of a special law enforcement task force who is trapped in a mansion populated by dangerous mutated creatures. The objective of the game is to uncover the mystery of the mansion and ultimately escape alive.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (43, 'Super Mario 64', 'Super Mario 64 is a 3D platform game in which the player controls Mario through various courses. Mario\'s abilities in Super Mario 64 are far more diverse than those of previous Mario games.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (44, 'Tomb Raider', 'omb Raider is an action-adventure video game in which the player assumes the role of archaeologist-adventurer Lara Croft, who navigates through a series of ancient ruins and tombs in search of an ancient artefact.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (45, 'Wave Racer 64', 'Wave Race 64 is a racing game in which players race on Jet Skis in different weather conditions and on a variety of courses. The game features three single-player modes (Championship, Time Trials, and Stunt Mode) as well as a multiplayer mode for competitive play.', 4, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (46, 'Castlevania: Symphony of the Night', 'Symphony of the Night uses 2-dimensional side-scrolling gameplay.[6] The objective is exploring Dracula\'s castle to defeat an entity named Shaft who is controlling Richter Belmont, the self-proclaimed lord of the castle and hero of the events which took place in Castlevania: Rondo of Blood.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (47, 'Diablo', 'Diablo is an action role-playing video game. The player moves and interacts with the environment primarily by way of a mouse.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (48, 'Fallout', 'Fallout is a 1997 role-playing video game developed and published by Interplay Productions. The game has a post-apocalyptic and chiefly retro-futuristic setting, taking place in the mid-22nd century decades after a global nuclear war. ', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (49, 'Final Fantasy VII', 'The game features three modes of play: the world map, the field, and the battle screen.  At its grandest scale, players explore the entire world of Final Fantasy VII on a 3D world map.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (50, 'GoldenEye 007', 'GoldenEye 007 is a first-person shooter where the player takes the role of Secret Intelligence Service agent James Bond through a series of levels. In each level, the player must complete a set of objectives while computer-controlled opponents try to hinder the player\'s progress.', 4, 1, 5, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (51, 'Gran Turismo', 'Gran Turismo is a racing game. The player must maneuver a car to compete against artificially intelligent drivers on various race tracks.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (52, 'Quake II', 'Quake II is a first-person shooter, in which the player shoots enemies from the perspective of the main character. The gameplay is very similar to that featured in Quake, in terms of movement and controls, although the player\'s movement speed has been slowed down, and the player now has the ability to crouch. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (53, 'Star Fox 64', 'Star Fox 64 is a 3D rail shooter game in which the player controls one of the vehicles piloted by Fox McCloud, usually an Arwing. Most of the game takes place in \"Corridor Mode\", which forces Fox\'s vehicle down an on-rails path straight forward through the environment.', 4, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (54, 'Star Wars Jedi Knight: Dark Forces', 'Jedi Knight is primarily a first-person shooter, although it does offer the choice of a third-person view. The game consists of twenty-one levels with objectives which the player must complete before being able to continue to the next level. There are weapons available in each level and after level three, the player has the use of a lightsaber, along with the Force.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (55, 'Fallout 2', 'Fallout 2 is a role-playing open-world video game. The player is free to move at will until they enter into combat. Combat gives them a number of action points to move, fire, check their equipment, reload and the like.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (56, 'Half-Life', 'Half-Life is a first-person shooter that requires the player to perform combat tasks and puzzle solving to advance through the game. Unlike most of its peers at the time, Half-Life uses scripted sequences, such as a Vortigaunt ramming down a door, to advance major plot points.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (57, 'The Legend of Zelda: Ocarina of Time', 'The Legend of Zelda: Ocarina of Time is a fantasy action-adventure game set in an expansive environment. The player controls series protagonist Link from a third-person perspective in a three-dimensional world. Link primarily fights with a sword and shield, but can also use other weapons such as projectiles, bombs, and magic spells.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (58, 'Metal Gear Solid', 'The player must navigate the protagonist, Solid Snake, through a nuclear weapons facility without being detected by enemies.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (59, 'Resident Evil 2', 'A survival horror game, Resident Evil 2 features the same basic gameplay mechanics as its predecessor, Resident Evil. The player explores a fictional city while solving puzzles and fighting monsters.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (60, 'StarCraft', 'Set in a fictitious future timeline during the 25th century AD in a distant part of the Milky Way galaxy known as the Koprulu Sector, the game revolves around three intelligent species fighting for dominance: the Terrans are humans exiled from Earth who are now skilled at adapting to any situation; the Zerg are a race of insectoid aliens in pursuit of genetic perfection and obsessed with assimilating other races; the Protoss are a humanoid species with advanced technology and psionic abilities who are attempting to preserve their civilization and strict philosophy about their way of life from the Zerg.\n', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (61, 'Age of Empires II', 'Age of Empires II is a real-time strategy game that focuses on building towns, gathering resources, and creating armies to defeat opponents. Players conquer rival towns and empires as they advance one of 13 civilizations through four \"Ages\": the Dark Age, the Feudal Age, the Castle Age (representing the High Middle Ages), and the Imperial Age (reminiscent of the Renaissance)—a 1,000-year timeframe.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (62, 'EverQuest', 'Many of the elements in EverQuest have been drawn from text-based MUD (Multi-User Dungeon) games, particularly DikuMUDs, which in turn were inspired by traditional role-playing games such as Dungeons & Dragons.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (63, 'Quake III: Arena', 'Unlike its predecessors, Quake III Arena does not have a plot-based single-player campaign. Instead, it simulates the multiplayer experience with computer-controlled players known as bots. The game\'s story is brief: \"the greatest warriors of all time fight for the amusement of a race called the Vadrigar in the Arena Eternal.\"', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (64, 'Shenmue', 'The player controls teenage martial artist Ryo Hazuki as he investigates his father\'s murder in Yokosuka in 1986. They must explore the open world, searching for clues, examining objects and talking to non-player characters. Occasionally, Ryo battles opponents in fighting sequences similar to Sega\'s Virtua Fighter series.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (65, 'Silent Hill', 'The objective of the player is to guide main protagonist and player character Harry Mason through a monster-filled town as he searches for his lost daughter, Cheryl. Silent Hill\'s gameplay consists of combat, exploration, and puzzle-solving.', 1, 1, 5, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (66, 'Unreal Tournament', 'Unreal Tournament is an arena first-person shooter, with head-to-head multiplayer deathmatches being the primary focus of the game. The single-player campaign is a series of arena matches played with bots, where the player competes for the title of Grand Champion.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (67, 'Counter Strike', 'Counter-Strike is a first-person shooter game in which players join either the terrorist team, the counter-terrorist team, or become spectators. Each team attempts to complete their mission objective and/or eliminate the opposing team. Each round starts with the two teams spawning simultaneously. All players have only one life by default and start with a pistol as well as a knife.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (68, 'Diablo II', 'Diablo II\'s storyline progresses through four chapters or \"Acts\". Each act follows a predetermined path, but the wilderness areas and dungeons between key cities are randomly generated. The player progresses through the story by completing a series of quests within each act, while there are also optional side dungeons for extra monsters and experience.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (69, 'The Legend of Zelda: Majora\'s Mask', 'The gameplay of Majora\'s Mask expands on that of Ocarina of Time. It retains the concept of dungeon puzzles and ocarina songs and introduces new elements including character transformations and a three-day cycle. As in previous installments, Link can perform basic actions such as walking, running and limited jumping (although sometimes Link performs flips), and must use items to battle enemies and solve puzzles.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (70, 'The Sims', 'The structure of the game is an agent-based artificial life program. The presentation of the game\'s artificial intelligence is advanced, and the Sims will respond to outside conditions independently, though often the player\'s intervention is necessary to keep the Sims on the right track.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (71, 'Tony Hawk\'s Pro Skater 2', 'Tony Hawk\'s Pro Skater 2 puts the player in control of a professional or fictional skater and takes place in a third-person view with a fixed camera. The player must perform tricks and complete level objectives in return for cash rewards, which can be used to unlock other levels, improve the player character\'s statistics and obtain better equipment.', 2, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (72, 'Animal Crossing', 'Animal Crossing is a social simulation game, dubbed a \"communication game\" by Nintendo. It is open-ended, and the player\'s character can live a separate life with very little set plot or mandatory tasks. Players assume the role of a new resident to the town', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (73, 'Devil May Cry', 'The gameplay consists of levels called \"missions\", where players must fight numerous enemies, perform platforming tasks, and occasionally solve puzzles to progress through the story. The player\'s performance in each mission is given a letter grade, starting with D, increasing to C, B, and A, with an additional top grade of S. Grades are based on the time taken to complete the mission, the amount of \"red orbs\" gathered (the in-game currency obtained from defeated enemies, destroyed objects, and exploration), how \"stylish\" their combat was, item usage, and damage taken.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (74, 'Final Fantasy X', 'Like previous games in the series, Final Fantasy X is presented in a third-person perspective, with players directly navigating the main character, Tidus, around the world to interact with objects and people. Unlike previous games, however, the world and town maps have been fully integrated, with terrain outside of cities rendered to scale. As Tidus explores the world, he randomly encounters enemies. When an enemy is encountered, the environment switches to a turn-based battle area where characters and enemies await their turn to attack.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (75, 'Gran Turismo 3: A-Spec', 'The objective of the game is to win all the provided races, championships, complete license tests and achieve 100% game completion. Every 25% of the game completed results in the player being awarded a car as a special prize.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (76, 'Grand Theft Auto III', 'Grand Theft Auto III is an action-adventure game played from a third-person perspective. Players complete missions—linear scenarios with set objectives—to progress through the story. It is possible to have several missions available at a time, as some missions require players to wait for further instructions or events. Outside of missions, players can freely roam the game\'s open world, and have the ability to complete optional side missions.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (77, 'Halo: Combat Evolved', 'Halo: Combat Evolved is a first-person shooter (FPS) game in which players experience gameplay in a 3D environment almost entirely from a first-person view. The player can move around and look up, down, left, or right.[6] The game features vehicles, ranging from armored 4×4s and tanks to alien hovercraft and aircraft, many of which can be controlled by the player.', 4, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (78, 'Max Payne', 'The player assumes the role of the titular character, with gameplay revolving around the use of the bullet time mechanic during firefights – when triggered, time is slowed down to such an extent that the speed at which bullets and other projectiles move is slow enough to be seen by the naked eye. Although Max\'s movement is also slowed, the player is still able to move and react in real-time, allowing them more time to plan and react to enemies.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (79, 'Metal Gear Solid 2: Sons of Liberty', 'Metal Gear Solid 2 carries the subtitle of \"Tactical Espionage Action,\" and most of the game involves the protagonist sneaking around avoiding being seen by the enemies. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (80, 'Silent Hill 2', 'The objective of Silent Hill 2 is to guide player character, James Sunderland, through the monster-filled town of Silent Hill as he searches for his deceased wife. ', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (81, 'Super Smash Bros. Melee', 'Like its predecessor, Super Smash Bros. Melee differs from traditional fighting games as the objective is to force their opponents beyond the boundaries of the stage.', 4, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (82, 'The Elder Scrolls III: Morrowind', 'The Elder Scrolls III: Morrowind is an open-world action role-playing video game developed by Bethesda Game Studios and published by Bethesda Softworks. It is the third installment in the Elder Scrolls series.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (83, 'Grand Theft Auto: Vice City', 'Grand Theft Auto: Vice City is an action-adventure game played from a third-person perspective. The player controls criminal Tommy Vercetti and completes missions—linear scenarios with set objectives—to progress through the story. It is possible to have several missions available at a time, as some missions require the player to wait for further instructions or events.', 1, 1, 5, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (84, 'Kingdom Hearts', 'Kingdom Hearts is influenced by its parent franchise, Final Fantasy, and carries gameplay elements over into its own action-based, hack and slash system.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (85, 'The Legend of Zelda: The Wind Waker', 'The Legend of Zelda: The Wind Waker is an open world action-adventure game with role-playing elements. The control scheme is comparable to its predecessors: the player moves the protagonist Link in three dimensions from a third-person perspective. Link fights with a sword and shield as well as a variety of other weapons and items. He interacts with non-player characters and objects via the action button.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (86, 'Metroid Prime', 'Metroid Prime is a 3D action-adventure game in which players control series protagonist Samus Aran from a first-person perspective, unlike previous games of the Metroid series, with third-person elements used for Morph Ball mode. The gameplay involves solving puzzles to reveal secrets, platform jumping, and shooting foes with the help of a \"lock-on\" mechanism that allows circle strafing while staying aimed at the enemy.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (87, 'Tom Clancy\'s Splinter Cell', 'The primary focus and hallmark of Splinter Cell\'s gameplay is stealth, with strong emphasis on light and darkness. The player is encouraged to move through the shadows for concealment whenever possible. The game displays a \"light meter\" that reflects how visible the player character is to enemies, and night vision and thermal vision goggles to help the player navigate in darkness or smoke/fog, respectively. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (88, 'Max Payne 2', 'Max Payne 2 is a third-person shooter, in which the player assumes the role of Max Payne, and plays as Mona Sax in a few levels.[2] Initially, the player\'s weapon is a 9mm pistol. As they progress, players access weapons including other handguns, shotguns, submachine guns, assault rifles, sniper rifles, and hand-thrown weapons. To move the game along, the player is told what the next objective is through Max\'s internal monologue, in which Max iterates what his next steps should be.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (89, 'Prince of Persia: The Sands of Time', 'Prince of Persia: The Sands of Time is an action-adventure puzzle-platformer. The player controls the main protagonist, an unnamed Prince from a kingdom in Persia. Environments are seen through a controllable third-person view. ', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (90, 'Star Wars: Kights of the Old Republic', 'Players choose from three basic character classes (Scout, Soldier or Scoundrel) at the beginning of the game and later choose from three Jedi subclasses (Guardian, Sentinel or Consular). Beyond class, a character has \"skills\" stats, tiered \"feats,\" and later on, tiered Force powers, similar to magic spells in fantasy games. Feats and Force powers are generally unlocked upon level-up, while the player is given skill points to distribute among their skills every level.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (91, 'Burnout 3: Takedown', 'Burnout 3: Takedown is a racing video game with arcade-style gameplay that emphasises dangerous and fast-paced driving. The game features standard circuit races which take place on carriageways and city streets populated with traffic.', 2, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (92, 'Grand Theft Auto: San Andreas', 'Grand Theft Auto: San Andreas is an action-adventure game with role-playing and stealth elements. Structured similarly to the previous two games in the series, the core gameplay consists of elements of third-person shooter and driving games, affording the player a large, open-world environment in which to move around.', 1, 1, 5, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (93, 'Half-Life 2', 'Like the original Half-Life (1998), Half-Life 2 is a single-player first-person shooter in which players control Gordon Freeman. It has similar mechanics to Half-Life, including health-and-weapon systems and periodic physics puzzles, except with the newer Source engine and improved graphics. ', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (94, 'Halo 2', 'Halo 2 is a shooter game. Players primarily experience gameplay from a first-person perspective, with the viewpoint shifting to third-person for vehicle segments.', 4, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (95, 'Metal Gear Solid 3: Snake Eater', 'The gameplay of Snake Eater is similar to that of previous games in the Metal Gear Solid series. Snake, controlled by the player, must move undetected through a hostile, enemy-filled environment.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (96, 'World of Warcraft', 'World of Warcraft (WoW) is a massively multiplayer online role-playing game (MMORPG) released in 2004 by Blizzard Entertainment. Set in the Warcraft fantasy universe, World of Warcraft takes place within the world of Azeroth, approximately four years after the events of the previous game in the series.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (97, 'God of War', 'God of War is a third-person single player action-adventure video game with hack and slash elements, viewed from a fixed camera perspective. The player controls the character Kratos in combo-based combat, platforming, and puzzle game elements, and battles Greek mythological foes that include undead soldiers, harpies, minotaurs, Medusa and the Gorgons, cyclopes, wraiths, Sirens, satyrs, centaurs, cerberuses, and boss opponents—the Hydra and a giant minotaur known as Pandora\'s Guardian.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (98, 'Guitar Hero', 'The gameplay is similar to other music and rhythm video games, in that the player must press buttons on a game controller in time with scrolling notes on the game screen to complete a song.', 2, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (99, 'Resident Evil 4', 'The player controls the protagonist, Leon S. Kennedy, from a third-person perspective. Departing significantly from the series\' previous games, the gameplay focuses on action and shootouts with fewer survival horror elements.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (100, 'Company of Heroes', 'Company of Heroes is set during the Second World War and contains two playable factions. Players aim to capture strategic resource sectors located around the map, which they use to build base structures, produce new units, and defeat their enemies.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (101, 'The Elder Scrolls IV: Oblivion', 'Oblivion is an open world role-playing game (RPG) that incorporates open-ended gameplay. The player can follow side-quests, interact with NPCs, dispatch monsters, develop their character, and travel anywhere in the province of Cyrodiil at any time while playing the game, provided that the areas are not quest-specific and otherwise inaccessible when not questing. The game never ends, and the player can continue playing after completing the main quest.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (102, 'Gears of War', 'Gears of War is a third-person shooter that places emphasis on using cover to avoid taking damage while moving towards enemy forces. The game uses a number of weapons, but predominately featured is the Lancer Assault Rifle, which has a mounted chainsaw bayonet that can deal melee damage at close range.', 4, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (103, 'Wii Sports', 'Wii Sports consists of five separate sports games—tennis, baseball, bowling, golf, and boxing—accessed from the main menu. The games use the motion sensor capabilities of the Wii Remote to control the player\'s dominant arm and/or the appropriate sports equipment it wields.', 4, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (104, 'BioShock', 'BioShock takes place in Rapture, a large underwater city planned and constructed in the 1940s by Objectivist business magnate Andrew Ryan, who wanted to create a utopia for society\'s elite to flourish outside of government control and \"petty morality\".', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (105, 'Call of Duty 4: Modern Warfare', 'The story takes place in the year of 2011, where a radical leader has executed the president of an unnamed country in the Middle East, and an ultranationalist movement ignites a civil war in Russia. The conflicts are seen from the perspectives of a U.S. Marine Force Recon sergeant and a British SAS commando and are set in various locales, such as the United Kingdom, the Middle East, Azerbaijan, Russia, and Ukraine. The multiplayer portion of the game features various game modes and contains a leveling system that allows the player to unlock additional weapons, weapon attachments, and camouflage schemes as they advance.', 4, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (106, 'God of War II', 'God of War II is an action-adventure game with hack and slash elements. It\'s a third-person single-player video game viewed from a fixed camera perspective. The player controls the character Kratos in combo-based combat, platforming, and puzzle game elements, and battles foes who primarily stem from Greek mythology, including harpies, minotaurs, Gorgons, griffins, cyclopes, cerberuses, Sirens, satyrs, and nymphs.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (107, 'Halo 3', 'Halo 3 is a shooter game where players primarily experience gameplay from a first-person perspective. Much of the gameplay takes place on foot, but also includes segments focused on vehicular combat. Gameplay focuses on the \"Golden Triangle of Halo\": players utilize weapons, grenades, and melee attacks, which are available to a player in most situations.', 4, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (108, 'Mass Effect', 'Mass Effect is a single-player action role-playing game in which the player takes the role of Commander Shepard from a third-person perspective.[1] Shepard\'s gender, appearance, military background, combat-training and first name are determined by the player before the game begins.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (109, 'Portal', 'In Portal, the player controls the protagonist, Chell, from a first-person perspective as she is challenged to navigate through a series of test chambers using the Aperture Science Handheld Portal Device, or portal gun, under the watchful supervision of the artificial intelligence GLaDOS. The portal gun can create two distinct portal ends, orange and blue. The portals create a visual and physical connection between two different locations in three-dimensional space.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (110, 'Rock Band', 'The game allows up to four players to simulate the performance of popular rock songs by playing with controllers modeled after musical instruments. Players can play the lead guitar, bass guitar, and drums parts to songs with \"instrument controllers\", as well as sing through a USB microphone. Players are scored on their ability to match scrolling musical \"notes\" while playing instruments, or by their ability to match the singer\'s pitch on vocals.', 4, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (111, 'Team Fortress 2', 'Players join one of two teams, RED and BLU, and choose one of nine character classes to play as in game modes such as capture the flag and king of the hill. Development was led by John Cook and Robin Walker, the developers of the original Team Fortress mod.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (112, 'Fallout 3', 'The main story takes place in the year 2277, around 36 years after the events of Fallout 2, of which it is not a direct sequel. Players take control of an inhabitant of Vault 101, one of several underground shelters created before the Great War to protect around 1,000 humans from the nuclear fallout, who is forced to venture out into the Capital Wasteland to find their father after he disappears from the Vault under mysterious circumstances. They find themselves seeking to complete their father\'s work while fighting against the Enclave, the corrupt remnants of the former U.S. Government that seeks to use it for their own purposes.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (113, 'Grand Theft Auto IV', 'Grand Theft Auto IV is an action-adventure game played from a third-person perspective. Players complete missions—linear scenarios with set objectives—to progress through the story. It is possible to have several active missions running at one time, as some require players to wait for further instructions or events. Outside of missions, players can freely roam the game\'s open world and complete optional side missions.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (114, 'Gears of War 2', 'Gears of War 2 is a third person shooter with an emphasis on the tactical use of cover, and retains much of the same gameplay from the first game.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (115, 'Left 4 Dead', 'An outbreak of a highly contagious pathogen nicknamed the \"Green Flu\" (which causes extreme aggression, mutation to the body cells, loss of higher brain functions, and essential zombification of those who catch it) begins in Pennsylvania.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (116, 'Rock Band 2', 'The core gameplay in Rock Band 2 is mostly unchanged from the original Rock Band. Players use controllers modeled after musical instruments to simulate the performance of rock songs. Players use these instruments to play scrolling musical \"notes\" on-screen in time with the music. Rock Band 2 offers single-player and multiplayer gameplay for lead guitar, bass guitar, drums, and vocals, allowing for any combination of parts to play as a band.', 4, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (117, 'Assassin\'s Creed II', 'Players directly control the on-screen character through a third-person perspective and can control the camera, allowing for a 360° view of their surroundings. The game takes place in an open world environment with nonlinear gameplay, allowing the player to roam freely within several regions of late fifteenth-century Italy such as Venice, Florence, Monteriggioni, Forlì, San Gimignano, and the Tuscany countryside.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (118, 'Batman: Arkam Asylum', 'Batman: Arkham Asylum is an action-adventure game viewed from the third-person perspective. The playable character is visible on the screen and the camera can be freely rotated around him. The player controls Batman as he traverses Arkham Asylum, a secure facility for the criminally insane located off the coast of Gotham City.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (119, 'Left 4 Dead 2', 'Like its predecessor, Left 4 Dead 2 is a first-person shooter with a heavy emphasis on cooperative gameplay. The game presents five new campaigns, each composed of three to five smaller levels. As in the first game, each campaign is presented in menus and loading screens as a film starring the four Survivors; and features, upon completing a campaign, a faux credits screen which acts as the final scoreboard for the players and recaps certain performance statistics for the group.', 4, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (120, 'Mass Effect 2', 'For the game, BioWare changed several gameplay elements and put further emphasis on third-person shooter aspects, including limited ammunition and regenerable health. In contrast to the exclusive focus on the main story of the original Mass Effect, the developers opted to create a plot where optional missions had as much intensity as the main mission.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (121, 'Red Dead Redmption', 'The game is played from a third-person perspective. The player may freely roam in its interactive open world, a fictionalized version of the Western United States and Northern Mexico, primarily by horseback and on foot.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (122, 'Rock Band 3', 'Rock Band 3 allows for 1–7 players, either locally or through online game services, to use various instrument controllers to accurately simulate the playing of music. In addition to supporting the four Basic instrument controllers from previous Rock Band games (lead guitar, bass guitar, drums and vocals), Rock Band 3 adds support for two additional microphones for singers to provide backup vocal harmonies (previously found in The Beatles: Rock Band and Green Day: Rock Band), an electric keyboard as a new instrument (or any MIDI-compatible keyboard), plus support for a specially made 102-button MIDI bass, and an actual Squier guitar by Fender. Support for MIDI compatible electronic drum kits as well.', 7, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (123, 'Starcraft II: Wings of Liberty', 'Like its predecessor, the game revolves around three species: the Terrans (humans), the Zerg (a super-species of assimilated life forms),[8] and the Protoss (a technologically advanced species with vast psionic powers). Wings of Liberty focuses on the Terrans, while the expansions, Heart of the Swarm and Legacy of the Void, would focus on the Zerg and Protoss, respectively. The game is set four years after the events of 1998\'s Brood War, and follows the exploits of Jim Raynor as he leads an insurgent group against the autocratic Terran Dominion. The game includes new and returning characters and locations from the original game.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (124, 'Super Mario Galaxy 2', 'The gameplay of Super Mario Galaxy 2 is similar to Super Mario Galaxy, with a focus on platforming based on and around 3D planets, grouped into levels known as galaxies. Planets and galaxies each have varying themes, sizes, landscapes, and climates. The player controls Mario (or later in the game, his brother Luigi, though using him is optional), who has special abilities such as the \"Spin\" attack, long jump, wall jumps, and a variety of somersaults. As in the original, the objective of the game is to travel to the various galaxies and collect Power Stars, which are awarded by completing levels and accomplishing tasks and are used to gain access to later levels.', 2, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (125, 'Batman: Arkham City', 'The game is presented from the third-person perspective with a primary focus on Batman\'s combat and stealth abilities, detective skills, and gadgets that can be used in both combat and exploration. Batman can freely move around the Arkham City prison, interacting with characters and undertaking missions, and unlocking new areas by progressing through the main story or obtaining new equipment. The player is able to complete side missions away from the main story to unlock additional content and collectible items. Batman\'s ally Catwoman is another playable character, featuring her own story campaign that runs parallel to the game\'s main plot.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (126, 'Dark Souls', 'Dark Souls takes place in the fictional kingdom of Lordran, where players assume the role of a cursed undead character who begins a pilgrimage to discover the fate of their kind.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (127, 'The Elder Scrolls V: Skyrim', 'The Elder Scrolls V: Skyrim is an action role-playing game, playable from either a first or third-person perspective. The player may freely roam over the land of Skyrim—an open world environment consisting of wilderness expanses, dungeons, caves, cities, towns, fortresses, and villages.[1] Players may navigate the game world more quickly by riding horses, paying for a ride from a city\'s stable or by utilizing a fast-travel system which allows them to warp to previously discovered locations.', 1, 1, 4, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (128, 'Minecraft', 'In Minecraft, players explore a blocky, procedurally generated 3D world with virtually infinite terrain, and may discover and extract raw materials, craft tools and items, and build structures or earthworks.In Minecraft, players explore a blocky, procedurally generated 3D world with virtually infinite terrain, and may discover and extract raw materials, craft tools and items, and build structures or earthworks.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (129, 'Portal 2', 'Portal 2 is a first-person perspective puzzle game. The player takes the role of Chell in the single-player campaign, as one of two robots—Atlas and P-Body—in the cooperative campaign, or as a simplistic humanoid icon in community-developed puzzles. These three characters can explore and interact with the environment. Characters can withstand limited damage but will die after sustained injury. There is no penalty for falling onto a solid surface, but falling into bottomless pits or toxic pools kills the player character immediately.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (130, 'Dota 2', 'Dota 2 is a multiplayer online battle arena (MOBA) video game in which two teams of five players compete to collectively destroy a large structure defended by the opposing team known as the \"Ancient\", whilst defending their own.', 1, 1, 2, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (131, 'Grand Theft Auto V', 'The game is played from either a third-person or first-person perspective, and its world is navigated on foot and by vehicle. Players control the three lead protagonists throughout single-player and switch among them, both during and outside missions. The story is centred on the heist sequences, and many missions involve shooting and driving gameplay.', 1, 1, 5, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (132, 'Destiny', 'Players take on the role of a Guardian, protectors of Earth\'s last safe city as they wield a power called Light to protect the City from different alien races. Guardians are tasked with reviving a celestial being called the Traveler, while journeying to different planets to investigate and destroy the alien threats before humanity is completely wiped out.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (133, 'Overwatch', 'Overwatch is an online team-based game generally played as a first-person shooter. The game features several different game modes, principally designed around squad-based combat with two opposing teams of six players each.', 1, 1, 3, 'https://i.imgur.com/a3H171W.png');
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (134, 'The Legend of Zelda: Breath of the Wild', 'Breath of the Wild is an action-adventure game set in an open world where players are tasked with exploring the kingdom of Hyrule while controlling Link. Breath of the Wild encourages nonlinear gameplay, which is illustrated by the game\'s lack of defined entrances or exits to areas, scant instruction given to the player, and encouragement to explore freely.', 1, 1, 1, 'https://i.imgur.com/a3H171W.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `platform`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `platform` (`id`, `name`) VALUES (1, 'PC');
INSERT INTO `platform` (`id`, `name`) VALUES (2, 'Nintendo');
INSERT INTO `platform` (`id`, `name`) VALUES (3, 'SNES');
INSERT INTO `platform` (`id`, `name`) VALUES (4, 'Sega Genesis');
INSERT INTO `platform` (`id`, `name`) VALUES (5, 'Sega Genesis II');
INSERT INTO `platform` (`id`, `name`) VALUES (6, 'Sega Genesis III');
INSERT INTO `platform` (`id`, `name`) VALUES (7, 'PlayStation');
INSERT INTO `platform` (`id`, `name`) VALUES (8, 'Nintendo 64');
INSERT INTO `platform` (`id`, `name`) VALUES (9, 'PSone');
INSERT INTO `platform` (`id`, `name`) VALUES (10, 'Dreamcast');
INSERT INTO `platform` (`id`, `name`) VALUES (11, 'Nintendo GameCube');
INSERT INTO `platform` (`id`, `name`) VALUES (12, 'Playstation 2');
INSERT INTO `platform` (`id`, `name`) VALUES (13, 'Xbox');
INSERT INTO `platform` (`id`, `name`) VALUES (14, 'Playstation 3');
INSERT INTO `platform` (`id`, `name`) VALUES (15, 'Wii');
INSERT INTO `platform` (`id`, `name`) VALUES (16, 'Xbox 360');
INSERT INTO `platform` (`id`, `name`) VALUES (17, 'Wii U');
INSERT INTO `platform` (`id`, `name`) VALUES (18, 'Playstation 4');
INSERT INTO `platform` (`id`, `name`) VALUES (19, 'Xbox One');
INSERT INTO `platform` (`id`, `name`) VALUES (20, 'Nintendo Switch');
INSERT INTO `platform` (`id`, `name`) VALUES (21, 'Playstation 5');
INSERT INTO `platform` (`id`, `name`) VALUES (22, 'Xbox Series X/S');
INSERT INTO `platform` (`id`, `name`) VALUES (23, 'Game Boy ');
INSERT INTO `platform` (`id`, `name`) VALUES (24, 'Game Boy Color');
INSERT INTO `platform` (`id`, `name`) VALUES (25, 'Game Boy Advance');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game_inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (1, 1, 1, 'Sellers personal description goes here.', 25.99, 1, 2.99, 1, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (2, 50, 1, 'Pristine copy', 0.99, 1, 0.99, 5, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (3, 4, 2, 'Pristine copy', 1.50, 1, 1.50, 1, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (4, 87, 1, 'Pristine copy', 2.90, 1, 2.90, 2, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (5, 46, 2, 'Pristine copy', 0.99, 1, 0.99, 3, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (6, 45, 1, 'Pristine copy', 1.50, 1, 1.50, 4, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (7, 7, 2, 'Pristine copy', 2.90, 1, 2.90, 5, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (8, 123, 1, 'Pristine copy', 0.99, 1, 0.99, 6, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (9, 120, 2, 'Pristine copy', 1.50, 1, 1.50, 7, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (10, 2, 1, 'Pristine copy', 2.90, 1, 2.90, 8, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (11, 5, 3, 'Fair and good ', 49.99, 1, 9.99, 1, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (12, 8, 4, 'Fair and good ', 49.99, 1, 9.99, 2, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (13, 9, 5, 'Fair and good ', 49.99, 1, 9.99, 3, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (14, 52, 6, 'Fair and good ', 49.99, 1, 9.99, 4, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (15, 55, 7, 'Fair and good ', 49.99, 1, 9.99, 5, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (16, 77, 8, 'Fair and good ', 49.99, 1, 9.99, 6, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (17, 44, 8, 'Fair and good ', 49.99, 1, 9.99, 7, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (18, 111, 8, 'Fair and good ', 49.99, 1, 9.99, 8, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (19, 111, 8, 'Fair and good ', 49.99, 1, 9.99, 1, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (20, 100, 9, 'Fair and good ', 49.99, 1, 9.99, 2, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (21, 97, 11, 'Fair and good ', 39.99, 1, 9.99, 3, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (22, 60, 13, 'Fair and good ', 39.99, 1, 9.99, 4, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (23, 30, 13, 'Brand new', 39.99, 1, 9.99, 5, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (24, 33, 20, 'Brand new', 39.99, 1, 9.99, 6, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (25, 33, 20, 'Brand new', 39.99, 1, 9.99, 7, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (26, 102, 18, 'Brand new', 39.99, 1, 9.99, 8, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (27, 88, 18, 'Brand new', 39.99, 1, 9.99, 1, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (28, 8, 19, 'Brand new', 39.99, 1, 9.99, 2, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (29, 78, 10, 'Brand new', 29.99, 1, 9.99, 3, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (30, 103, 12, 'Brand new', 29.99, 1, 9.99, 4, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (31, 89, 14, 'Brand new', 29.99, 1, 9.99, 5, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (32, 9, 15, 'Brand new', 29.99, 1, 9.99, 6, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (33, 78, 15, 'Brand new', 29.99, 1, 9.99, 7, 1);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (34, 57, 16, 'Slightly used', 99.99, 1, 9.99, 8, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (35, 59, 17, 'Slightly used', 99.99, 1, 9.99, 1, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (36, 60, 18, 'Slightly used', 99.99, 1, 9.99, 2, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (37, 61, 19, 'Slightly used', 99.99, 1, 9.99, 3, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (38, 62, 20, 'Slightly used', 99.99, 1, 9.99, 4, 0);
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (39, 63, 20, 'Slightly used', 99.99, 1, 9.99, 5, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sale`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (1, 1, 2, 1, '2021-12-11 3:33:30', 5, 'Fast shipping!', 5, 'Payment went through!', '2021-12-22', '2021-12-21');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (2, 2, 11, 2, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-22 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (3, 3, 11, 3, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-23 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (4, 4, 11, 4, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-24 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (5, 4, 12, 5, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-25 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (6, 4, 12, 6, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-26 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (7, 5, 12, 7, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-27 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (8, 6, 13, 8, '2021-12-13 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-28 3:33:00', '2021-12-21 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (9, 6, 14, 9, '2021-12-15 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-29 3:33:00', '2021-12-22 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (10, 6, 14, 10, '2021-12-16 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-22 3:33:00', '2021-12-22 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (11, 7, 14, 11, '2021-12-17 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-23 3:33:00', '2021-12-22 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (12, 8, 15, 12, '2021-12-18 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-24 3:33:00', '2021-12-22 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (13, 9, 16, 13, '2021-12-19 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-25 3:33:00', '2021-12-23 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (14, 9, 17, 14, '2021-12-20 3:33:30', 5, 'Arrived in perfect condition', 5, 'Nice person', '2021-12-26 3:33:00', '2021-12-24 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (15, 9, 17, 15, '2021-12-21 3:33:30', 4, 'Seller was good, game was ok', 4, 'Good person', '2021-12-27 3:33:00', '2021-12-25 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (16, 10, 17, 16, '2021-12-22 3:33:30', 3, 'Condition not as listed', 3, 'Ok person', '2021-12-28 3:33:00', '2021-12-26 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (17, 10, 18, 17, '2021-12-23 3:33:30', 2, 'Terrible communication', 2, 'Bad person', '2021-12-28 3:33:00', '2021-12-27 12:00:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (18, 10, 18, 18, '2021-12-24 3:33:30', 1, 'Just awful', 1, 'Terrible person', '2021-12-22 3:33:00', '2021-12-22 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (19, 19, 11, 19, '2021-12-25 3:33:30', 4, 'Seller was good, game was ok', 3, 'Good person', '2021-12-22 3:33:00', '2021-12-23 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (20, 19, 12, 20, '2021-12-26 3:33:30', 4, 'Seller was good, game was ok', 3, 'Good person', '2021-12-23 3:33:00', '2021-12-24 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (21, 19, 13, 21, '2021-12-27 3:33:30', 4, 'Seller was good, game was ok', 5, 'Good person', '2021-12-24 3:33:00', '2021-12-25 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (22, 19, 14, 22, '2021-12-28 3:33:30', 3, 'Seller was good, game was ok', 4, 'Good person', '2021-12-25 3:33:00', '2021-12-26 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (23, 20, 15, 23, '2021-12-29 3:33:30', 3, 'Seller was good, game was ok', 5, 'Good person', '2021-12-26 3:33:00', '2021-12-27 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (24, 20, 15, 24, '2021-12-30 3:33:30', 3, 'Seller was good, game was ok', 4, 'Good person', '2021-12-27 3:33:00', '2021-12-28 15:33:00');
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (25, 20, 16, 25, '2021-12-31 3:33:30', 4, 'Seller was good, game was ok', 2, 'Good person', '2021-12-28 3:33:00', '2021-12-29 15:33:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `payment` (`id`, `payment_date`, `amount`, `sale_id`) VALUES (1, '2021-12-11 3:33:30', 12.99, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (1, 'Action', 'Emphasizes physical challenges that require hand-eye coordination and motor skill to overcome.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (2, 'Action-adventure', 'Focus on exploration and usually involve item gathering, simple puzzle solving, and combat.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (3, 'Adventure', 'Normally require the player to solve various puzzles by interacting with people or the environment, most often in a non-confrontational way.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (4, 'Role-Playing', 'These games cast the player in the role of a character that grows in strength and experience over the course of the game.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (5, 'Simulation', 'Games generally designed to closely simulate aspects of a real or fictional reality.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (6, 'Strategy', 'Focus on gameplay requiring careful and skillful thinking and planning in order to achieve victory and the action scales from world domination to squad-based tactics.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (7, 'Sports', 'Games that simulate sports. The opposing team(s) can be controlled by other real life people or artificial intelligence.  ');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (8, 'MMO', 'Multiplayer online video game which is capable of supporting large numbers of players simultaneously');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (9, 'Sandbox', 'Game with a gameplay element that gives the player a great degree of creativity to complete tasks towards a goal within the game, if such a goal exists.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (10, 'Casino', 'Three general categories of casino games: gaming machines, table games, and random number games.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (11, 'Horror', 'Games that incorporate elements of horror fiction into their narrative, generally irrespective of the type of gameplay.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (1, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (2, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (3, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (4, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (5, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (6, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (7, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (8, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (9, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (10, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (11, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (12, 9);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (13, 10);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (14, 11);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (15, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (16, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (17, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (18, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (19, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (20, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (21, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (22, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (23, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (24, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (25, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (26, 11);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (27, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (28, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (29, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (30, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (31, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (32, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (33, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (34, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (35, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (36, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (37, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (38, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (39, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (40, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (41, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (42, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (43, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (44, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (45, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (46, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (47, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (48, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (49, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (50, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (51, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (52, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (53, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (54, 9);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (55, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (56, 11);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (57, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (58, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (59, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (60, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (61, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (62, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (63, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (64, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (65, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (66, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (67, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (68, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (69, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (70, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (71, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (72, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (73, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (74, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (75, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (76, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (77, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (78, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (79, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (80, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (81, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (82, 7);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (83, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (84, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (85, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (86, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (87, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (88, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (89, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (91, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (92, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (93, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (94, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (95, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (96, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (97, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (98, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (99, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (100, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (101, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (102, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (103, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (104, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (105, 9);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (106, 11);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (107, 10);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (108, 11);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (109, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (110, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (111, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (112, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (113, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (114, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (115, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (115, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (117, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (118, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (119, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (120, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (121, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (122, 1);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (123, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (124, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (125, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (126, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (127, 8);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (128, 9);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (129, 4);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (130, 5);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (131, 6);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (132, 3);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (133, 2);
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (134, 5);

COMMIT;

