-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA?JD', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('QAO#U', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!SOC?', 'TR009', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAG!_', 'A', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAq??', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA?)B', 'A', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA#$g', 'TR009', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAE"a', 'TR009', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!_Q__', 'A', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!MUcF', 'A', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAP_g', 'A', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_qK?19?', 'A', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Oq__?_ ', 'A', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!/_cQ', 'TR009', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAg_)', 'A', '78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA_QO', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA''?G', 'TR009', 'yp5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAbGO', 'TR009', 'vqx58pz0f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('SqCGS_', 'TR009', 'gd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!__?_/', 'A', 'vy9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (')qX_Mw_', 'TR009', 'bdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('''qI?W?M', 'b_s_549047', '5hncpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cn__7b3ebe', 'TR009', 'u0dz7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cn__8262fa', 'b_s_549047', 'fjgq8n2f3dq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA?S[', 'b_s_549047', 'k');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5u');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b_s_549047', 'gndqwnqc');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m_s_500ff5', 'zbilyrkn');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cn__6a7adb', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b_s_c540d8', 'A', 'gcb98oz');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA?JD', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('QAO#U', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!SOC?', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAG!_', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAq??', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA?)B', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA#$g', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAE"a', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!_Q__', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!MUcF', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAP_g', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_qK?19?', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Oq__?_ ', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!/_cQ', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAg_)', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA_QO', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA''?G', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAbGO', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('SqCGS_', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!__?_/', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES (')qX_Mw_', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('''qI?W?M', 'TR009_12', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cn__7b3ebe', 'cn__8262fa', 'cn__6a7adb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA?S[', 'TR009_12', 'cn__6a7adb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM connected AS cn JOIN bond AS b ON cn.bond_id = b.bond_id JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR009' AND (cn.atom_id = 'TR009_12' OR cn.atom_id2 = 'TR009_12');

/*
Prediction Result:
(23,)
*/