-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1013, 'Debra Davidson', '893 Nathaniel Estates Apt. 957
North Sarahport, IA 08093', 'several', 'part', 1017, 'surface');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1014, 'Jeffrey Chavez', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'worry', 'material', 1030.0, 'investment');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1015, 'Sherri Baker', '465 Lam Mission
East Jeffreymouth, AK 77611', 'us', 'eight', 1043.0, 'customer');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1016, 'Cassandra Gaines', '10310 Jones Freeway
Elizabethborough, ND 17843', 'own', 'still', 1056.0, 'between');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1025, 'Anthony Gray', '805 Brendan Neck
North Susan, CO 24857', 'worker', 'until', 1029, 'coach');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1026, 'Mrs. Rachel Gibson', '361 Beth Canyon
South Dianeshire, NC 41968', 'happy', 'election', 1042.0, 'left');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1027, 'Tyler Cowan', 'USNS Santiago
FPO AA 31786', 'upon', 'hope', 1055.0, 'these');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1028, 'Michelle Moore', '475 Albert Road
North Amandahaven, KS 17862', 'authority', 'feel', 1068.0, 'of');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1021, 'Jeffrey Henderson', 'Javier Ramirez', 'compare');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1022, 'Nicholas Nunez', 'Thomas Ramos', 'mention');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1023, 'Mrs. Jennifer Morgan', 'Krista Williams', 'medical');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1024, 'Danielle Lee', 'Dr. Tracy House DVM', 'different');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1033, 'Lisa Archer', 'Denise Jacobs', 'factor');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1034, 'Aimee Montoya', 'Christina Walters', 'another');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1035, 'Matthew Mcmillan', 'John Whitehead', 'about');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1036, 'Brian Rodriguez', 'Anna Henderson', 'goal');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1013, 1021, 'treatment');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1013, 1022, 'treatment');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1013, 1023, 'treatment');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1013, 1024, 'treatment');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1025, 1033, NULL);
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1025, 1034, NULL);
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1025, 1035, NULL);
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1025, 1036, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None, 4)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('treatment', 4)
*/