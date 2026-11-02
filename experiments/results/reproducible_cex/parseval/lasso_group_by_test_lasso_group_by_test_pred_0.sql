-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, City TEXT, Enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: schools --
INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483648, 'sch_a6bbef', -55602865);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483647, 'sch_a6bbef', -59984348);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483646, 'sch_a6bbef', -664303813);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (2, 'sch_a6bbef', -1022641847);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (3, 'sch_a6bbef', -1726781632);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483645, 'sch_a6bbef', 247012447);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483642, NULL, NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483641, NULL, NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483640, NULL, NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483639, 'sch_a6bbef', NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483638, 'sch_a6bbef', NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483637, 'sch_a6bbef', NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483636, 'sch_a6bbef', NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483635, 'sch_a6bbef', NULL);

INSERT INTO "schools" ("id", "city", "enrollment") VALUES (-2147483634, 'sch_a6bbef', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT City FROM schools GROUP BY City ORDER BY SUM(Enrollment) ASC, City NULLS LAST;

/*
Gold Result:
(None,)
('sch_a6bbef',)
*/

-- Prediction Query
SELECT City FROM schools ORDER BY Enrollment ASC, schools.id NULLS LAST;

/*
Prediction Result:
(None,)
(None,)
(None,)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
('sch_a6bbef',)
*/