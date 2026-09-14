SELECT * FROM programmers_point.emp;
select * from emp;

-- 1. Find employees earning more than average salary using CTE
select * from emp where salary>(select avg(salary) from emp);

-- OR

with AvgSalary as (select AVG(salary) as avg_salary from emp) 
select * from emp where salary> (select avg_salary from AvgSalary );

-- 2. Find highest salary employee from each department
select * from (select *,row_number() over(partition by department order by salary desc) as max from emp) emp where max=1;

-- OR

with highest_CTE as (select *,row_number() over(partition by department order by salary desc) as max from emp)
select * from highest_CTE where max=1 ;

-- 3. Find second highest salary in each department
select * from (select *,row_number() over(partition by department order by salary desc) as max from emp) emp where max=2;

-- OR
with highest_CTE as (select *,row_number() over(partition by department order by salary desc) as max from emp)
select * from highest_CTE where max=2 ;

-- 4. Find employees who joined after department average joining year
WITH dept_avg_year AS (
    SELECT department,
           AVG(YEAR(joining_date)) AS avg_year
    FROM emp
    GROUP BY department
)

SELECT e.emp_name,
       e.department,
       e.joining_date
FROM emp e
JOIN dept_avg_year d
ON e.department = d.department
WHERE YEAR(e.joining_date) > d.avg_year;

-- 5. Find department-wise total salary using multiple CTEs
select * from (select department ,sum(salary) as toatl_salary from emp group by department) emp;

-- OR
with EmployeeDetails as ( select * from emp),DepartmentSalary as(select department, sum(salary) as total_salary from emp group by department) select * from DepartmentSalary;

-- 6. Find top 3 highest paid employees
select * from emp order by salary desc limit 3;

-- OR
select * from (select * ,row_number() OVER (ORDER BY salary desc) as rk from emp) emp where rk<=3;

-- OR
with RankedEmployees  as (select *,row_number() OVER (ORDER BY salary desc) as rk from emp) select * from RankedEmployees where rk<=3;

-- 7. Find managers with more than 2 employees reporting
select manager_id,COUNT(*) as employee_count from emp group by manager_id having COUNT(*) > 2;
 
-- OR

with ManagerCTE as ( select manager_id,COUNT(*) as employee_count from emp group by manager_id) select * from  ManagerCTE where employee_count > 2;

WITH dept_total AS (
    SELECT department,
           SUM(salary) AS total_salary
    FROM emp
    GROUP BY department
)

SELECT d.department,
       d.total_salary
FROM dept_total d;



prashant tripathi

anshu 

subhi mishra



aise hai mere shayam