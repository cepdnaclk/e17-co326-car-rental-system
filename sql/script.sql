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


/*				  VIEWS, TRIGGERS, STORED PROCEDURES			*/


/*                          VEHICLE OWNER                       */

/*REGISTER NEW VEHICLE OWNER*/
DELIMITER $$
CREATE PROCEDURE REGISTER_VEHICLE_RENTER (IN fn VARCHAR(30), IN mn VARCHAR(30), IN ln VARCHAR(30), IN addr VARCHAR(100),
                                          IN emailin VARCHAR(50), IN bankin VARCHAR(20), IN branchin VARCHAR(20), IN acc_noin VARCHAR(15))
BEGIN

    INSERT INTO VEHICLE_OWNER(f_name, m_name, l_name, address, email, registered_date, bank, branch, acc_no) 
    VALUES (fn, mn, ln, addr, emailin, CURDATE(), bankin, branchin, acc_noin);

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                             VEHICLE                         */

/*REGISTER NEW VEHICLE*/
DELIMITER $$
CREATE PROCEDURE REGISTER_VEHICLE (IN license_plate VARCHAR(11), IN engine CHAR(10), IN cat CHAR(2), IN namein VARCHAR(12), IN totkm INT,
                                   IN gps VARCHAR(150), IN max INT, IN owner CHAR(5))
BEGIN

    INSERT INTO VEHICLE(license_plate_no, engine_serial_no, category, name, total_kms, last_service_date, last_service_kms,
                        gps_link, max_passengers, owner_id, registered_date, availability)
    VALUES (license_plate, engine, cat, namein, totkm, CURDATE(), totkm, gps, max, owner, CURDATE(), TRUE);

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              CUSTOMER                        */

/*REGISTER NEW CUSTOMER*/
DELIMITER $$
CREATE PROCEDURE REGISTER_CUSTOMER (IN nicno CHAR(10), IN fn VARCHAR(30), IN mn VARCHAR(30), IN ln VARCHAR(30), IN addr VARCHAR(100),
                                    IN em VARCHAR(50), IN drive CHAR(8))
BEGIN

    INSERT INTO CUSTOMER 
    VALUES (nicno, fn, mn, ln, addr, em, drive, CURDATE());

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              BOOKING                            */

/*MAKE NEW BOOKING*/
DELIMITER $$
CREATE PROCEDURE MAKE_BOOKING(IN vehicle CHAR(5), IN customer CHAR(10), IN bookdate DATE, IN returndate DATE)
BEGIN

    DECLARE pack CHAR(7);
    SET pack =  (SELECT pack_id FROM PACKAGE 
                WHERE PACKAGE.vehicle_category = (SELECT category FROM VEHICLE WHERE id = vehicle)
                AND pack_name LIKE 
                CASE WHEN DATEDIFF(returndate, bookdate) < 5 THEN '%Daily'
                      WHEN DATEDIFF(returndate, bookdate) >=5 AND  DATEDIFF(returndate, bookdate) < 21 THEN '%Weekly'
                      ELSE '%Monthly' END );
    

    INSERT INTO BOOKING(booking_done_date, packID, vehicleID, customerNIC, booked_date, return_date, completed)
    VALUES (CURDATE(), pack, vehicle, customer, bookdate, returndate, 'N');

END$$
DELIMITER ;


/*VIEW DETAILS OF A BOOKING*/
DELIMITER //
CREATE PROCEDURE VIEW_BOOKING (IN book_id CHAR(10))
BEGIN

    SELECT booking_id  AS 'BOOKING ID', customerNIC AS 'CUSTOMER NIC', booking_done_date AS 'BOOKING DONE DATE', 
    pack_name AS PACKAGE, VEHICLE.id AS 'VEHICLE ID', name AS VEHICLE, license_plate_no AS 'NUMBER PLATE', booked_date AS 'BOOKED DATE',
    return_date AS 'RETURN DATE', key_money AS 'KEY MONEY'
    FROM BOOKING, PACKAGE, VEHICLE
    WHERE BOOKING.packID = PACKAGE.pack_id AND BOOKING.vehicleID = VEHICLE.id
    AND BOOKING.booking_id = book_id;
    
END//
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              TRANSACTION                         */

/*RENT A VEHICLE ON A BOOKING*/
DELIMITER $$
CREATE PROCEDURE RENT_VEHICLE (IN booking CHAR(10), IN keymoney DECIMAL(7,2))
BEGIN

    SET @v = (SELECT total_kms FROM VEHICLE WHERE id = (SELECT vehicleID FROM BOOKING WHERE booking_id=booking) );
    INSERT INTO TRANSACTION(booking_id, start_meter_reading, paid_key_money)
    VALUES (booking, @v, keymoney);

