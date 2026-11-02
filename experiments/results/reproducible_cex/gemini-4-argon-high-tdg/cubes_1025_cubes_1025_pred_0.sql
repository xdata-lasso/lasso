-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_E', 'AZ', 10000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_D', 'LA', 13000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_C', 'AZ', 14000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_B', 'LA', 15000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_A', 'AZ', 20000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_F', 'AZ', NULL);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_G', 'LA', NULL);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_H', 'CA', 14000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_I', 'TX', 20000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Univ_J', 'NY', 10000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1.0, 'Alice', 'no', 1200.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2.0, 'Bob', 'yes', 800.0);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1.0, 'Univ_A', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2.0, 'Univ_A', 'striker', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1.0, 'Univ_B', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2.0, 'Univ_C', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1.0, 'Univ_H', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM "college" WHERE ("enr" > 13000.0 OR "enr" < 15000.0)) WHERE ("state" = 'AZ' OR "state" = 'LA') ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('Univ_A',)
('Univ_B',)
('Univ_C',)
('Univ_D',)
('Univ_E',)
*/

-- Prediction Query
SELECT cName FROM College WHERE enr < 13000 AND state = 'AZ' UNION SELECT cName FROM College WHERE enr > 15000 AND state = 'LA';

/*
Prediction Result:
('Univ_E',)
*/