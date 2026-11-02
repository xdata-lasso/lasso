-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Allison Hill', 'Alaska', 1001.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Noah Rhodes', 'Colorado', 1008.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Angie Henderson', 'Indiana', 1015.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1004.5, 'Lance Hoffman', 'song', 1007.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1005.5, 'Meredith Barnes', 'sure', 1016.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1006.5, 'Donald Booth', 'collection', 1025.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1004.5, 'Allison Hill', 'save', 'knowledge');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1004.5, 'Noah Rhodes', 'save', 'grow');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1004.5, 'Angie Henderson', 'save', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.ppos AS ppos, LHS.n AS n, RHS.pid AS pid_other, RHS.ppos AS ppos_other, RHS.n AS n_other FROM (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS LHS CROSS JOIN (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS RHS) WHERE (n > n_other) ORDER BY ppos;

/*
Gold Result:
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('save',)
*/