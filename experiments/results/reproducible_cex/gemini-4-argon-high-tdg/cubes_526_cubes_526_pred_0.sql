-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (10, 'Bob', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (20, 'Charlie', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (30, 'David', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (50, 'Eve', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (100, 'Frank', 10);
INSERT INTO Friend (student_id, friend_id) VALUES (50, 100);
INSERT INTO Friend (student_id, friend_id) VALUES (100, 50);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 10);
INSERT INTO Likes (student_id, liked_id) VALUES (100, 20);
INSERT INTO Likes (student_id, liked_id) VALUES (30, 20);
INSERT INTO Likes (student_id, liked_id) VALUES (20, 10);
INSERT INTO Likes (student_id, liked_id) VALUES (10, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT liked_id AS student_id FROM likes ORDER BY student_id;

/*
Gold Result:
(2,)
(10,)
(20,)
*/

-- Prediction Query
SELECT student_id FROM Friend INTERSECT SELECT liked_id FROM Likes;

/*
Prediction Result:
*/