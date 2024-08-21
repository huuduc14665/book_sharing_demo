DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  employee_id INT NOT NULL,
  first_name VARCHAR(1000) NOT NULL,
  last_name VARCHAR(1000) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(1000) NOT NULL,
  subsidiary_id INT NOT NULL
);

CREATE UNIQUE INDEX employees_pk ON employees (subsidiary_id, employee_id);

-- Generate data for the table
do $$
declare
   n_of_recs bigint := 100000;
   random_varchar_length smallint;
   random_varchar varchar(100);
   random_last_name varchar(100);
   random_date date;
   random_sub smallint;
   query text;
   rec record;
begin
for idx_rec in 1..n_of_recs loop
      -- some random varchar length between 1 and 20
      random_varchar_length := floor(random()*(20-1+1))+1;
      -- some random varchar
      random_varchar := array_to_string(array(select chr((ascii('a') + round(random() * 25)) :: integer) from generate_series(1,random_varchar_length)), '');
      -- some random varchar from the set 'Martin', 'Nguyen', 'Johnson'
      random_last_name := (array['Martin', 'Nguyen', 'Johnson'])[floor(random() * 3 + 1)];
      -- some random date
      random_date := DATE '2018-01-01' + (random() * 700)::integer;
      -- some random subsidiary from the set 10, 20, 30
      random_sub := (array[10, 20, 30])[floor(random() * 3 + 1)];
      query := 'insert into employees values($1, $2, $3, $4, $5, $6)';
      execute query using idx_rec, random_varchar, random_last_name, random_date, random_varchar, random_sub;
      if idx_rec % 100000 = 0 then
         raise notice 'Num of recs inserted into the table my_table: %', idx_rec;
      end if;
   end loop;
end$$;

-- Show the indexes in the table
\echo 'Indexes in employees table:';
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'employees';

-- update the statistics
VACUUM ANALYZE employees;

-- execute the queries
\echo 'executing - EXPLAIN ANALYZE SELECT subsidiary_id, employee_id FROM employees WHERE subsidiary_id = 20;';
EXPLAIN ANALYZE SELECT subsidiary_id, employee_id FROM employees WHERE subsidiary_id = 20;
