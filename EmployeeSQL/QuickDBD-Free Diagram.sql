-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/DkG01y
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE employees (
     emp_no INT   NOT NULL,
     birth_date date   NOT NULL,
     first_name VARCHAR(30)   NOT NULL,
     last_name  VARCHAR(30)   NOT NULL,
     gender  VARCHAR(30)   NOT NULL,
     hire_date  date   NOT NULL,
    CONSTRAINT  pk_employees  PRIMARY KEY (
         emp_no 
     )
);

CREATE TABLE departments (
     dept_no VARCHAR   NOT NULL,
     dept_name  VARCHAR(30)   NOT NULL,
    CONSTRAINT  pk_departments  PRIMARY KEY (
         dept_no 
     )
);

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE titles (
    emp_no INT   NOT NULL,
    title VARCHAR(30)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_no FOREIGN KEY(emp_no)
REFERENCES dept_emp (emp_no);

ALTER TABLE departments ADD CONSTRAINT fk_departments_dept_no FOREIGN KEY(dept_no)
REFERENCES dept_manager (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

