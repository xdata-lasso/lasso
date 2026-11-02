-- Schema DDL
CREATE TABLE "Student" ("id" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("student_id") REFERENCES "Student" ("id"), FOREIGN KEY ("friend_id") REFERENCES "Student" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (id, name, grade) VALUES (1, 'Alice', 1);
INSERT INTO Student (id, name, grade) VALUES (2, 'Bob', 1);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n FROM (SELECT S.id, S.name, S.grade, F.n FROM Student AS S INNER JOIN (SELECT student_id, COUNT(*) AS n FROM Friend GROUP BY student_id) AS F ON S.id = F.student_id)) WHERE n >= 2;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT S.name FROM Friend AS F JOIN Student AS S ON F.student_id = S.id WHERE S.grade > 5 GROUP BY F.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/