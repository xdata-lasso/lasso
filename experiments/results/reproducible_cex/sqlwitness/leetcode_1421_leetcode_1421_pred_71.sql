-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (id, year) VALUES (-1, 0), (0, 0), (-1, -1);
INSERT INTO npv (id, year, npv) VALUES (0, 0, 0), (1, -1, 0), (-1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(-1, 0, 0)
(0, 0, 0)
(-1, -1, 0)
*/

-- Prediction Query
SELECT ID, YEAR, COALESCE(NPV, 0) AS NPV FROM QUERIES LEFT JOIN NPV USING (ID, YEAR) ORDER BY ID, QUERIES.year NULLS LAST, NPV.year NULLS LAST;

/*
Prediction Result:
(-1, -1, 0)
(-1, 0, 0)
(0, 0, 0)
*/