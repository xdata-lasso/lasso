-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "alignment" ("id", "alignment") VALUES (1465, 'notice');
INSERT INTO "alignment" ("id", "alignment") VALUES (1466, 'area');
INSERT INTO "alignment" ("id", "alignment") VALUES (1467, 'hard');
INSERT INTO "alignment" ("id", "alignment") VALUES (1468, 'door');
INSERT INTO "alignment" ("id", "alignment") VALUES (1505, 'test');
INSERT INTO "alignment" ("id", "alignment") VALUES (1506, 'might');
INSERT INTO "alignment" ("id", "alignment") VALUES (1507, 'born');
INSERT INTO "alignment" ("id", "alignment") VALUES (1508, 'lead');
INSERT INTO "colour" ("id", "colour") VALUES (1469, 'rate');
INSERT INTO "colour" ("id", "colour") VALUES (1470, 'authority');
INSERT INTO "colour" ("id", "colour") VALUES (1471, 'statement');
INSERT INTO "colour" ("id", "colour") VALUES (1472, 'reach');
INSERT INTO "colour" ("id", "colour") VALUES (1509, 'high');
INSERT INTO "colour" ("id", "colour") VALUES (1510, 'prove');
INSERT INTO "colour" ("id", "colour") VALUES (1511, 'vote');
INSERT INTO "colour" ("id", "colour") VALUES (1512, 'them');
INSERT INTO "colour" ("id", "colour") VALUES (1489, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1493, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1529, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1533, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1473, 'amount');
INSERT INTO "gender" ("id", "gender") VALUES (1474, 'somebody');
INSERT INTO "gender" ("id", "gender") VALUES (1475, 'allow');
INSERT INTO "gender" ("id", "gender") VALUES (1476, 'end');
INSERT INTO "gender" ("id", "gender") VALUES (1513, 'machine');
INSERT INTO "gender" ("id", "gender") VALUES (1514, 'second');
INSERT INTO "gender" ("id", "gender") VALUES (1515, 'claim');
INSERT INTO "gender" ("id", "gender") VALUES (1516, 'learn');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1477, 'Alex Hernandez');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1478, 'Michael Elliott');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1479, 'Michael Wang');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1480, 'Lawrence Adkins');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1517, 'Joseph Santos');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1518, 'Tamara Hampton');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1519, 'Roger Vargas');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1520, 'David Michael');
INSERT INTO "race" ("id", "race") VALUES (1481, 'building');
INSERT INTO "race" ("id", "race") VALUES (1482, 'star');
INSERT INTO "race" ("id", "race") VALUES (1483, 'tell');
INSERT INTO "race" ("id", "race") VALUES (1484, 'common');
INSERT INTO "race" ("id", "race") VALUES (1521, 'family');
INSERT INTO "race" ("id", "race") VALUES (1522, 'upon');
INSERT INTO "race" ("id", "race") VALUES (1523, 'little');
INSERT INTO "race" ("id", "race") VALUES (1524, 'either');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1485, 'Laura Barnett', 'Sarah Burke', 1473, 1469, 1489, 1493, 1481, 1477, 1465, 1537, 2616.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1486, 'Michael Rubio', 'William Patton', 1473, 1469, 1489, 1493, 1481, 1477, 1465, 1520.0, 2596.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1487, 'Miguel Jones', 'Jeffrey Wood', 1473, 1469, 1489, 1493, 1481, 1477, 1465, 1543.0, 2586.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1488, 'Lori Garcia', 'Gloria Atkinson', 1473, 1469, 1489, 1493, 1481, 1477, 1465, 1566.0, 2576.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1525, 'Ashley Johnson', 'Cheryl Allen', 1513, 1509, 1529, 1533, 1521, 1517, 1505, 1497, 2616.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1526, 'Johnny Nguyen', 'Justin Allen', 1513, 1509, 1529, 1533, 1521, 1517, 1505, 1560.0, 2506.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1527, 'Mr. David Ramirez', 'Michael West', 1513, 1509, 1529, 1533, 1521, 1517, 1505, 1583.0, 2496.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1528, 'Sheryl Peters', 'Edward Sullivan', 1513, 1509, 1529, 1533, 1521, 1517, 1505, 1606.0, 2486.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('rate',)
*/

-- Prediction Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.weight_kg = (SELECT MAX(T1.weight_kg) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id);

/*
Prediction Result:
('rate',)
('high',)
*/