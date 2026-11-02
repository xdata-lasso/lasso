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
INSERT INTO alignment (id, alignment) VALUES (1, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (2, 'Good');
INSERT INTO alignment (id, alignment) VALUES (3, 'Bad');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (3, 'Speed');
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (1, 'HeroOne', 'FullOne', 3, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (2, 'HeroTwo', 'FullTwo', 1, 175, 75);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (3, 'HeroThree', 'FullThree', 2, 185, 85);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 2, 200);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 40);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 3, 55);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 2, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(47.5,)
*/

-- Prediction Query
SELECT AVG(ha.attribute_value) FROM superhero AS s JOIN hero_attribute AS ha ON s.id = ha.hero_id WHERE s.alignment_id = 3;

/*
Prediction Result:
(200.0,)
*/