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
INSERT INTO "alignment" ("id", "alignment") VALUES (15, '24');
INSERT INTO "alignment" ("id", "alignment") VALUES (23, '24');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (17, '24');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (16, '24');
INSERT INTO "colour" ("id", "colour") VALUES (24, '24');
INSERT INTO "colour" ("id", "colour") VALUES (26, '24');
INSERT INTO "gender" ("id", "gender") VALUES (25, '24');
INSERT INTO "gender" ("id", "gender") VALUES (18, '24');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (19, '24');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (27, '24');
INSERT INTO "race" ("id", "race") VALUES (20, '24');
INSERT INTO "race" ("id", "race") VALUES (28, '24');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (22, 23, NULL, 25, 24, 27, 20, 26, NULL, '24', NULL, 24);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (21, 23, 24, 25, 26, 27, 28, 24, NULL, '33', -463, 34);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (16, 22, 24);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (16, NULL, 24);
INSERT INTO "superpower" ("id", "power_name") VALUES (30, '24');
INSERT INTO "superpower" ("id", "power_name") VALUES (29, '24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT superhero_name FROM superhero ORDER BY height_cm DESC, superhero.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT superhero_name FROM superhero WHERE height_cm = (SELECT MAX(height_cm) FROM superhero);

/*
Prediction Result:
(None,)
*/