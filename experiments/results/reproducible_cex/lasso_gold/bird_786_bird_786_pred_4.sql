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
INSERT INTO "alignment" ("id", "alignment") VALUES (1289, 'father');
INSERT INTO "alignment" ("id", "alignment") VALUES (1301, 'everybody');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1290, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1302, 'Gavin Anderson');
INSERT INTO "colour" ("id", "colour") VALUES (1291, 'point');
INSERT INTO "colour" ("id", "colour") VALUES (1303, 'color');
INSERT INTO "colour" ("id", "colour") VALUES (1296, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1297, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1308, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1309, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1292, 'develop');
INSERT INTO "gender" ("id", "gender") VALUES (1304, 'site');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1293, 'Christina Walters');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1305, 'Michael Hoffman');
INSERT INTO "race" ("id", "race") VALUES (1294, 'everything');
INSERT INTO "race" ("id", "race") VALUES (1306, 'brother');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1295, 'Danielle Odonnell', 'Mark Calderon', 1292, 1291, 1296, 1297, 1294, 1293, 1289, 1298, 1299);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1307, 'Stephen Mckee', 'Sandra Aguilar', 1304, 1303, 1308, 1309, 1306, 1305, 1301, 1310, 1311);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1295, 1290, 1300);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1307, 1302, 1312);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute AS T3 INNER JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Strength');

/*
Prediction Result:
(1,)
*/