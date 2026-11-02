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
INSERT INTO "alignment" ("id", "alignment") VALUES (36, 'Strength42');
INSERT INTO "alignment" ("id", "alignment") VALUES (32, 'Strength42');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (41, 'Strength56');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (40, 'Strength');
INSERT INTO "colour" ("id", "colour") VALUES (65, 'Strength42');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Strength42');
INSERT INTO "gender" ("id", "gender") VALUES (73, 'Female');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (33, 'Strength42');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, 'Strength42');
INSERT INTO "race" ("id", "race") VALUES (34, 'Strength42');
INSERT INTO "race" ("id", "race") VALUES (38, 'Strength42');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (35, 36, 39, 73, 65, 37, 38, 39, 'Female49', 'Strength50', 51, 52);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (42, NULL, NULL, 73, 65, NULL, NULL, NULL, NULL, NULL, 71, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (40, 42, 100);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (41, 42, 53);
INSERT INTO "superpower" ("id", "power_name") VALUES (44, 'Strength42');
INSERT INTO "superpower" ("id", "power_name") VALUES (43, 'Strength42');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.attribute_name = 'Strength' AND T2.attribute_value = 100 AND T4.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS S INNER JOIN gender AS G ON S.gender_id = G.id INNER JOIN hero_attribute AS H_A ON S.id = H_A.hero_id INNER JOIN attribute AS A ON H_A.attribute_id = A.id WHERE G.gender = 'Female' AND A.attribute_name = 'Strength' AND H_A.attribute_value = 100;

/*
Prediction Result:
(1,)
*/