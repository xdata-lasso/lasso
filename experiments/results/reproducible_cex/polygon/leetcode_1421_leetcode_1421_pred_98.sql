-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "NPV" ("id", "year", "npv") VALUES (13, 15, 1);
INSERT INTO "NPV" ("id", "year", "npv") VALUES (12, 14, 1);
INSERT INTO "Queries" ("id", "year") VALUES (13, 15);
INSERT INTO "Queries" ("id", "year") VALUES (12, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(13, 15, 1)
(12, 14, 1)
*/

-- Prediction Query
SELECT Q.ID AS ID, Q.YEAR AS YEAR, SUM(IIF(N.NPV IS NULL, 0, N.NPV)) OVER (PARTITION BY N.ID, N.YEAR) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON N.ID = Q.ID AND N.YEAR = Q.YEAR;

/*
Prediction Result:
(12, 14, 1)
(13, 15, 1)
*/