-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'USA', 330000000, 9833520, 'English');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (1, 1, 'Coaster A', 'Park A', 1000.0, 100.0, '50 mph', '2000', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (2, 1, 'Coaster B', 'Park B', 1200.0, 120.0, '60 mph', '2005', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.n AS n FROM roller_coaster AS LHS LEFT JOIN (SELECT roller_coaster_id, name, park, country_id, LENGTH, height, speed, opened, status, COUNT(*) OVER () AS n FROM roller_coaster) AS RHS ON (LHS.roller_coaster_id = RHS.roller_coaster_id AND LHS.name = RHS.name AND LHS.park = RHS.park AND LHS.country_id = RHS.country_id AND LHS.length = RHS.length AND LHS.height = RHS.height AND LHS.speed = RHS.speed AND LHS.opened = RHS.opened AND LHS.status = RHS.status)) ORDER BY status;

/*
Gold Result:
('Closed',)
('Operating',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('Closed',)
*/