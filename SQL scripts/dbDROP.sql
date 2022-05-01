/*This is the dbDROP.sql file, Team-12, Members:-1)Pranav Medhi(Student ID:-1001756326) 2)Dhaval Wagela(Student ID:-1001769786)*/
/* This file contains all the queries which dropped all the triggers, constraints, views, indexes and tables from the database */

drop trigger test_before_inserting_phone_for_users;
drop trigger test_before_inserting_ssn;
drop trigger test_before_inserting_email_for_employee;
drop trigger test_before_inserting_phone_for_branch;

alter table contacts drop foreign key UserContactSSN;
alter table employee drop foreign key EmployeeSSN;

drop view APARTMENT_NEARBY_PLACES;

drop table WORKS_AT;
drop table CUSTOMER_SERVICE_OFFICER;
drop table MANAGER;
drop table BRANCH;
drop table INTERIORS;
drop table NEARBY;
drop table FACILITIES;
drop table DEPENDENT;
drop table SEARCHES;
drop table ALLOTTED;
drop table AGENT;
drop table CONTACTS;
drop table EMPLOYEE;
drop table SELLER;
drop table APARTMENTS;
drop table BUYER;

alter table user drop index Account_Id_idx;

drop table USER;

