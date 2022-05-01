/*This is the dbSQL.sql file, Team-12

Members:- 
1)Dhaval Wagela (Student ID:-1001769786)
2)Pranav Medhi (Student ID:-1001756326)

*/
/* This file contains SQL Queries to fetch the data */

/* 1. Show the apartments in Arlington, TX with is located near a grocery store  */

select * from apartments where apt_id IN (select apt_id from apartment_nearby_places where city LIKE 'Arlington' AND places LIKE 'GROCERY_STORE');

/* 

Output:

+---------+------+--------+----------------+----------+-----------------+-----------+--------+
| Apt_Id  | Area | Cost   | No_of_Bedrooms | Floor_No | Street          | City      | Apt_No |
+---------+------+--------+----------------+----------+-----------------+-----------+--------+
| 1009APT | 2000 | 100030 |              3 |        2 | 214 Prairie Rd. | Arlington |    201 |
+---------+------+--------+----------------+----------+-----------------+-----------+--------+


*/


/* 2. Show an apartment be found in Dallas, TX that costs under 10000$ and has a playschool nearby. */ 

select * from apartments where cost < 100000 AND apt_id IN (select apt_id from apartment_nearby_places where city LIKE 'Dallas' AND places LIKE 'PLAY_SCHOOL');

/* 

Output:

+---------+------+-------+----------------+----------+---------------------+--------+--------+
| Apt_Id  | Area | Cost  | No_of_Bedrooms | Floor_No | Street              | City   | Apt_No |
+---------+------+-------+----------------+----------+---------------------+--------+--------+
| 1010APT | 1200 | 90000 |              3 |        2 | 219 University Lane | Dallas |    202 |
+---------+------+-------+----------------+----------+---------------------+--------+--------+

*/

/* 3. Show the top 5 agents with the highest amount of experience.  */

select e.Employee_id, e.Fname, e.Lname, e.Email_id, a.SSN, a.Years_of_Experience, a.No_of_Sales from Employee as e INNER JOIN Agent as a on a.employee_id = e.Employee_id order by a.Years_of_Experience desc LIMIT 5;


/*

Output:

+-------------+---------+----------+-----------------------------+-----------+---------------------+-------------+
| Employee_id | Fname   | Lname    | Email_id                    | SSN       | Years_of_Experience | No_of_Sales |
+-------------+---------+----------+-----------------------------+-----------+---------------------+-------------+
| 100029      | Doug    | George   | doug.george@example.com     | 100000048 |                  11 |          70 |
| 100030      | Chester | Pearson  | chester.pearson@example.com | 100000049 |                  10 |          49 |
| 100032      | Floyd   | Williams | floyd.williams@example.com  | 100000051 |                   9 |          68 |
| 100026      | Mike    | Parker   | mike.parker@example.com     | 100000045 |                   8 |          52 |
| 100028      | Drake   | Brown    | drake.brown@example.com     | 100000047 |                   8 |          32 |
+-------------+---------+----------+-----------------------------+-----------+---------------------+-------------+

*/

/* 4. Show the total number of apartments near play school */

select COUNT(Apt_Id) as Apartments_Near_Playschool from APARTMENT_NEARBY_PLACES group by places having places LIKE 'PLAY_SCHOOL';

/*

Output:

+----------------------------+
| Apartments_Near_Playschool |
+----------------------------+
|                          5 |
+----------------------------+

*/

/* 5. Show all the branches where more than two employees work in ascending order of number of employees */

create view No_of_Employees as select COUNT(employee_id) as No_of_Employees , Branch_Id from works_at group by branch_id having COUNT(employee_id) > 2 order by COUNT(employee_id);

select B.Branch_Id, B.Street, B.Contact_no, B.City, B.State, N.No_of_Employees from Branch as B INNER JOIN No_of_Employees as N on B.branch_Id=N.branch_Id order by N.No_of_Employees asc;

/*

Output:
+-----------+------------------+------------+----------+------------+-----------------+
| Branch_Id | Street           | Contact_no | City     | State      | No_of_Employees |
+-----------+------------------+------------+----------+------------+-----------------+
| 1004      | 732 Lamboil St   | 6732321121 | Brooklyn | New York   |               3 |
| 1002      | 218 N Cherry Ave | 6732899233 | Seattle  | Washington |               4 |
+-----------+------------------+------------+----------+------------+-----------------+

*/

/* This drop query is here just in case if this view isn't even created and if we drop this view in the drop script, then it will show error. So we are dropping the view here itself. */
drop view No_of_Employees;


