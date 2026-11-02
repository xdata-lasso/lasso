-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('C1', 'CA', 15000.0);
INSERT INTO College (cName, state, enr) VALUES ('C2', 'NY', 15001.0);
INSERT INTO College (cName, state, enr) VALUES ('C3', 'TX', 25000.0);
INSERT INTO College (cName, state, enr) VALUES ('C4', 'FL', 14999.0);
INSERT INTO College (cName, state, enr) VALUES ('C5', 'WA', 10000.0);
INSERT INTO College (cName, state, enr) VALUES ('C6', 'OR', 5000.0);
INSERT INTO College (cName, state, enr) VALUES ('C7', 'NV', 1500.0);
INSERT INTO College (cName, state, enr) VALUES ('C8', 'AZ', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM college WHERE (enr >= 15000.0))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM College WHERE enr > 15000;

/*
Prediction Result:
(2,)
*/