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
INSERT INTO "alignment" ("id", "alignment") VALUES (1433, 'two');
INSERT INTO "alignment" ("id", "alignment") VALUES (1481, 'Mr');
INSERT INTO "alignment" ("id", "alignment") VALUES (1529, 'reflect');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1437, 'Durability');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1485, 'Durability');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1533, 'Durability');
INSERT INTO "colour" ("id", "colour") VALUES (1441, 'clear');
INSERT INTO "colour" ("id", "colour") VALUES (1489, 'not');
INSERT INTO "colour" ("id", "colour") VALUES (1537, 'same');
INSERT INTO "colour" ("id", "colour") VALUES (1461, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1465, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1509, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1513, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1557, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1561, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1445, 'treatment');
INSERT INTO "gender" ("id", "gender") VALUES (1493, 'business');
INSERT INTO "gender" ("id", "gender") VALUES (1541, 'dark');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1449, 'Dark Horse Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1497, 'Dark Horse Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1545, 'Dark Horse Comics');
INSERT INTO "race" ("id", "race") VALUES (1453, 'cost');
INSERT INTO "race" ("id", "race") VALUES (1501, 'partner');
INSERT INTO "race" ("id", "race") VALUES (1549, 'hundred');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1457, 'Tim Patton', 'Thomas Bailey', 1445, 1441, 1461, 1465, 1453, 1449, 1433, 1469, 1473);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1505, 'Tim Patton', 'Teresa Mclaughlin', 1493, 1489, 1509, 1513, 1501, 1497, 1481, 1517, 1521);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1553, 'Keith Sullivan', 'Toni Fitzgerald', 1541, 1537, 1557, 1561, 1549, 1545, 1529, 1565, 1569);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1457, 1437, 10);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1505, 1485, 100);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1553, 1533, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Tim Patton',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN publisher AS p ON s.publisher_id = p.id INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Durability' AND p.publisher_name = 'Dark Horse Comics' AND ha.attribute_value = (SELECT MAX(ha2.attribute_value) FROM superhero AS s2 INNER JOIN hero_attribute AS ha2 ON s2.id = ha2.hero_id INNER JOIN attribute AS a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Durability' AND s2.publisher_id = p.id);

/*
Prediction Result:
('Tim Patton',)
('Tim Patton',)
('Keith Sullivan',)
*/