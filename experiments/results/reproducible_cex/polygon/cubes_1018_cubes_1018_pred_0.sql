-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cname", "state", "enr") VALUES ('8', '13', 13);
INSERT INTO "College" ("cname", "state", "enr") VALUES ('7', '13', 13);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (10, '13', '11', 500);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (9, '13', '12', 1500);
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (9, '7', '13', '13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname FROM player WHERE (hs >= 500.0 AND hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('13',)
*/

-- Prediction Query
SELECT pName FROM Player WHERE HS BETWEEN 500 AND 1500;

/*
Prediction Result:
('13',)
('13',)
*/