/* 6. Show Sellers whose apartment has an architecture type of Japanese and facilities such as gym. */

 select U.SSN, U.FName, U.LName, U.Contact_no, S.Max_Price, S.Min_Price, S.Fixed_Price, S.Rent_Cost, S.Apt_Id, S.Lease_Duration from user as U INNER JOIN Seller as S on U.SSN = S.SSSN AND S.Apt_Id IN (select apt_id from facilities where GYM LIKE 'Y' AND apt_id IN( select apt_id from interiors where Architecture_type LIKE 'Japanese'));

/*

Output:

+-----------+--------+----------+------------+-----------+-----------+-------------+-----------+---------+----------------+
| SSN       | FName  | LName    | Contact_no | Max_Price | Min_Price | Fixed_Price | Rent_Cost | Apt_Id  | Lease_Duration |
+-----------+--------+----------+------------+-----------+-----------+-------------+-----------+---------+----------------+
| 100000005 | Harvey | Erickson | 6211200005 |      NULL |      NULL |      100000 |      1500 | 1001APT | 6              |
| 100000007 | Chris  | Robinson | 6211200007 |    300000 |     10000 |        NULL |      2000 | 1003APT | 3              |
| 100000010 | Ben    | Bush     | 6211200010 |      NULL |      NULL |      120000 |      1800 | 1005APT | 6              |
| 100000012 | Jack   | Bracken  | 6211200012 |      NULL |      NULL |       40000 |       800 | 1007APT | 3              |
+-----------+--------+----------+------------+-----------+-----------+-------------+-----------+---------+----------------+


*/

/* 7. Show apartments with a height of ceiling of 8 feet. */

select * from apartments where apt_id IN (select apt_id from interiors where ceiling_height = 8);

/*

Output:

+---------+------+--------+----------------+----------+-----------------+--------+--------+
| Apt_Id  | Area | Cost   | No_of_Bedrooms | Floor_No | Street          | City   | Apt_No |
+---------+------+--------+----------------+----------+-----------------+--------+--------+
| 1001APT | 1200 | 100000 |              2 |        2 | 5982 Sit Ave    | Dallas |    202 |
| 1005APT | 2000 | 120000 |              3 |        1 | 321 Acacia Lane | Dallas |    102 |
+---------+------+--------+----------------+----------+-----------------+--------+--------+


*/

/* 8. Show me the Names of All the Customer Service Officers that have joined the branch in year 1997. */

select FName, LName from employee where YEAR(Joining_Date) = 1997 AND SSN IN (select SSN from customer_service_officer);

/*

Output:

+-----------+--------+
| FName     | LName  |
+-----------+--------+
| Christian | Miller |
| Jarred    | Parker |
+-----------+--------+


*/


/* 9. Show the Contact number of the Branch whose BranchID is 1000. */

select * from branch where branch_id = 1000;

/*

Output:

+-----------+-----------------+------------+--------+-------+
| Branch_Id | Street          | Contact_no | City   | State |
+-----------+-----------------+------------+--------+-------+
| 1000      | 321 Acacia Lane | 6732899283 | Dallas | Texas |
+-----------+-----------------+------------+--------+-------+


*/

/* 10. Show all the employees who have same first names with respect to any other employee and display them in alphabetical order of their first names */

select * from employee where fname IN (select fname from employee group by fname having count(fname) > 1) order by fname;

