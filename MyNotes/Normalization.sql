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
