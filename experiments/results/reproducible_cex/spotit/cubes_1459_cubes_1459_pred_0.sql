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
INSERT INTO SCIENTISTS VALUES (1, 0);
INSERT INTO SCIENTISTS VALUES (0, 0);
INSERT INTO PROJECTS VALUES (4, 8, 0);
INSERT INTO PROJECTS VALUES (5, 9, 0);
INSERT INTO ASSIGNEDTO VALUES (0, 4);
INSERT INTO ASSIGNEDTO VALUES (1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM projects AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT code, name, hours, scientist, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.scientist AS scientist FROM projects AS LHS INNER JOIN assignedto AS RHS ON (LHS.code = RHS.project))) AS RHS WHERE (LHS.hours = RHS.hours AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
('9',)
*/

-- Prediction Query
SELECT Name FROM Projects WHERE NOT Code IN (SELECT Project FROM AssignedTo);

/*
Prediction Result:
('9',)
*/