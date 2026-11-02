-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Dufourspitze', 4634.0, 2165.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Puncak Jaya', 4884.0, 4884.0, 'Sudirman', 'Indonesia');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Puncak Trikora', 4750.0, 1268.0, 'Sudirman', 'Indonesia');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (6, 'Mount Elbert', 4401.0, 2772.0, 'Rockies', 'USA');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (7, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Alice', 'UK', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 1, 'Bob', 'USA', '12:00', 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT * FROM (SELECT * FROM (SELECT height, RANGE, COUNT(*) AS n FROM mountain GROUP BY height, RANGE) ORDER BY RANGE DESC) LIMIT 1);

/*
Gold Result:
('Sudirman',)
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alps',)
*/