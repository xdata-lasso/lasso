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
INSERT INTO "alignment" ("id", "alignment") VALUES (49, 'Strength51');
INSERT INTO "alignment" ("id", "alignment") VALUES (48, 'Strength51');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (51, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (50, 'Strength68');
INSERT INTO "colour" ("id", "colour") VALUES (53, 'Strength51');
INSERT INTO "colour" ("id", "colour") VALUES (52, 'Strength51');
INSERT INTO "gender" ("id", "gender") VALUES (55, 'Strength51');
INSERT INTO "gender" ("id", "gender") VALUES (54, 'Strength51');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (57, 'Strength51');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (56, 'Strength51');
INSERT INTO "race" ("id", "race") VALUES (59, 'Strength51');
INSERT INTO "race" ("id", "race") VALUES (58, 'Strength51');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (60, 49, 53, 55, 52, 56, NULL, 53, 'Strength51', 'Strength51', 51, 51);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (61, NULL, 52, 55, 53, 57, 58, 53, 'Strength51', 'Strength51', 51, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (51, 60, 855);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (50, 61, 856);
INSERT INTO "superpower" ("id", "power_name") VALUES (63, 'Strength51');
INSERT INTO "superpower" ("id", "power_name") VALUES (62, 'Strength51');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (61, 62);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength'));

/*
Prediction Result:
(1,)
*/