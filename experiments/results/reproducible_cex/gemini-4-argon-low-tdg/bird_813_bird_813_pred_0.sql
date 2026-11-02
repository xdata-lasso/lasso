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
-- DATASET 5
-- Tests mutants that unnecessarily join `hero_power` or `superpower` (causes row fan-out or drops heroes without powers)
-- Also tests mutants that include `GROUP BY` (e.g., GROUP BY hero_id or alignment_id) when multiple 'Neutral' alignment rows or heroes exist.
INSERT INTO alignment (id, alignment) VALUES (1, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (2, 'Neutral');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Combat');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Durability');
INSERT INTO superpower (id, power_name) VALUES (1, 'Flight');
INSERT INTO superpower (id, power_name) VALUES (2, 'Invisibility');
INSERT INTO superhero (id, superhero_name, alignment_id) VALUES (1, 'Powerless_Neutral_Hero', 1);
INSERT INTO superhero (id, superhero_name, alignment_id) VALUES (2, 'MultiPower_Neutral_Hero', 2);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 1, 20);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 40);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 2, 70);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(43.333333333333336,)
*/

-- Prediction Query
SELECT AVG(attribute_value) FROM hero_attribute WHERE hero_id IN (SELECT id FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Neutral'));

/*
Prediction Result:
(20.0,)
*/