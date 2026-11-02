-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: conductor --
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678);

-- Inserting into table: orchestra --
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483648, -2147483648, 'a2y', 'orc_f8db23', 797.015047, 'uzhs');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483647, -2147483648, 'wbbp6luhvdlt', 'orc_f8db23', 304.02808, 'bnp');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483646, -2147483648, 'dpos', 'orc_f8db23', 133.007885, '5u');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483645, -2147483648, '6klfa9', 'orc_35f400', 877.276439, '00t5c4ecigc');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483644, -2147483648, '76nium52', 'orc_35f400', 816.814398, 'buo4nrq');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483643, -2147483648, 'fqyp', 'orc_35f400', 488.977171, '5bbp0');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483642, -2147483648, 'eutliqa11r', 'orc_f8db23', 997.73177, 'ytoo3o9hl7');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483641, -2147483648, 'lex', 'orc_f8db23', 913.303855, 'ji7zwau2');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483640, -2147483648, 'yrq13p', 'orc_f8db23', 375.832821, '8d99rljsl');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483639, -2147483648, '4', 'orc_35f400', 884.000446, 'p5qi2rkf9v');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483638, -2147483648, 'x58pz0f8je', 'orc_35f400', 755.698226, 'd2');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483637, -2147483648, 'y9uxj4', 'orc_35f400', 124.573829, 'd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483636, -2147483648, 'ph2', NULL, 109.083092, 'dqwn');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483635, -2147483648, 'x', NULL, 668.309685, 'hncprjtu0dz');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483634, -2147483648, 'gq8', NULL, 915.268032, '2f3d');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483633, -2147483648, '0gcb98', NULL, 221.227801, 'k3zbily');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483632, -2147483648, 'kn6vck6ah0f8', NULL, 145.983385, 'wlq7xb');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483631, -2147483648, 'xa', NULL, 584.342044, 'yfdrz');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483630, -2147483648, '6nijjai5dh', 'orc_f8db23', 488.601669, 'grgj');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483629, -2147483648, 'yzt1afgog', 'orc_f8db23', 279.731401, 'tsj3ayxp1q4');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483628, -2147483648, '1jh3den', 'orc_f8db23', 544.095565, 'c68x8vacx7');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483627, -2147483648, 'u5', 'orc_35f400', 354.593207, 'of77pzo');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483626, -2147483648, 'ctdctmfg62g0', 'orc_35f400', 935.463334, 'q8qdjpe1');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483625, -2147483648, '2278', 'orc_35f400', 494.537964, '7cvtjpt');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483624, -2147483648, '6b', 'orc_f8db23', 217.602841, 'u5zi');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483623, -2147483648, 'c4bfkfoac', 'orc_f8db23', 60.937725, '7z2zezj');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483622, -2147483648, 'wgxd5ysxc', 'orc_f8db23', 187.71278, '0oztd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483621, -2147483648, '5i3', 'orc_35f400', 172.799686, '5lnpim5k58qs');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483620, -2147483648, '7p2r94gth2m', 'orc_35f400', 925.474843, 'ajjl');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483619, -2147483648, 'okv8uttm', 'orc_35f400', 318.763195, 'ne578lfv');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483618, -2147483648, '7zzbe8y', 'orc_f8db23', 335.639672, 'v42q7sx58b4p');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483617, -2147483648, 'u', 'orc_f8db23', 771.198983, 'auvmkrpd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483616, -2147483648, 'wzw5chn9mo70', 'orc_f8db23', 486.420817, 'a9n0jxfofws');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483615, -2147483648, 'o', 'orc_35f400', 778.650393, '2zobb0q0k32o');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483614, -2147483648, 'cl5ams', 'orc_35f400', 665.099697, 'lwyng');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483613, -2147483648, 'dj9erhi', 'orc_35f400', 746.006477, 'k1');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483612, -2147483648, 'eyo6', 'orc_f8db23', 938.174215, '0hd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483611, -2147483648, 'fuqyxuzkb', 'orc_f8db23', 904.57762, '521gwnlas6e');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483610, -2147483648, 'boeowii1z5nx', 'orc_f8db23', 138.537557, '62q2xlyot');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483609, -2147483648, '9oaawg', 'orc_35f400', 555.75468, 'aqb0tbindz39');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483608, -2147483648, 'j', 'orc_35f400', 770.531988, '9td8n5w');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483607, -2147483648, 'um', 'orc_35f400', 30.758515, '3');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483606, -2147483648, 'u', 'orc_f8db23', 506.209886, 'd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483605, -2147483648, '9603vz', 'orc_f8db23', 685.760212, 'xw1rxe9yfk7q');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483604, -2147483648, '162nh55y3d', 'orc_f8db23', 602.631056, 'vu');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483603, -2147483648, 'dza35rmki', 'orc_35f400', 229.766946, 'ri2hy08ft');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483602, -2147483648, 'ewtqxxnja', 'orc_35f400', 779.614625, 'y');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483601, -2147483648, 'n2mfx7h', 'orc_35f400', 463.637542, '6sto');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483600, -2147483648, 'j', 'orc_f8db23', 835.790392, 'h5knz');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483599, -2147483648, '7dyyd', 'orc_f8db23', 425.077908, 'jmgjach8qt');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483598, -2147483648, '8y3a17v4yg', 'orc_f8db23', 851.403807, 'ayq3');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483597, -2147483648, 'dpuap96rnt', 'orc_35f400', 51.630816, 'rhm5w');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483596, -2147483648, 'c7d', 'orc_35f400', 638.478504, 'np490xdm');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483595, -2147483648, 'tgelc', 'orc_35f400', 321.654734, 'b9i9f');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483594, -2147483648, 'ccukjq1qui', 'orc_f8db23', 160.296838, 'yhb08hlst1pq');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483593, -2147483648, 'iztv', 'orc_f8db23', 17.438617, '4iz7');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483592, -2147483648, 'qlud8', 'orc_f8db23', 82.054778, 'tb8r9114qbre');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483591, -2147483648, 'jeuuwsj8kj', 'orc_35f400', 114.099596, 'wpxlvris');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483590, -2147483648, 'z0kaq', 'orc_35f400', 309.39382, 'ncgc8s3b7v8');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483589, -2147483648, 'dmdbdh', 'orc_35f400', 303.260196, 'j47nxar50h');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483588, -2147483648, 'han', 'orc_f8db23', 778.307195, 'dpunmw');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483587, -2147483648, 'xqrlaw', 'orc_f8db23', 164.859551, '14r5dqtsmg97');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483586, -2147483648, 'z2o20', 'orc_f8db23', 974.446302, 'j6dd');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483585, -2147483648, 'su6iphd', 'orc_35f400', 168.487055, '2gir31');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483584, -2147483648, 'q51oa2', 'orc_35f400', 706.295383, 'b3uoi');

INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (-2147483583, -2147483648, 'avcv', 'orc_35f400', 722.756601, 'nyqrou');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT record_company_other AS record_company FROM (SELECT LHS.record_company AS record_company, LHS.n AS n, RHS.record_company AS record_company_other, RHS.n AS n_other FROM (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS LHS CROSS JOIN (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS RHS) WHERE (n < n_other) ORDER BY record_company;

/*
Gold Result:
('orc_35f400',)
('orc_f8db23',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC, Record_Company NULLS LAST LIMIT 1;

/*
Prediction Result:
('orc_35f400',)
*/