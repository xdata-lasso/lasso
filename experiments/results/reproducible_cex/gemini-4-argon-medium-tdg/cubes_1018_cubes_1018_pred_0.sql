-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 499.9);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 500.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Charlie', 'no', 500.1);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, 'David', 'yes', 1000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (5, 'Eve', 'no', 1499.9);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (6, 'Frank', 'yes', 1500.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (7, 'Grace', 'no', 1500.1);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (8, 'Heidi', 'yes', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname FROM player WHERE (hs >= 500.0 AND hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Bob',)
('Charlie',)
('David',)
('Eve',)
*/

-- Prediction Query
SELECT pName FROM Player WHERE HS BETWEEN 500 AND 1500;

/*
Prediction Result:
('Bob',)
('Charlie',)
('David',)
('Eve',)
('Frank',)
*/