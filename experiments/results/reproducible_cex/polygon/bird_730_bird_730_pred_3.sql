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
INSERT INTO "alignment" ("id", "alignment") VALUES (75, 'Marvel Comics78');
INSERT INTO "alignment" ("id", "alignment") VALUES (33, 'Marvel Comics78');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (35, 'Marvel Comics78');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (34, 'Marvel Comics78');
INSERT INTO "colour" ("id", "colour") VALUES (80, 'Marvel Comics78');
INSERT INTO "colour" ("id", "colour") VALUES (77, 'Marvel Comics78');
INSERT INTO "gender" ("id", "gender") VALUES (76, 'Marvel Comics78');
INSERT INTO "gender" ("id", "gender") VALUES (36, 'Marvel Comics78');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, 'Marvel Comics78');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (78, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (38, 'Marvel Comics78');
INSERT INTO "race" ("id", "race") VALUES (79, 'Marvel Comics78');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (74, NULL, NULL, NULL, NULL, 78, NULL, NULL, 'Marvel Comics70', NULL, NULL, 73);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (85, 75, 77, 76, 77, 78, 79, 80, NULL, 'Marvel Comics82', 83, 84);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (34, 74, 78);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, NULL, 78);
INSERT INTO "superpower" ("id", "power_name") VALUES (40, 'Super Strength47');
INSERT INTO "superpower" ("id", "power_name") VALUES (39, 'Super Strength');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (74, 40);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (85, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.power_name = 'Super Strength' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T4.publisher_name = 'Marvel Comics';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.power_name = 'Super Strength' AND T4.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(None,)
*/