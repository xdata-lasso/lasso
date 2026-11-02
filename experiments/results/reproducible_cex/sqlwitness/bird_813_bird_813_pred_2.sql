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
INSERT INTO race (id, race) VALUES (3, 'default1'), (1, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (4, NULL), (0, 'default1'), (2, 'default1'), (3, NULL), (1, 'default2'), (5, 'default2');
INSERT INTO gender (id, gender) VALUES (4, 'default1'), (2, NULL), (1, 'default2'), (3, 'default1');
INSERT INTO colour (id, colour) VALUES (0, 'Neutral'), (1, 'Neutral'), (4, 'Neutral'), (2, 'Neutral'), (3, 'Neutral'), (5, 'default2'), (6, 'Neutral');
INSERT INTO attribute (id, attribute_name) VALUES (3, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (3, NULL), (2, NULL), (1, 'Neutral'), (4, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (4, NULL, 5, 1, NULL, NULL, 1, 3, 'default1', 'default1', 0, 4), (3, 1, 6, 2, 2, 1, 3, 6, 'Neutral', 'default1', 0, 1), (0, NULL, 2, 4, NULL, 5, 1, NULL, 'default1', 'Neutral', 1, NULL), (2, 2, 2, 3, 1, 2, 3, 5, 'Neutral', 'Neutral', 3, 2), (1, NULL, 2, 1, 4, 0, 1, 6, 'Neutral', 'default1', NULL, NULL), (5, 3, 0, NULL, 1, 0, NULL, 2, 'default1', 'default1', NULL, 3);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (3, NULL, 4), (3, 1, 0), (3, 4, NULL), (3, NULL, 0), (NULL, 3, 1), (NULL, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT AVG("hero_attribute"."attribute_value") FROM "hero_attribute" INNER JOIN "superhero" ON "hero_attribute"."hero_id" = "superhero"."id" WHERE "superhero"."alignment_id" = 3;

/*
Prediction Result:
(None,)
*/