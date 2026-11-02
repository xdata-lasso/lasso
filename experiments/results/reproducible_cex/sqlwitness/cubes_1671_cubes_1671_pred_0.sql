-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, railway_id, train_num, name, "from", arrival) VALUES (1, NULL, 'default1', NULL, 'default2', 'default1'), (0, NULL, NULL, NULL, NULL, NULL), (2, NULL, NULL, 'default2', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, arrival FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, 'default1')
('default2', 'default1')
*/

-- Prediction Query
SELECT Name, Arrival FROM train;

/*
Prediction Result:
(None, None)
(None, 'default1')
('default2', 'default1')
*/