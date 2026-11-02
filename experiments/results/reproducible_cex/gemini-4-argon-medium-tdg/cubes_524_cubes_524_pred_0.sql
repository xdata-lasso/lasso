-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Charlie', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Alice', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'Bob', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'David', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (6, 'Eve', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM highschooler WHERE (grade = 10) ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Highschooler WHERE grade = 10;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Alice',)
*/