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
INSERT INTO race (id, race) VALUES (2, 'default1'), (1, 'default1'), (0, 'default1'), (-1, 'default2'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1'), (7, 'default1'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, 'default1'), (-1, NULL), (2, 'default2');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (1, 'default1'), (-1, 'default1'), (0, NULL), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'default2');
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, 'default2'), (-1, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (2, 'default2'), (-1, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (-1, 0, -1, -1, -1, 1, 12, 1, 'default2', 'default2', NULL, 0), (2, NULL, 1, 0, 0, 0, 7, -1, NULL, 'default2', NULL, NULL), (0, NULL, -1, NULL, -1, 1, 2, 0, 'default2', 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(*) AS REAL) / SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id;

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT COUNT("superhero"."id") * 1.0 / SUM("superhero"."skin_colour_id" = 1) FROM "superhero" WHERE "superhero"."skin_colour_id" = 1;

/*
Prediction Result:
(1.0,)
*/