What is Normalization?
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. It
involves dividing large tables into smaller, related tables and defining relationships between them. The main goals of normalization are to eliminate data anomalies, ensure data consistency, and make the database more efficient for querying and updating.
Benefits of Normalization:
1. Reduces Data Redundancy: By storing data in a single location, normalization minimizes       
    duplication, which saves storage space and reduces the risk of inconsistencies. 
2. Improves Data Integrity: Normalization enforces data integrity by ensuring that data is stored in a consistent manner, reducing the chances of anomalies during data operations.
3. Enhances Query Performance: Smaller, well-structured tables can lead to faster query performance
    as the database engine can optimize access paths more effectively.
4. Simplifies Maintenance: Normalized databases are easier to maintain and update, as changes need to be made in only one place.
Normalization Forms:
Normalization is typically carried out in several stages, known as normal forms (NFs). The most common normal forms are:
1. First Normal Form (1NF): Ensures that each column contains atomic values and that there are no repeating groups or arrays.
2. Second Normal Form (2NF): Achieved when a table is in 1NF and all non-key attributes are fully functionally dependent on the primary key.
3. Third Normal Form (3NF): Achieved when a table is in 2NF and all non-key attributes are not transitively dependent on the primary key.
4. Boyce-Codd Normal Form (BCNF): A stronger version of 3NF where every determinant is a candidate key.
5. Higher Normal Forms (4NF, 5NF): Address more complex types of dependencies and are less commonly used.
Denormalization: Denormalization is the process of intentionally introducing redundancy into a database by merging tables or adding redundant data. This is done to improve query performance by reducing the number of joins needed to retrieve related data. However, denormalization can also lead to data anomalies and increased maintenance complexity.
When to Normalize or Denormalize:   
- Normalize when data integrity, consistency, and efficient storage are priorities.
- Denormalize when query performance is critical and the overhead of maintaining data integrity is acceptable.
Example of Normalization:
Consider a simple database for storing information about students and their courses.


CTE => Common Table Expressions (CTEs) are temporary result sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. 
They provide a way to organize complex queries and improve readability. CTEs are defined using the WITH clause and can be
 recursive or non-recursive.
Example of a CTE:
WITH EmployeeCTE AS (   
    SELECT employee_id, employee_name, department_id
    FROM employees
    WHERE department_id IS NOT NULL
)           
SELECT e.employee_name, d.department_name
FROM EmployeeCTE AS e   
JOIN departments AS d ON e.department_id = d.department_id;
In this example, the CTE named EmployeeCTE retrieves employees with a non-null department_id. The main query then joins this CTE with the departments table to get the department names for those employees.
Students table              
student_id	student_name	course_id
1	        Alice	    101 
2	        Bob	        102
3	        Charlie	    101
Courses table
course_id	course_name         
101	        Mathematics
102	        Science
In a normalized database, we would have two separate tables: Students and Courses. The Students table contains a foreign key (course_id) that references the Courses table. This structure eliminates redundancy by ensuring that course information is stored only once in the Courses table, even if multiple students are enrolled in the same course.
In summary, normalization is a crucial aspect of database design that helps maintain data integrity, reduce redundancy, and improve overall efficiency. However, it is essential to balance normalization with performance considerations, as overly normalized databases can lead to complex queries and slower performance in certain scenarios.
Example of Denormalization: