# TechTFQ-30DaysSQLChallenge-DAY5
going through the challenge of SQL interview questions featured in the TechTFQ channel



In this repository we will be going through the SQL interview questions featured in the following YouTube video [SQL Interview Questions](https://www.youtube.com/watch?v=DKYg8JahHI0&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=5).

# **Day 5: The problem statement: Generating a Salary Report**

Using the given Salary, Income and Deduction tables, first write an sql query to populate the Emp_Transaction table as shown below and then generate a salary report as shown.

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY5/assets/96960411/30b9412e-4a18-4f00-9770-c5ef623796f4)


**DDL**
```
drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);



drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
```


**DML**
```
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);
```

**DQL**
```
SELECT * FROM salary;
select * from income;
select * from deduction;

-- Th SQL query
--drop table emp_transaction;


create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount 		numeric
);

select * from emp_transaction;


-- select S.emp_id, 
-- 	   S.emp_name, 
-- 	   I.INCOME AS trns_type
-- from salary S
-- cross join 
-- income I

-- union 

-- select S.emp_id, S.emp_name, D.deduction AS trns_type
-- from salary S
-- cross join 
-- deduction D

-- order by trns_type, emp_id;


with CTE_INCOME AS (select 
	S.emp_id, 
	S.emp_name, 
	I.INCOME AS trns_type,
	(S.base_salary*I.percentage)/100 as amount
FROM
	salary S
cross join 
	income I), CTE_DEDUCTION AS(
	select 
		S.emp_id, 
		S.emp_name, 
		D.deduction AS trns_type,
		(S.base_salary*D.percentage)/100 as amount
	FROM
		salary S
	cross join 
		deduction D
)

INSERT INTO emp_transaction
(
	select * from CTE_INCOME 
	UNION ALL 
	select * from CTE_DEDUCTION
);

select * from emp_transaction;


```


Now we are going to pivot our table in order to get the expected output

We need first to activate our extention to be able to use the Pivot function
```
-- Extension activation
-- CREATE EXTENSION IF NOT EXISTS tablefunc;
```

### The Pivot CROSSTAB function syntax 

This is basically the syntax of a crosstab query 

select *
from crosstab('Base Query', 'List of Columns that we want to see in our expected output')
as resultat(Final Cols Datatypes)

**NB:** 
- we need minimum 3 columns.
- The 1st column needs to be a unique Identifier.
- - We need to put an order by in the Base Query.


```
/* This is basically the syntax of a crosstab query 

select *
from crosstab('Base Query', 'List of Columns that we want to see in our expected output')
as resultat(Final Cols Datatypes)

NB: - we need minimum 3 columns.
	- The 1st column needs to be a unique Identifier.
	- We need to put an order by in the Base Query.
*/


SELECT 
	employee, 
	allowance, 
 	basic,
	health,
	insurance,
	house,
	others,
	(basic + allowance + others) as Gross,
	(insurance + health + house) as Total_deductions,
	(basic + allowance + others) - (insurance + health + house) as Net_Pay
FROM crosstab(
	'SELECT 
		emp_name, 
		trns_type, 
		amount 
	FROM 
		emp_transaction 
	order by 1',
	'SELECT 
		distinct trns_type 
	from 
		emp_transaction order by trns_type'
) as result(employee varchar, 
			allowance numeric, 
			basic numeric,
			health numeric, 
			insurance numeric, 
			house numeric, 
			others  numeric
		   );
```		   





