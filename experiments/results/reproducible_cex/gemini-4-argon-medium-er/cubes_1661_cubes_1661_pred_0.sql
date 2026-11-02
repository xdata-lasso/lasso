-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'R1', 'B1', '1900', 'B', 'Loc1', 'Obj1');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'R2', 'B2', '1901', 'A', 'Loc2', 'Obj2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT wheels, LOCATION FROM railway ORDER BY wheels, railway.railway_id NULLS LAST;

/*
Gold Result:
('A', 'Loc2')
('B', 'Loc1')
*/

-- Prediction Query
SELECT Wheels, LOCATION FROM railway;

/*
Prediction Result:
('B', 'Loc1')
('A', 'Loc2')
*/