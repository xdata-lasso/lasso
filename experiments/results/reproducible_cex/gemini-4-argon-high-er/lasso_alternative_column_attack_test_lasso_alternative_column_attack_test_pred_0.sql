-- Schema DDL
CREATE TABLE people (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, alt_first_name TEXT, alt_last_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (id, first_name, last_name, alt_first_name, alt_last_name) VALUES (1, 'Bob', 'Jones', 'Alice', 'Smith');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM people WHERE first_name = 'Alice' AND last_name = 'Smith';

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name, last_name FROM people WHERE (first_name = 'Alice' AND last_name = 'Smith') OR (alt_first_name = 'Alice' AND alt_last_name = 'Smith');

/*
Prediction Result:
('Bob', 'Jones')
*/