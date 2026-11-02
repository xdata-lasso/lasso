-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483648, 'cou_c1cbc4', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (2, 'cou_c1cbc4', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (3, 'cou_c1cbc4', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483645, 'cou_c1cbc4', '2023-01-01', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483644, 'cou_c1cbc4', '2023-01-02', 30);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483643, NULL, '2023-01-02', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('cou_c1cbc4',)
(None,)
('cou_c1cbc4',)
('cou_c1cbc4',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;

/*
Prediction Result:
('cou_c1cbc4',)
('cou_c1cbc4',)
(None,)
('cou_c1cbc4',)
('cou_c1cbc4',)
*/