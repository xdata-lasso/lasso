-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1062, 'Linda Cruz', 1063.5, 1064.5, 'pick', 'Lao People''s Democratic Republic');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1067, 'Melanie Herrera', 1068.5, 1069.5, 'example', 'Seychelles');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1065, 1062, 'Tricia Valencia', 'Algeria', 'about', 1066.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1070, 1067, 'Sherri Baker', 'Korea', 'response', 1067.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "climber" WHERE ("country" <> 'Switzerland') ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
('Sherri Baker',)
('Tricia Valencia',)
*/

-- Prediction Query
SELECT Name FROM climber WHERE Country <> 'Switzerland';

/*
Prediction Result:
('Tricia Valencia',)
('Sherri Baker',)
*/