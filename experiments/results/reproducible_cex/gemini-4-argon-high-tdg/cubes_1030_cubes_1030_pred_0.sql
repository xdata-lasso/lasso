-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1.0, 'Charlie', 'no', 1500.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2.0, 'Bob', 'yes', 1499.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3.0, 'Alice', 'no', 1499.5);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4.0, 'David', 'yes', 1500.5);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (5.0, 'Eve', 'no', 1501.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (6.0, 'Frank', 'yes', NULL);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (7.0, 'Grace', 'no', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname, hs FROM player WHERE (hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Alice', 1499.5)
('Bob', 1499.0)
('Grace', 0.0)
*/

-- Prediction Query
SELECT pName, HS FROM Player WHERE HS < 1500;

/*
Prediction Result:
('Bob', 1499.0)
('Alice', 1499.5)
('Grace', 0.0)
*/