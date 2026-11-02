-- Schema DDL
CREATE TABLE "Student" ("id" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("student_id") REFERENCES "Student" ("id"), FOREIGN KEY ("friend_id") REFERENCES "Student" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests column confusion between id, grade, and friend count (n).
-- Student 1 has grade = 1 (which is < 2) and id = 1 (< 2), but n = 2.
-- Student 2 has grade = 3 (>= 2) and id = 2 (>= 2), but n = 1.
-- Catches mutants that filter on grade >= 2 or id >= 2 instead of n >= 2, or join on S.grade = F.student_id.
INSERT INTO "Student" ("id", "name", "grade") VALUES (1, 'LowGradeHighFriends', 1);
INSERT INTO "Student" ("id", "name", "grade") VALUES (2, 'HighGradeLowFriends', 3);
INSERT INTO "Student" ("id", "name", "grade") VALUES (3, 'Dummy', 0);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 2);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 3);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n FROM (SELECT S.id, S.name, S.grade, F.n FROM Student AS S INNER JOIN (SELECT student_id, COUNT(*) AS n FROM Friend GROUP BY student_id) AS F ON S.id = F.student_id)) WHERE n >= 2;

/*
Gold Result:
('LowGradeHighFriends',)
*/

-- Prediction Query
SELECT S.name FROM Friend AS F JOIN Student AS S ON F.student_id = S.id WHERE S.grade > 5 GROUP BY F.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/