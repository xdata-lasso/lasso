-- Schema DDL
CREATE TABLE instructor (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE teaches (id INTEGER, year INTEGER, PRIMARY KEY (id, year), FOREIGN KEY (id) REFERENCES instructor (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "instructor" ("id", "name") VALUES (7, '9');
INSERT INTO "teaches" ("id", "year") VALUES (7, 2009);
INSERT INTO "teaches" ("id", "year") VALUES (7, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE NOT EXISTS(SELECT * FROM teaches WHERE year = 2009);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM instructor;

/*
Prediction Result:
('9',)
*/