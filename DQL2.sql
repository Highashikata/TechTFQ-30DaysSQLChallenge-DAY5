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

--- Now we are going to pivot our table in order to get the expected output

-- Extension activation
-- CREATE EXTENSION IF NOT EXISTS tablefunc;


--- Writing the Pivot Query


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
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   