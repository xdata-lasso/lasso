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
INSERT INTO colour (id, colour) VALUES (1, 'No Colour');
INSERT INTO colour (id, colour) VALUES (2, 'Blue');
INSERT INTO colour (id, colour) VALUES (3, 'Prefix No Colour');
INSERT INTO colour (id, colour) VALUES (4, 'No Colour Suffix');
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (1, 'Hero_Boundary_Low_In', 'Full_1', 1, 2, 2, 170, 80);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (2, 'Hero_Boundary_High_In', 'Full_2', 1, 2, 2, 190, 80);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (3, 'Hero_Mid_In', 'Full_3', 1, 2, 2, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (4, 'Hero_Boundary_Low_Out', 'Full_4', 1, 2, 2, 169, 180);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (5, 'Hero_Boundary_High_Out', 'Full_5', 1, 2, 2, 191, 180);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (6, 'Hero_Height_Null', 'Full_6', 1, 2, 2, NULL, 180);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.height_cm BETWEEN 170 AND 190 AND T2.colour LIKE 'No Colour';

/*
Gold Result:
('Hero_Boundary_Low_In',)
('Hero_Boundary_High_In',)
('Hero_Mid_In',)
*/

-- Prediction Query
SELECT superhero_name FROM superhero WHERE height_cm BETWEEN 170 AND 190 AND eye_colour_id IS NULL;

/*
Prediction Result:
*/