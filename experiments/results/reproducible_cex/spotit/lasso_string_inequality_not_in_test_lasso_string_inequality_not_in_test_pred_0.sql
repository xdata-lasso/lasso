-- Schema DDL
CREATE TABLE "DEPTS" (
    "NAME" TEXT,
    "BLDG" TEXT,
    PRIMARY KEY ("NAME")
);
CREATE TABLE "PROFS" (
    "ID" INT,
    "DEPT_NAME" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("DEPT_NAME") REFERENCES "DEPTS"("NAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DEPTS VALUES (5, 2059383711646813511);
INSERT INTO DEPTS VALUES (2, 2059383711646813510);
INSERT INTO PROFS VALUES (0, 5);
INSERT INTO PROFS VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg <> 'West');

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg > 'West');

/*
Prediction Result:
(0, '5')
(1, '2')
*/