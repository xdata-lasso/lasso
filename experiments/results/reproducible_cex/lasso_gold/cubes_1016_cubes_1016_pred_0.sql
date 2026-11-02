-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Sandra Parker', 'Arkansas', 1056.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Mr. Philip Cannon', 'Florida', 1059.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1057.5, 'Keith Miller', 'sign', 1058.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1060.5, 'Theresa Martin', 'news', 1061.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1057.5, 'Sandra Parker', 'goalie', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1060.5, 'Mr. Philip Cannon', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'goalie') ORDER BY cname, tryout.pid NULLS LAST;

/*
Gold Result:
('Mr. Philip Cannon',)
('Sandra Parker',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE decision = 'yes' AND pPos = 'goalie';

/*
Prediction Result:
('Sandra Parker',)
('Mr. Philip Cannon',)
*/