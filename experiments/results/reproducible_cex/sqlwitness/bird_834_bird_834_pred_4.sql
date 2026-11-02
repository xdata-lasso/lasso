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
INSERT INTO race (id, race) VALUES (101, 'default1'), (0, 'default2'), (100, 'George Lucas'), (2, 'default2'), (99, NULL), (1, NULL), (3, 'default2'), (4, 'default1'), (5, 'George Lucas'), (6, 'George Lucas'), (7, 'default2'), (8, 'George Lucas'), (9, 'default2'), (10, 'default1'), (11, NULL), (12, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (101, NULL), (99, 'default2'), (2, 'George Lucas'), (100, NULL), (0, 'Female'), (1, 'George Lucas'), (3, 'default1'), (4, 'Female'), (5, 'Female'), (6, NULL), (7, 'George Lucas'), (8, 'default2'), (9, 'Female'), (10, 'George Lucas'), (11, 'George Lucas'), (12, 'George Lucas'), (13, NULL), (14, 'default2'), (15, 'default1'), (16, 'Female'), (17, 'George Lucas'), (18, 'default2'), (19, 'Female'), (20, NULL), (21, NULL), (22, 'Female'), (23, NULL), (24, NULL), (25, NULL), (26, NULL);
INSERT INTO gender (id, gender) VALUES (0, NULL), (2, 'George Lucas'), (100, 'Female'), (101, 'George Lucas'), (1, 'default2'), (99, 'default2'), (3, 'George Lucas'), (4, 'default2'), (5, 'Female'), (6, 'George Lucas'), (7, 'Female'), (8, 'default1'), (9, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'Female'), (101, 'George Lucas'), (100, 'default1'), (99, NULL), (0, 'Female'), (2, 'default2'), (3, NULL), (4, NULL), (5, 'George Lucas'), (6, 'Female'), (7, 'default1'), (8, 'George Lucas'), (9, 'Female'), (10, NULL), (11, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (2, 'George Lucas'), (1, 'default1'), (99, 'default1'), (100, 'default1'), (101, 'George Lucas'), (3, 'George Lucas'), (4, 'Female'), (5, 'George Lucas'), (6, 'default2'), (7, 'George Lucas'), (8, NULL), (9, 'George Lucas'), (10, 'George Lucas'), (11, NULL), (12, NULL), (13, 'default2'), (14, 'Female'), (15, 'default1'), (16, 'default2'), (17, 'Female'), (18, NULL), (19, NULL), (20, 'default2'), (21, 'Female'), (22, 'default1'), (23, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 14, 5, 4, 4, 9, 3, 5, 'default2', 'default1', 100, 100), (99, 20, 1, 9, 9, 2, 1, 5, 'Female', 'default2', NULL, 2), (1, 23, NULL, 9, 7, 13, 101, 100, NULL, NULL, 99, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'George Lucas';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(gender.gender = 'Female') * 100.0 / COUNT(*)) AS female_percentage FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id JOIN gender ON superhero.gender_id = gender.id WHERE publisher.publisher_name = 'George Lucas';

/*
Prediction Result:
(None,)
*/