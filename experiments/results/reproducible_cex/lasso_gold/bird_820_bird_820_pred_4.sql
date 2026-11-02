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
INSERT INTO "alignment" ("id", "alignment") VALUES (1121, 'break');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1122, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1134, 'Strength');
INSERT INTO "colour" ("id", "colour") VALUES (1123, 'claim');
INSERT INTO "colour" ("id", "colour") VALUES (1128, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1129, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1124, 'product');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1125, 'Michael Carlson');
INSERT INTO "race" ("id", "race") VALUES (1126, 'image');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1127, 'Hulk', 'Zachary Rice', 1124, 1123, 1128, 1129, 1126, 1125, 1121, 1130, 1131);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1133, 'Hulk', 'Zachary Rice', 1124, 1123, 1128, 1129, 1126, 1125, 1121, 1130, 1131);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1127, 1122, 1132);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1133, 1134, 1132);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Hulk' AND T3.attribute_name = 'Strength';

/*
Gold Result:
(1132,)
(1132,)
*/

-- Prediction Query
SELECT attribute_value FROM hero_attribute WHERE hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Hulk') AND attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength');

/*
Prediction Result:
(1132,)
*/