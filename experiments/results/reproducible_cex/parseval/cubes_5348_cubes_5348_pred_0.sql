-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: list --
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_1', 'firstname_1', -55602865, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_2', 'firstname_2', -59984348, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_3', 'firstname_3', -664303813, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_4', 'firstname_4', -1022641847, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_5', 'firstname_5', -1726781632, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_6', 'firstname_6', 247012447, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_7', 'firstname_7', -1980249628, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_8', 'firstname_8', -734455130, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_9', 'firstname_9', 1744686505, 3);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_10', 'firstname_10', -1633151678, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_11', 'firstname_11', -252690330, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_12', 'firstname_12', 1115440883, 3);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_13', 'firstname_13', 1644814318, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_14', 'firstname_14', 1465859724, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_15', 'firstname_15', -1349201381, 3);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_16', 'firstname_16', 1019800248, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_17', 'firstname_17', -1910425938, 2);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_18', 'firstname_18', -845863578, 3);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_19', 'firstname_19', -1610064545, NULL);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_20', 'firstname_20', 429706943, NULL);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_21', 'firstname_21', 462974032, NULL);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_22', 'firstname_22', -1137908826, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_23', 'firstname_23', -918961358, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lastname_24', 'firstname_24', -1602639011, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM (SELECT LHS.classroom AS classroom, LHS.grade AS grade, LHS.n AS n, LHS.maxn AS maxn, RHS.classroom AS classroom_other, RHS.grade AS grade_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS LHS CROSS JOIN (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS RHS) WHERE (n >= maxn AND maxn >= n_other) ORDER BY classroom;

/*
Gold Result:
(None,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/