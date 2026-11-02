-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO railway (railway_id, railway, builder, built, wheels, location, objectnumber) VALUES (0, 'default2', 'default1', 'default1', 'default2', 'default1', 'default1'), (1, 'default1', NULL, NULL, NULL, 'default1', NULL), (2, 'default2', NULL, NULL, 'default2', 'default1', 'default2'), (3, 'default2', NULL, 'default2', 'default1', NULL, NULL);
INSERT INTO train (train_id, railway_id, train_num, name, "from", arrival) VALUES (0, 0, 'default2', 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT objectnumber FROM (SELECT * FROM railway AS LHS WHERE NOT EXISTS(SELECT 1 FROM train AS RHS WHERE (LHS.railway_id = RHS.railway_id))) ORDER BY objectnumber;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT ObjectNumber FROM railway WHERE NOT Railway_ID IN (SELECT Railway_ID FROM train);

/*
Prediction Result:
(None,)
('default2',)
(None,)
*/