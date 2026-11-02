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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "alignment" ("id", "alignment") VALUES (1002, 'brother');
INSERT INTO "alignment" ("id", "alignment") VALUES (1003, 'ago');
INSERT INTO "colour" ("id", "colour") VALUES (1004, 'site');
INSERT INTO "colour" ("id", "colour") VALUES (1005, 'face');
INSERT INTO "colour" ("id", "colour") VALUES (1006, 'election');
INSERT INTO "colour" ("id", "colour") VALUES (1019, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1022, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1031, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1034, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1007, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (1008, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (1009, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1010, 'Noah Rhodes');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1011, 'Angie Henderson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1012, 'Daniel Wagner');
INSERT INTO "race" ("id", "race") VALUES (1013, 'agreement');
INSERT INTO "race" ("id", "race") VALUES (1014, 'option');
INSERT INTO "race" ("id", "race") VALUES (1015, 'decide');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1016, 'Meredith Barnes', 'Daniel Gallagher', 1007, 1004, 1019, 1022, 1013, 1010, 1001, 1025, -1);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1017, 'Donald Booth', 'James Howard', 1007, 1004, 1019, 1022, 1013, 1010, 1001, 1048.0, 1);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1018, 'Caitlin Henderson', 'Dennis Williams', 1007, 1004, 1019, 1022, 1013, 1010, 1001, 1071.0, 3);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1028, 'Calvin Nielsen', 'Matthew Mejia', 1007, 1004, 1031, 1034, 1013, 1010, 1001, 1037, 1040);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1029, 'Edward Fuller', 'Dr. Sharon James', 1007, 1004, 1031, 1034, 1013, 1010, 1001, 1060.0, 1065.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1030, 'Heidi Lee', 'Roy Martin', 1007, 1004, 1031, 1034, 1013, 1010, 1001, 1083.0, 1090.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('Matthew Mejia',)
('Dr. Sharon James',)
('Roy Martin',)
*/

-- Prediction Query
SELECT "superhero"."superhero_name" FROM "superhero" INNER JOIN "gender" ON "superhero"."gender_id" = "gender"."id" WHERE "gender"."gender" = 'Male' AND "superhero"."weight_kg" > (SELECT AVG("weight_kg") * 0.79 FROM "superhero");

/*
Prediction Result:
('Calvin Nielsen',)
('Edward Fuller',)
('Heidi Lee',)
*/