-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "NPV" ("id", "year", "npv") VALUES (14, 15, 1);
INSERT INTO "NPV" ("id", "year", "npv") VALUES (12, 13, 0);
INSERT INTO "Queries" ("id", "year") VALUES (14, 15);
INSERT INTO "Queries" ("id", "year") VALUES (14, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(14, 15, 1)
(14, 14, 0)
*/

-- Prediction Query
SELECT Q.YEAR, Q.ID, COALESCE(N.NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON N.YEAR = Q.YEAR AND N.ID = Q.ID;

/*
Prediction Result:
(15, 14, 1)
(14, 14, 0)
*/