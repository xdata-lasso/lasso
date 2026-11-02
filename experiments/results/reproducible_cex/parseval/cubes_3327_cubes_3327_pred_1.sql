-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: school --
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 475.173408, 'sch_42b7cb', 'u7', 'sch_ab978c', 328.996339, '4h');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483647, 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, 'sch_42b7cb', 'l', 'sch_ab978c', 303.05704, 'lbn');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483646, 'rmdp', 'siie', 489.397796, 933.422701, 'sch_42b7cb', '6klfa9', 'sch_ab978c', 877.276439, '00t5c4ecigc');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483645, 'e376nium52', 'zbuo4nrqrof', 586.906897, 389.878901, 'sch_42b7cb', 's5bbp02e', 'sch_ab978c', 325.080047, 'iqa');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483644, '1ryytoo', 'o9hl72kl', 74.250383, 776.522001, 'sch_42b7cb', '14ji7z', 'sch_ab978c', 353.163664, 'u');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483643, '2dwyrq13pyu7', 'd99rljsl0', 27.036693, 884.000446, 'sch_42b7cb', 'p5qi2rkf9v', 'sch_ab978c', 263.638479, 'x58pz0f8jeg');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483642, 'd21vy9uxj4hw', 'd', 328.40866, 989.653112, 'sch_42b7cb', 'h2gndqwnqcx5', NULL, 635.267184, 'cprj');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483641, 'u0dz7', 'fjgq8n2f3', 687.701166, 656.638403, 'sch_42b7cb', 'qv0gcb98oz', NULL, 836.121091, 'zbilyrkn');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483640, '6vck6ah0f8js', 'wlq7xb', 598.428216, 949.322482, 'sch_42b7cb', '2fxa7ryfdrz', NULL, 753.351134, '6nijjai');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483639, 'dh5ogrgj', '8', 740.059813, 388.212083, NULL, 't1afgog', 'sch_ab978c', 279.731401, 'tsj3ayxp1q4');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483638, '01jh3den', 'c68x8vacx', 516.027628, 8.577518, NULL, 'u5', 'sch_ab978c', 354.593207, 'of77pzo');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483637, '72ctdctmfg62', '0v', 492.883123, 691.147113, NULL, 'qdjpe1io2', 'sch_ab978c', 445.968654, '507cvtjpt');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483636, 'tg6bnou5zi', '6c4bfkfo', 12.330671, 774.96573, 'sch_42b7cb', 'd', 'sch_ab978c', 992.626961, '7z2zezjo7wg');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483635, 'd5ysxc', 'r0oz', 297.258735, 104.37745, 'sch_42b7cb', '5i3lq5lnpim5', 'sch_ab978c', 167.377262, '8qs27p2r');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483634, '4gth2mnaj', 'la3', 588.850908, 230.994112, 'sch_42b7cb', 'v8u', 'sch_ab978c', 311.951038, 'mu2ne');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483633, '78lfvyz7', 'zzbe8yvkv4', 445.606673, 574.707916, 'sch_42b7cb', 'sx58b4pma', 'sch_ab978c', 693.650436, 's3auvm');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483632, 'rpd', 'wzw', 487.079129, 110.207708, 'sch_42b7cb', 'mo705a9n0', 'sch_ab978c', 903.226183, 'fofwsz');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483631, 'o', '2zobb0q0k32o', 57.929422, 38.169466, 'sch_42b7cb', '5am', 'sch_ab978c', 938.014057, 'orlwy');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483630, 'gc1d', 'j9erhizgk1', 722.415629, 230.654784, 'sch_42b7cb', 'o6l0hdt', 'sch_ab978c', 506.13059, 'uq');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483629, 'xuzkb52', 'gwnlas6', 907.723998, 65.338043, 'sch_42b7cb', 'boe', 'sch_ab978c', 230.129952, 'i1z');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483628, 'nxih662q', 'xlyotow9', 232.87238, 669.409476, 'sch_42b7cb', 'awg96aqb0tbi', 'sch_ab978c', 617.126317, 'z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination, n AS count___ FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) ORDER BY denomination, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('sch_42b7cb', 3)
('sch_42b7cb', 15)
*/

-- Prediction Query
SELECT Denomination, COUNT(*) FROM school GROUP BY Denomination;

/*
Prediction Result:
(None, 3)
('sch_42b7cb', 18)
*/