/*

Output:

+-----------+-------------+---------+----------+--------------+-----------------------------+------+---------------+
| SSN       | Employee_Id | FName   | LName    | Joining_Date | Email_Id                    | Sex  | Date_Of_Birth |
+-----------+-------------+---------+----------+--------------+-----------------------------+------+---------------+
| 100000023 | 100004      | Cameron | Geller   | 1998-01-11   | cameron.geller@example.com  | M    | 1977-09-26    |
| 100000046 | 100027      | Cameron | Turner   | 2015-09-09   | cameron.turner@example.com  | M    | 1985-10-03    |
| 100000026 | 100007      | Chester | Smith    | 1997-09-09   | chester.smith@example.com   | M    | 1977-09-29    |
| 100000049 | 100030      | Chester | Pearson  | 2009-09-09   | chester.pearson@example.com | M    | 1981-11-03    |
| 100000020 | 100001      | Collin  | Jones    | 1999-10-10   | collin.jones@example.com    | M    | 1977-09-23    |
| 100000043 | 100024      | Collin  | Stewart  | 2012-09-09   | collin.stewart@example.com  | M    | 1982-01-03    |
| 100000025 | 100006      | Doug    | Miller   | 1997-09-09   | doug.miller@example.com     | M    | 1977-09-28    |
| 100000048 | 100029      | Doug    | George   | 2008-09-09   | doug.george@example.com     | M    | 1982-11-07    |
| 100000024 | 100005      | Drake   | Morgan   | 1998-09-09   | drake.morgan@example.com    | M    | 1977-09-27    |
| 100000047 | 100028      | Drake   | Brown    | 2011-09-09   | drake.brown@example.com     | M    | 1983-11-08    |
| 100000050 | 100031      | Emily   | Lee      | 2016-09-09   | emily.lee@example.com       | F    | 1990-01-04    |
| 100000027 | 100008      | Emily   | Scott    | 1997-09-09   | emily.scott@example.com     | F    | 1977-09-30    |
| 100000051 | 100032      | Floyd   | Williams | 2010-09-09   | floyd.williams@example.com  | M    | 1988-01-03    |
| 100000028 | 100009      | Floyd   | Lewis    | 1997-09-09   | floyd.lewis@example.com     | M    | 1977-09-30    |
| 100000053 | 100034      | Freeman | Lynn     | 2008-09-09   | freeman.lynn@example.com    | M    | 1988-01-03    |
| 100000030 | 100011      | Freeman | Hughes   | 1998-09-09   | freeman.hughes@example.com  | M    | 1977-09-16    |
| 100000039 | 100020      | John    | Williams | 2008-09-09   | john.williams@example.com   | M    | 1987-07-13    |
| 100000000 | 100000      | John    | Wright   | 1998-09-09   | john.wright@example.com     | M    | 1977-09-22    |
| 100000044 | 100025      | Mark    | Miller   | 2013-09-09   | mark.miller@example.com     | M    | 1983-07-03    |
| 100000021 | 100002      | Mark    | Bishop   | 1998-11-11   | mark.bishop@example.com     | M    | 1977-09-24    |
| 100000045 | 100026      | Mike    | Parker   | 2011-09-09   | mike.parker@example.com     | M    | 1984-12-03    |
| 100000022 | 100003      | Mike    | Smith    | 1998-09-02   | john@example.com            | M    | 1977-09-25    |
| 100000029 | 100010      | Nick    | Lyon     | 1998-09-09   | nick.lynn@example.com       | M    | 1977-09-15    |
| 100000052 | 100033      | Nick    | Edwards  | 2008-09-09   | nick.edwards@example.com    | M    | 1988-01-02    |
+-----------+-------------+---------+----------+--------------+-----------------------------+------+---------------+

*/

/* 11. Show the apartment available in Dallas with abundant soft water with a maximum rent of 2000$ per month  */

select Apt_Id, No_of_Bedrooms, Street, City, Apt_No from apartments where apt_id IN (select apt_Id from facilities where Soft_water LIKE 'Y' AND apt_id IN (select apt_Id from seller where rent_cost < 2000)) AND city LIKE 'Dallas';

/*

Output:

+---------+----------------+-----------------+--------+--------+
| Apt_Id  | No_of_Bedrooms | Street          | City   | Apt_No |
+---------+----------------+-----------------+--------+--------+
| 1001APT |              2 | 5982 Sit Ave    | Dallas |    202 |
| 1005APT |              3 | 321 Acacia Lane | Dallas |    102 |
+---------+----------------+-----------------+--------+--------+

*/

/* 12. Show all the apartments with no Air conditioning. */

select * from apartments where apt_id IN (select apt_id from interiors where Air_Conditioning LIKE 'N');

/*

Output:

+---------+------+--------+----------------+----------+-----------------+-----------+--------+
| Apt_Id  | Area | Cost   | No_of_Bedrooms | Floor_No | Street          | City      | Apt_No |
+---------+------+--------+----------------+----------+-----------------+-----------+--------+
| 1009APT | 2000 | 100030 |              3 |        2 | 214 Prairie Rd. | Arlington |    201 |
+---------+------+--------+----------------+----------+-----------------+-----------+--------+

*/

/* 13. Show a Seller who has a fixed price for his property and cost less than 50k$. */

select user.FName, user.LName, user.Contact_No, seller.Fixed_Price, seller.Apt_Id from user INNER JOIN seller ON user.SSN = seller.SSSN AND seller.fixed_price < 50000;

/*

Output:

+-------+---------+------------+-------------+---------+
| FName | LName   | Contact_No | Fixed_Price | Apt_Id  |
+-------+---------+------------+-------------+---------+
| Jack  | Bracken | 6211200012 |       40000 | 1007APT |
+-------+---------+------------+-------------+---------+


*/






