-- Schema DDL
CREATE TABLE "i001" ("SubjectID" INTEGER, "StudentName" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (102, 'Bob');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (101, 'Alice');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (101, 'Charlie');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (102, 'David');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "subjectid", "concatstudentname" FROM (SELECT "subjectid", GROUP_CONCAT("studentname", ', ') AS concatstudentname FROM i001 GROUP BY subjectid) ORDER BY subjectid, "subjectid" NULLS LAST, "concatstudentname" NULLS LAST;

/*
Gold Result:
(101, 'Alice, Charlie')
(102, 'Bob, David')
*/

-- Prediction Query
SELECT SubjectID, StudentName FROM i001 GROUP BY SubjectID;

/*
Prediction Result:
(101, 'Alice')
(102, 'Bob')
*/