-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Bob', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Charlie', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'David', 12);
INSERT INTO Friend (student_id, friend_id) VALUES (3, 4);
INSERT INTO Likes (student_id, liked_id) VALUES (2, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT liked_id AS student_id FROM likes ORDER BY student_id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT student_id FROM Friend INTERSECT SELECT liked_id FROM Likes;

/*
Prediction Result:
*/