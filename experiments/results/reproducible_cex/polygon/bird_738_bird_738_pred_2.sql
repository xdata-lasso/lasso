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
INSERT INTO "alignment" ("id", "alignment") VALUES (37, 'Durability39');
INSERT INTO "alignment" ("id", "alignment") VALUES (46, 'Durability39');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, 'Durability');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, 'Durability');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Durability39');
INSERT INTO "colour" ("id", "colour") VALUES (50, 'Durability39');
INSERT INTO "gender" ("id", "gender") VALUES (38, 'Durability39');
INSERT INTO "gender" ("id", "gender") VALUES (47, 'Durability39');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Durability39');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (51, 'Durability39');
INSERT INTO "race" ("id", "race") VALUES (52, 'Durability39');
INSERT INTO "race" ("id", "race") VALUES (41, 'Durability39');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (45, 37, 39, 38, 39, 40, 41, 50, 'Durability2', 'Durability42', 43, 44);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (56, 46, 39, 47, 50, 51, 52, 39, 'Durability2', 'Durability53', 54, 55);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (23, 45, 48);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, 56, 49);
INSERT INTO "superpower" ("id", "power_name") VALUES (26, 'Durability39');
INSERT INTO "superpower" ("id", "power_name") VALUES (25, 'Durability39');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (45, 26);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (56, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Durability' AND T1.attribute_value < 50;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T3.attribute_name = 'Durability' AND T2.attribute_value < 50;

/*
Prediction Result:
('Durability2',)
('Durability2',)
*/