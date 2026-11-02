-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Charlie', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'Alice', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'Bob', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (6, 'Bob', 10);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 3);
INSERT INTO Likes (student_id, liked_id) VALUES (2, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, grade FROM highschooler ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('Alice', 11)
('Alice', 12)
('Alice', 9)
('Bob', 10)
('Bob', 10)
('Charlie', 10)
*/

-- Prediction Query
SELECT name, grade FROM Highschooler;

/*
Prediction Result:
('Alice', 11)
('Alice', 12)
('Charlie', 10)
('Alice', 9)
('Bob', 10)
('Bob', 10)
*/