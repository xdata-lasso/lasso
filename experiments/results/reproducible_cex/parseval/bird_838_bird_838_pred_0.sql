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
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '9n8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'Alien', 'sup_23214d', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1268590800, 1219478689);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'Alien', 'sup_23214d', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2122220075, 1072996612);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'Alien', 'sup_23214d', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -841692980, -1364429300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'sup_63e3ff', 'sup_23214d', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -918961358, -1602639011);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'Alien', NULL, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1038707349, 1419861592);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, NULL, '76nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT full_name FROM superhero WHERE superhero_name = 'Alien';

/*
Gold Result:
('sup_23214d',)
(None,)
('sup_23214d',)
('sup_23214d',)
*/

-- Prediction Query
SELECT "superhero"."full_name" FROM "superhero" INNER JOIN "race" ON "superhero"."race_id" = "race"."id" WHERE "race"."race" = 'Alien';

/*
Prediction Result:
*/