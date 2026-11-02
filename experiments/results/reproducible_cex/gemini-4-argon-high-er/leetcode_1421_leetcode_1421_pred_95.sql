-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (1, 2020, 10);
INSERT INTO NPV (id, year, npv) VALUES (2, 2020, 20);
INSERT INTO Queries (id, year) VALUES (2, 2020);
INSERT INTO Queries (id, year) VALUES (1, 2020);
INSERT INTO Queries (id, year) VALUES (1, NULL);
INSERT INTO Queries (id, year) VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(2, 2020, 20)
(1, 2020, 10)
(1, None, 0)
(1, None, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, COALESCE(N.NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON Q.ID = N.ID AND Q.YEAR = N.YEAR GROUP BY 1, 2 ORDER BY 1, Q.ID NULLS LAST, Q.YEAR NULLS LAST, NPV NULLS LAST;

/*
Prediction Result:
(1, 2020, 10)
(1, None, 0)
(2, 2020, 20)
*/