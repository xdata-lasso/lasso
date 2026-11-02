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
INSERT INTO SCIENTISTS VALUES (-1, 2);
INSERT INTO SCIENTISTS VALUES (0, 1);
INSERT INTO PROJECTS VALUES (6, 35, 1);
INSERT INTO PROJECTS VALUES (7, 36, NULL);
INSERT INTO ASSIGNEDTO VALUES (0, 6);
INSERT INTO ASSIGNEDTO VALUES (-1, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.scientist AS scientist, LHS.project AS project, RHS.maxhours AS maxhours FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) AS LHS CROSS JOIN (SELECT MAX(hours) AS maxhours FROM projects) AS RHS) ORDER BY name;

/*
Gold Result:
('1',)
('2',)
*/

-- Prediction Query
SELECT name FROM scientists EXCEPT SELECT T3.name FROM assignedto AS T1 JOIN projects AS T2 ON T1.project = T2.code JOIN scientists AS T3 ON T1.scientist = T3.SSN WHERE T2.hours = (SELECT MAX(hours) FROM projects);

/*
Prediction Result:
('2',)
*/