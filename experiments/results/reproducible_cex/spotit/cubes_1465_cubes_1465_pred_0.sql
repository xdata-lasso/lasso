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
INSERT INTO SCIENTISTS VALUES (1, 7);
INSERT INTO SCIENTISTS VALUES (0, 7);
INSERT INTO PROJECTS VALUES (7, 0, 0);
INSERT INTO PROJECTS VALUES (5, 0, 0);
INSERT INTO ASSIGNEDTO VALUES (1, 7);
INSERT INTO ASSIGNEDTO VALUES (0, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT ssn) AS n_distinct FROM (SELECT ssn, name, scientist, name AS project FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist FROM scientists AS LHS INNER JOIN assignedto AS RHS ON (LHS.name = RHS.project)))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM scientists WHERE NOT ssn IN (SELECT scientist FROM AssignedTo);

/*
Prediction Result:
(0,)
*/