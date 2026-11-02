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
INSERT INTO "alignment" ("id", "alignment") VALUES (57, 'Super Strength59');
INSERT INTO "alignment" ("id", "alignment") VALUES (28, 'Super Strength59');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Super Strength59');
INSERT INTO "colour" ("id", "colour") VALUES (62, 'Super Strength59');
INSERT INTO "colour" ("id", "colour") VALUES (59, 'Super Strength59');
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Super Strength59');
INSERT INTO "gender" ("id", "gender") VALUES (58, 'Super Strength59');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (60, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Super Strength59');
INSERT INTO "race" ("id", "race") VALUES (32, 'Super Strength59');
INSERT INTO "race" ("id", "race") VALUES (61, 'Super Strength59');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (66, 57, 59, 58, 59, 60, 61, 62, 'Marvel Comics100', 'Super Strength63', 64, 65);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, NULL, NULL, NULL, 59, 31, 61, 62, 'Super Strength59', 'Super Strength59', 59, 59);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, 66, 59);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, NULL, 59);
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Super Strength');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (66, 34);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (66, 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.power_name = 'Super Strength' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T4.publisher_name = 'Marvel Comics';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id INNER JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'Marvel Comics' AND superpower.power_name = 'Super Strength';

/*
Prediction Result:
('Marvel Comics100',)
('Marvel Comics100',)
*/