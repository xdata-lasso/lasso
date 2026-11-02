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
INSERT INTO "alignment" ("id", "alignment") VALUES (2761, 'form');
INSERT INTO "alignment" ("id", "alignment") VALUES (2762, 'customer');
INSERT INTO "alignment" ("id", "alignment") VALUES (2763, 'source');
INSERT INTO "alignment" ("id", "alignment") VALUES (2764, 'collection');
INSERT INTO "alignment" ("id", "alignment") VALUES (2809, 'loss');
INSERT INTO "alignment" ("id", "alignment") VALUES (2810, 'church');
INSERT INTO "alignment" ("id", "alignment") VALUES (2811, 'police');
INSERT INTO "alignment" ("id", "alignment") VALUES (2812, 'walk');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2765, 'Mr. Jonathan Parker Jr.');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2767, 'Kathy Levy');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2768, 'Harry Williams');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2814, 'Stephen Pena MD');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2766, 'Erin Austin');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2815, 'William Stevenson');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2816, 'George Clayton');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2817, 'Michelle Evans');
INSERT INTO "colour" ("id", "colour") VALUES (2769, 'not');
INSERT INTO "colour" ("id", "colour") VALUES (2770, 'across');
INSERT INTO "colour" ("id", "colour") VALUES (2771, 'throw');
INSERT INTO "colour" ("id", "colour") VALUES (2772, 'box');
INSERT INTO "colour" ("id", "colour") VALUES (2817, 'team');
INSERT INTO "colour" ("id", "colour") VALUES (2818, 'adult');
INSERT INTO "colour" ("id", "colour") VALUES (2819, 'home');
INSERT INTO "colour" ("id", "colour") VALUES (2820, 'glass');
INSERT INTO "colour" ("id", "colour") VALUES (2789, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2793, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2837, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2841, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2773, 'lawyer');
INSERT INTO "gender" ("id", "gender") VALUES (2774, 'center');
INSERT INTO "gender" ("id", "gender") VALUES (2775, 'us');
INSERT INTO "gender" ("id", "gender") VALUES (2776, 'everything');
INSERT INTO "gender" ("id", "gender") VALUES (2821, 'report');
INSERT INTO "gender" ("id", "gender") VALUES (2822, 'break');
INSERT INTO "gender" ("id", "gender") VALUES (2823, 'keep');
INSERT INTO "gender" ("id", "gender") VALUES (2824, 'past');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2777, 'Pamela Diaz');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2778, 'Kelly Lee');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2779, 'Angel Gordon');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2780, 'Diana Hays');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2825, 'Steven Wiggins');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2826, 'Linda Baker');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2827, 'Valerie Lane');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2828, 'Anthony Castillo');
INSERT INTO "race" ("id", "race") VALUES (2781, 'popular');
INSERT INTO "race" ("id", "race") VALUES (2782, 'by');
INSERT INTO "race" ("id", "race") VALUES (2783, 'career');
INSERT INTO "race" ("id", "race") VALUES (2784, 'bill');
INSERT INTO "race" ("id", "race") VALUES (2829, 'professional');
INSERT INTO "race" ("id", "race") VALUES (2830, 'set');
INSERT INTO "race" ("id", "race") VALUES (2831, 'president');
INSERT INTO "race" ("id", "race") VALUES (2832, 'thought');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2786, 'Black Panther', 'Robert Morgan', 2773, 2769, 2789, 2793, 2781, 2777, 2761, 2797, 2801);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2787, 'Black Panther', 'Nicole Gonzalez', 2773, 2769, 2789, 2793, 2781, 2777, 2761, 2820.0, 2826.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2788, 'Black Panther', 'Kathryn Williams', 2773, 2769, 2789, 2793, 2781, 2777, 2761, 2843.0, 2851.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2833, 'Black Panther', 'Gary Wells', 2773, 2769, 2789, 2793, 2781, 2777, 2761, 2866.0, 2876.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2785, 'Black Panther', 'Roberto Allen', 2821, 2817, 2837, 2841, 2829, 2825, 2809, 2798, 2802);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2834, 'Black Panther', 'Melody Lee', 2821, 2817, 2837, 2841, 2829, 2825, 2809, 2868.0, 2874.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2835, 'Black Panther', 'Jason Gutierrez', 2821, 2817, 2837, 2841, 2829, 2825, 2809, 2891.0, 2899.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2836, 'Black Panther', 'Jonathan Carr', 2821, 2817, 2837, 2841, 2829, 2825, 2809, 2914.0, 2924.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2786, 2765, 2805);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2786, 2765, 2812.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2786, 2765, 2819.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2786, 2765, 2826.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2785, 2766, 2805);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2785, 2766, 2860.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2785, 2766, 2867.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2785, 2766, 2874.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Erin Austin',)
*/

-- Prediction Query
SELECT a.attribute_name FROM attribute AS a JOIN hero_attribute AS ha ON a.id = ha.attribute_id JOIN superhero AS s ON ha.hero_id = s.id WHERE s.superhero_name = 'Black Panther' ORDER BY ha.attribute_value ASC, a.id NULLS LAST, ha.hero_id NULLS LAST, ha.attribute_id NULLS LAST, s.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Mr. Jonathan Parker Jr.',)
*/