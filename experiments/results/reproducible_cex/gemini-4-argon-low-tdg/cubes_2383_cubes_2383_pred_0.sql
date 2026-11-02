-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (10, 2, 'Ueli Steck', 'Switzerland', '02:22:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (20, 1, 'Reinhold Messner', 'Italy', '04:00:00', 95.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (30, 1, 'Reinhold Messner', 'Germany', '05:00:00', 90.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (40, 2, 'Alex Honnold', 'USA', '03:15:00', 98.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "climber" WHERE ("country" <> 'Switzerland') ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
('Alex Honnold',)
('Reinhold Messner',)
('Reinhold Messner',)
*/

-- Prediction Query
SELECT Name FROM climber WHERE Country <> 'Switzerland';

/*
Prediction Result:
('Reinhold Messner',)
('Reinhold Messner',)
('Alex Honnold',)
*/