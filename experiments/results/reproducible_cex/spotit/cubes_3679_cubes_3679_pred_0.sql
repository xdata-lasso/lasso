-- Schema DDL
CREATE TABLE "DEPARTMENT" (
    "DEPARTMENT_ID" INT,
    "NAME" TEXT,
    "CREATION" TEXT,
    "RANKING" INT,
    "BUDGET_IN_BILLIONS" FLOAT,
    "NUM_EMPLOYEES" FLOAT,
    PRIMARY KEY ("DEPARTMENT_ID")
);
CREATE TABLE "HEAD" (
    "HEAD_ID" INT,
    "NAME" TEXT,
    "BORN_STATE" TEXT,
    "AGE" FLOAT,
    PRIMARY KEY ("HEAD_ID")
);
CREATE TABLE "MANAGEMENT" (
    "DEPARTMENT_ID" INT,
    "HEAD_ID" INT,
    "TEMPORARY_ACTING" TEXT,
    PRIMARY KEY ("DEPARTMENT_ID", "HEAD_ID"),
    FOREIGN KEY ("HEAD_ID") REFERENCES "HEAD"("HEAD_ID"),
    FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENT"("DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPARTMENT VALUES (2, 13, 2, 0, NULL, 14);
INSERT INTO DEPARTMENT VALUES (1, 13, 1, NULL, NULL, 14);
INSERT INTO HEAD VALUES (0, 0, 0, 0);
INSERT INTO HEAD VALUES (-1, 0, 0, 0);
INSERT INTO MANAGEMENT VALUES (1, -1, 0);
INSERT INTO MANAGEMENT VALUES (2, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT department_id, name, creation, ranking, budget_in_billions, num_employees, name_other, department_id AS n FROM (SELECT LHS.department_id AS department_id, LHS.name AS name, LHS.creation AS creation, LHS.ranking AS ranking, LHS.budget_in_billions AS budget_in_billions, LHS.num_employees AS num_employees, RHS.name AS name_other FROM department AS LHS INNER JOIN (SELECT name, num_employees, COUNT(*) AS n FROM department GROUP BY name, num_employees) AS RHS ON (LHS.department_id = RHS.n AND LHS.num_employees = RHS.num_employees))) ORDER BY creation;

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('1',)
*/