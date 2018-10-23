-- Sakila Database Warehouse Schema Edilson Alzemand

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS sakila_dwh;
CREATE SCHEMA sakila_dwh;
USE sakila_dwh;

--
-- Table structure for table `dim_customer`
--

CREATE TABLE dim_customer (
  customer_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  cust_first_name VARCHAR(45),
  cust_last_name VARCHAR(45),
  address VARCHAR(50),
  address2 VARCHAR(50),
  city VARCHAR(50),
  district VARCHAR(20),
  zip VARCHAR(10) DEFAULT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(50),
  active CHAR(3),
  cust_valid_from DATE,
  cust_valid_to DATE,
  PRIMARY KEY  (customer_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_staff`
--

CREATE TABLE dim_staff (
  staff_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  staff_id TINYINT UNSIGNED NOT NULL,
  staff_fname VARCHAR(45) NOT NULL,
  staff_lname VARCHAR(45) NOT NULL,
  staff_store_id INT,
  staff_versn_no SMALLINT,
  active CHAR(3),
  staff_valid_from DATE,
  staff_valid_to DATE,
  PRIMARY KEY  (staff_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_date`
--

CREATE TABLE dim_date (
  date_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  month_abbrev CHAR(3),
  year4 year,
  day_of_month TINYINT,
  day_of_yr SMALLINT,
  day_of_wk CHAR(3),
  wk_in_month TINYINT,
  wk_in_yr TINYINT,
  month_number TINYINT,
  yr_month CHAR(7),
  yr_month_abbrev CHAR(8),
  qtr_name CHAR(2),
  qtr_number TINYINT,
  year_qtr CHAR(7),
  PRIMARY KEY  (date_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_time`
--

CREATE TABLE dim_time (
  time_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  time_val TIME,
  hrs24 TINYINT,
  hrs12 TINYINT,
  minutes TINYINT,
  seconds TINYINT,
  ampm CHAR(3),
  PRIMARY KEY  (time_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_store`
--

CREATE TABLE dim_store (
  store_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  store_id INT UNSIGNED NOT NULL,
  store_city VARCHAR(50),
  store_district VARCHAR(20),
  store_zip VARCHAR(10),
  store_country VARCHAR(50),
  store_phone VARCHAR(20),
  store_mgr_id INT,
  st_mgr_fname VARCHAR(45),
  st_mgr_lname VARCHAR(45),
  st_valid_from DATE,
  st_valid_to DATE,
  PRIMARY KEY  (store_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_film`
--

CREATE TABLE dim_film (
  film_key INT UNSIGNED NOT NULL AUTO_INCREMENT,
  film_id INT UNSIGNED NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  release_year YEAR(4) DEFAULT NULL,
  film_language VARCHAR(20),
  film_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
  rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  length SMALLINT UNSIGNED DEFAULT NULL,
  replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  PRIMARY KEY  (film_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `fact_rental`
--

CREATE TABLE fact_rental (
  rental_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_key INTEGER UNSIGNED NOT NULL,
  staff_key INTEGER UNSIGNED,
  rent_date_key INTEGER UNSIGNED NOT NULL,
  rtn_date_key INTEGER UNSIGNED,
  rtn_time_key INTEGER UNSIGNED,
  store_key INTEGER UNSIGNED,
  film_key INTEGER UNSIGNED,
  count_rentals INTEGER UNSIGNED,
  count_returns INTEGER UNSIGNED,
  rent_duration INTEGER UNSIGNED,
  PRIMARY KEY  (rental_id),
  CONSTRAINT `fk_customer` FOREIGN KEY (customer_key) REFERENCES dim_customer (customer_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_staff` FOREIGN KEY (staff_key) REFERENCES dim_staff (staff_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_rent_date` FOREIGN KEY (rent_date_key) REFERENCES dim_date (date_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_return_date` FOREIGN KEY (rtn_date_key) REFERENCES dim_date (date_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_time` FOREIGN KEY (rtn_time_key) REFERENCES dim_time (time_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_store` FOREIGN KEY (store_key) REFERENCES dim_store (store_key) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_film` FOREIGN KEY (film_key) REFERENCES dim_film (film_key) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


