-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1004, 'fall', 'they', 'his', 'hear', '283 Steven Groves
Lake Mark, WI 07832', 'pick');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1005, 'long', 'they', 'commercial', 'determine', '6413 Lewis Parks
Wilkersonmouth, FL 35219', 'attack');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1006, 'prove', 'they', 'hospital', 'religious', '969 Cox Dam Suite 101
Lake Ernest, TX 55834', 'image');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1007, NULL, 'enter', 'on', 'activity', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'someone');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1008, NULL, 'enter', 'traditional', 'response', '809 Burns Creek
Natashaport, IA 08093', 'show');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1009, NULL, 'enter', 'yes', 'set', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'road');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT builder FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) WHERE (n <> 1) ORDER BY builder;

/*
Gold Result:
('enter',)
('they',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('enter',)
*/