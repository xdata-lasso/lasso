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
INSERT INTO race (id, race) VALUES (1, 'default1'), (0, NULL), (2, 'Charles Chandler'), (3, 'default2'), (4, 'Emil Blonsky'), (5, 'Charles Chandler'), (6, 'default2'), (7, 'Charles Chandler'), (8, 'default1'), (9, 'default2'), (10, 'Charles Chandler'), (11, 'default2'), (12, 'default2'), (13, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, 'Emil Blonsky'), (2, NULL), (3, 'default1'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, 'Charles Chandler'), (10, 'default1'), (11, NULL), (12, NULL);
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, NULL), (2, 'Emil Blonsky'), (3, 'default1'), (4, NULL), (5, 'default1'), (6, 'Charles Chandler'), (7, 'default2'), (8, 'Charles Chandler'), (9, 'Emil Blonsky'), (10, 'Emil Blonsky'), (11, 'Emil Blonsky'), (12, 'default2'), (13, 'Emil Blonsky'), (14, NULL), (15, 'default2');
INSERT INTO colour (id, colour) VALUES (0, NULL), (1, NULL), (2, 'default2'), (3, NULL), (4, 'Charles Chandler');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, 'Charles Chandler'), (2, 'default1'), (3, 'Emil Blonsky'), (4, 'default1'), (5, 'Emil Blonsky'), (6, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, 3, 3, NULL, 9, 7, NULL, 'Charles Chandler', 'Charles Chandler', 0, 1), (0, 6, 3, 9, 2, 0, 12, 1, 'Emil Blonsky', 'Charles Chandler', 1, 1), (2, 5, 4, 9, 4, NULL, 7, 2, 'Charles Chandler', 'Charles Chandler', 1, 0), (3, 3, NULL, 11, 3, 6, 9, 3, NULL, NULL, NULL, 1), (4, 4, NULL, 0, 4, 3, NULL, 4, 'Emil Blonsky', 'default1', 1, 0), (5, 0, 1, 13, 4, 5, 7, NULL, 'default2', NULL, 0, NULL), (6, 5, 0, 1, NULL, 8, 0, 1, NULL, NULL, 1, NULL), (7, NULL, 0, 6, 1, 5, 6, 2, 'default1', NULL, 1, 1), (8, 5, NULL, 1, 4, 0, 7, NULL, 'Charles Chandler', 'default2', 0, NULL), (9, 2, 4, 9, NULL, 2, 10, 4, 'default1', 'Emil Blonsky', 0, 0), (10, 4, NULL, 11, 3, NULL, 1, 4, 'default1', 'default1', 1, NULL), (11, 2, 1, 7, 1, 1, NULL, 0, 'default1', NULL, 0, NULL), (12, 5, 3, 13, 1, 8, 6, 0, 'Emil Blonsky', 'default1', 0, NULL), (13, 4, 3, 9, NULL, 4, 9, 0, 'default1', 'Charles Chandler', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT weight_kg FROM superhero WHERE full_name LIKE 'Emil Blonsky') - (SELECT weight_kg FROM superhero WHERE full_name LIKE 'Charles Chandler') AS CALCULATE;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT (SELECT SUM(weight_kg) FROM superhero WHERE full_name = 'Emil Blonsky') - (SELECT SUM(weight_kg) FROM superhero WHERE full_name = 'Charles Chandler') AS difference;

/*
Prediction Result:
(-2,)
*/