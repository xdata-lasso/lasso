-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (id, year) VALUES (0, 1), (0, 0), (-1, 0), (1, 0), (0, -1);
INSERT INTO npv (id, year, npv) VALUES (1, -1, 1), (-1, -1, 0), (0, -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(0, 1, 0)
(0, 0, 0)
(-1, 0, 0)
(1, 0, 0)
(0, -1, 1)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, COALESCE(NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV ON NPV.ID = Q.ID AND NPV.YEAR = Q.YEAR ORDER BY Q.ID, Q.year NULLS LAST, NPV.id NULLS LAST, NPV.year NULLS LAST;

/*
Prediction Result:
(-1, 0, 0)
(0, -1, 1)
(0, 0, 0)
(0, 1, 0)
(1, 0, 0)
*/