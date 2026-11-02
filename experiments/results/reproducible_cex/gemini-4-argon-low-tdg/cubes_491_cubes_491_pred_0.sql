-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "stadium" ("Stadium_ID", "Location", "Name", "Capacity", "Highest", "Lowest", "Average") VALUES (10, 'Paris', 'Twin Stadium', 30000, 29000, 5000, 15000);
INSERT INTO "stadium" ("Stadium_ID", "Location", "Name", "Capacity", "Highest", "Lowest", "Average") VALUES (20, 'Berlin', 'Twin Stadium', 70000, 65000, 30000, 50000);
INSERT INTO "stadium" ("Stadium_ID", "Location", "Name", "Capacity", "Highest", "Lowest", "Average") VALUES (30, 'Rome', 'Unique Field', 45000, 40000, 10000, 25000);
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (201, '10', 'Concert A', 'Classical', '2019');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (202, '10', 'Concert B', 'Classical', '2020');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (203, '10', 'Concert C', 'Opera', '2021');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (204, '20', 'Concert D', 'Indie', '2022');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (205, '30', 'Concert E', 'Metal', '2023');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.stadium_id AS stadium_id, LHS.location AS LOCATION, LHS.name AS name, LHS.capacity AS capacity, LHS.highest AS highest, LHS.lowest AS lowest, LHS.average AS average, RHS.n AS n FROM stadium AS LHS INNER JOIN (SELECT stadium_id, COUNT(*) AS n FROM concert GROUP BY stadium_id) AS RHS ON (LHS.stadium_id = RHS.stadium_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Twin Stadium', 1)
('Twin Stadium', 3)
('Unique Field', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id;

/*
Prediction Result:
('Twin Stadium', 3)
('Twin Stadium', 1)
('Unique Field', 1)
*/