END$$
DELIMITER ;


/*UPDATE TRANSACTION AFTER BOOING IS COMPLETED*/
DELIMITER $$
CREATE PROCEDURE RETURN_VEHICLE (IN book CHAR(10), IN meter_read INT, IN dam DECIMAL(7,2), IN descr VARCHAR(100))
BEGIN

    SET @pack = (SELECT packID FROM BOOKING WHERE booking_id = book);
    SET @maxi = (SELECT max_kms FROM PACKAGE WHERE pack_id = @pack);
    SET @dailyrent = (SELECT rent FROM PACKAGE WHERE pack_id = @pack);
    SET @maxrent = (SELECT charge_per_extra_km FROM PACKAGE WHERE pack_id = @pack);
    SET @date = (SELECT booked_date FROM BOOKING WHERE booking_id = book);

    UPDATE TRANSACTION 
    SET end_meter_reading = meter_read,

    extra_kms = (CASE 
                WHEN (end_meter_reading-start_meter_reading)> (@maxi * (1 + DATEDIFF(CURDATE(), @date)))
                THEN (end_meter_reading - (@maxi * (1 + DATEDIFF(CURDATE(), @date))) )
                ELSE 0 END),

    total_rent = @dailyrent * (1 + DATEDIFF(CURDATE(), @date)) + extra_kms * @maxrent,

    damage = dam,
    to_pay = total_rent + damage - paid_key_money, 
    return_description = descr, 
    owner_commision = total_rent * 0.7

    WHERE booking_id = book;

END$$
DELIMITER ;


/*AUTO UPDATE BOOKING completed TRIGGER*/
DELIMITER $$
CREATE TRIGGER UPDATE_BOOKING_ON_COMPLETION
AFTER UPDATE ON TRANSACTION
FOR EACH ROW
BEGIN

    UPDATE BOOKING
    SET BOOKING.completed = 'Y'
    WHERE BOOKING.booking_id = NEW.booking_id;

END$$
DELIMITER ;


/*AUTO UPDATE VEHICLE kms TRIGGER*/
DELIMITER $$
CREATE TRIGGER UPDATE_VEHICLE_ON_COMPLETION
AFTER UPDATE ON TRANSACTION
FOR EACH ROW
BEGIN

    UPDATE VEHICLE
    SET total_kms = NEW.end_meter_reading
    WHERE VEHICLE.id = (SELECT VehicleID FROM BOOKING WHERE BOOKING.booking_id = NEW.booking_id);

END$$
DELIMITER ;


/*Get a View of a Transaction*/
DELIMITER $$
CREATE PROCEDURE VIEW_TRANSACTION (IN book CHAR(10))
BEGIN

    SELECT booking_id AS 'BOOKING ID', paid_key_money AS 'KEY MONEY PAID', start_meter_reading AS 'START METER READING', end_meter_reading AS 'END METER READING', 
    extra_kms AS 'EXTRA KMS', total_rent AS 'TOTAL RENT', damage AS 'DAMAGE', to_pay AS 'AMOUNT TO BE PAID', 
    return_description AS 'DESCRIPTION'
    FROM TRANSACTION WHERE booking_id = book;

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                  POPULATE DATA                          */
/*This is for Testing purpose only. Remove this section  if not for testing*/

INSERT INTO PACKAGE VALUES
('C1 0001','Economy Daily'           , 'C1',  5000.00, 2000.00, 100, 16.00),
('C1 0002','Economy Weekly'          , 'C1',  7500.00, 1800.00,  80, 16.00),
('C1 0003','Economy Monthly'         , 'C1', 10000.00, 1200.00,  80, 15.00),
('C2 0001','Affordable Comfy Daily'  , 'C2',  5000.00, 2500.00, 100, 16.00),
('C2 0002','Affordable Comfy Weekly' , 'C2',  7500.00, 2100.00,  80, 16.00),
('C2 0003','Affordable Comfy Monthly', 'C2', 15000.00, 1650.00,  80, 15.00),
('C3 0001','Premier Daily'           , 'C3',  6500.00, 3000.00, 100, 17.00),
('C3 0002','Premier Weekly'          , 'C3', 10000.00, 2500.00,  80, 17.00),
('C3 0003','Premier Monthly'         , 'C3', 18000.00, 2100.00,  80, 16.00),
('V1 0001','Economy Daily'           , 'V1',  6500.00, 3500.00, 100, 18.00),
('V1 0002','Economy Weekly'          , 'V1', 10000.00, 3000.00,  80, 17.00),
('V1 0003','Economy Monthly'         , 'V1', 20000.00, 2500.00,  80, 16.00),
('V2 0001','Affordable Comfy Daily'  , 'V2',  6500.00, 4500.00, 100, 20.00),
('V2 0002','Affordable Comfy Weekly' , 'V2', 10000.00, 4000.00,  80, 18.00),
('V2 0003','Affordable Comfy Monthly', 'V2', 20000.00, 3500.00,  80, 17.00);


