-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'New York', 'Alpha Arena', 50000, 48000, 12000, 30000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Chicago', 'Beta Dome', 60000, 55000, 15000, 35000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (10, 'Boston', 'Gamma Field', 40000, 39000, 10000, 25000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (20, 'Seattle', 'Delta Park', 45000, 42000, 11000, 28000);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '10', 'Summer Jam', 'Rock', '2021');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (2, '20', 'Winter Fest', 'Pop', '2018');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (3, '1', 'Autumn Beats', 'Jazz', '2015');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (4, '2', 'Spring Vibes', 'Classical', '2016');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (5, '10', 'Solo Night', 'Indie', '2023');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM (SELECT LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, RHS.concert_id AS concert_id_other, RHS.concert_name AS concert_name_other, RHS.theme AS theme_other, RHS.year AS year_other, RHS.n AS n FROM concert AS LHS INNER JOIN (SELECT concert_id, concert_name, theme, stadium_id, YEAR, COUNT(*) OVER () AS n FROM concert) AS RHS ON (LHS.concert_id = RHS.stadium_id)) ORDER BY YEAR;

/*
Gold Result:
('2018',)
('2021',)
*/

-- Prediction Query
SELECT YEAR FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC, YEAR NULLS LAST LIMIT 1;

/*
Prediction Result:
('2015',)
*/