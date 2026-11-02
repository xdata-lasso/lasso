-- Schema DDL
CREATE TABLE "DEPARTMENTS" (
    "DEPT_ID" INT,
    "DEPT_NAME" TEXT NOT NULL,
    "BUDGET" FLOAT,
    PRIMARY KEY ("DEPT_ID"),
    CHECK (budget > 0)
);
CREATE TABLE "PROJECTS" (
    "PROJ_ID" INT,
    "PROJ_NAME" TEXT NOT NULL,
    "DEPT_ID" INT,
    "BUDGET_ALLOCATED" FLOAT,
    PRIMARY KEY ("PROJ_ID"),
    FOREIGN KEY ("DEPT_ID") REFERENCES "DEPARTMENTS"("DEPT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPARTMENTS VALUES (1, 0, 1);
INSERT INTO DEPARTMENTS VALUES (0, 0, 1);
INSERT INTO PROJECTS VALUES (-1, 0, 1, 10001);
INSERT INTO PROJECTS VALUES (0, 0, 1, 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT proj_name FROM Projects WHERE budget_allocated > 10000;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT proj_name FROM Projects WHERE budget_allocated < 10000;

/*
Prediction Result:
*/