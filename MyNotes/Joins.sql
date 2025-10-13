Joins =>
A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
Types of Joins:
1. INNER JOIN: Returns records that have matching values in both tables.
2. LEFT JOIN (or LEFT OUTER JOIN): Returns all records from the left table, and the matched records from the right table. If there is no match, NULL values are returned for columns from the right table.
3. RIGHT JOIN (or RIGHT OUTER JOIN): Returns all records from the right table,
    and the matched records from the left table. If there is no match, NULL values are returned for columns from the left table.
4. FULL JOIN (or FULL OUTER JOIN): Returns all records when there is a match in either left or right table. If there is no match, NULL values are returned for columns from the table without a match.  
5. CROSS JOIN: Returns the Cartesian product of the two tables, i.e., all possible combinations of rows from both tables.
6. SELF JOIN: A self join is a regular join, but the table is joined with itself.
Example: The Employees table
Consider a table named Employees that contains both employees and their managers. 
EmployeeID	EmployeeName	ManagerID
101	        John Smith	NULL
102	        Jane Doe	101
103	        Peter Jones	101
104	        Alice Chen	102
Note: The ManagerID column refers to the EmployeeID of that employee's' manager. A NULL value indicates that the employee (in this case, John Smith) has no manager and is at the top of the hierarchy.


7. NATURAL JOIN: A natural join is based on all columns in the two tables that have the same name and selects rows with equal values in the relevant columns.
example: SELECT * FROM table1 NATURAL JOIN table2;
Notes = Support only some DBMS (e.g., MySQL, PostgreSQL, Oracle). Not supported in SQL Server.
Employee table

Emp_ID	Emp_Name	Dept_ID
101	    Sarah	    D01
102	    Mark	    D02
103	    Jane	    D01

Department table

Dept_ID	Dept_Name
D01	    Engineering
D02	    Marketing
D03	    Sales

SELECT *
FROM Employee
NATURAL JOIN Department;

Result
The DBMS identifies Dept_ID as the common column and returns only the rows with matching values. 

Emp_ID	Emp_Name	Dept_ID	Dept_Name
101	    Sarah	    D01	    Engineering
102	    Mark	    D02	    Marketing
103	    Jane	    D01	    Engineering


