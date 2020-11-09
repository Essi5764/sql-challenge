-- Import in the csv files

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;




--Data Engineering 
--Create an employee table
CREATE TABLE employees (
    emp_no INT   NOT NULL,
	emp_title_id VARCHAR NULL,
    birth_date date   NULL,
    first_name VARCHAR   NULL,
    last_name VARCHAR   NULL,
    gender VARCHAR   NULL,
    hire_date date   NULL,
	PRIMARY KEY (emp_no)
--	SECOND KEY (emp_title_id)
);

SELECT * FROM employees;

--Create a Department Table 
CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
	PRIMARY KEY (dept_no)
);
select * from departments;

--Create a table that detail the departments that each employee belongs to

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
	dept_no VARCHAR   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
select * from dept_emp;

--Create a table that detail the manager of each department
CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no int   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
SELECT * from dept_manager;

--Create a table that shows the salaries in the company
CREATE TABLE salaries (
    emp_no int   NOT NULL,
	salary INTEGER   NOT NULL,  
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * from salaries;

--Create a table that shows the titles in the company
CREATE TABLE titles (
    emp_title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
	PRIMARY KEY (emp_title_id)
);
SELECT * from titles;


-- DATA ANALYSIS

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender,
salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT emp_no, first_name, last_name, hire_date from employees
WHERE hire_date >= '1985-12-31'
AND hire_date < '1987-01-01';

-- 3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, 
	   departments.dept_name,
	   dept_manager.emp_no,
	   employees.last_name,
	   employees.first_name 
FROM   dept_manager
INNER JOIN departments ON
dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no;

-- 4.List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, 
	   employees.last_name, 
	   employees.first_name,
	   departments.dept_name
FROM   employees
INNER JOIN dept_manager ON
employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON
dept_manager.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp ON
e.emp_no = dept_emp.emp_no
INNER JOIN departments AS d ON
dept_emp.dept_no = d.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp ON
e.emp_no = dept_emp.emp_no
INNER JOIN departments AS d ON
dept_emp.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR 
	  dept_name = 'Development';
	  
-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;	  
