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
-- DATASET 4
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'Dark Horse Comics');
INSERT INTO gender (id, gender) VALUES (1, 'Female');
INSERT INTO gender (id, gender) VALUES (2, 'Female');
INSERT INTO gender (id, gender) VALUES (3, 'Male');
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO race (id, race) VALUES (1, 'Mutant');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO superpower (id, power_name) VALUES (1, 'Telepathy');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (10, 'Psylocke', 'Betsy Braddock', 1, 1, 1, 1, 1, 1, 1, 180, 70);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (20, 'Jubilee', 'Jubilation Lee', 2, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (30, 'Hellboy', 'Anung Un Rama', 3, 3);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 1, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS s JOIN publisher AS p ON s.publisher_id = p.id WHERE s.gender_id = (SELECT id FROM gender WHERE gender = 'Female') AND p.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(1,)
*/