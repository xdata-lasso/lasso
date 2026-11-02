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
-- DATASET 1
-- Tests basic matching, DISTINCT deduplication, AND vs OR in WHERE clause, and boundary values (107, 108, 109 and 187, 188, 189).
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO race (id, race) VALUES (2, 'Mutant');
INSERT INTO race (id, race) VALUES (3, 'Alien');
INSERT INTO race (id, race) VALUES (4, 'Cyborg');
INSERT INTO race (id, race) VALUES (5, 'God');
-- Target matches (two heroes of the same race to test DISTINCT)
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (10, 'HeroMatch1', 1, 108, 188);
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (11, 'HeroMatch2', 1, 108, 188);
-- Partial matches (tests AND vs OR, and single predicate omission)
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (12, 'WeightOnly', 2, 108, 180);
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (13, 'HeightOnly', 3, 100, 188);
-- Boundary values (tests >, <, >=, <=, != mutations)
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (14, 'WeightLow', 4, 107, 188);
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (15, 'WeightHigh', 4, 109, 188);
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (16, 'HeightLow', 5, 108, 187);
INSERT INTO superhero (id, superhero_name, race_id, weight_kg, height_cm) VALUES (17, 'HeightHigh', 5, 108, 189);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.race FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T1.weight_kg = 108 AND T1.height_cm = 188;

/*
Gold Result:
('Human',)
*/

-- Prediction Query
SELECT T1.race FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id WHERE T2.weight_kg = 108 AND T2.height_cm = 188;

/*
Prediction Result:
('Human',)
('Human',)
*/