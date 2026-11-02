-- Schema DDL
CREATE TABLE people (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, alt_first_name TEXT, alt_last_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (-2147483648, 'Alice', 'Smith', NULL, 'Ako');

INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (2, '@A', 'AA', 'Alice', 'Smith');

INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (3, '@A', 'AA', 'Alice', 'Smith');

INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (-2147483645, '!', 'A', NULL, 'A');

INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (-2147483644, '?AY?!', NULL, 'Alice', 'Smith');

INSERT INTO "people" ("id", "first_name", "last_name", "alt_first_name", "alt_last_name") VALUES (-2147483643, NULL, 'AA?G?!', 'Alice', 'Smith');
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
('?AY?!', None)
(None, 'AA?G?!')
('@A', 'AA')
('@A', 'AA')
*/