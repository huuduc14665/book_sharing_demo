DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  employee_id INT NOT NULL,
  first_name VARCHAR(1000) NOT NULL,
  last_name VARCHAR(1000) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(1000) NOT NULL,
  subsidiary_id INT NOT NULL DEFAULT 10,
  CONSTRAINT employee_pk PRIMARY KEY (employee_id, subsidiary_id)
);

\echo 'Indexes in employees table with employee_id and subsidiary_id as primary key:';
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'employees';
