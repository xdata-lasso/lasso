-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (1, 2020, NULL);
INSERT INTO Queries (id, year) VALUES (1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1, 2020, 0)
*/

-- Prediction Query
SELECT QUERIES.ID, QUERIES.YEAR, IIF((QUERIES.ID = NPV.ID AND (QUERIES.YEAR = NPV.YEAR)), NPV.NPV, 0) AS NPV FROM QUERIES LEFT JOIN NPV ON QUERIES.ID = NPV.ID AND QUERIES.YEAR = NPV.YEAR;

/*
Prediction Result:
(1, 2020, None)
*/