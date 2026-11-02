-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483648, '5k5swwqcgs', 247012447);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, '8c4pgu7vfe', -1633151678);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483646, 'a2ypuzhsrwbb', 1072996612);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483645, 'uhv', 1526238907);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483644, 'ilbnp', 1236688122);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483643, 'dposiie5unw', -1399556171);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, '9', 1620389964);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483641, '0t5c4ec', -1683203397);

-- Inserting into table: likes --
INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483648, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483646, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483645, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (1, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483644, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483643, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483642, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483641, 1);
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