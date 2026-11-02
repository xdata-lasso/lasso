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
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'DC Comics');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Hero_Zero_A', 'Clark Kent', 1, 1, 1, 1, 1, 1, 1, 180, 0);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Hero_Zero_B', 'Clark Kent', 1, 1, 1, 1, 1, 1, 1, 185, 0);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Hero_NullWeight', 'Bruce Wayne', 1, 1, 1, 1, 1, 1, 1, 0, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Hero_NullName_ZeroWeight', NULL, 1, 1, 1, 1, 1, 1, 1, 180, 0);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (5, 'Hero_NullName_NullWeight', NULL, 1, 1, 1, 1, 1, 1, 1, 180, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (6, 'Hero_NullName_PosWeight', NULL, 1, 1, 1, 1, 1, 1, 1, 180, 85);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (7, 'Hero_NegWeight', 'Barry Allen', 1, 1, 1, 1, 1, 1, 1, 180, -99);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (8, 'Hero_PosWeight_1', 'Hal Jordan', 1, 1, 1, 1, 1, 1, 1, 180, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (9, 'Hero_PosWeight_100', 'Arthur Curry', 1, 1, 1, 1, 1, 1, 1, 0, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT full_name FROM superhero WHERE NOT full_name IS NULL AND (weight_kg IS NULL OR weight_kg = 0);

/*
Gold Result:
('Clark Kent',)
('Bruce Wayne',)
*/

-- Prediction Query
SELECT full_name FROM superhero WHERE weight_kg = 0 OR weight_kg IS NULL;

/*
Prediction Result:
('Clark Kent',)
('Clark Kent',)
('Bruce Wayne',)
(None,)
(None,)
*/