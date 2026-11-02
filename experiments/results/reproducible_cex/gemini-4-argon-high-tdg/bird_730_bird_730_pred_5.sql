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
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'DC Comics');
INSERT INTO superpower (id, power_name) VALUES (4, 'Super Strength');
INSERT INTO superpower (id, power_name) VALUES (5, 'Flight');
INSERT INTO superpower (id, power_name) VALUES (6, 'Invisibility');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (10, 'Hero A', 'Full A', 1, 1, 1, 1, 1, 2, 1, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (11, 'Hero B', 'Full B', 1, 1, 1, 1, 1, 2, 1, 175, 70);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (12, 'Hero C', 'Full C', 1, 1, 1, 1, 1, 2, 1, 185, 85);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (13, 'Hero D', 'Full D', 1, 1, 1, 1, 1, 3, 1, 190, 95);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 1, 90);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (11, 1, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (12, 1, 70);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (13, 1, 85);
INSERT INTO hero_power (hero_id, power_id) VALUES (10, 4);
INSERT INTO hero_power (hero_id, power_id) VALUES (11, 5);
INSERT INTO hero_power (hero_id, power_id) VALUES (12, 6);
INSERT INTO hero_power (hero_id, power_id) VALUES (13, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.power_name = 'Super Strength' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T4.publisher_name = 'Marvel Comics';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.power_name = 'Super Strength' AND T4.publisher_name = 'Marvel Comics';

/*
Prediction Result:
('Hero A',)
*/