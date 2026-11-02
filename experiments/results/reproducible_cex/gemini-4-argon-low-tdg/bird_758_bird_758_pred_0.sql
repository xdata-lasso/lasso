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
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO race (id, race) VALUES (2, 'Mutant');
INSERT INTO race (id, race) VALUES (3, 'Human-Kree');
INSERT INTO colour (id, colour) VALUES (1, 'Black');
INSERT INTO colour (id, colour) VALUES (2, 'Blond');
INSERT INTO colour (id, colour) VALUES (3, 'Brown');
INSERT INTO colour (id, colour) VALUES (4, 'Red');
INSERT INTO colour (id, colour) VALUES (5, 'Green');
INSERT INTO colour (id, colour) VALUES (6, 'Blue');
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (1, 'Hero_Target_1', 2, 1, 3, 1, 185, 80);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (2, 'Hero_Target_Dup', 3, 1, 2, 1, 185, 90);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (3, 'Hero_Wrong_Height_Low', 1, 4, 1, 1, 184, 185);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (4, 'Hero_Wrong_Height_High', 1, 5, 1, 1, 186, 185);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (5, 'Hero_Wrong_Race', 1, 6, 1, 2, 185, 80);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, race_id, height_cm, weight_kg) VALUES (6, 'Hero_Partial_Race', 1, 2, 1, 3, 185, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('Black',)
*/

-- Prediction Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id WHERE T1.height_cm = 185 AND T3.race = 'human';

/*
Prediction Result:
*/