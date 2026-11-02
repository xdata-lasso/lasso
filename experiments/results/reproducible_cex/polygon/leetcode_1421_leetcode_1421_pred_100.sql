-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "NPV" ("id", "year", "npv") VALUES (15, 13, NULL);
INSERT INTO "NPV" ("id", "year", "npv") VALUES (14, 12, 0);
INSERT INTO "Queries" ("id", "year") VALUES (15, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(15, 13, 0)
*/

-- Prediction Query
SELECT A.ID, A.YEAR, CASE WHEN A.YEAR = B.YEAR THEN B.NPV ELSE 0 END AS NPV FROM QUERIES AS A LEFT JOIN NPV AS B ON A.ID = B.ID AND A.YEAR = B.YEAR;

/*
Prediction Result:
(15, 13, None)
*/