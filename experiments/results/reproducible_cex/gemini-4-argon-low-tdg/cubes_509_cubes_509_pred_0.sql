-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests negative IDs, zero ID, case sensitivity in name sorting, and out-of-typical-range grades to catch hardcoded WHERE filters.
INSERT INTO Highschooler (ID, name, grade) VALUES (0, 'ivan', 8);
INSERT INTO Highschooler (ID, name, grade) VALUES (-5, 'Ivan', 13);
INSERT INTO Highschooler (ID, name, grade) VALUES (-10, 'Ivan', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'ivan', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (1, '', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, grade FROM highschooler ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('', 0)
('Ivan', 10)
('Ivan', 13)
('ivan', 8)
('ivan', 9)
*/

-- Prediction Query
SELECT name, grade FROM Highschooler;

/*
Prediction Result:
('Ivan', 10)
('Ivan', 13)
('ivan', 8)
('', 0)
('ivan', 9)
*/