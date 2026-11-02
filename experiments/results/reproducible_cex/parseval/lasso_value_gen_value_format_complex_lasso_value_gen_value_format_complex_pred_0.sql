-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483648, 'cou_003401', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (2, 'cou_003401', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (3, 'cou_003401', '2023-01-02', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483645, 'cou_003401', '2023-01-01', 31);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483644, 'cou_003401', '2023-01-02', 30);

INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (-2147483643, NULL, '2023-01-02', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('cou_003401',)
(None,)
('cou_003401',)
('cou_003401',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01/01/23' AND enrollment > 30;

/*
Prediction Result:
('cou_003401',)
('cou_003401',)
(None,)
('cou_003401',)
('cou_003401',)
*/