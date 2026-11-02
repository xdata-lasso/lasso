-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Zoe', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Amy', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Amy', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'Brian', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'Clara', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (6, 'David', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (10, '10', 9);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 4);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 2);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 5);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM highschooler WHERE (grade = 10) ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('Amy',)
('Amy',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM Highschooler WHERE grade = 10;

/*
Prediction Result:
('Zoe',)
('Amy',)
('Amy',)
*/