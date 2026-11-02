-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'London', 'Wembley', 90000, 90000, 10000, 50000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Manchester', 'Old Trafford', 74000, 74000, 20000, 60000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (3, 'Madrid', 'Bernabeu', 81000, 81000, 30000, 70000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (4, 'Barcelona', 'Wembley', 99000, 99000, 40000, 80000);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '2', 'Rock Fest', 'Rock', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (2, '2', 'Pop Night', 'Pop', '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM concert AS RHS WHERE (LHS.stadium_id = RHS.stadium_id))) ORDER BY name;

/*
Gold Result:
('Bernabeu',)
('Wembley',)
('Wembley',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT stadium_id IN (SELECT stadium_id FROM concert);

/*
Prediction Result:
('Wembley',)
('Bernabeu',)
('Wembley',)
*/