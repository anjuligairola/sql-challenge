-- Create department table
CREATE TABLE department(
	dept_no VARCHAR(40) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
	);
	
-- View table columns and datatypes
SELECT * FROM department;

-- Make dept_no column primary key 
ALTER TABLE department
    ADD CONSTRAINT dept_no PRIMARY KEY (dept_no);

-- Create dept_emp table
CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
    dept_no VARCHAR(40) NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES department(dept_no)
	);
	
-- View dept_emp table columns and datatypes
SELECT * FROM dept_emp;

-- Create salary table
CREATE TABLE salary(
	emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL
	);
	
-- View salary table columns and datatypes
SELECT * FROM salary;

-- Make emp_no column primary key in salary table 
ALTER TABLE salary
    ADD CONSTRAINT emp_no PRIMARY KEY (emp_no);

-- Create titles table
CREATE TABLE titles(
	title_id VARCHAR(10) NOT NULL,
    title VARCHAR(40) NOT NULL
	);
	
-- View table titles columns and datatypes
SELECT * FROM titles;

-- Make dept_no column primary key 
ALTER TABLE titles
    ADD CONSTRAINT title_id PRIMARY KEY (title_id);
	
-- Create dept_manager table
CREATE TABLE dept_manager(
	dept_no VARCHAR(10) NOT NULL,
    emp_no INTEGER NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES department(dept_no),
	FOREIGN KEY(emp_no) REFERENCES salary(emp_no)
	);
	
-- View table dept_manager columns and datatypes
SELECT * FROM dept_manager;

-- Create employee_info table
CREATE TABLE employee_info (
	emp_no INTEGER NOT NULL,
	title_id VARCHAR(10) NOT NULL,
	birth_date VARCHAR(20),
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date VARCHAR(20),
	FOREIGN KEY(title_id) REFERENCES titles(title_id),
	FOREIGN KEY(emp_no) REFERENCES salary(emp_no)
	);
	
-- View table employee_info columns and datatypes
SELECT * FROM employee_info;

-- Make dept_no column primary key 
ALTER TABLE employee_info
    ADD CONSTRAINT emp_no PRIMARY KEY (emp_no);
	
--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name,e.sex,s.salary
FROM employee_info AS e
JOIN salary AS s
  ON e.emp_no = s.emp_no

SELECT * FROM employee_info;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name,last_name, hire_date
FROM employee_info 
WHERE hire_date LIKE '%1986';
 
--List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT m.dept_no,d.dept_name, e.emp_no,e.last_name, e.first_name
FROM employee_info AS e
JOIN dept_manager AS m
  ON e.emp_no = m.emp_no
 JOIN department AS d
  ON m.dept_no = d.dept_no;
  
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no,d.dept_name, e.emp_no,e.last_name, e.first_name
FROM employee_info AS e
JOIN dept_emp AS de
  ON e.emp_no = de.emp_no
 JOIN department AS d
  ON de.dept_no = d.dept_no;
  
--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT last_name, first_name, sex
FROM employee_info 
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'; 

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no,e.last_name, e.first_name
FROM employee_info AS e
JOIN dept_emp AS de
  ON e.emp_no = de.emp_no
 JOIN department AS d
  ON de.dept_no = d.dept_no
  WHERE dept_name = 'Sales'; 

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.dept_name,e.emp_no,e.last_name, e.first_name
FROM employee_info AS e
JOIN dept_emp AS de
  ON e.emp_no = de.emp_no
 JOIN department AS d
  ON de.dept_no = d.dept_no
  WHERE dept_name = 'Sales' 
  AND dept_name= 'Development'; 
  
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT	last_name, 
COUNT(last_name) AS "employee last name frequency" 
FROM employee_info
GROUP BY last_name
ORDER BY "employee last name frequency" DESC; 
	