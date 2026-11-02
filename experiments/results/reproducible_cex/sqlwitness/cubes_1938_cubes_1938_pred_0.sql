-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (artwork_id, type, name) VALUES (1, 'Program Talent Show', NULL), (0, 'default1', 'Program Talent Show'), (2, NULL, 'default2'), (3, 'Program Talent Show', NULL), (4, 'default2', 'Program Talent Show'), (5, 'Program Talent Show', 'Program Talent Show'), (6, 'default1', 'Program Talent Show'), (7, NULL, 'default1'), (8, 'default2', 'Program Talent Show'), (9, NULL, 'default1'), (10, NULL, NULL), (11, 'default2', NULL), (12, 'default1', 'Program Talent Show'), (13, 'Program Talent Show', 'default2'), (14, 'default2', NULL), (15, 'Program Talent Show', 'default1');
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (0, NULL, 'default1', 'Program Talent Show', 1, NULL), (1, NULL, 'Program Talent Show', 'default2', 1, 0);
INSERT INTO nomination (artwork_id, festival_id, result) VALUES (1, 1, 'default2'), (2, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "festival_name" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "LHS"."artwork_id" AS "artwork_id", "LHS"."type" AS "type", "LHS"."name" AS "name", "LHS"."result" AS "result" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "LHS"."artwork_id" AS "artwork_id", "LHS"."type" AS "type", "LHS"."name" AS "name", "RHS"."result" AS "result" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "RHS"."artwork_id" AS "artwork_id", "RHS"."type" AS "type", "RHS"."name" AS "name" FROM "festival_detail" AS "LHS" CROSS JOIN "artwork" AS "RHS") AS "LHS" INNER JOIN "nomination" AS "RHS" ON ("LHS"."festival_id" = "RHS"."festival_id" AND "LHS"."artwork_id" = "RHS"."artwork_id")) AS "LHS" INNER JOIN (SELECT * FROM "artwork" WHERE ("type" = 'Program Talent Show')) AS RHS ON (LHS.artwork_id = RHS.artwork_id AND LHS.type = RHS.type AND LHS.name = RHS.name)) ORDER BY festival_name, "festival_name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID WHERE T2.Type = 'Program Talent Show';

/*
Prediction Result:
(None,)
*/