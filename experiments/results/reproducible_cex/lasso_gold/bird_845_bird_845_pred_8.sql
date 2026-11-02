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
INSERT INTO "alignment" ("id", "alignment") VALUES (1046, 'wish');
INSERT INTO "alignment" ("id", "alignment") VALUES (1047, 'push');
INSERT INTO "alignment" ("id", "alignment") VALUES (1048, 'rise');
INSERT INTO "colour" ("id", "colour") VALUES (1049, 'onto');
INSERT INTO "colour" ("id", "colour") VALUES (1050, 'discuss');
INSERT INTO "colour" ("id", "colour") VALUES (1051, 'reveal');
INSERT INTO "colour" ("id", "colour") VALUES (1067, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1070, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1052, 'garden');
INSERT INTO "gender" ("id", "gender") VALUES (1053, 'threat');
INSERT INTO "gender" ("id", "gender") VALUES (1054, 'special');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1055, 'Crystal Johnson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1056, 'Derek Clark');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1057, 'Sherri Edwards');
INSERT INTO "race" ("id", "race") VALUES (1058, 'reality');
INSERT INTO "race" ("id", "race") VALUES (1059, 'money');
INSERT INTO "race" ("id", "race") VALUES (1060, 'individual');
INSERT INTO "superpower" ("id", "power_name") VALUES (1061, 'Maria Thomas');
INSERT INTO "superpower" ("id", "power_name") VALUES (1062, 'Patrick Ryan');
INSERT INTO "superpower" ("id", "power_name") VALUES (1063, 'Jessica Silva');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1064, 'Zachary Taylor', 'Kyle Mcdonald', 1052, 1049, 1067, 1070, 1058, 1055, 1046, 1407374883552881, 1073);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1096, 'Zachary Taylor', 'Kyle Mcdonald', 1052, 1049, 1067, 1070, 1058, 1055, 1046, 2111062325329321, 1073);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1064, 1061);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1064, 1062);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1064, 1063);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
('Maria Thomas',)
('Patrick Ryan',)
('Jessica Silva',)
*/

-- Prediction Query
SELECT T2.power_name FROM superhero AS T1 JOIN hero_power AS T3 ON T1.id = T3.hero_id JOIN superpower AS T2 ON T3.power_id = T2.id WHERE T1.height_cm > (SELECT AVG(height_cm) * 0.8 FROM superhero);

/*
Prediction Result:
*/