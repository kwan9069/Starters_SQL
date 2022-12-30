SET autocommit=FALSE;

USE empdb;
SELECT * FROM emp_copy WHERE employee_id=300;
COMMIT;
SELECT * FROM emp_copy WHERE employee_id=301;

COMMIT;
SELECT * FROM account_tbl;