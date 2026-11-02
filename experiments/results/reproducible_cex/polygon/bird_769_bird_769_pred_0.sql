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
INSERT INTO "alignment" ("id", "alignment") VALUES (32, 'Dark Horse Comics42');
INSERT INTO "alignment" ("id", "alignment") VALUES (39, 'Dark Horse Comics42');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (55, 'Durability');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (33, 'Dark Horse Comics42');
INSERT INTO "colour" ("id", "colour") VALUES (42, 'Dark Horse Comics42');
INSERT INTO "colour" ("id", "colour") VALUES (34, 'Dark Horse Comics42');
INSERT INTO "gender" ("id", "gender") VALUES (40, 'Dark Horse Comics42');
INSERT INTO "gender" ("id", "gender") VALUES (35, 'Dark Horse Comics42');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (36, 'Dark Horse Comics42');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (59, 'Dark Horse Comics');
INSERT INTO "race" ("id", "race") VALUES (37, 'Dark Horse Comics42');
INSERT INTO "race" ("id", "race") VALUES (41, 'Dark Horse Comics42');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (43, 39, 42, 40, 42, 59, 41, 42, NULL, 'Dark Horse Comics51', 52, 53);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (38, 39, 42, 40, 34, 59, 37, 42, 'Dark Horse Comics42', 'Dark Horse Comics42', 42, 42);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (55, 43, 54);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (55, 43, 56);
INSERT INTO "superpower" ("id", "power_name") VALUES (45, 'Dark Horse Comics42');
INSERT INTO "superpower" ("id", "power_name") VALUES (44, 'Dark Horse Comics42');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (38, 44);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (38, 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.attribute_name = 'durability' AND T4.publisher_name = 'Dark Horse Comics' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/