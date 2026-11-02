-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1004, 'determine', 'not', 'capital', 'win', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1005, 'machine', 'religious', 'example', 'election', 'USS Lynch
FPO AE 70511', 'shoulder');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT wheels, LOCATION FROM railway ORDER BY wheels, railway.railway_id NULLS LAST;

/*
Gold Result:
('election', 'USS Lynch\nFPO AE 70511')
('win', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
*/

-- Prediction Query
SELECT Wheels, LOCATION FROM railway;

/*
Prediction Result:
('win', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
('election', 'USS Lynch\nFPO AE 70511')
*/