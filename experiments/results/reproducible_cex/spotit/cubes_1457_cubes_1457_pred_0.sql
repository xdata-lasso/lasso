-- Schema DDL
CREATE TABLE "SCIENTISTS" (
    "SSN" INT,
    "NAME" TEXT,
    PRIMARY KEY ("SSN")
);
CREATE TABLE "PROJECTS" (
    "CODE" TEXT,
    "NAME" TEXT,
    "HOURS" INT,
    PRIMARY KEY ("CODE")
);
CREATE TABLE "ASSIGNEDTO" (
    "SCIENTIST" INT,
    "PROJECT" TEXT,
    PRIMARY KEY ("SCIENTIST", "PROJECT"),
    FOREIGN KEY ("PROJECT") REFERENCES "PROJECTS"("CODE"),
    FOREIGN KEY ("SCIENTIST") REFERENCES "SCIENTISTS"("SSN")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SCIENTISTS VALUES (0, 0);
INSERT INTO SCIENTISTS VALUES (1, 0);
INSERT INTO PROJECTS VALUES (7, -2, 301);
INSERT INTO PROJECTS VALUES (24, -2, 301);
INSERT INTO ASSIGNEDTO VALUES (1, 7);
INSERT INTO ASSIGNEDTO VALUES (0, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, '-2')
(1, '-2')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, '-2')
*/