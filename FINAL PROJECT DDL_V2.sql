-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LasVegas_Restaurants_COVID_v2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LasVegas_Restaurants_COVID_v2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LasVegas_Restaurants_COVID_v2` DEFAULT CHARACTER SET utf16 ;
-- -----------------------------------------------------
-- Schema LasVegas_Restaurants_COVID
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LasVegas_Restaurants_COVID
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LasVegas_Restaurants_COVID` ;
USE `LasVegas_Restaurants_COVID_v2` ;

-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID`.`dim_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID`.`dim_states` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID`.`dim_states` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(2) NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_address` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_address` (
  `business_id` VARCHAR(50) NOT NULL,
  `address` VARCHAR(30) NULL DEFAULT NULL,
  `state` VARCHAR(2) NOT NULL,
  `postal_code` INT(5) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `dim_states_state_id` INT NOT NULL,
  PRIMARY KEY (`business_id`),
  INDEX `fk_dim_address_dim_states1_idx` (`dim_states_state_id` ASC) VISIBLE,
  CONSTRAINT `fk_dim_address_dim_states1`
    FOREIGN KEY (`dim_states_state_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_categories` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_categories` (
  `category_id` INT(10) NOT NULL,
  `categories` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_covid_banner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_covid_banner` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_covid_banner` (
  `business_id` VARCHAR(50) NOT NULL,
  `covid_banner` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`business_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_delivery_takeout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_delivery_takeout` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_delivery_takeout` (
  `business_id` VARCHAR(50) NOT NULL,
  `delivery_or_takeout` VARCHAR(5) NULL DEFAULT NULL,
  `Grubhub_enabled` VARCHAR(5) NULL DEFAULT NULL,
  `restaurantsDelivery` VARCHAR(6) NULL DEFAULT NULL,
  `restaurantsTakeout` VARCHAR(6) NULL DEFAULT NULL,
  PRIMARY KEY (`business_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_yelp_reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_yelp_reviews` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_yelp_reviews` (
  `business_id` VARCHAR(50) NOT NULL,
  `xref_id` VARCHAR(50) NULL DEFAULT NULL,
  `yelp_stars` FLOAT NULL DEFAULT NULL,
  `yelp_review_count` INT(5) NULL DEFAULT NULL,
  PRIMARY KEY (`business_id`),
  INDEX `fk_dim_yelp_reviews_dim_zomato_reviews1` (`xref_id` ASC) VISIBLE,
  CONSTRAINT `fk_dim_yelp_reviews_dim_zomato_reviews1`
    FOREIGN KEY (`xref_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_zomato_reviews` (`xref_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_zomato_reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_zomato_reviews` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_zomato_reviews` (
  `xref_id` VARCHAR(50) NOT NULL,
  `zomato_review_count` INT(5) NULL DEFAULT NULL,
  `aggregate_rating` FLOAT NULL DEFAULT NULL,
  `user_rating_votes` INT(5) NULL DEFAULT NULL,
  PRIMARY KEY (`xref_id`),
  CONSTRAINT `fk_dim_zomato_reviews_dim_yelp_reviews1`
    FOREIGN KEY ()
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_yelp_reviews` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`fact_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`fact_data` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`fact_data` (
  `business_id` VARCHAR(50) NOT NULL,
  `category_id` INT(10) NULL DEFAULT NULL,
  `name` VARCHAR(300) NULL DEFAULT NULL,
  `weighted_average_stars` FLOAT NULL DEFAULT NULL,
  `total_reviews` INT(5) NULL DEFAULT NULL,
  INDEX `business_id` (`business_id` ASC) VISIBLE,
  INDEX `categories_fact_data_fk` (`category_id` ASC) VISIBLE,
  CONSTRAINT `address_fact_data_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_address` (`business_id`),
  CONSTRAINT `categories_fact_data_fk`
    FOREIGN KEY (`category_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_categories` (`category_id`),
  CONSTRAINT `covid_banner_fact_data_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_covid_banner` (`business_id`),
  CONSTRAINT `delivery_takeout_fact_data_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_delivery_takeout` (`business_id`),
  CONSTRAINT `total_reviews_fact_data_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_total_reviews` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `yelp_reviews_fact_data_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_yelp_reviews` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_data_dim_address1`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_address` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_data_dim_covid_banner1`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_covid_banner` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_data_dim_delivery_takeout1`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_delivery_takeout` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_data_dim_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_data_dim_yelp_reviews1`
    FOREIGN KEY (`business_id`)
    REFERENCES `LasVegas_Restaurants_COVID_v2`.`dim_yelp_reviews` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `LasVegas_Restaurants_COVID_v2`.`dim_daily_COVID_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_daily_COVID_states` ;

CREATE TABLE IF NOT EXISTS `LasVegas_Restaurants_COVID_v2`.`dim_daily_COVID_states` (
  `ID` VARCHAR(25) NOT NULL,
  `date` DATE NULL DEFAULT NULL,
  `state` VARCHAR(2) NULL DEFAULT NULL,
  `positive` FLOAT NULL DEFAULT NULL,
  `negative` FLOAT NULL DEFAULT NULL,
  `totalTestResults` FLOAT NULL DEFAULT NULL,
  `hospitalizedCurrently` FLOAT NULL DEFAULT NULL,
  `inIcuCurrently` FLOAT NULL DEFAULT NULL,
  `onVentilatorCurrently` FLOAT NULL DEFAULT NULL,
  `death` FLOAT NULL DEFAULT NULL,
  `lastUpdateEt` DATETIME NULL DEFAULT NULL,
  `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dim_states_state_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_dim_daily_COVID_states_dim_states1_idx` (`dim_states_state_id` ASC) VISIBLE,
  CONSTRAINT `fk_dim_daily_COVID_states_dim_states1`
    FOREIGN KEY (`dim_states_state_id`)
    REFERENCES `LasVegas_Restaurants_COVID`.`dim_states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;

USE `LasVegas_Restaurants_COVID` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
