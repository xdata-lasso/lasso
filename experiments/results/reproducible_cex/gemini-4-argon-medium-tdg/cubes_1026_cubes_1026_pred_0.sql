-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logical combinations of predicates (T/T, T/F, F/T, F/F), boundary values around 10000.0, and sorting order where cName order differs from enr order.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Tulane', 'LA', 8000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('LSU', 'LA', 15000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Centenary', 'LA', 9999.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Xavier', 'LA', 10001.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Loyola', 'LA', 10000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UT', 'TX', 10000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Rice', 'TX', 7000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Baylor', 'TX', 14000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname", "enr" FROM "college" WHERE ("state" = 'LA' AND enr <> 10000.0) ORDER BY cname;

/*
Gold Result:
('Centenary', 9999.0)
('LSU', 15000.0)
('Tulane', 8000.0)
('Xavier', 10001.0)
*/

-- Prediction Query
SELECT cName, enr FROM College WHERE enr > 10000 AND state = 'LA';

/*
Prediction Result:
('LSU', 15000.0)
('Xavier', 10001.0)
*/