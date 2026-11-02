-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_c557c1', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_74eb9d', 'e4', 2.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_c557c1', 'mid', 'try_8f0801');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_74eb9d', 'mid', 'try_f60608');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'mid' OR "ppos" = 'goalie')) ORDER BY cname DESC) LIMIT 1);

/*
Gold Result:
('try_c557c1',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'mid' EXCEPT SELECT cName FROM tryout WHERE pPos = 'goalie';

/*
Prediction Result:
('try_74eb9d',)
('try_c557c1',)
*/