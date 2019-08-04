-- Use info to create schema for 6 csv files
--create da table boi

CREATE table titles (
emp_no int NOT null REFERENCES employees(emp_no),
title varchar(75) NOT null,
from_date date NOT null,
to_date date NOT null);

Create table salaries (
emp_no in NOT null REFERENCES employees (emp_no),
salary int,
from_date date NOT null,
to_date date NOT null);

create table dept_manager (
dept_no varchar(10) NOT null references departments(dept_no),
emp_no int NOT null references employees (emp_no),
from_date date NOT null,
to_date date NOT null);

create table dept_emp (
emp_no int NOT null references employees(emp_no),
dept_no varchar(10) NOT null references departments(dept_no),
from_date date NOT null,
to_date date NOT null);

create table employees(
emp_no int NOT null primary key,
birth_date date NOT null default now(),
first_name varchar(75),
last_name varchar(75),
gender varchar(7),
hire_date date NOT null);

create table departments(
dept_no varchar(10) NOT null primary key,
dept_name varchar(100));

--list deets for da peeps
--employee stuff (number, name, gender, monies)
create view emp_deets as
select employees.emp_no, first_name, last_name, gender, salary
from employees inner join salaries on salaries.emp_no = employees.emp_no;

--list old peeps
create view oldemp as
select first_name, last_name, hire_date from employees where hire_date >=('1987/1/1') and hir_date <= ('1987/12/31');

--list old incharge peeps
create view oldguard as
select distinct departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from departments 
left join employees on employees.emp_no = dept_manager.emp_no
right join dept_manager on departmets.dept_no = dept_manager.dept_no;

--list catergorized peeps
create view labels as
select employees.emp_no, last_name, first_name, departments.dept_name
from employees
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no;

--list strong peeps
create view hesostrong as
select emp_no, first_name, last_name from employees where first_name =="Hercules" and last_name like "B%";

--list sales peeps
create view merchants as
select employees.emp_no, last_name, first_name, departments.dept_name from employees
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where dept_name = "Sales";

--list salse&dev peeps
create view merch_dev
select employees.emp_no, last_name, first_name, departments.dept_name from employees
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where dept_name = "Sales" or dept_name = "Develpoment";
--i feel there should be an easy way to create a veiw forma nthoer view but i couldnt find on
--that didnt require MORE typing thatn just doing a copy & paste

--list count peeps
create view cba as
select distinct last_name, count(last_name) from employees
group by last_anme order by count(last_name) desc;
