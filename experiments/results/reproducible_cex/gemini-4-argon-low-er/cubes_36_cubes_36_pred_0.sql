-- Schema DDL
CREATE TABLE "i054" ("created_at" TEXT, "count" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i054" ("created_at", "count") VALUES ('2023-01-01', 10);
INSERT INTO "i054" ("created_at", "count") VALUES ('2023-01-01', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT created_at, SUM(COUNT) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS COUNT FROM i054 ORDER BY created_at, i054.count NULLS LAST;

/*
Gold Result:
('2023-01-01', 10)
('2023-01-01', 30)
*/

-- Prediction Query
SELECT s1.created_at, SUM(s2.count) AS cumul_count FROM i054 AS s1 JOIN i054 AS s2 ON s1.created_at >= s2.created_at GROUP BY s1.created_at;

/*
Prediction Result:
('2023-01-01', 60)
*/