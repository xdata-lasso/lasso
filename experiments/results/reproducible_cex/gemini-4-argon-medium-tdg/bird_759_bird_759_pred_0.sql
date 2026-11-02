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
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO colour (id, colour) VALUES (2, 'Red');
INSERT INTO colour (id, colour) VALUES (3, 'Green');
INSERT INTO colour (id, colour) VALUES (4, 'Black');
INSERT INTO colour (id, colour) VALUES (5, 'White');
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (1, 'Hero_Lightest_Tallest', 1, 4, 5, 300, 50);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (2, 'Hero_Middle', 2, 4, 5, 200, 100);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (3, 'Hero_Heaviest_Shortest', 3, 4, 5, 100, 200);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (4, 'Hero_No_Eyes_Super_Heavy', NULL, 4, 5, 400, 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Green',)
*/

-- Prediction Query
SELECT colour.colour FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.weight_kg = (SELECT MAX(weight_kg) FROM superhero);

/*
Prediction Result:
*/