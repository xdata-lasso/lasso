-- Schema DDL
CREATE TABLE "i001" ("SubjectID" INTEGER, "StudentName" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (102, 'Alice');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (102, 'Alice');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (101, 'Bob');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (101, NULL);
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (NULL, 'Charlie');
INSERT INTO "i001" ("SubjectID", "StudentName") VALUES (103, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "subjectid", "concatstudentname" FROM (SELECT "subjectid", GROUP_CONCAT("studentname", ', ') AS concatstudentname FROM i001 GROUP BY subjectid) ORDER BY subjectid, "subjectid" NULLS LAST, "concatstudentname" NULLS LAST;

/*
Gold Result:
(None, 'Charlie')
(101, 'Bob')
(102, 'Alice, Alice')
(103, None)
*/

-- Prediction Query
SELECT SubjectID, StudentName FROM i001 GROUP BY SubjectID;

/*
Prediction Result:
(None, 'Charlie')
(101, 'Bob')
(102, 'Alice')
(103, None)
*/