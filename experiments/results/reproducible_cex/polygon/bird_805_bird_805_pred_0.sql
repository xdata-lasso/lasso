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
INSERT INTO "alignment" ("id", "alignment") VALUES (15, '26');
INSERT INTO "alignment" ("id", "alignment") VALUES (22, '26');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (17, '26');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (16, '26');
INSERT INTO "colour" ("id", "colour") VALUES (26, '26');
INSERT INTO "gender" ("id", "gender") VALUES (23, '26');
INSERT INTO "gender" ("id", "gender") VALUES (18, '26');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (24, '26');
INSERT INTO "race" ("id", "race") VALUES (19, '26');
INSERT INTO "race" ("id", "race") VALUES (25, '26');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (21, 22, 26, 23, 26, 24, 25, 26, '28', NULL, 29, 0);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '26', '26', 26, 30);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (16, 20, 26);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (16, 20, 26);
INSERT INTO "superpower" ("id", "power_name") VALUES (27, '26');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (20, 27);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (20, 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT full_name FROM superhero WHERE NOT full_name IS NULL AND (weight_kg IS NULL OR weight_kg = 0);

/*
Gold Result:
*/

-- Prediction Query
SELECT full_name FROM superhero WHERE weight_kg = 0 OR weight_kg IS NULL;

/*
Prediction Result:
(None,)
*/