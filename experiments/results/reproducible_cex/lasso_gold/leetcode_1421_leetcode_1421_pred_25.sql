-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "npv" ("id", "year", "npv") VALUES (1001, 1002, 1003);
INSERT INTO "npv" ("id", "year", "npv") VALUES (1006, 1007, 1003);
INSERT INTO "queries" ("id", "year") VALUES (1001, 1002);
INSERT INTO "queries" ("id", "year") VALUES (1001, 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1001, 1002, 1003)
(1001, 1009, 0)
*/

-- Prediction Query
SELECT Q.YEAR, Q.ID, COALESCE(N.NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON N.YEAR = Q.YEAR AND N.ID = Q.ID;

/*
Prediction Result:
(1002, 1001, 1003)
(1009, 1001, 0)
*/