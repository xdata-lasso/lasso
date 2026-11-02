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
INSERT INTO "alignment" ("id", "alignment") VALUES (67, NULL);
INSERT INTO "alignment" ("id", "alignment") VALUES (23, 'Good');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (25, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (27, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (26, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (35, 'Female');
INSERT INTO "gender" ("id", "gender") VALUES (28, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, NULL);
INSERT INTO "race" ("id", "race") VALUES (32, NULL);
INSERT INTO "race" ("id", "race") VALUES (31, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 23, NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (57, 67, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (25, 57, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, NULL, NULL);
INSERT INTO "superpower" ("id", "power_name") VALUES (41, NULL);
INSERT INTO "superpower" ("id", "power_name") VALUES (40, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (57, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(superhero.id) FROM superhero INNER JOIN alignment ON superhero.alignment_id = alignment.id INNER JOIN gender ON superhero.gender_id = gender.id WHERE alignment.id = 1 AND gender.id = 2;

/*
Prediction Result:
(0,)
*/