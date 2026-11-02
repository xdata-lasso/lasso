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
-- DATASET 2
-- Tests:
-- 1. AVG(weight_kg) or COUNT(weight_kg) vs SUM(weight_kg) / COUNT(T1.id) when weight_kg is NULL.
--    Gold calculates: (100 + 50) / 3 = 50.0. AVG(weight_kg) calculates: (100 + 50) / 2 = 75.0.
-- 2. Filtering out weight_kg <= 0 (includes 0 and negative weights if mutated).
-- 3. Case sensitivity / exact match on 'Alien' vs 'alien' or 'Alien '.
INSERT INTO race (id, race) VALUES (10, 'Alien');
INSERT INTO race (id, race) VALUES (20, 'alien');
INSERT INTO race (id, race) VALUES (30, 'Alien Warrior');
INSERT INTO superhero (id, superhero_name, race_id, height_cm, weight_kg) VALUES (1, 'AlienWithWeight1', 10, 100, 100);
INSERT INTO superhero (id, superhero_name, race_id, height_cm, weight_kg) VALUES (2, 'AlienWithWeight2', 10, 150, 50);
INSERT INTO superhero (id, superhero_name, race_id, height_cm, weight_kg) VALUES (3, 'AlienNullWeight', 10, 200, NULL);
INSERT INTO superhero (id, superhero_name, race_id, height_cm, weight_kg) VALUES (4, 'LowercaseAlien', 20, 180, 500);
INSERT INTO superhero (id, superhero_name, race_id, height_cm, weight_kg) VALUES (5, 'PrefixAlien', 30, 180, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.weight_kg) AS REAL) / COUNT(T1.id) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Alien';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT AVG(s.weight_kg) AS average_weight FROM superhero AS s JOIN race AS r ON s.race_id = r.id WHERE r.race = 'Alien';

/*
Prediction Result:
(75.0,)
*/