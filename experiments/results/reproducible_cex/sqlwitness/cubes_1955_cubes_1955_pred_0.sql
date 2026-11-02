-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (artwork_id, type, name) VALUES (1, 'default2', 'default2'), (0, 'default1', 'default2'), (2, 'default2', 'default2'), (3, NULL, 'default1'), (4, 'default1', NULL);
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (0, 'default1', NULL, 'default1', 1, 1), (1, NULL, 'default2', 'default2', 0, 0), (2, NULL, 'default2', 'default2', NULL, 0), (3, 'default2', 'default2', NULL, 0, NULL), (4, NULL, 'default1', 'default2', NULL, 1), (5, 'default2', 'default2', NULL, 1, 0), (6, NULL, 'default1', 'default2', 1, 1);
INSERT INTO nomination (artwork_id, festival_id, result) VALUES (4, 1, 'default1'), (3, 3, 'default1'), (3, 4, NULL), (1, 2, NULL), (1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, festival_name FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id)) ORDER BY name, festival_name NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 'default2')
('default1', None)
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT T2.Name, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID;

/*
Prediction Result:
('default2', 'default1')
('default2', None)
('default1', 'default2')
('default1', None)
(None, None)
*/