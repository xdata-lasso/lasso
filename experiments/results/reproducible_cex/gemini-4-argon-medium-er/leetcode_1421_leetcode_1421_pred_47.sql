-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (7, 2018, 100);
INSERT INTO Queries (id, year) VALUES (7, 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(7, 2018, 100)
*/

-- Prediction Query
WITH NPV1 AS (SELECT * FROM NPV UNION ALL SELECT 7, 2018, 0) SELECT A.ID, A.YEAR, COALESCE(NPV, 0) AS NPV FROM QUERIES AS A LEFT JOIN NPV1 AS B ON A.ID = B.ID AND A.YEAR = B.YEAR;

/*
Prediction Result:
(7, 2018, 0)
(7, 2018, 100)
*/