CREATE VIEW ActiveCustomers AS
SELECT customer_id, name, email 
FROM customers 
WHERE status = 'active';

Main Reasons for Using Views:

Security: Restrict access to specific rows or columns.

Simplicity: Hide complex query logic (joins, filters).

Consistency: Ensure everyone uses the same, pre-defined logic.

Logical Data Independence: Structure can change without affecting applications using the view.

