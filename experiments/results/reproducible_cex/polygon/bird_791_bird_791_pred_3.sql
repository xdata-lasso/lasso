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
INSERT INTO "alignment" ("id", "alignment") VALUES (13, '16');
INSERT INTO "alignment" ("id", "alignment") VALUES (12, '16');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (15, '16');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (14, '16');
INSERT INTO "colour" ("id", "colour") VALUES (17, '16');
INSERT INTO "colour" ("id", "colour") VALUES (16, '16');
INSERT INTO "gender" ("id", "gender") VALUES (19, '16');
INSERT INTO "gender" ("id", "gender") VALUES (18, '16');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (21, '16');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (20, '16');
INSERT INTO "race" ("id", "race") VALUES (22, '16');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (24, NULL, 16, 19, 16, NULL, NULL, 16, '16', '16', NULL, 16);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (23, 12, 16, 18, 17, NULL, 22, 16, '16', '16', 1064, 16);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (14, 23, 16);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (14, 23, 16);
INSERT INTO "superpower" ("id", "power_name") VALUES (25, '16');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (23, 25);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (23, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(height_cm) AS REAL) / COUNT(id) FROM superhero;

/*
Gold Result:
(532.0,)
*/

-- Prediction Query
SELECT AVG(height_cm) FROM superhero;

/*
Prediction Result:
(1064.0,)
*/