-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'K2', 8611.0, 4020.0, 'Karakoram', 'Pakistan');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Zugspitze', 2962.0, 1746.0, 'Wetterstein', 'Germany');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Alice', 'France', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 1, 'Bob', 'UK', '12:00', 90.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, 3, 'Charlie', 'USA', '24:00', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT * FROM (SELECT * FROM (SELECT height, RANGE, COUNT(*) AS n FROM mountain GROUP BY height, RANGE) ORDER BY RANGE DESC) LIMIT 1);

/*
Gold Result:
('Wetterstein',)
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alps',)
*/