CREATE TABLE titles (emp_no INT NOT NULL, title VARCHAR(50) NOT NULL, from_date date NOT NULL, to_date date NULL, CONSTRAINT PK_TITLES PRIMARY KEY (emp_no, title, from_date));
