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
INSERT INTO colour (id, colour) VALUES (101, 'Blue');
INSERT INTO colour (id, colour) VALUES (102, 'Blond');
INSERT INTO colour (id, colour) VALUES (103, 'White');
INSERT INTO colour (id, colour) VALUES (104, 'Green');
INSERT INTO colour (id, colour) VALUES (105, 'Black');
INSERT INTO colour (id, colour) VALUES (106, 'Red');
INSERT INTO colour (id, colour) VALUES (107, 'Brown');
INSERT INTO colour (id, colour) VALUES (108, 'Auburn');
INSERT INTO colour (id, colour) VALUES (109, 'Grey');
INSERT INTO gender (id, gender) VALUES (10, 'Female');
INSERT INTO gender (id, gender) VALUES (20, 'Male');
INSERT INTO gender (id, gender) VALUES (30, 'N/A');
INSERT INTO publisher (id, publisher_name) VALUES (100, 'Dark Horse Comics');
INSERT INTO publisher (id, publisher_name) VALUES (200, 'DC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (300, 'Marvel Comics');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Heroine Alpha', 'Alice Smith', 10, 101, 102, 103, 1, 100, 1, 170, 60);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Heroine Beta', 'Beth Jones', 10, 101, 102, 103, 1, 100, 1, 168, 58);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Heroine Gamma', 'Clara Oswald', 10, 104, 105, 106, 1, 100, 1, 175, 65);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Hero Delta', 'David Tennant', 20, 107, 108, 109, 1, 100, 1, 185, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (5, 'Heroine Epsilon', 'Diana Prince', 10, 108, 109, 101, 1, 200, 1, 180, 70);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (6, 'Hero Zeta', 'Peter Parker', 20, 109, 101, 102, 1, 300, 1, 178, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(101, 102, 103)
(101, 102, 103)
(104, 105, 106)
*/

-- Prediction Query
SELECT T2.colour AS eye_colour, T3.colour AS hair_colour, T4.colour AS skin_colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id INNER JOIN colour AS T4 ON T1.skin_colour_id = T4.id INNER JOIN gender AS T5 ON T1.gender_id = T5.id INNER JOIN publisher AS T6 ON T1.publisher_id = T6.id WHERE T5.gender = 'Female' AND T6.publisher_name = 'Dark Horse Comics';

/*
Prediction Result:
('Blue', 'Blond', 'White')
('Blue', 'Blond', 'White')
('Green', 'Black', 'Red')
*/