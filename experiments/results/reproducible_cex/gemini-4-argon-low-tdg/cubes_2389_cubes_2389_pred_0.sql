-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 3, 'Hillary', 'New Zealand', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 3, 'Norgay', 'Nepal', '10:00', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM mountain AS LHS WHERE NOT EXISTS(SELECT 1 FROM climber AS RHS WHERE (LHS.mountain_id = RHS.mountain_id))) ORDER BY name;

/*
Gold Result:
('K2',)
('Matterhorn',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE NOT Mountain_ID IN (SELECT Mountain_ID FROM climber);

/*
Prediction Result:
('Matterhorn',)
('K2',)
*/