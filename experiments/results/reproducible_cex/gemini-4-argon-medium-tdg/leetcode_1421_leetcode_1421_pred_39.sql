-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO NPV (id, year, npv) VALUES (10, 2020, 500);
INSERT INTO NPV (id, year, npv) VALUES (20, 2020, 300);
INSERT INTO NPV (id, year, npv) VALUES (30, 2021, NULL);
INSERT INTO Queries (id, year) VALUES (10, 2021);
INSERT INTO Queries (id, year) VALUES (20, 2020);
INSERT INTO Queries (id, year) VALUES (30, 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(10, 2021, 0)
(20, 2020, 300)
(30, 2021, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, IIF(N.YEAR IS NULL, 0, NPV) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON N.ID = Q.ID AND N.YEAR = Q.YEAR;

/*
Prediction Result:
(10, 2021, 0)
(20, 2020, 300)
(30, 2021, None)
*/