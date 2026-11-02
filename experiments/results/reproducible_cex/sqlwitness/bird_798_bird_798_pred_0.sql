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
INSERT INTO race (id, race) VALUES (0, 'default1'), (1, 'Hawkman'), (2, 'Hawkman');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (1, NULL), (2, 'default2'), (3, 'Speedy');
INSERT INTO gender (id, gender) VALUES (1, 'default2'), (0, NULL), (2, 'Hawkman'), (3, 'Hawkman'), (4, 'Hawkman');
INSERT INTO colour (id, colour) VALUES (1, 'default1'), (0, 'default1'), (2, 'Speedy'), (3, 'Speedy'), (4, 'Hawkman');
INSERT INTO alignment (id, alignment) VALUES (0, 'Speedy'), (1, 'Karate Kid'), (2, 'default2'), (3, 'Karate Kid'), (4, 'default2'), (5, NULL), (6, 'Speedy'), (7, 'Hawkman'), (8, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 5, NULL, 4, 3, 0, NULL, 0, 'default1', 'Hawkman', 1, NULL), (0, 8, 1, 0, 4, 1, 2, 1, NULL, 'default1', NULL, 0), (2, 2, 3, 3, NULL, NULL, 2, 4, 'default1', NULL, NULL, NULL), (3, NULL, 2, 3, 4, 2, 2, NULL, 'Speedy', 'default1', NULL, 0), (4, 6, 3, 3, 4, 2, 0, 4, NULL, 'default1', NULL, 1), (5, 6, 3, 2, 2, 3, NULL, NULL, 'Karate Kid', 'Hawkman', 1, NULL), (6, 3, 4, 1, NULL, 1, 1, 0, NULL, NULL, 1, 0), (7, 8, 4, NULL, 2, 2, 2, 2, 'Speedy', 'default2', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Gold Result:
('default2',)
('Speedy',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT publisher.publisher_name FROM superhero INNER JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Prediction Result:
('default2',)
('Speedy',)
*/