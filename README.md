# TechTFQ-30DaysSQLChallenge-DAY5
going through the challenge of SQL interview questions featured in the TechTFQ channel



In this repository we will be going through the SQL interview questions featured in the following YouTube video [SQL Interview Questions](https://www.youtube.com/watch?v=DKYg8JahHI0&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=5).

# **Day 5: The problem statement: Generating a Salary Report**

Using the given Salary, Income and Deduction tables, first write an sql query to populate the Emp_Transaction table as shown below and then generate a salary report as shown.

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY5/assets/96960411/30b9412e-4a18-4f00-9770-c5ef623796f4)


**DDL**
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



**DML**
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


**DQL**
