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
INSERT INTO "alignment" ("id", "alignment") VALUES (3, 'Neutral47');
INSERT INTO "alignment" ("id", "alignment") VALUES (21, 'Neutral31');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (44, 'Neutral31');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (32, 'Neutral31');
INSERT INTO "colour" ("id", "colour") VALUES (31, 'Neutral31');
INSERT INTO "colour" ("id", "colour") VALUES (28, 'Neutral31');
INSERT INTO "gender" ("id", "gender") VALUES (22, 'Neutral31');
INSERT INTO "gender" ("id", "gender") VALUES (27, 'Neutral31');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (23, 'Neutral31');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, 'Neutral31');
INSERT INTO "race" ("id", "race") VALUES (30, 'Neutral31');
INSERT INTO "race" ("id", "race") VALUES (24, 'Neutral31');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (26, 21, 28, 27, 28, 23, 24, 28, 'Neutral31', 'Neutral31', 31, 31);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (25, 3, 31, 27, 28, 29, 30, 31, 'Neutral40', 'Neutral41', 42, 43);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (32, 25, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (44, 25, 152);
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Neutral31');
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Neutral31');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(hero_attribute.attribute_value) FROM superhero INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id WHERE superhero.alignment_id = 3;

/*
Prediction Result:
(152.0,)
*/