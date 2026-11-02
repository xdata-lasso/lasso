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
INSERT INTO "alignment" ("id", "alignment") VALUES (2586, 'truth');
INSERT INTO "alignment" ("id", "alignment") VALUES (2762, 'step');
INSERT INTO "colour" ("id", "colour") VALUES (2587, 'ground');
INSERT INTO "colour" ("id", "colour") VALUES (2763, 'when');
INSERT INTO "colour" ("id", "colour") VALUES (2653, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2669, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2829, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2845, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2588, 'summer');
INSERT INTO "gender" ("id", "gender") VALUES (2764, 'trial');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2589, 'Victor Taylor');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2765, 'Elizabeth Schneider');
INSERT INTO "race" ("id", "race") VALUES (2590, 'draw');
INSERT INTO "race" ("id", "race") VALUES (2766, 'allow');
INSERT INTO "superpower" ("id", "power_name") VALUES (2591, 'Misty Whitney');
INSERT INTO "superpower" ("id", "power_name") VALUES (2592, 'Regina Diaz');
INSERT INTO "superpower" ("id", "power_name") VALUES (2593, 'Alexis Herrera');
INSERT INTO "superpower" ("id", "power_name") VALUES (2594, 'Michael Chambers');
INSERT INTO "superpower" ("id", "power_name") VALUES (2595, 'Samantha Bentley');
INSERT INTO "superpower" ("id", "power_name") VALUES (2596, 'David Johnson');
INSERT INTO "superpower" ("id", "power_name") VALUES (2597, 'Kristina Herman');
INSERT INTO "superpower" ("id", "power_name") VALUES (2598, 'Arthur Colon');
INSERT INTO "superpower" ("id", "power_name") VALUES (2599, 'Elizabeth Ortiz');
INSERT INTO "superpower" ("id", "power_name") VALUES (2600, 'Tracy Torres');
INSERT INTO "superpower" ("id", "power_name") VALUES (2601, 'Brent Clay Jr.');
INSERT INTO "superpower" ("id", "power_name") VALUES (2602, 'Michael Paul');
INSERT INTO "superpower" ("id", "power_name") VALUES (2603, 'Jennifer Newton');
INSERT INTO "superpower" ("id", "power_name") VALUES (2604, 'Jason Garcia');
INSERT INTO "superpower" ("id", "power_name") VALUES (2605, 'Jason Lynn Jr.');
INSERT INTO "superpower" ("id", "power_name") VALUES (2606, 'Jeremy Sampson');
INSERT INTO "superpower" ("id", "power_name") VALUES (2767, 'John Morales');
INSERT INTO "superpower" ("id", "power_name") VALUES (2768, 'Katherine Browning');
INSERT INTO "superpower" ("id", "power_name") VALUES (2769, 'Bobby Franklin');
INSERT INTO "superpower" ("id", "power_name") VALUES (2770, 'Donald Schultz');
INSERT INTO "superpower" ("id", "power_name") VALUES (2771, 'Erika Vang');
INSERT INTO "superpower" ("id", "power_name") VALUES (2772, 'Jody Jacobs');
INSERT INTO "superpower" ("id", "power_name") VALUES (2773, 'Michael Farrell');
INSERT INTO "superpower" ("id", "power_name") VALUES (2774, 'Patricia Le');
INSERT INTO "superpower" ("id", "power_name") VALUES (2775, 'Jesse Perez');
INSERT INTO "superpower" ("id", "power_name") VALUES (2776, 'Jesse Perry');
INSERT INTO "superpower" ("id", "power_name") VALUES (2777, 'Jeffery Ortega');
INSERT INTO "superpower" ("id", "power_name") VALUES (2778, 'Christian Leblanc');
INSERT INTO "superpower" ("id", "power_name") VALUES (2779, 'Ronald Davis');
INSERT INTO "superpower" ("id", "power_name") VALUES (2780, 'Parker Cain');
INSERT INTO "superpower" ("id", "power_name") VALUES (2781, 'Laurie Hoffman');
INSERT INTO "superpower" ("id", "power_name") VALUES (2782, 'Bryan Gomez');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2607, 'Ariana Jennings', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2730, 2746);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2608, 'Vanessa Howard', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2753.0, 2771.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2609, 'Colton Martinez', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2776.0, 2796.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2610, 'Jordan Bates', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2799.0, 2821.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2611, 'Linda Smith', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2822.0, 2846.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2612, 'Dana Martinez', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2845.0, 2871.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2613, 'Andrea Hubbard', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2868.0, 2896.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2614, 'Daniel Kane', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2891.0, 2921.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2615, 'Charles Lester', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2914.0, 2946.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2616, 'Scott Thomas', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2937.0, 2971.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2617, 'David Thompson', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2960.0, 2996.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2618, 'Allison Smith', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 2983.0, 3021.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2619, 'Cynthia Morris', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 3006.0, 3046.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2620, 'Anthony Harmon', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 3029.0, 3071.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2621, 'Nichole Alvarez', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 3052.0, 3096.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2622, 'Kayla Rodriguez', 'Theresa Williams', 2588, 2587, 2653, 2669, 2590, 2589, 2586, 3075.0, 3121.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2783, 'Nicole Parrish', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 2906, 2922);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2784, 'Tracy Burke', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 2929.0, 2947.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2785, 'Kenneth Lewis', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 2952.0, 2972.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2786, 'Courtney Rodriguez', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 2975.0, 2997.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2787, 'Holly Farmer', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 2998.0, 3022.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2788, 'Renee Bruce', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3021.0, 3047.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2789, 'Sabrina Austin', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3044.0, 3072.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2790, 'Allison Hickman', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3067.0, 3097.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2791, 'Debra White', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3090.0, 3122.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2792, 'Ellen Morgan', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3113.0, 3147.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2793, 'Sergio Knight', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3136.0, 3172.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2794, 'Charles Schultz', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3159.0, 3197.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2795, 'Paul Lewis', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3182.0, 3222.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2796, 'Glen Wood', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3205.0, 3247.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2797, 'Paula Bradley', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3228.0, 3272.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2798, 'Anthony Moore', 'Theresa Williams', 2764, 2763, 2829, 2845, 2766, 2765, 2762, 3251.0, 3297.0);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2591);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2592);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2593);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2594);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2595);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2596);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2597);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2598);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2599);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2600);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2601);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2602);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2603);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2604);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2605);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2607, 2606);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2767);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2768);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2769);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2770);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2771);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2772);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2773);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2774);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2775);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2776);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2777);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2778);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2779);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2780);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2781);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2783, 2782);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
('Theresa Williams',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN (SELECT hero_id FROM hero_power GROUP BY hero_id HAVING COUNT(DISTINCT power_id) > 15) AS power_count ON superhero.id = power_count.hero_id;

/*
Prediction Result:
('Theresa Williams',)
('Theresa Williams',)
*/