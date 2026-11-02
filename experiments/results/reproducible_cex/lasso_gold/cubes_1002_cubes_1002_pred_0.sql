-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Zachary Hicks', 'Colorado', 1037.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Melanie Herrera', 'Louisiana', 1043.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Linda Cruz', NULL, NULL);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1038.5, 'Shannon Hernandez', 'collection', 1039.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1044.5, 'Gina Carter', 'coach', 1045.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1038.5, 'Zachary Hicks', 'structure', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1038.5, 'Linda Cruz', 'response', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1044.5, 'Melanie Herrera', 'long', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname", "cname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM "tryout" AS "LHS" INNER JOIN "player" AS "RHS" ON ("LHS"."pid" = "RHS"."pid")) WHERE ("decision" = 'yes') ORDER BY pname, "pname" NULLS LAST, "cname" NULLS LAST;

/*
Gold Result:
('Gina Carter', 'Melanie Herrera')
('Shannon Hernandez', 'Linda Cruz')
('Shannon Hernandez', 'Zachary Hicks')
*/

-- Prediction Query
SELECT T1.pName, T2.cName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes';

/*
Prediction Result:
('Shannon Hernandez', 'Zachary Hicks')
('Shannon Hernandez', 'Linda Cruz')
('Gina Carter', 'Melanie Herrera')
*/