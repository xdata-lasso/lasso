-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'Austria', 9000000, 83871, 'German');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (2, 'France', 67000000, 643801, 'French');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (3, 'Germany', 83000000, 357022, 'German');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (4, 'Brazil', 212000000, 8515767, 'Portuguese');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (5, 'Atlantis', 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "country" WHERE ("languages" <> 'German') ORDER BY name, country.country_id NULLS LAST;

/*
Gold Result:
('Brazil',)
('France',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Languages <> 'German';

/*
Prediction Result:
('France',)
('Brazil',)
*/