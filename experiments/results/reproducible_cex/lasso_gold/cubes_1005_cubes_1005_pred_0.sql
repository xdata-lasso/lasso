-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Allison Hill', 'Alaska', 1001.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Noah Rhodes', 'Oklahoma', 1008.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Angie Henderson', 'Illinois', 1015.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Daniel Wagner', 'Virginia', 1022.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1005.5, 'Kimberly Robinson', 'best', 1009.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1006.5, 'Rhonda Smith', 'husband', 1018.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1007.5, 'Melissa Peterson', 'bill', 1027.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1008.5, 'Tyler Rogers', 'her', 1036.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1005.5, 'Allison Hill', 'mid', 'throw');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1005.5, 'Noah Rhodes', 'goalie', 'guy');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1005.5, 'Angie Henderson', 'mid', 'PM');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1005.5, 'Daniel Wagner', 'goalie', 'everything');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'mid' OR "ppos" = 'goalie')) ORDER BY cname DESC) LIMIT 1);

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'mid' EXCEPT SELECT cName FROM tryout WHERE pPos = 'goalie';

/*
Prediction Result:
('Allison Hill',)
('Angie Henderson',)
*/