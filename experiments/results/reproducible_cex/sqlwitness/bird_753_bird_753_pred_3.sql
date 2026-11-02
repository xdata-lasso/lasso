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
INSERT INTO race (id, race) VALUES (189, 'No Colour'), (170, NULL), (0, 'No Colour'), (1, 'default2'), (190, 'default2'), (169, 'No Colour'), (191, 'default2'), (171, NULL), (2, 'No Colour'), (3, 'No Colour'), (4, 'No Colour'), (5, 'default1'), (6, 'default1'), (7, NULL), (8, 'default1'), (9, NULL), (10, NULL), (11, 'No Colour'), (12, 'default2'), (13, NULL), (14, NULL), (15, 'No Colour'), (16, 'No Colour'), (17, 'No Colour'), (18, 'No Colour');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (189, 'default1'), (171, 'No Colour'), (190, 'No Colour'), (170, NULL), (169, NULL), (191, NULL), (0, 'No Colour'), (2, 'default2'), (3, 'No Colour'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default1');
INSERT INTO gender (id, gender) VALUES (170, 'default1'), (190, 'default1'), (171, NULL), (1, NULL), (169, 'default2'), (189, 'default1'), (0, 'default2'), (191, NULL), (2, 'default1'), (3, 'default1'), (4, 'No Colour'), (5, NULL), (6, 'default1'), (7, 'No Colour'), (8, 'No Colour'), (9, 'default1'), (10, 'No Colour'), (11, 'default1'), (12, 'default2'), (13, 'No Colour'), (14, 'default1'), (15, 'No Colour'), (16, NULL);
INSERT INTO colour (id, colour) VALUES (190, 'default1'), (1, 'default2'), (191, 'No Colour'), (171, NULL), (170, NULL), (189, NULL), (169, 'default1'), (0, 'default1'), (2, 'No Colour'), (3, 'No Colour'), (4, 'No Colour'), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, 'No Colour'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, 'No Colour'), (13, 'default1'), (14, 'No Colour'), (15, 'default1'), (16, 'default1');
INSERT INTO alignment (id, alignment) VALUES (171, 'No Colour'), (1, 'No Colour'), (190, 'No Colour'), (189, 'default1'), (0, 'default2'), (170, NULL), (191, 'No Colour'), (169, 'default2'), (2, 'No Colour'), (3, 'default1'), (4, 'default2'), (5, 'No Colour'), (6, 'default2'), (7, 'default1'), (8, 'default2'), (9, 'default2'), (10, NULL), (11, 'default2'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default1'), (16, 'default1'), (17, 'No Colour'), (18, NULL), (19, 'default1'), (20, 'default2'), (21, NULL), (22, 'default2'), (23, 'default2'), (24, 'default2'), (25, 'No Colour'), (26, 'No Colour'), (27, NULL), (28, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (191, 8, 5, 0, 189, 2, 12, 12, 'No Colour', 'default1', 191, 190), (189, 190, 5, 7, 8, 5, 14, 8, NULL, 'No Colour', 191, 170), (170, 19, 9, 5, 1, 5, NULL, 2, 'No Colour', 'No Colour', 0, 169), (171, 9, 14, 13, 190, 189, 14, 189, 'default1', 'No Colour', 0, 189), (0, 7, 4, 3, 2, 1, 6, 6, 'default1', 'default2', 171, 191), (169, 18, 0, 8, 3, 170, 17, 0, NULL, NULL, NULL, 189), (1, 26, 4, 11, 16, 6, 12, 191, 'No Colour', 'default2', 0, NULL), (190, 171, 10, 190, 8, 0, 7, 15, NULL, 'default2', 0, 191), (2, 6, 14, 9, 12, 171, 189, 10, NULL, 'default1', 1, 171), (3, 191, 4, 1, 191, 3, 9, 189, NULL, 'No Colour', 190, 170), (4, 0, 189, 190, 8, 3, 14, 6, NULL, 'No Colour', 190, 189), (5, 28, 5, 14, NULL, 171, 5, 1, 'No Colour', 'No Colour', 170, 191), (6, 8, 4, 3, 12, 7, 169, 16, 'No Colour', NULL, 1, 190), (7, 26, 4, 16, 3, 191, 169, 3, 'default2', 'default1', 170, NULL), (8, 5, 8, 170, 4, 6, 1, 8, NULL, 'default1', 191, 169), (9, 3, 4, 14, 3, 7, 6, 7, NULL, 'No Colour', 190, 191), (10, 20, 4, 7, 11, 0, 4, 14, 'default1', 'default1', NULL, 190);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.height_cm BETWEEN 170 AND 190 AND T2.colour LIKE 'No Colour';

/*
Gold Result:
('default1',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s JOIN colour AS c ON s.eye_colour_id = c.id WHERE s.height_cm BETWEEN 170 AND 190 AND c.colour = 'No Colour';

/*
Prediction Result:
('default1',)
(None,)
('default2',)
(None,)
*/