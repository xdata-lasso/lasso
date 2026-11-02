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
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel');
INSERT INTO colour (id, colour) VALUES (1, 'Red');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO race (id, race) VALUES (10, 'Vampire');
INSERT INTO race (id, race) VALUES (20, 'vampire');
INSERT INTO race (id, race) VALUES (30, 'Vampire Lord');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (100, 'Blade', 'Eric Brooks', 1, 1, 1, 1, 10, 1, 1, 188, 97);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (101, 'Blade', 'Duplicate Name', 1, 1, 1, 1, 10, 1, 1, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (102, NULL, 'Nameless Vampire', 1, 1, 1, 1, 10, 1, 1, 175, 70);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (103, 'Iron Man', 'Tony Stark', 1, 1, 1, 1, 1, 1, 1, 185, 90);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (104, 'Mystery', 'No Race Hero', 1, 1, 1, 1, NULL, 1, 1, 180, 75);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (105, 'Fake Vamp 1', 'Lowercase Race', 1, 1, 1, 1, 20, 1, 1, 180, 75);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (106, 'Fake Vamp 2', 'Substring Race', 1, 1, 1, 1, 30, 1, 1, 180, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.id) FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id WHERE T1.race = 'Vampire';

/*
Prediction Result:
(3,)
*/