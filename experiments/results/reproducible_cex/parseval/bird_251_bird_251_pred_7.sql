-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_8ea852', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_d686ae', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_ecfc57', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('1', 'A', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (';', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'A', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('J', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'A', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('%', 'ato_7bc4ac', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('b', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('R', 'ato_4e4c8c', 'ato_4e14fb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'H', 'ato_567e5f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'mol_73c624', 'ato_567e5f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('(', 'D', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'I', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_7bc4ac', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_4e4c8c', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8c4pgu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_73c624', 'uzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('ato_4e14fb',)
*/

-- Prediction Query
SELECT "atom"."element" FROM "atom" INNER JOIN "molecule" ON "atom"."molecule_id" = "molecule"."molecule_id" WHERE "molecule"."label" = '+' GROUP BY "atom"."element" ORDER BY COUNT("atom"."atom_id") ASC, "atom"."element" NULLS LAST LIMIT 1;

/*
Prediction Result:
('ato_567e5f',)
*/