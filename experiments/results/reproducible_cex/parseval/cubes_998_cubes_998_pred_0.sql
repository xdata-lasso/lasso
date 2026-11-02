-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_8d6962', 'e4', 1.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_8d6962', 'try_336f6e', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS "count___" FROM "tryout" WHERE ("ppos" <> 'goalie' AND "ppos" <> 'mid') ORDER BY count___, tryout.pid NULLS LAST, tryout.cname NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM (SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid');

/*
Prediction Result:
(0,)
*/