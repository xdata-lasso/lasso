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
INSERT INTO "alignment" ("id", "alignment") VALUES (1061, 'prove');
INSERT INTO "alignment" ("id", "alignment") VALUES (1073, 'almost');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1062, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1074, 'Strength');
INSERT INTO "colour" ("id", "colour") VALUES (1063, 'Congress');
INSERT INTO "colour" ("id", "colour") VALUES (1075, 'support');
INSERT INTO "colour" ("id", "colour") VALUES (1068, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1069, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1080, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1081, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1064, 'none');
INSERT INTO "gender" ("id", "gender") VALUES (1076, 'four');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1065, 'Carla Gray');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1077, 'Austin Gentry');
INSERT INTO "race" ("id", "race") VALUES (1066, 'wish');
INSERT INTO "race" ("id", "race") VALUES (1078, 'our');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1067, 'Kristin Cohen', 'Patty Perez', 1064, 1063, 1068, 1069, 1066, 1065, 1061, 1070, 1071);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1079, 'Emily Rios', 'Thomas Ellis', 1076, 1075, 1080, 1081, 1078, 1077, 1073, 1082, 1083);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1067, 1062, 1072);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (NULL, 1074, 1084);
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