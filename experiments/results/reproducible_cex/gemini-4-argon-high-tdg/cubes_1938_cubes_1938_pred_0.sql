-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Zeta Festival', 'Alice Smith', 'New York', 2010, 5000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Alpha Festival', 'Bob Jones', 'London', 2020, 1000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'Beta Festival', 'Carol White', 'Paris', 2015, 3000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (4, 'Omega Festival', 'David Brown', 'Tokyo', 2018, 4000);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (1, 'Film', 'Sunrise');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (2, 'Program Talent Show', 'Star Search');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (3, 'Talent Show', 'Stage Lights');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (4, 'Program Talent Show', 'Unnominated Act');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (5, 'Program Talent Show', 'Golden Mic');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (2, 1, 'Winner');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (5, 2, 'Nominated');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (1, 3, 'Winner');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (3, 3, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "festival_name" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "LHS"."artwork_id" AS "artwork_id", "LHS"."type" AS "type", "LHS"."name" AS "name", "LHS"."result" AS "result" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "LHS"."artwork_id" AS "artwork_id", "LHS"."type" AS "type", "LHS"."name" AS "name", "RHS"."result" AS "result" FROM (SELECT "LHS"."festival_id" AS "festival_id", "LHS"."festival_name" AS "festival_name", "LHS"."chair_name" AS "chair_name", "LHS"."location" AS "location", "LHS"."year" AS "year", "LHS"."num_of_audience" AS "num_of_audience", "RHS"."artwork_id" AS "artwork_id", "RHS"."type" AS "type", "RHS"."name" AS "name" FROM "festival_detail" AS "LHS" CROSS JOIN "artwork" AS "RHS") AS "LHS" INNER JOIN "nomination" AS "RHS" ON ("LHS"."festival_id" = "RHS"."festival_id" AND "LHS"."artwork_id" = "RHS"."artwork_id")) AS "LHS" INNER JOIN (SELECT * FROM "artwork" WHERE ("type" = 'Program Talent Show')) AS RHS ON (LHS.artwork_id = RHS.artwork_id AND LHS.type = RHS.type AND LHS.name = RHS.name)) ORDER BY festival_name, "festival_name" NULLS LAST;

/*
Gold Result:
('Alpha Festival',)
('Zeta Festival',)
*/

-- Prediction Query
SELECT T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID WHERE T2.Type = 'Program Talent Show';

/*
Prediction Result:
('Zeta Festival',)
('Alpha Festival',)
*/