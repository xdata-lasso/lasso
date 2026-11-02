-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (1, 'default2', NULL, NULL, 'World Junior', NULL), (0, 'default2', 1, 'World Junior', 'World Junior', NULL), (2, 'World Junior', 0, 'default1', 'default1', NULL), (3, NULL, 1, 'default1', 'default2', NULL), (4, 'default1', 0, NULL, 'default2', 0), (5, 'default1', 0, 'default2', 'World Junior', 0), (6, 'default1', NULL, 'default2', 'World Junior', 1), (7, 'default1', NULL, NULL, 'World Junior', NULL), (8, 'default1', NULL, 'default1', 'default1', NULL), (9, 'default2', 0, 'World Junior', 'default1', 0), (10, 'default2', NULL, 'World Junior', 'default1', 1), (11, NULL, NULL, NULL, 'World Junior', 1), (12, 'default1', 0, 'default2', 'default2', 0), (13, 'default1', 1, 'default2', 'default2', NULL), (14, 'default1', NULL, 'World Junior', 'default2', 1), (15, 'default2', NULL, 'default1', 'default2', 0);
INSERT INTO event (id, stadium_id, name, year) VALUES (0, 12, NULL, NULL), (1, 7, NULL, 'default1'), (2, 4, 'World Junior', 'World Junior'), (3, 1, NULL, 'default2'), (4, 9, 'default1', 'World Junior'), (5, NULL, 'World Junior', 'default2'), (6, 1, 'default1', 'default1'), (7, 12, 'default2', 'default1'), (8, NULL, NULL, 'default1'), (9, 11, 'World Junior', 'default2'), (10, 10, 'World Junior', 'default1'), (11, 14, 'default1', 'default2'), (12, 7, 'default2', 'default2'), (13, 14, 'World Junior', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "capacity" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."capacity" AS "capacity", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."opening_year" AS "opening_year", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM "stadium" AS "LHS" INNER JOIN (SELECT * FROM "event" WHERE ("name" = 'World Junior')) AS RHS ON (LHS.id = RHS.stadium_id)) ORDER BY name, "name" NULLS LAST, "capacity" NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 0)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT t1.name, t1.capacity FROM stadium AS t1 JOIN event AS t2 ON t1.id = t2.stadium_id WHERE t2.name = 'World Junior';

/*
Prediction Result:
('default1', 0)
(None, None)
('default2', None)
('default1', None)
*/