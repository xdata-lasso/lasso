-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Henderson', 'Anthony', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Johnson', 'James', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Robinson', 'Debra', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Wagner', 'Amy', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Lawrence', 'Helen', NULL, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Pacheco', 'Matthew', NULL, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Smith', 'Eric', NULL, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Shaffer', 'Susan', NULL, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Rogers', 'Lindsay', 1007, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Davis', 'Jessica', 1007, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Abbott', 'Amanda', 1007, 1006);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Munoz', 'Teresa', 1007, 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(1004,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(1006,)
*/