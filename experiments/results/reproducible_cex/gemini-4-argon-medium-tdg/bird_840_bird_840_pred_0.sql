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
INSERT INTO race (id, race) VALUES (1, 'Atlantean');
INSERT INTO attribute (id, attribute_name) VALUES (10, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (20, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (30, 'Speed');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Aquababy', 'Arthur Curry Jr.', 1, 1, 1, 1, 1, 1, 1, 60, 10);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Aquaman', 'Aquababy', 1, 1, 1, 1, 1, 1, 1, 185, 146);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 10, 50);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 20, 50);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 30, 75);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 10, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id WHERE T1.superhero_name = 'Aquababy';

/*
Gold Result:
(50,)
(50,)
(75,)
*/

-- Prediction Query
SELECT T2.attribute_name, T1.attribute_value FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T3.superhero_name = 'Aquababy';

/*
Prediction Result:
('Intelligence', 50)
('Strength', 50)
('Speed', 75)
*/