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
-- DATASET 6
INSERT INTO alignment (id, alignment) VALUES (1, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (3, 'Good');
INSERT INTO colour (id, colour) VALUES (10, 'Green');
INSERT INTO colour (id, colour) VALUES (20, 'Green');
INSERT INTO colour (id, colour) VALUES (30, 'Black');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO race (id, race) VALUES (1, 'Mutant');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Durability');
INSERT INTO superpower (id, power_name) VALUES (1, 'Super Strength');
INSERT INTO superpower (id, power_name) VALUES (2, 'Regeneration');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (50, 'Toad', 'Mortimer Toynbee', 1, 30, 30, 10, 1, 1, 1, 175, 76);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (51, 'Lizard', 'Curt Connors', 1, 30, 30, 20, 1, 1, 2, 203, 230);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (50, 1, 60);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (50, 2, 70);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (51, 1, 80);
INSERT INTO hero_power (hero_id, power_id) VALUES (50, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (50, 2);
INSERT INTO hero_power (hero_id, power_id) VALUES (51, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.alignment = 'Bad' AND T3.colour = 'Green';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero WHERE skin_colour_id = (SELECT id FROM colour WHERE colour = 'Green') AND alignment_id = (SELECT id FROM alignment WHERE alignment = 'Bad');

/*
Prediction Result:
(1,)
*/