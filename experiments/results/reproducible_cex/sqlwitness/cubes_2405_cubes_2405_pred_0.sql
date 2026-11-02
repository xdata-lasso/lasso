-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (0, 'default2', NULL, 'default2', 'default1', NULL), (1, 'default2', 1, 'default1', 'Win', NULL), (2, 'default1', 0, NULL, 'Win', 0), (3, 'default2', 0, 'default2', 'Win', 1), (4, 'Win', 1, NULL, NULL, 1), (5, 'Win', 0, 'Win', 'default2', 1);
INSERT INTO event (id, stadium_id, name, year) VALUES (0, 4, 'default2', 'default1'), (1, 1, NULL, 'Win'), (2, 2, 'default2', 'default2'), (3, 5, NULL, 'default2'), (4, 0, 'Win', 'default2'), (5, 2, 'default1', 'default1'), (6, 3, 'Win', NULL), (7, 5, 'default1', 'default2'), (8, 1, 'default1', NULL), (9, 1, 'default1', 'default2'), (10, 3, 'default1', 'default2'), (11, 4, 'Win', 'default1'), (12, 2, 'Win', 'Win'), (13, 4, 'default1', 'Win'), (14, 1, NULL, 'default1'), (15, 4, NULL, 'Win'), (16, NULL, 'Win', 'default1'), (17, NULL, 'default2', 'default2'), (18, 1, 'Win', 'default2'), (19, 3, 'default2', NULL), (20, 2, NULL, 'default1'), (21, 3, 'default2', 'default2'), (22, 5, NULL, 'Win'), (23, 1, 'default2', 'default1'), (24, 5, 'default1', 'default2'), (25, 0, 'default1', 'default2');
INSERT INTO swimmer (id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, time) VALUES (0, 'default2', 'Win', 1.0, 'default1', 'default1', 'default1', 'Win', 'Win', 'default1', 'Win'), (1, 'default1', NULL, 1.0, 'default2', 'default2', NULL, NULL, 'Win', 'default1', 'default1'), (2, 'Win', NULL, 0.0, NULL, NULL, 'default2', 'Win', 'Win', 'Win', 'Win'), (3, NULL, 'default1', NULL, 'default1', 'Win', 'Win', NULL, 'Win', 'default1', NULL), (4, 'default2', 'default2', NULL, 'default1', 'default1', 'Win', 'default1', 'default2', 'default1', 'default1'), (5, 'Win', 'default2', NULL, NULL, 'default2', NULL, 'default1', NULL, NULL, 'default1'), (6, 'default2', 'default2', 0.0, NULL, 'Win', 'default2', NULL, 'default1', 'default1', 'Win'), (7, 'default2', NULL, 1.0, 'default2', 'Win', NULL, NULL, NULL, 'default2', 'default1'), (8, 'default1', 'Win', 1.0, 'Win', NULL, 'default1', NULL, 'Win', NULL, 'default1'), (9, 'Win', 'default1', 1.0, NULL, 'default2', 'default1', NULL, NULL, 'default1', 'default2'), (10, 'default2', 'default2', 0.0, 'Win', 'default2', NULL, 'default1', NULL, 'Win', 'default1'), (11, NULL, 'default1', NULL, 'default2', 'default1', 'Win', 'Win', NULL, 'Win', 'default2'), (12, 'default1', 'default1', NULL, 'default2', NULL, NULL, 'default1', NULL, 'Win', NULL), (13, NULL, 'Win', 1.0, 'default2', NULL, 'default1', NULL, 'default1', NULL, 'default2'), (14, 'default1', 'default1', 1.0, 'default1', 'default1', 'default1', 'default1', 'Win', NULL, NULL), (15, 'default1', 'default1', 1.0, 'default2', NULL, 'default2', 'default1', 'Win', 'default1', 'default1'), (16, 'default2', 'Win', 1.0, NULL, 'default2', 'default2', NULL, 'Win', NULL, 'default1'), (17, 'Win', 'Win', 1.0, 'Win', NULL, NULL, 'default1', NULL, 'default1', 'Win'), (18, 'Win', 'default1', NULL, 'default2', 'Win', 'Win', NULL, 'default1', NULL, 'default1'), (19, NULL, 'default1', 1.0, 'Win', NULL, NULL, 'default1', 'default2', 'default1', NULL), (20, NULL, 'default1', 1.0, 'default2', NULL, 'default2', 'default2', 'default1', 'default1', 'default2'), (21, NULL, 'default1', 1.0, NULL, 'default2', NULL, 'default2', 'default1', 'Win', 'default1'), (22, 'Win', 'default1', 0.0, 'default2', 'default2', NULL, 'default1', 'default2', 'default2', 'default2');
INSERT INTO record (swimmer_id, event_id, id, result) VALUES (5, 1, NULL, 'default2'), (5, 7, 0, 'default1'), (3, 13, 0, 'default2'), (0, 20, 0, NULL), (20, 2, 1, 'Win'), (1, 24, 1, 'default2'), (4, 5, NULL, 'Win'), (0, 1, 0, 'Win'), (6, 4, NULL, 'default2'), (10, 20, 0, 'default2'), (16, 12, 1, NULL), (7, 12, NULL, NULL), (18, 18, NULL, 'Win'), (14, 8, NULL, NULL), (12, 20, 1, 'default1'), (9, 9, NULL, 'Win'), (3, 23, 0, NULL), (0, 0, NULL, 'default2'), (9, 6, 0, 'default2'), (22, 24, NULL, NULL), (0, 15, NULL, 'Win'), (15, 3, NULL, 'default2'), (1, 25, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time", "id_other", "result", "event_id", "id" AS "swimmer_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."nationality" AS "nationality", "LHS"."meter_100" AS "meter_100", "LHS"."meter_200" AS "meter_200", "LHS"."meter_300" AS "meter_300", "LHS"."meter_400" AS "meter_400", "LHS"."meter_500" AS "meter_500", "LHS"."meter_600" AS "meter_600", "LHS"."meter_700" AS "meter_700", "LHS"."time" AS "time", "RHS"."id" AS "id_other", "RHS"."result" AS "result", "RHS"."event_id" AS "event_id" FROM "swimmer" AS "LHS" INNER JOIN "record" AS "RHS" ON ("LHS"."id" = "RHS"."swimmer_id"))) WHERE ("result" = 'Win') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Win',)
('Win',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Win';

/*
Prediction Result:
(None,)
('default2',)
('default2',)
('Win',)
('Win',)
('default2',)
*/