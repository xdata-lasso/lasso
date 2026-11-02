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
INSERT INTO colour (id, colour) VALUES (10, 'Black');
INSERT INTO colour (id, colour) VALUES (20, 'Black');
INSERT INTO colour (id, colour) VALUES (30, 'black');
INSERT INTO colour (id, colour) VALUES (40, 'Blackish');
INSERT INTO colour (id, colour) VALUES (50, NULL);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (1, 'Dup_Hero_Name', 'Real_Name_1', 10, 10, 30);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (2, 'Dup_Hero_Name', 'Real_Name_2', 10, 10, 30);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (3, 'Hero_Diff_Black_IDs', 'Real_Name_3', 10, 20, 10);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (4, 'Hero_Lowercase_Black', 'Real_Name_4', 30, 30, 10);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (5, 'Hero_Substring_Black', 'Real_Name_5', 40, 40, 10);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (6, 'Hero_Null_Colour_Text', 'Real_Name_6', 50, 50, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
('Dup_Hero_Name',)
('Dup_Hero_Name',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Black' AND T3.colour = 'Black';

/*
Prediction Result:
('Dup_Hero_Name',)
('Dup_Hero_Name',)
('Hero_Diff_Black_IDs',)
*/