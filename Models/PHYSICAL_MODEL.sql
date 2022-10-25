/*				DATABASE PROJECT PHYSICAL MODEL			*/
/*				  DATABASE DEVELOPMENT SCRIPT			*/


CREATE DATABASE RENT_A_CAR;
USE RENT_A_CAR;


/*                          VEHICLE OWNER RELATION                        */

CREATE TABLE VEHICLE_OWNER_SEQ (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );


CREATE TABLE VEHICLE_OWNER (
    id CHAR(5) NOT NULL,
    f_name VARCHAR(30) NOT NULL,
    m_name VARCHAR(30),
    l_name VARCHAR(30) NOT NULL,
    address VARCHAR(100) NOT NULL,
    email VARCHAR(50),
    registered_date DATE,
    bank VARCHAR(20) NOT NULL,
    branch VARCHAR(20) NOT NULL,
    acc_no VARCHAR(15) NOT NULL,
    PRIMARY KEY (id) );


DELIMITER $$
CREATE TRIGGER TRIG_VEHICLE_OWNER_ID 
BEFORE INSERT ON VEHICLE_OWNER
FOR EACH ROW
BEGIN
    INSERT INTO VEHICLE_OWNER_SEQ VALUES (NULL);
    SET NEW.id = CONCAT('VO', LPAD(LAST_INSERT_ID(),3,'0'));
END$$
DELIMITER ;


CREATE TABLE OWNER_TEL_NO (
    owner_id CHAR (5) NOT NULL,
    owner_tel_no CHAR (10) NOT NULL,
    PRIMARY KEY(owner_id,owner_tel_no),
    FOREIGN KEY (owner_id) REFERENCES VEHICLE_OWNER (id) ON UPDATE CASCADE );

/*  --------------------------------------------------------------------------- */


/*                          VEHICLE RELATION                      */

CREATE TABLE VEHICLE_SEQ (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );


CREATE TABLE VEHICLE (
    id CHAR(5) NOT NULL,
    license_plate_no VARCHAR(11) NOT NULL UNIQUE,
    engine_serial_no CHAR(10) NOT NULL UNIQUE,
    category CHAR(2) NOT NULL,
    name VARCHAR(12) NOT NULL,
    total_kms INT NOT NULL,
    last_service_date DATE,
    last_service_kms INT,
    gps_link VARCHAR(150) UNIQUE,
    max_passengers INT NOT NULL,
    owner_id CHAR(5) NOT NULL,
    registered_date DATE,
    availability BOOLEAN NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES VEHICLE_OWNER (id) ON UPDATE CASCADE );


DELIMITER $$
CREATE TRIGGER TRIG_VEHICLE_ID 
BEFORE INSERT ON VEHICLE
FOR EACH ROW
BEGIN
    INSERT INTO VEHICLE_SEQ VALUES (NULL);
    SET NEW.id = CONCAT('V', LPAD(LAST_INSERT_ID(),4,'0'));
END$$
DELIMITER ;

/* ----------------------------------------------------------------------------- */



/*                      CUSTOMER RELATION                           */

CREATE TABLE CUSTOMER (
    nic CHAR(10) NOT NULL,
    f_name VARCHAR(30) NOT NULL,
    m_name VARCHAR(30) ,
    l_name VARCHAR(30) NOT NULL,
    address VARCHAR(100) NOT NULL,
    email VARCHAR(50),
    driving_license_no CHAR(8) NOT NULL,
    registered_date DATE,
    PRIMARY KEY (nic) );


CREATE TABLE CUSTOMER_TEL_NO (
    cx_nic CHAR (10) NOT NULL,
    cx_tel_no CHAR (10) NOT NULL,
    PRIMARY KEY(cx_nic,cx_tel_no),
    FOREIGN KEY (cx_nic) REFERENCES  CUSTOMER (nic) ON UPDATE CASCADE );

/* ----------------------------------------------------------------------------- */



/*                              PACKAGE RELATION                     */

CREATE TABLE PACKAGE (
    pack_id CHAR(7) NOT NULL,
    pack_name VARCHAR(30) NOT NULL,
    vehicle_category CHAR(2) NOT NULL,
    key_money DECIMAL(7,2) NOT NULL,
    rent DECIMAL(6,2) NOT NULL,
    max_kms INT NOT NULL,
    charge_per_extra_km DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (pack_id) );

/* ------------------------------------------------------------------------------ */



/*                              BOOKING RELATION                    */

CREATE TABLE BOOKING_SEQ (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );


CREATE TABLE BOOKING (
    booking_id CHAR(10) NOT NULL,
    booking_done_date DATE NOT NULL,
    packID CHAR(7) NOT NULL,
    vehicleID CHAR(5) NOT NULL,
    customerNIC CHAR(10) NOT NULL,
    booked_date DATE NOT NULL,
    return_date DATE,
    completed CHAR(1) NOT NULL,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (packID) REFERENCES PACKAGE (pack_id) ON UPDATE CASCADE,
    FOREIGN KEY (vehicleID) REFERENCES VEHICLE (id) ON UPDATE CASCADE,
    FOREIGN KEY (customerNIC) REFERENCES CUSTOMER (nic) ON UPDATE CASCADE );


DELIMITER $$
CREATE TRIGGER TRIG_BOOKING_ID 
BEFORE INSERT ON BOOKING
FOR EACH ROW
BEGIN
    INSERT INTO BOOKING_SEQ VALUES (NULL);
    SET NEW.booking_id = CONCAT('B', LPAD(LAST_INSERT_ID(),9,'0'));
END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */



/*                              TRANSACTION RELATION                */

CREATE TABLE TRANSACTION (
    booking_id CHAR(10) NOT NULL,
    start_meter_reading INT,
    paid_key_money DECIMAL(7,2),
    end_meter_reading INT,
    extra_kms INT, 
    total_rent DECIMAL(8,2),
    damage DECIMAL(8,2),
    to_pay DECIMAL(8,2),
    return_description VARCHAR(100),
    owner_commision DECIMAL(8,2),
    PRIMARY KEY (booking_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING (booking_id) );

/* ------------------------------------------------------------------------------- */