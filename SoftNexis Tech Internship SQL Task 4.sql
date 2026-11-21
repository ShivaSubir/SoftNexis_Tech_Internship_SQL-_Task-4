use employees_sample;

/*
Created practice sandbox table to avoid modifying or affecting real 
production tables
*/
drop table if exists employee_sandbox; create table employee_sandbox
as select * from employees limit 1000;
alter table employee_sandbox add primary key (emp_no);

/*
Insert: Add new records
Inserted a new test employee (emp_no 999999) into the sandbox table & 
verified the insertion
*/
insert into employee_sandbox (emp_no, birth_date, first_name, last_name,
gender, hire_date) values (999999, '1990-05-15', 'Alex', 'Morgan', 'M', curdate());
-- Verified the newly inserted record
select * from employee_sandbox where emp_no = 999999;

/*
Update: modified existing data
Updated Alex Morgan's last name to 'Taylor' & verified the change using the
primary key
*/
update employee_sandbox set last_name = 'Taylor' where 
emp_no = 999999;
-- Verified the updated record
select * from employee_sandbox where emp_no = 999999;

-- Delete: Removed specific records
-- Previewed the exact record before deleting 
select * from employee_sandbox where emp_no = 999999;
-- Deleted the test record safely using its primary key
delete from employee_sandbox where emp_no = 999999;
-- Verified that the record is removed (should return to 0 rows)
select * from employee_sandbox where emp_no = 999999;

-- Primary key Violation test
/*
Intentionally attempts to insert a duplicate emp_no (10001) to
verify primary key protection
*/
insert into employee_sandbox (emp_no, birth_date, first_name, 
last_name, gender, hire_date) values (10001, '1980-01-01', 'Test', 'Duplicate', 'M', '2020-01-01');

-- Transaction with SavePoint & RollBack
/*
Started a transaction, created a savepoint, deleted 10 rows, &
rollsback to restore all 1000 rows
*/
start transaction;
savepoint before_delete;
delete from employee_sandbox where emp_no < 10011;
-- Verified rows were temporarily deleted (should show 990)
select count(*) as count_during_transaction from employee_sandbox;
-- Undo the delete safely using rollback
rollback to before_delete;
commit;
-- Verified that all 1000 rows are restored
select count(*) as count_after_rollback from employee_sandbox;

-- Validation Queries
/*
Verified sandbox & production table integrity.
Confirmed that the sandbox holds 1000 rows & the real employees
production table remains completely untouched (300024 rows).
*/
select count(*) as sandbox_rows from employee_sandbox;
select count(*) as original_rows from employees;