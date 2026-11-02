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
INSERT INTO "alignment" ("id", "alignment") VALUES (2909, 'area');
INSERT INTO "alignment" ("id", "alignment") VALUES (2910, 'black');
INSERT INTO "alignment" ("id", "alignment") VALUES (2911, 'job');
INSERT INTO "alignment" ("id", "alignment") VALUES (2912, 'give');
INSERT INTO "alignment" ("id", "alignment") VALUES (2957, 'side');
INSERT INTO "alignment" ("id", "alignment") VALUES (2958, 'low');
INSERT INTO "alignment" ("id", "alignment") VALUES (2959, 'raise');
INSERT INTO "alignment" ("id", "alignment") VALUES (2960, 'even');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2913, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2915, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2916, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2962, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2914, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2963, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2964, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2965, 'Speed');
INSERT INTO "colour" ("id", "colour") VALUES (2917, 'marriage');
INSERT INTO "colour" ("id", "colour") VALUES (2918, 'responsibility');
INSERT INTO "colour" ("id", "colour") VALUES (2919, 'accept');
INSERT INTO "colour" ("id", "colour") VALUES (2920, 'oil');
INSERT INTO "colour" ("id", "colour") VALUES (2965, 'serious');
INSERT INTO "colour" ("id", "colour") VALUES (2966, 'cultural');
INSERT INTO "colour" ("id", "colour") VALUES (2967, 'address');
INSERT INTO "colour" ("id", "colour") VALUES (2968, 'since');
INSERT INTO "colour" ("id", "colour") VALUES (2937, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2941, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2985, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2989, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2921, 'woman');
INSERT INTO "gender" ("id", "gender") VALUES (2922, 'investment');
INSERT INTO "gender" ("id", "gender") VALUES (2923, 'read');
INSERT INTO "gender" ("id", "gender") VALUES (2924, 'worry');
INSERT INTO "gender" ("id", "gender") VALUES (2969, 'green');
INSERT INTO "gender" ("id", "gender") VALUES (2970, 'street');
INSERT INTO "gender" ("id", "gender") VALUES (2971, 'find');
INSERT INTO "gender" ("id", "gender") VALUES (2972, 'out');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2925, 'Karen Santos');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2927, 'Donna Mitchell');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2928, 'Randy Pearson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2973, 'Parker Jefferson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2926, 'Cheryl Carr');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2974, 'Jennifer Patterson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2975, 'James Davis');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2976, 'Mrs. Taylor Smith');
INSERT INTO "race" ("id", "race") VALUES (2929, 'always');
INSERT INTO "race" ("id", "race") VALUES (2930, 'white');
INSERT INTO "race" ("id", "race") VALUES (2931, 'will');
INSERT INTO "race" ("id", "race") VALUES (2932, 'continue');
INSERT INTO "race" ("id", "race") VALUES (2977, 'identify');
INSERT INTO "race" ("id", "race") VALUES (2978, 'likely');
INSERT INTO "race" ("id", "race") VALUES (2979, 'some');
INSERT INTO "race" ("id", "race") VALUES (2980, 'example');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2934, 'Elizabeth Sharp', 'Emily Wilson', 2921, 2917, 2937, 2941, 2929, 2925, 2909, 2945, 2949);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2935, 'Russell French', 'Martin Warren', 2921, 2917, 2937, 2941, 2929, 2925, 2909, 2968.0, 2974.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2936, 'Paul Brennan', 'Brandi Gordon', 2921, 2917, 2937, 2941, 2929, 2925, 2909, 2991.0, 2999.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2981, 'Andrew Evans', 'Robert Rivera', 2921, 2917, 2937, 2941, 2929, 2925, 2909, 3014.0, 3024.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2933, 'Ryan Peck', 'Tanya Rogers', 2969, 2965, 2985, 2989, 2977, 2926, 2957, 2946, 2950);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2982, 'Matthew Schwartz', 'Elizabeth Mendez', 2969, 2965, 2985, 2989, 2977, 2926, 2957, 3016.0, 3022.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2983, 'Bryan Parker', 'Casey Hernandez', 2969, 2965, 2985, 2989, 2977, 2926, 2957, 3039.0, 3047.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2984, 'Jonathan Jacobson', 'Lisa Perry', 2969, 2965, 2985, 2989, 2977, 2926, 2957, 3062.0, 3072.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2934, 2913, 2953);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2934, 2913, 2960.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2934, 2913, 2967.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2934, 2913, 2974.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2933, 2914, 2953);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2933, 2914, 3008.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2933, 2914, 3015.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2933, 2914, 3022.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id INNER JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Cheryl Carr',)
*/

-- Prediction Query
SELECT T1.publisher_name FROM publisher AS T1 JOIN superhero AS T2 ON T1.id = T2.publisher_id JOIN hero_attribute AS T3 ON T2.id = T3.hero_id JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value ASC, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Karen Santos',)
*/