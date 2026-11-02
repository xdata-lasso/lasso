-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1052, 'Michael Carlson', 1053.5, 1054.5, 'image', 'Nepal');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1057, 'Melanie Herrera', 1058.5, 1059.5, 'example', 'Seychelles');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1062, 'Sherri Baker', 1063.5, 1064.5, 'month', 'Serbia');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (0, 1052, 'Kendra Maddox DVM', 'Algeria', 'response', 1056.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (150, 1057, 'Kendra Maddox DVM', 'Korea', 'about', 1061.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (20, 1062, 'Lisa Hernandez', 'French Southern Territories', 'thought', 1066.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM climber ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
('Kendra Maddox DVM',)
('Kendra Maddox DVM',)
('Lisa Hernandez',)
*/

-- Prediction Query
SELECT Name FROM climber ORDER BY Points DESC, climber.climber_id NULLS LAST;

/*
Prediction Result:
('Lisa Hernandez',)
('Kendra Maddox DVM',)
('Kendra Maddox DVM',)
*/