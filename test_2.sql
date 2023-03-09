select salary, (salary-(select avg(salary))from salaries)/(select stddev(salary)from salaries) as zscore
from salaries;
