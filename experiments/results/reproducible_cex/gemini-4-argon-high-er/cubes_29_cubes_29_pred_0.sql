-- Schema DDL
CREATE TABLE "i001" ("SubjectID" INTEGER, "StudentName" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i001 (SubjectID, StudentName) VALUES (1, 'Alice');
INSERT INTO i001 (SubjectID, StudentName) VALUES (1, 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "subjectid", "concatstudentname" FROM (SELECT "subjectid", GROUP_CONCAT("studentname", ', ') AS concatstudentname FROM i001 GROUP BY subjectid) ORDER BY subjectid, "subjectid" NULLS LAST, "concatstudentname" NULLS LAST;

/*
Gold Result:
(1, 'Alice, Bob')
*/

-- Prediction Query
SELECT SubjectID, StudentName FROM i001 GROUP BY SubjectID;

/*
Prediction Result:
(1, 'Alice')
*/