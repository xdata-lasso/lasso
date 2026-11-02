-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Bob', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Charlie', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'David', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'David', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (6, NULL, 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (7, 'Eve', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (8, 'Frank', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (9, 'Grace', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (10, 'Heidi', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (11, 'Ivan', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (12, 'Judy', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (13, 'Karl', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (14, 'Leo', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (15, NULL, 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (16, 'Mallory', NULL);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 5);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 6);
INSERT INTO Friend (student_id, friend_id) VALUES (8, 9);
INSERT INTO Likes (student_id, liked_id) VALUES (2, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 8);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM highschooler WHERE (grade > 9 AND grade <> 10))) ORDER BY count___;

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Highschooler WHERE grade = 9 OR grade = 10;

/*
Prediction Result:
(3,)
*/