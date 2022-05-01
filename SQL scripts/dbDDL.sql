/*This is the dbDDL.sql file, Team-12 ,Members:-1)Pranav Medhi(Student ID:-1001756326) 2)Dhaval Wagela(Student ID:-1001769786)*/
/* This file will contains all the sql statement related to creating tables and view objects*/
 
/* This file contains MySQL queries. */

/* Create tables */

/* 1. User */
create table USER (SSN INT, Account_Id VARCHAR(20), FName VARCHAR(20), LName VARCHAR(20), Contact_no NUMERIC(10), PRIMARY KEY(SSN, Account_Id), INDEX Account_Id_idx(Account_Id));

DELIMITER //
CREATE TRIGGER `test_before_inserting_ssn` BEFORE INSERT ON USER
FOR EACH ROW
BEGIN
    IF LENGTH(new.SSN) != 9 THEN
         SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid SSN' ;
    END IF;
END
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `test_before_inserting_phone_for_users` BEFORE INSERT ON USER
FOR EACH ROW
BEGIN
    IF LENGTH(new.Contact_no) != 10 THEN
         SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid contact number' ;
    END IF;
END
//
DELIMITER ;

/* 2. Buyer */
create table BUYER (BSSN INT, Available_Budget INT, No_of_Dependents int, Account_Id VARCHAR(20), FOREIGN KEY (BSSN) REFERENCES USER(SSN), FOREIGN KEY (Account_Id) REFERENCES USER(Account_Id));

/* 3. Apartments */
create table APARTMENTS (Apt_Id VARCHAR(20) PRIMARY KEY, Area NUMERIC(10), Cost INT, No_of_Bedrooms INT, Floor_No INT, Street VARCHAR(20), City VARCHAR(20), Apt_No INT);

/* 4. Seller */
create table SELLER (SSSN INT, Account_Id VARCHAR(20), Max_Price INT, Min_Price INT, Fixed_Price INT, Rent_Cost INT, Apt_Id VARCHAR(20), Lease_Duration VARCHAR(20), FOREIGN KEY (SSSN) REFERENCES USER(SSN), FOREIGN KEY (Account_Id) REFERENCES USER(Account_Id), FOREIGN KEY (Apt_Id) REFERENCES APARTMENTS(Apt_Id));

/* 5. Employee */
create table EMPLOYEE (SSN INT, CONSTRAINT EmployeeSSN FOREIGN KEY (SSN) REFERENCES USER(SSN), Employee_Id VARCHAR(20) PRIMARY KEY, FName VARCHAR(20), LName VARCHAR(20), Joining_Date DATE, Email_Id VARCHAR(40), Sex CHAR(1), Date_Of_Birth DATE);

DELIMITER //
CREATE TRIGGER `test_before_inserting_email_for_employee` BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF new.Email_Id NOT LIKE '%@%.com' THEN
         SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid EmailId' ;
    END IF;
END
//
DELIMITER ;

/* 6. Contacts */
create table CONTACTS (SSN INT, BSSN int, CONSTRAINT UserContactSSN FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN), Employee_Id VARCHAR(20), FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id), Account_Id VARCHAR(20), FOREIGN KEY (BSSN) REFERENCES BUYER(BSSN), FOREIGN KEY (Account_Id) REFERENCES BUYER(Account_Id));

/* 7. Agent */
create table AGENT (SSN INT,  FOREIGN KEY (SSN) REFERENCES USER(SSN), Employee_Id VARCHAR(20), Years_of_Experience INT, No_of_Sales INT, Alloted_Sellers INT, FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id));

/* 8. Allotted */
create table ALLOTTED (SSN INT, SSSN INT, FOREIGN KEY (SSN) REFERENCES AGENT(SSN), Employee_Id VARCHAR(20), FOREIGN KEY (Employee_Id) REFERENCES AGENT(Employee_Id), Account_Id VARCHAR(20), FOREIGN KEY (Account_Id) REFERENCES SELLER(Account_Id), FOREIGN KEY (SSSN) REFERENCES SELLER(SSSN));

/* 9. Searches */
create table SEARCHES (Apt_Id VARCHAR(20), BSSN int, Account_Id VARCHAR(20), FOREIGN KEY (Apt_Id) REFERENCES APARTMENTS(Apt_Id), FOREIGN KEY (Account_Id) REFERENCES BUYER(Account_Id), FOREIGN KEY (BSSN) REFERENCES BUYER(BSSN));

/* 10. Dependent */
create table DEPENDENT (Relationship VARCHAR(20), Sex CHAR(1), BSSN int, Account_Id VARCHAR(20), FOREIGN KEY (Account_Id) REFERENCES BUYER(Account_Id), FOREIGN KEY (BSSN) REFERENCES BUYER(BSSN));

/* 11. Facilities */
create table FACILITIES (Apt_Id VARCHAR(20), Gym CHAR(3), Soft_Water CHAR(3), Pool CHAR(3), Parking CHAR(3), FOREIGN KEY (Apt_Id) REFERENCES APARTMENTS(Apt_Id));

/* 12. Nearby */
create table NEARBY (Apt_Id VARCHAR(20), Places VARCHAR(30), FOREIGN KEY (Apt_Id) REFERENCES APARTMENTS(Apt_Id));

/* 13. Interiors */
create table INTERIORS (Apt_Id VARCHAR(20), Architecture_type VARCHAR(15), Floor_plan VARCHAR(5), Air_Conditioning CHAR(3), Ceiling_height INT, FOREIGN KEY (Apt_Id) REFERENCES APARTMENTS(Apt_Id));

/* 14. Branch */
create table BRANCH (Branch_Id VARCHAR(20) PRIMARY KEY, Street VARCHAR(20), Contact_no NUMERIC(10) UNIQUE, City VARCHAR(20), State VARCHAR(20));

DELIMITER //
CREATE TRIGGER `test_before_inserting_phone_for_branch` BEFORE INSERT ON BRANCH
FOR EACH ROW
BEGIN
    IF LENGTH(new.Contact_no) != 10 THEN
         SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid contact number' ;
    END IF;
END
//
DELIMITER ;

/* 15. Manager */
create table MANAGER (Employee_Id VARCHAR(20), FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id), SSN INT, FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN));

/* 16. Customer Service Officer */
create table CUSTOMER_SERVICE_OFFICER (Employee_Id VARCHAR(20), FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id), SSN int, FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN));

/* 17. Works_at */
create table WORKS_AT (Employee_Id VARCHAR(20), FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id), SSN int, FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN), Hours INT, Branch_Id VARCHAR(20), FOREIGN KEY (Branch_Id) REFERENCES BRANCH(Branch_Id));

/* 18. Apartment's Nearby Places */
create view APARTMENT_NEARBY_PLACES as select apartments.Apt_Id, apartments.area, apartments.cost, apartments.no_of_bedrooms,nearby.places from NEARBY, APARTMENTS where nearby.apt_id = apartments.apt_id;

