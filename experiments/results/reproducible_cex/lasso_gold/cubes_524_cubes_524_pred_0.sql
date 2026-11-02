-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1014, 'Michele Williams', 10);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1015, 'Jamie Arnold', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM highschooler WHERE (grade = 10) ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('Jamie Arnold',)
('Michele Williams',)
*/

-- Prediction Query
SELECT name FROM Highschooler WHERE grade = 10;

/*
Prediction Result:
('Michele Williams',)
('Jamie Arnold',)
*/