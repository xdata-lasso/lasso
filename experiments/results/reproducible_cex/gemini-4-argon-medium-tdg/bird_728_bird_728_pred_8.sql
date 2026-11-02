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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'DC Comics');
INSERT INTO colour (id, colour) VALUES (10, 'Blue');
INSERT INTO colour (id, colour) VALUES (20, 'Green');
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, publisher_id) VALUES (101, 'HeroA', 'FullA', 10, 20, 20, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, publisher_id) VALUES (102, 'HeroB', NULL, 10, 20, 20, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, publisher_id) VALUES (103, 'HeroC', 'FullC', 20, 10, 20, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, publisher_id) VALUES (104, 'HeroD', 'FullD', 20, 20, 10, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id, publisher_id) VALUES (105, 'HeroE', 'FullE', 10, 20, 20, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.colour = 'Blue';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT T3.colour FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T4.publisher_name = 'Marvel Comics' GROUP BY T3.colour ORDER BY COUNT(T1.id) DESC, T3.colour NULLS LAST LIMIT 1;

/*
Prediction Result:
*/