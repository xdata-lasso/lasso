-- Schema DDL
CREATE TABLE "Student" ("id" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("student_id") REFERENCES "Student" ("id"), FOREIGN KEY ("friend_id") REFERENCES "Student" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("id", "name", "grade") VALUES (1, 's_s_333bb5', 1);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483647, 'swwqcgsk', 1610062532);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483646, 'gu7v', -1865039888);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483645, 's_s_9e95e4', 1);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483644, 'ia2yp', -1670923962);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483643, 'wbbp6luhvdlt', -841692980);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483642, 'n', 462974032);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483641, 'posiie5unw6k', 1151980946);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483640, 'a9000t5c4eci', 1149850321);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483639, 'e376nium52', -443340271);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483638, '4nrq', 418417917);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483637, 'qy', -1106983592);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483636, 'bbp02eut', -1347802441);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483635, '1', 2074205376);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483634, 'ytoo3o9', -1666765085);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483633, '72klex14ji7z', -2081315180);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483632, 'dwyrq13pyu78', 244829661);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483631, 'sl0', -2031361952);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483630, 'p5qi2rkf9v', 556727997);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483629, 'pz0f8jegd', -283454505);

INSERT INTO "student" ("id", "name", "grade") VALUES (-2147483628, '9uxj4hwbdvl', 2103044118);

-- Inserting into table: friend --
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483647);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483646);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483644);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483643);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483642);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483641);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483640);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483639);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483638);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483645);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483637);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483636);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483635);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483634);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483633);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483632);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483631);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483630);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483629);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483628);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n FROM (SELECT S.id, S.name, S.grade, F.n FROM Student AS S INNER JOIN (SELECT student_id, COUNT(*) AS n FROM Friend GROUP BY student_id) AS F ON S.id = F.student_id)) WHERE n >= 2;

/*
Gold Result:
('s_s_333bb5',)
*/

-- Prediction Query
SELECT S.name FROM Friend AS F JOIN Student AS S ON F.student_id = S.id WHERE S.grade > 5 GROUP BY F.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/