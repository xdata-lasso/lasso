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
INSERT INTO "alignment" ("id", "alignment") VALUES (35, 'Strength58');
INSERT INTO "alignment" ("id", "alignment") VALUES (34, 'Strength58');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (58, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (36, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (38, 'Strength58');
INSERT INTO "colour" ("id", "colour") VALUES (37, 'Strength58');
INSERT INTO "gender" ("id", "gender") VALUES (40, 'Strength58');
INSERT INTO "gender" ("id", "gender") VALUES (39, 'Strength58');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (42, 'Strength58');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (41, 'Strength58');
INSERT INTO "race" ("id", "race") VALUES (44, 'Strength58');
INSERT INTO "race" ("id", "race") VALUES (43, 'Strength58');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (45, 34, 38, 39, 37, 41, 43, 38, 'Strength58', 'Strength58', 58, 58);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (66, NULL, 37, NULL, 37, 41, 43, NULL, 'Strength58', 'Strength58', 58, 58);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (36, 45, 6168);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (58, 66, 0);
INSERT INTO "superpower" ("id", "power_name") VALUES (47, 'Strength58');
INSERT INTO "superpower" ("id", "power_name") VALUES (46, 'Strength58');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (66, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT hero_id) FROM hero_attribute JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Strength' AND hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Strength');

/*
Prediction Result:
(1,)
*/