CALL REGISTER_VEHICLE_RENTER ("Sarath", "Kumara", "De Silva", "16/2,Mahara,Kadawtha", "sarath25@gmail.com", "Sampath", "Kiribathgoda",  '001010011327');
CALL REGISTER_VEHICLE_RENTER ("Samantha", "Dalas", "Alahaoon", "166/7,Miriswatta,Gampaha", "Samanthadalahaoon@yahoo.com", "Peoples", "Miriswatta", '204200100091326');
CALL REGISTER_VEHICLE_RENTER ("Dinithi", "Devni", "Perera", "12/C,Salmal rd,Kiribathkumbura", "devniperera@hotmail.com", "BOC", "Kandy", '198204376489');
CALL REGISTER_VEHICLE_RENTER ("Hemantha", "Chandrarathna", "Kodagoda", "155/8,Vihara Mw,Kelaniya", "hemanthakodagoda@gmail.com", "Peoples", "Kelaniya", '109378490137649');
CALL REGISTER_VEHICLE_RENTER ("Nilantha", "Minidu", "Silva", "46/3,Santha rd,Kottawa", "nilanthasilva@gmal.com", "Peoples", "Kottawa", '936517263865429');
CALL REGISTER_VEHICLE_RENTER ("Harendra", "Kasun", "Akalanka", "27/C,Meewathura rd,Peradeniya", "kasunharendra1880@hotmail.com", "Peoples", "Peradeniya", '993651736527164');
CALL REGISTER_VEHICLE_RENTER ("Sewwandi", "Sachini", "Mudalige", "53/A,Mihindu Mw,Rajagiriya", "sachini23mudalige@yahoo.com", "Sampath", "Rajagiriya", '183461083746');
CALL REGISTER_VEHICLE_RENTER ("Janaka", NULL, "Gamage", "143/5,Araliya rd,Wattala", "janakagamage@gmail.com", "HSBC", "Wattala", '126389165429');


CALL REGISTER_VEHICLE('WP CAC 6322', 'H22AM03737', 'C1', 'Viva Elite', 105003,'https://www.google.lk/maps/V0001', 4, 'VO001');
CALL REGISTER_VEHICLE('WP PF 4423',  'R78AM02312', 'V1', 'Nissan NV200', 106893, 'https://www.google.lk/maps/V0008', 8, 'VO001');
CALL REGISTER_VEHICLE('WP CAE 1515', 'H22AM06737', 'C2', 'Wagon R', 75030, 'https://www.google.lk/maps/V0002', 4, 'VO002');
CALL REGISTER_VEHICLE('WP CAB 1127', 'H76BR03457', 'C3', 'Toyota Prius', 115323, 'https://www.google.lk/maps/V0009', 5, 'VO003');
CALL REGISTER_VEHICLE('CP PG 6356',  'R66AM03677', 'V1', 'Nissan NV200', 91067, 'https://www.google.lk/maps/V0015', 8, 'VO004');
CALL REGISTER_VEHICLE('WP PF 6572',  'R22TY04567', 'V2', 'KDH', 105678, 'https://www.google.lk/maps/V0019', 10, 'VO005');
CALL REGISTER_VEHICLE('WP CAA 2243', 'H11AM03247', 'C1', 'Maruti Alto', 105453, 'https://www.google.lk/maps/V0013', 3, 'VO006');
CALL REGISTER_VEHICLE('WP KV 4562',  'H11AM56737', 'C1', 'Maruti Alto', 144578, 'https://www.google.lk/maps/V0012', 3, 'VO007');
CALL REGISTER_VEHICLE('WP CAB 5476', 'T76VF37456', 'C3', 'Honda Civic', 104503, 'https://www.google.lk/maps/V0020', 5, 'VO008');
CALL REGISTER_VEHICLE('WP CAG 1856', 'H98AM06754', 'C2', 'Toyota Aqua', 67003, 'https://www.google.lk/maps/V0011', 4, 'VO008');
/* ------------------------------------------------------------------------------- */