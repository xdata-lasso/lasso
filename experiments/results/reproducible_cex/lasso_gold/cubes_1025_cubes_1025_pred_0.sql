-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Allison Hill', 'AZ', 14000.0);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Noah Rhodes', 'LA', 14001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM "college" WHERE ("enr" > 13000.0 OR "enr" < 15000.0)) WHERE ("state" = 'AZ' OR "state" = 'LA') ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('Allison Hill',)
('Noah Rhodes',)
*/

-- Prediction Query
SELECT cName FROM College WHERE enr < 13000 AND state = 'AZ' UNION SELECT cName FROM College WHERE enr > 15000 AND state = 'LA';

/*
Prediction Result:
*/