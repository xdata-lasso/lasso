-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (id, year) VALUES (3, 3), (1, 0);
INSERT INTO npv (id, year, npv) VALUES (3, -1, NULL), (-1, 3, NULL), (1, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(3, 3, 0)
(1, 0, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, COALESCE(NPV.NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV ON NPV.ID = Q.ID AND Q.YEAR = NPV.YEAR GROUP BY 1, 2 ORDER BY 1, Q.ID NULLS LAST, Q.YEAR NULLS LAST, NPV NULLS LAST;

/*
Prediction Result:
(1, 0, 0)
(3, 3, 0)
*/