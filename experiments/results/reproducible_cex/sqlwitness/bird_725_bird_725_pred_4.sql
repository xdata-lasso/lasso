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
INSERT INTO race (id, race) VALUES (0, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (1, 'default1'), (2, 'Marvel Comics'), (3, 'default1'), (4, NULL), (5, NULL), (6, 'Marvel Comics');
INSERT INTO colour (id, colour) VALUES (0, NULL), (1, 'default1'), (2, NULL), (3, 'default2'), (4, 'Marvel Comics');
INSERT INTO alignment (id, alignment) VALUES (0, 'Marvel Comics'), (1, 'default2'), (2, 'default1'), (3, 'Marvel Comics'), (4, 'Marvel Comics'), (5, 'default2'), (6, 'default1'), (7, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 7, 2, NULL, NULL, NULL, 0, 2, NULL, 'default2', 0, 1), (0, 0, 3, NULL, 4, 6, NULL, NULL, NULL, 'default1', NULL, 1), (2, 6, 2, NULL, 2, 6, NULL, 0, 'Marvel Comics', 'default2', NULL, NULL), (3, 6, 0, NULL, 3, 2, NULL, 2, 'default1', 'Marvel Comics', 1, 1), (4, 5, 4, NULL, 4, 0, 0, 3, NULL, 'default2', 1, 0), (5, 1, 4, NULL, 3, 6, 0, 1, 'default1', 'Marvel Comics', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics');

/*
Prediction Result:
(1,)
*/