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
INSERT INTO race (id, race) VALUES (1, NULL), (170, 'default2'), (169, 'default1'), (190, NULL), (0, 'No Colour'), (191, 'default1'), (171, 'default2'), (189, 'default1'), (2, 'default2'), (3, NULL), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'No Colour'), (10, NULL), (11, 'default1'), (12, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (170, 'default2'), (190, 'No Colour'), (1, 'No Colour'), (0, 'default2'), (191, NULL), (169, NULL), (171, NULL), (189, 'default1'), (2, 'No Colour'), (3, 'default1'), (4, NULL), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'No Colour'), (9, 'No Colour'), (10, 'default1'), (11, 'default1'), (12, 'default2');
INSERT INTO gender (id, gender) VALUES (169, 'default2');
INSERT INTO colour (id, colour) VALUES (190, 'default1'), (171, 'default1'), (170, NULL), (1, NULL), (189, 'No Colour'), (0, 'default2'), (191, NULL), (169, 'default2'), (2, 'No Colour'), (3, NULL), (4, 'No Colour'), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default1'), (9, 'default2'), (10, 'default1'), (11, 'No Colour'), (12, 'default2'), (13, 'default1'), (14, 'default2'), (15, 'default2'), (16, 'No Colour'), (17, 'No Colour');
INSERT INTO alignment (id, alignment) VALUES (190, NULL), (171, 'No Colour'), (1, 'default2'), (169, NULL), (189, 'default1'), (0, 'default2'), (191, 'No Colour'), (170, NULL), (2, 'No Colour'), (3, NULL), (4, NULL), (5, 'default2'), (6, NULL), (7, NULL), (8, 'No Colour'), (9, 'default1'), (10, 'No Colour'), (11, 'No Colour'), (12, 'default2'), (13, 'No Colour'), (14, NULL), (15, 'default1'), (16, 'default2'), (17, 'No Colour'), (18, NULL), (19, 'No Colour');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (190, 16, 14, NULL, 191, 191, 189, NULL, 'default1', 'default2', NULL, 0), (189, 0, 4, NULL, 5, NULL, 191, 14, 'default2', 'default2', 189, NULL), (170, 12, 190, NULL, 2, 4, 171, 1, 'No Colour', NULL, 0, 171), (171, 16, 11, 169, 13, 1, 4, 0, 'default2', NULL, NULL, 169), (191, 169, 4, 169, 13, 12, 7, 13, 'default2', 'default1', 190, 0), (169, 18, 2, NULL, 1, 2, 10, 4, NULL, 'default1', 190, 189), (0, 17, 170, NULL, 5, 1, 3, 4, 'default1', 'default2', NULL, 170), (1, 10, 16, NULL, 190, 2, 2, 191, 'default1', 'No Colour', 190, 0), (2, 171, 5, NULL, 2, 10, 191, NULL, 'default2', 'No Colour', 1, 171), (3, 16, 17, NULL, 5, 4, 11, 9, 'default2', 'No Colour', 189, NULL), (4, 13, 14, 169, 169, 2, 189, 171, 'No Colour', 'default1', 190, 169), (5, 5, 14, 169, 5, 169, 9, 1, 'No Colour', 'default2', 189, 191), (6, 13, 1, NULL, 191, 4, 0, 190, 'default1', 'No Colour', 1, NULL), (7, 12, 6, 169, 5, NULL, 9, 17, 'default1', 'No Colour', 1, 189), (8, 0, 191, 169, 7, 4, 12, 1, 'No Colour', 'default1', 0, 171), (9, 13, 13, NULL, 1, 189, 10, 2, 'default1', NULL, 189, 169), (10, 2, 14, NULL, 16, 2, 2, NULL, 'No Colour', 'No Colour', 170, 190), (11, 7, NULL, NULL, 191, 12, 2, 169, 'default1', 'default2', 171, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.height_cm BETWEEN 170 AND 190 AND T2.colour LIKE 'No Colour';

/*
Gold Result:
('default1',)
('default2',)
(None,)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'No Colour' AND superhero.height_cm BETWEEN 170 AND 190;

/*
Prediction Result:
('default1',)
('default2',)
(None,)
('default2',)
('default2',)
*/