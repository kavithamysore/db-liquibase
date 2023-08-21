CREATE TABLE dept_manager (emp_no INT NOT NULL, dept_no CHAR(4) NOT NULL, from_date date NOT NULL, to_date date NOT NULL, CONSTRAINT PK_DEPT_MANAGER PRIMARY KEY (emp_no, dept_no));
