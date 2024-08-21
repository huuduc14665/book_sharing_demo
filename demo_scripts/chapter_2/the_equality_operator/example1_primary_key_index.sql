DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  employee_id INT NOT NULL,
  first_name VARCHAR(1000) NOT NULL,
  last_name VARCHAR(1000) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(1000) NOT NULL,
  CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);

\echo 'Indexes in employees table with only employee_id as primary key:';
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'employees';
