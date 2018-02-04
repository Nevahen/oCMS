-- MySQL Script generated by MySQL Workbench
-- Sun Feb  4 22:31:53 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ocms
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ocms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ocms` DEFAULT CHARACTER SET utf8 ;
USE `ocms` ;

-- -----------------------------------------------------
-- Table `ocms`.`ocms_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_users` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `password` CHAR(64) NULL,
  `activated` TINYINT NULL DEFAULT 0,
  `password_reset_pending` TINYINT NULL,
  `password_reset_secret` CHAR(64) NULL,
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `idusers_UNIQUE` (`userid` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ocms`.`ocms_pages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_pages` (
  `page_id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NULL,
  `data` MEDIUMTEXT NULL,
  `parent_id` INT NULL,
  `status` TINYINT NOT NULL DEFAULT 0,
  `ocms_pagescol` VARCHAR(45) NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE INDEX `page_id_UNIQUE` (`page_id` ASC),
  INDEX `author_id_idx` (`author_id` ASC),
  CONSTRAINT `author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `ocms`.`ocms_users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ocms`.`ocms_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_tags` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `category_id_UNIQUE` (`tag_id` ASC),
  UNIQUE INDEX `category_name_UNIQUE` (`tag_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ocms`.`ocms_settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_settings` (
  `setting_id` INT NOT NULL AUTO_INCREMENT,
  `setting_key` VARCHAR(90) NOT NULL,
  `setting_value` MEDIUMTEXT NULL,
  PRIMARY KEY (`setting_id`),
  UNIQUE INDEX `setting_id_UNIQUE` (`setting_id` ASC),
  UNIQUE INDEX `setting_key_UNIQUE` (`setting_key` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ocms`.`ocms_permalinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_permalinks` (
  `permalink_id` INT NOT NULL AUTO_INCREMENT,
  `page_id` INT NULL,
  `permalink` VARCHAR(200) NULL,
  PRIMARY KEY (`permalink_id`),
  UNIQUE INDEX `permalink_id_UNIQUE` (`permalink_id` ASC),
  UNIQUE INDEX `page_id_UNIQUE` (`page_id` ASC),
  CONSTRAINT `page_id`
    FOREIGN KEY (`page_id`)
    REFERENCES `ocms`.`ocms_pages` (`page_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ocms`.`ocms_page_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocms`.`ocms_page_tags` (
  `ocms_page_categories` INT NOT NULL,
  `page_id` INT NULL,
  `tag_id` INT NULL,
  PRIMARY KEY (`ocms_page_categories`),
  INDEX `category_idx` (`tag_id` ASC),
  INDEX `page_idx` (`page_id` ASC),
  UNIQUE INDEX `catpage` (`page_id` ASC, `tag_id` ASC),
  CONSTRAINT `category`
    FOREIGN KEY (`tag_id`)
    REFERENCES `ocms`.`ocms_tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `page`
    FOREIGN KEY (`page_id`)
    REFERENCES `ocms`.`ocms_pages` (`page_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
