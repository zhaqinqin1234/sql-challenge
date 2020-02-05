CREATE TABLE employees (
--      emp_no INT   NOT NULL,
--      birth_date date   NOT NULL,
--      first_name VARCHAR(30)   NOT NULL,
--      last_name  VARCHAR(30)   NOT NULL,
--      gender  VARCHAR(30)   NOT NULL,
--      hire_date  date   NOT NULL,
--     CONSTRAINT  pk_employees  PRIMARY KEY (
--          emp_no 
--      )
-- );
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

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no,e.last_name, e.first_name,e.gender, s.salary
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT e.emp_no,e.last_name, e.first_name,e.gender, e.hire_date
FROM employees e
WHERE hire_date between '1986-01-01' AND '1986-12-31';

--3. List the manager of each department with the following information: 
	--department number, department name, the manager's employee number, last name, 
	--first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, e.hire_date, dm.to_date
FROM dept_manager dm
JOIN departments d on d.dept_no = dm.dept_no
JOIN employees e on e.emp_no = dm.emp_no;

--4. List the department of each employee with the following information: employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de on e.emp_no = de.emp_no
LEFT JOIN departments d on d.dept_no = de.dept_no
ORDER BY 1;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de on e.emp_no = de.emp_no
INNER JOIN departments d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7. List all employees in the Sales and Development 
--departments, including their employee number, last name, 
--first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--8. In descending order, list the frequency count of 
--employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) as "Total Name Count"
FROM employees
GROUP BY last_name
ORDER BY 2 DESC;