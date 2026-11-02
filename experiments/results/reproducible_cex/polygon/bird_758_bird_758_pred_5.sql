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
INSERT INTO "alignment" ("id", "alignment") VALUES (39, 'Human53');
INSERT INTO "alignment" ("id", "alignment") VALUES (47, 'Human53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Human53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'Human53');
INSERT INTO "colour" ("id", "colour") VALUES (42, 'Human53');
INSERT INTO "colour" ("id", "colour") VALUES (53, 'Human54');
INSERT INTO "gender" ("id", "gender") VALUES (40, 'Human53');
INSERT INTO "gender" ("id", "gender") VALUES (48, 'Human53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (41, 'Human53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (49, 'Human53');
INSERT INTO "race" ("id", "race") VALUES (30, 'Human53');
INSERT INTO "race" ("id", "race") VALUES (29, 'Human');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (38, 39, 42, 40, 53, 41, 29, 42, 'Human43', 'Human44', 185, 45);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (46, 47, 53, 48, 53, 49, 29, 53, 'Human50', 'Human51', 185, 52);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 46, 53);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 46, 53);
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Human53');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 31);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('Human54',)
*/

-- Prediction Query
SELECT c.colour FROM superhero AS s JOIN colour AS c ON s.hair_colour_id = c.id JOIN race AS r ON s.race_id = r.id WHERE s.height_cm = 185 AND r.race = 'Human';

/*
Prediction Result:
('Human54',)
('Human54',)
*/