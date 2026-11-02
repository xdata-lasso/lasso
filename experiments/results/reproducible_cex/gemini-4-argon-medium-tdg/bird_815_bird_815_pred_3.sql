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
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (4, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'Female');
INSERT INTO gender (id, gender) VALUES (2, 'Male');
INSERT INTO gender (id, gender) VALUES (3, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (1, 'Wonder Woman', 'Diana Prince', 1, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (2, 'Supergirl', NULL, 1, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (3, 'Harley Quinn', 'Harleen Quinzel', 1, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (4, 'Superman', 'Clark Kent', 2, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (5, 'Joker', 'Jack Napier', 2, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (6, 'Mystery Woman', NULL, 1, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (7, 'Good Entity', NULL, NULL, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (8, 'Unknown Entity', NULL, 3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.id = 1 AND T3.id = 2;

/*
Prediction Result:
(1,)
*/