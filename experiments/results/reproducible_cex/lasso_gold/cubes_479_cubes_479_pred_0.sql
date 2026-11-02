-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1001, '433 Jill Springs
New Roberttown, CO 29158', 'Lance Hoffman', 1002, 1003, 1004, 1005);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1006, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1001, 1001, 'Meredith Barnes', 'list', 'perform');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1006, 1006, 'Sean Blake', 'collection', 'save');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM (SELECT LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, RHS.concert_id AS concert_id_other, RHS.concert_name AS concert_name_other, RHS.theme AS theme_other, RHS.year AS year_other, RHS.n AS n FROM concert AS LHS INNER JOIN (SELECT concert_id, concert_name, theme, stadium_id, YEAR, COUNT(*) OVER () AS n FROM concert) AS RHS ON (LHS.concert_id = RHS.stadium_id)) ORDER BY YEAR;

/*
Gold Result:
('perform',)
('save',)
*/

-- Prediction Query
SELECT YEAR FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC, YEAR NULLS LAST LIMIT 1;

/*
Prediction Result:
('perform',)
*/