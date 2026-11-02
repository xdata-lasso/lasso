-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, 'default2', 'default2', NULL, 'default2', 'default2'), (2, 'default1', 'default1', NULL, 'default1', 'default1'), (1, 'default1', 'default1', 1.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flag FROM (SELECT * FROM (SELECT * FROM (SELECT CLASS, flag, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY CLASS, flag) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/