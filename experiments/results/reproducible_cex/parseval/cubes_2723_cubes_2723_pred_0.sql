-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: building --
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building_i_1', 'bui_fd75a4', '5k5swwqcgs', '9n8', 1610062532, -106629402);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('t1__ae5102', 't1__7b965c', 'u7', 'fe4hri', 1914020640, 1268590800);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('A', 'bui_fd75a4', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('C', 'bui_fd75a4', '76nium52', 'zbuo4nrqrof', 373262291, -472966518);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('t1__27d4ab', 't1__0f208d', 's5bbp02e', 'tliqa1', 2074205376, 274769912);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building_i_6', 'bui_fd75a4', 'vy9uxj4', 'wb', -1929953647, 1581736075);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building_i_7', 'bui_898fa6', 'gndqwnqc', 'x5hncprjtu0', -1898531797, -1748371085);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('Q', 't1__7b965c', 'q8', 'n2f3dqv0gcb9', 172461907, 1606439408);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building_i_9', 'bui_fd75a4', '1jh3den', 'c68x8vacx', -1762140823, 1371234901);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('O', 't1__7b965c', '1of77p', 'o72ctdc', 1303877941, -1284905200);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__11', 'bui_fd75a4', '6b', 'ou5z', 1691780814, 1944978593);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__12', 'bui_fd75a4', '5i3', 'q5l', 1339733032, -1556979799);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__13', 'bui_fd75a4', 'fvy', '7zzbe8y', -705922211, 1043710187);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__14', 'bui_fd75a4', 'do2zobb', 'q0k32od', -613916489, 2061558815);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('t2__e0eaaf', 't1__7b965c', '5amsorlwyngc', 'dj9erhi', 1056589776, -499913447);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__16', 'bui_fd75a4', '9td8n5w', 'g', -794767771, 989306270);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__17', 'bui_fd75a4', 'rmkio18r', 'i2hy08ftp6', -1853955201, -805997097);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__18', 'bui_fd75a4', 'xnjaby', 'mzn2mfx7h3', -891525031, -1154091048);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__19', 'bui_fd75a4', 'j', 'sh5knzys7', 1487347213, 1328948152);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building__20', NULL, '6rntdqrhm', 'wlic7dn2', 1409697108, -1104749933);

-- Inserting into table: institution --
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_1', 't1__ae5102', 'puzhsrw', 'b', 2003.0, 'p6luhvdlttil', 429706943, 'rmdp', 'siie');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_2', 't1__ae5102', 'oo3o9', 'l7', 2003.0, 'klex14ji', -453362185, 'au2dwyrq13', 'yu78');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_3', 't1__ae5102', '9', 'rljsl0b4y', 2003.0, 'p5qi2rkf9v', 556727997, '8pz0f8je', 'd2');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_4', 'Q', '3zb', 'lyr', 2003.0, 'kn6vck6ah0f8', -1520489792, 'wlq7xb', '72fxa7ryfd');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_5', 'Q', 'z16ni', 'jai', 2003.0, 'dh5ogrgj', -458359144, '1afgogritsj', 'ayxp1q43');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_6', 'A', '62', '0v', 2003.0, 'q8qdjpe1', -1180042408, '78507cvt', 'ptt');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_7', 'A', 'bfkfoacd', '7z2zezj', 2003.0, '7wgx', -57705450, 'xcmr0', 'ztdg');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_8', 'A', 'k58qs27p', 'r94gth2m', 2003.0, 'ajjl', -2096405521, 'okv8uttmu2', 'e578');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_9', 'A', '42q7sx58b4', 'pmaus3auvmkr', 2003.0, 'pdjwzw5chn9', 101754718, 'a9n0jxfo', 'ws');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('I', 't2__e0eaaf', 'yo', 'l0hdt6fuq', 2003.0, 'xuzkb52', -277407746, 'nlas6e', 'lboeowii1z5');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('A', 't2__e0eaaf', 'xih6', '2q2xlyoto', 2003.0, '9oaawg', 1044710644, 'qb0tbindz39t', 'j');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('O', 't2__e0eaaf', 'tdu6bd0w96', '3vzxw1r', 2003.0, 'e9yfk7', -1046720861, '162nh55y3d', 'ohvu06dza3');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('instituti_13', 't1__ae5102', '1', 'jmgjach8qt', 1.0, 'a8y3a17v4yg', -2081662466, '3qdpu', 'p');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('instituti_14', 't1__ae5102', '0xdmsqtge', 'cuq', 2003.0, '9', -1750715330, 'ccukjq1qui', '1yh');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM institution WHERE (founded >= 2003.0)) AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
(None,)
('bui_898fa6',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('bui_fd75a4',)
('t1__0f208d',)
('t1__7b965c',)
*/

-- Prediction Query
SELECT name FROM building EXCEPT SELECT T1.name FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id WHERE T2.founded = 2003;

/*
Prediction Result:
(None,)
('bui_898fa6',)
('t1__0f208d',)
*/