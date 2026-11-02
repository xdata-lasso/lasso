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
INSERT INTO "alignment" ("id", "alignment") VALUES (19, 'Intelligence33');
INSERT INTO "alignment" ("id", "alignment") VALUES (18, 'Intelligence33');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (36, 'Intelligence');
INSERT INTO "colour" ("id", "colour") VALUES (21, 'Intelligence33');
INSERT INTO "colour" ("id", "colour") VALUES (20, 'Intelligence33');
INSERT INTO "gender" ("id", "gender") VALUES (23, 'Intelligence33');
INSERT INTO "gender" ("id", "gender") VALUES (22, 'Intelligence33');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (25, 'Intelligence33');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (24, 'Intelligence33');
INSERT INTO "race" ("id", "race") VALUES (27, 'Intelligence33');
INSERT INTO "race" ("id", "race") VALUES (26, 'Intelligence33');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 19, 21, 22, 20, 24, 26, 20, 'Intelligence33', 'Intelligence33', 33, 33);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (36, 33, 34);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (36, 33, 35);
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Intelligence');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (33, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (33, 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.hero_id FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T2.power_name = 'Intelligence';

/*
Gold Result:
(33,)
*/

-- Prediction Query
SELECT "hero_attribute"."hero_id" FROM "hero_attribute" INNER JOIN "attribute" ON "hero_attribute"."attribute_id" = "attribute"."id" WHERE "attribute"."attribute_name" = 'Intelligence';

/*
Prediction Result:
(33,)
(33,)
*/