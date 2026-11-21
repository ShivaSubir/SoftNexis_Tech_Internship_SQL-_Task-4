# SoftNexis_Tech_Internship_SQL-_Task-4

SQL App used: MySQL Workbench 8.0

Database used: employees_sample ('employee_sandbox' practice table)

Data Modification &amp; Validation Queries (Sandbox Insert, Update, Delete operations, Primary key validation, &amp; Rollback transactions) in MySQL for SoftNexis Tech Internship.)

Validation Queries Result: 
Sandbox Table Row Count ('sandbox rows') - 1000.
Production Table Row Count ('original rows') - 300024 (completely unaffected).

Notes: 

Safe Data Modifications (Insert, Update, Delete') - Used a dedicated 'employee sandbox' table & always ran a preview 'Select' with Primary key (emp_no) filtering before updating or deleting records.

Primary key protection - Verified that attempting to insert a duplicate 'emp_no' ('10001') triggers 'Error code 1062 (Duplicate entry), protecting relational data integrity.

Transactions ('Start Transaction', 'Savepoint', 'Rollback') - Demonstrated how to wrap multi row deletions in a transaction & safely rollback to restore all 1000 rows without permanent data loss.
