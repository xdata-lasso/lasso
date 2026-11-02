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
INSERT INTO "alignment" ("id", "alignment") VALUES (31, '32');
INSERT INTO "alignment" ("id", "alignment") VALUES (38, '32');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, '32');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (21, '32');
INSERT INTO "colour" ("id", "colour") VALUES (32, '32');
INSERT INTO "gender" ("id", "gender") VALUES (39, '32');
INSERT INTO "gender" ("id", "gender") VALUES (23, '32');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (33, '32');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, '32');
INSERT INTO "race" ("id", "race") VALUES (34, '44');
INSERT INTO "race" ("id", "race") VALUES (41, '44');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (30, 31, 32, 39, 32, 33, 34, 32, '35', '36', 188, 108);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (37, 38, 32, 39, 32, 40, 41, 32, '42', '43', 188, 108);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (22, 37, 32);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 37, 32);
INSERT INTO "superpower" ("id", "power_name") VALUES (25, '32');
INSERT INTO "superpower" ("id", "power_name") VALUES (24, '32');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (37, 24);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (37, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.race FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T1.weight_kg = 108 AND T1.height_cm = 188;

/*
Gold Result:
('44',)
*/

-- Prediction Query
SELECT T1.race FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id WHERE T2.weight_kg = 108 AND T2.height_cm = 188;

/*
Prediction Result:
('44',)
('44',)
*/