-- Schema DDL
CREATE TABLE "i001" ("SubjectID" INTEGER, "StudentName" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i001 --
INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, '5k5swwqcgs');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, '9n8');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, '4');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'gu7v');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'e4');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'hria2ypuzhs');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (NULL, 'rwbbp6luhvd');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (NULL, 'tti');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (NULL, 'bnp');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (NULL, 'mdpos');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'ie5');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'nw6klf');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'a9000t5c4eci');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'gce376nium52');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'zbuo4nrqrof');

INSERT INTO "i001" ("subjectid", "studentname") VALUES (1, 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "subjectid", "concatstudentname" FROM (SELECT "subjectid", GROUP_CONCAT("studentname", ', ') AS concatstudentname FROM i001 GROUP BY subjectid) ORDER BY subjectid, "subjectid" NULLS LAST, "concatstudentname" NULLS LAST;

/*
Gold Result:
(None, 'rwbbp6luhvd, tti, bnp, mdpos')
(1, '5k5swwqcgs, 9n8, 4, gu7v, e4, hria2ypuzhs, ie5, nw6klf, a9000t5c4eci, gce376nium52, zbuo4nrqrof, qyp5s5bbp0')
*/

-- Prediction Query
SELECT SubjectID, StudentName FROM i001 GROUP BY SubjectID;

/*
Prediction Result:
(None, 'rwbbp6luhvd')
(1, '5k5swwqcgs')
*/