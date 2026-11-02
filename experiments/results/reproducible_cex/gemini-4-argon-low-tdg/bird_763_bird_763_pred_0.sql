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
INSERT INTO attribute (id, attribute_name) VALUES (10, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (20, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (30, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Abomination');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (1, 'Abomination', 'Emil Blonsky');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (2, 'Batman', 'Abomination');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (3, 'Abomination II', 'Other');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (4, 'abomination', 'Lowercase');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (5, NULL, 'NullName');
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 10, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 20, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 30, 50);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 99);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 10, 40);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 10, 30);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (5, 10, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id WHERE T1.superhero_name = 'Abomination';

/*
Gold Result:
(80,)
(80,)
(50,)
*/

-- Prediction Query
SELECT T2.attribute_name, T1.attribute_value FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T3.superhero_name = 'Abomination';

/*
Prediction Result:
('Intelligence', 80)
('Strength', 80)
('Speed', 50)
*/