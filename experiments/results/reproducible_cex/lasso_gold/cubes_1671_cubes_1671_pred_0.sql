-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1006, 'sea', 'available', 'answer', 'recently', '31647 Martin Knoll Apt. 419
New Jessica, GA 61090', 'hundred');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1008, 'stand', 'arrive', 'drop', 'term', '4139 Lewis Parks Suite 724
East Julie, ND 34939', 'skin');
INSERT INTO "train" ("train_id", "railway_id", "train_num", "name", "from", "arrival") VALUES (1007, 1006, 'expect', 'Peter Callahan Jr.', 'certainly', 'Mr');
INSERT INTO "train" ("train_id", "railway_id", "train_num", "name", "from", "arrival") VALUES (1009, 1008, 'pattern', 'Margaret Hawkins DDS', 'threat', 'special');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, arrival FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Margaret Hawkins DDS', 'special')
('Peter Callahan Jr.', 'Mr')
*/

-- Prediction Query
SELECT Name, Arrival FROM train;

/*
Prediction Result:
('Peter Callahan Jr.', 'Mr')
('Margaret Hawkins DDS', 'special')
*/