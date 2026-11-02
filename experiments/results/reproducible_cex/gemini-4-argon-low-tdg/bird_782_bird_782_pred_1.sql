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
INSERT INTO colour (id, colour) VALUES (1, 'Black');
INSERT INTO colour (id, colour) VALUES (2, 'Black');
INSERT INTO colour (id, colour) VALUES (3, 'black');
INSERT INTO colour (id, colour) VALUES (4, 'Black Widow');
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (1, 'Hero_Diff_Black_IDs', 'Full_Diff_Black', 1, 2, 3);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (2, 'Hero_Same_Black_ID1', 'Full_Same_1', 1, 1, 3);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (3, 'Hero_Same_Black_ID2', 'Full_Same_2', 2, 2, 3);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (4, 'Hero_Lowercase_Black', 'Full_Lower', 3, 3, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (5, 'Hero_Substring_Black', 'Full_Substring', 4, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
('Hero_Same_Black_ID1',)
('Hero_Same_Black_ID2',)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero INNER JOIN colour AS eye_colour ON superhero.eye_colour_id = eye_colour.id INNER JOIN colour AS hair_colour ON superhero.hair_colour_id = hair_colour.id WHERE eye_colour.colour = 'Black' AND hair_colour.colour = 'Black';

/*
Prediction Result:
('Hero_Diff_Black_IDs',)
('Hero_Same_Black_ID1',)
('Hero_Same_Black_ID2',)
*/