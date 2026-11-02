-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1226, 'really', 'four', 'Texas', 'sense', 'individual');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1227, 'past', 'worry', 'Texas', 'former', 'catch');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1228, 'other', 'every', 'Texas', 'edge', 'remain');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1229, 'necessary', 'democratic', 'Texas', 'evidence', 'quite');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1254, 'firm', 'wrong', 'Delaware', 'voice', 'clearly');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1255, 'work', 'unit', 'Delaware', 'both', 'expert');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1256, 'record', 'center', 'Delaware', 'situation', 'father');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1257, 'body', 'everything', 'Delaware', 'on', 'point');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1230, 'first', 'would');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1231, 'lot', 'baby');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1232, 'woman', 'act');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1233, 'society', 'low');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1258, 'develop', 'right');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1259, 'series', 'protect');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1260, 'gun', 'tonight');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1261, 'Democrat', 'mouth');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('really', 'first', 1234, 'pretty', 'Oregon', 'Angel Lewis MD', 1238, 1242, 1246, 1250, 'ready');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('really', 'first', 1241.0, 'pretty', 'Oregon', 'Shirley Suarez', 1253.0, 1259.0, 1265.0, 1271.0, 'newspaper');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('really', 'first', 1248.0, 'pretty', 'Oregon', 'Christopher Bass', 1268.0, 1276.0, 1284.0, 1292.0, 'across');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('really', 'first', 1255.0, 'pretty', 'Oregon', 'Lisa Archer', 1283.0, 1293.0, 1303.0, 1313.0, 'region');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('firm', 'develop', 1262, 'pretty', 'Oklahoma', 'Taylor Mathis Jr.', 1266, 1270, 1274, 1278, 'act');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('firm', 'develop', 1269.0, 'pretty', 'Oklahoma', 'Donald Smith', 1281.0, 1287.0, 1293.0, 1299.0, 'brother');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('firm', 'develop', 1276.0, 'pretty', 'Oklahoma', 'Mandy Green', 1296.0, 1304.0, 1312.0, 1320.0, 'bag');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('firm', 'develop', 1283.0, 'pretty', 'Oklahoma', 'Kristen Patterson', 1311.0, 1321.0, 1331.0, 1341.0, 'you');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('firm', 'develop', 1284.0, 'pretty', 'Oklahoma', 'Kristen Patterson', 1311.0, 1321.0, 1331.0, 1341.0, 'you');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT state, winery, COUNT(*) AS n FROM wine GROUP BY state, winery) WHERE (n >= 4) ORDER BY winery;

/*
Gold Result:
('pretty',)
('pretty',)
*/

-- Prediction Query
SELECT Winery FROM WINE GROUP BY Winery HAVING COUNT(*) >= 4;

/*
Prediction Result:
('pretty',)
*/