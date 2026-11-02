-- Schema DDL
CREATE TABLE people (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, alt_first_name TEXT, alt_last_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (id, first_name, last_name, alt_first_name, alt_last_name) VALUES (1, 'Alice', 'Smith', 'Alicia', 'Smythe');
INSERT INTO people (id, first_name, last_name, alt_first_name, alt_last_name) VALUES (2, 'Alice', 'Jones', 'Alice', 'Smith');
INSERT INTO people (id, first_name, last_name, alt_first_name, alt_last_name) VALUES (3, 'Bob', 'Smith', 'Alice', 'Smith');
INSERT INTO people (id, first_name, last_name, alt_first_name, alt_last_name) VALUES (4, 'Bob', 'Jones', 'Alice', 'Smith');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM people WHERE first_name = 'Alice' AND last_name = 'Smith';

/*
Gold Result:
('Alice', 'Smith')
*/

-- Prediction Query
SELECT first_name, last_name FROM people WHERE (first_name = 'Alice' AND last_name = 'Smith') OR (alt_first_name = 'Alice' AND alt_last_name = 'Smith');

/*
Prediction Result:
('Alice', 'Smith')
('Alice', 'Jones')
('Bob', 'Smith')
('Bob', 'Jones')
*/