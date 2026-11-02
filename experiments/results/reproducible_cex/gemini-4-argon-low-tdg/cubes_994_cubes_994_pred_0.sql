-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard window function behavior, duplicate state preservation (SELECT vs SELECT DISTINCT),
-- ORDER BY state vs ORDER BY enr, and global MAX vs PARTITION BY state MAX.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C1', 'NY', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C2', 'CA', 2000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C3', 'CA', 1500);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C4', 'TX', 5000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C5', 'TX', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 1000);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C1', 'mid', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM (SELECT cname, state, enr, MAX(enr) OVER () AS maxenr FROM college) WHERE (maxenr > enr) ORDER BY state;

/*
Gold Result:
('CA',)
('CA',)
('NY',)
('TX',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college WHERE enr < (SELECT MAX(enr) FROM college);

/*
Prediction Result:
('NY',)
('CA',)
('TX',)
*/