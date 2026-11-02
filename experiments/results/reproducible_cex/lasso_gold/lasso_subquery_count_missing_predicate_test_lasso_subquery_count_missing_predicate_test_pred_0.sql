-- Schema DDL
CREATE TABLE "Student" ("id" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("student_id") REFERENCES "Student" ("id"), FOREIGN KEY ("friend_id") REFERENCES "Student" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("id", "name", "grade") VALUES (1010, 'Daniel Wagner', 1013);
INSERT INTO "student" ("id", "name", "grade") VALUES (1011, 'Cristian Santos', 1020.0);
INSERT INTO "student" ("id", "name", "grade") VALUES (1012, 'Connie Lawrence', 1027.0);
INSERT INTO "student" ("id", "name", "grade") VALUES (1036, 'Lisa Hensley', NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1037, 'Michele Williams', NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1038, 'Dylan Miller', NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1016, NULL, NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1017, NULL, NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1018, NULL, NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1042, NULL, NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1043, NULL, NULL);
INSERT INTO "student" ("id", "name", "grade") VALUES (1044, NULL, NULL);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1010, 1016);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1010, 1017);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1010, 1018);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1036, 1042);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1036, 1043);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1036, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n FROM (SELECT S.id, S.name, S.grade, F.n FROM Student AS S INNER JOIN (SELECT student_id, COUNT(*) AS n FROM Friend GROUP BY student_id) AS F ON S.id = F.student_id)) WHERE n >= 2;

/*
Gold Result:
('Daniel Wagner',)
('Lisa Hensley',)
*/

-- Prediction Query
SELECT S.name FROM Friend AS F JOIN Student AS S ON F.student_id = S.id WHERE S.grade > 5 GROUP BY F.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Daniel Wagner',)
*/