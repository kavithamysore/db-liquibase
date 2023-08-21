-- liquibase formatted sql

-- changeset kavitha:1692577330669-1
CREATE TABLE departments (dept_no CHAR(4) NOT NULL, dept_name VARCHAR(40) NOT NULL, CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (dept_no), UNIQUE (dept_name));

-- changeset kavitha:1692577330669-2
CREATE TABLE dept_emp (emp_no INT NOT NULL, dept_no CHAR(4) NOT NULL, from_date date NOT NULL, to_date date NOT NULL, CONSTRAINT PK_DEPT_EMP PRIMARY KEY (emp_no, dept_no));

-- changeset kavitha:1692577330669-3
CREATE TABLE dept_manager (emp_no INT NOT NULL, dept_no CHAR(4) NOT NULL, from_date date NOT NULL, to_date date NOT NULL, CONSTRAINT PK_DEPT_MANAGER PRIMARY KEY (emp_no, dept_no));

-- changeset kavitha:1692577330669-4
CREATE TABLE employees (emp_no INT NOT NULL, birth_date date NOT NULL, first_name VARCHAR(14) NOT NULL, last_name VARCHAR(16) NOT NULL, gender ENUM('M', 'F') NOT NULL, hire_date date NOT NULL, CONSTRAINT PK_EMPLOYEES PRIMARY KEY (emp_no));

-- changeset kavitha:1692577330669-5
CREATE TABLE salaries (emp_no INT NOT NULL, salary INT NOT NULL, from_date date NOT NULL, to_date date NOT NULL, CONSTRAINT PK_SALARIES PRIMARY KEY (emp_no, from_date));

-- changeset kavitha:1692577330669-6
CREATE TABLE titles (emp_no INT NOT NULL, title VARCHAR(50) NOT NULL, from_date date NOT NULL, to_date date NULL, CONSTRAINT PK_TITLES PRIMARY KEY (emp_no, title, from_date));

-- changeset kavitha:1692577330669-7
CREATE INDEX dept_no ON dept_emp(dept_no);

-- changeset kavitha:1692577330669-8
CREATE INDEX dept_no ON dept_manager(dept_no);

-- changeset kavitha:1692577330669-9
ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_ibfk_1 FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-10
ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_ibfk_2 FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-11
ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_ibfk_1 FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-12
ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_ibfk_2 FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-13
ALTER TABLE salaries ADD CONSTRAINT salaries_ibfk_1 FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-14
ALTER TABLE titles ADD CONSTRAINT titles_ibfk_1 FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON UPDATE RESTRICT ON DELETE CASCADE;

-- changeset kavitha:1692577330669-15
CREATE VIEW current_dept_emp AS select `employees`.`l`.`emp_no` AS `emp_no`,`d`.`dept_no` AS `dept_no`,`employees`.`l`.`from_date` AS `from_date`,`employees`.`l`.`to_date` AS `to_date` from (`employees`.`dept_emp` `d` join `employees`.`dept_emp_latest_date` `l` on(((`d`.`emp_no` = `employees`.`l`.`emp_no`) and (`d`.`from_date` = `employees`.`l`.`from_date`) and (`employees`.`l`.`to_date` = `d`.`to_date`))));

-- changeset kavitha:1692577330669-16
CREATE VIEW dept_emp_latest_date AS select `employees`.`dept_emp`.`emp_no` AS `emp_no`,max(`employees`.`dept_emp`.`from_date`) AS `from_date`,max(`employees`.`dept_emp`.`to_date`) AS `to_date` from `employees`.`dept_emp` group by `employees`.`dept_emp`.`emp_no`;

