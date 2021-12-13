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
  `description` TEXT NULL,
  `max_players` INT NULL,
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
  `id` INT NOT NULL,
  `game_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `description` TEXT NULL,
  `sale_price` DECIMAL(4,2) NULL,
  `available` TINYINT NULL,
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
  `description` VARCHAR(45) NULL,
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `rating` (`id`, `name`, `description`) VALUES (1, 'E', 'Game is rated for everyone.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game` (`id`, `title`, `description`, `max_players`, `user_id`, `rating_id`, `image_url`) VALUES (1, 'Call of Duty: Vanguard', 'Description of game goes here. ', 4, 1, 1, 'game image url goes here.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `platform`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `platform` (`id`, `name`) VALUES (1, 'Playstation');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game_inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game_inventory` (`id`, `game_id`, `user_id`, `description`, `sale_price`, `available`, `rent_price`, `platform_id`, `condition_new`) VALUES (1, 1, 1, 'Sellers personal description goes here.', 25.99, 1, 2.99, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sale`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `sale` (`id`, `buyer_id`, `seller_id`, `game_inventory_id`, `sale_date`, `rating_by_buyer`, `comment_by_buyer`, `rating_by_seller`, `comment_by_seller`, `return_by_date`, `date_returned`) VALUES (1, 1, 2, 1, '2021-12-11 3:33:30', 5, 'Fast shipping!', 5, 'Payment went through!', '2021-12-22', '2021-12-21');

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
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (1, 'Action', 'Heavy action and constant gameplay');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `eternitygamehubdb`;
INSERT INTO `game_genre` (`game_id`, `genre_id`) VALUES (1, 1);

COMMIT;

