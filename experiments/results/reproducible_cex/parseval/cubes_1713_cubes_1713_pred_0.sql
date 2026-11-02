-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1, 'lhs_7e64cd', 'lhs_958e35', 'lhs_9fb19d', 'lhs_02b60c', 'lhs_58bd74');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483647, 'lhs_e6494a', 'lhs_43dbfd', 'lhs_37c859', 'lhs_ea06d3', 'lhs_5b7924');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (2, 'qv26u331spx', 'pw30bgwkxgi', 'nlj6idmp61', '2o3', 'k');

-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1, '5k5swwqcgs', 'rhs_9971db', 'rhs_2bbd71', 'rhs_04e81b', 1.0);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483647, 'gce', 'rhs_3f8b04', 'rhs_cf1318', 'rhs_51eae9', 1.0);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (2, '62ocagj', 'ev', 'zxlu49', 'ubo', 66.494394);

-- Inserting into table: flight --
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483648, 1, 1, '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 663.049759, 711.020062);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483647, 1, 1, 'p', 'luhvdltti', 'bnp', 787.938887, 986.066566);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483646, 1, 1, 'posiie5unw6k', 'fa9', '00t5c4e', 950.466571, 796.740316);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483645, -2147483647, 1, '6nium52zb', 'uo4nrqrofqy', '5s5b', 22.720462, 990.777211);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483644, -2147483647, 1, '2eutliqa11r', 'ytoo3o9', 'l7', 443.457804, 774.422647);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483643, 1, 1, 'x1', 'ji7zwau2', 'dwyrq13pyu78', 49.538289, 557.003843);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483642, 1, 1, 'l0b4y', 'p5qi2rkf9v', 'x58pz', 410.133844, 88.474525);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483641, 1, 1, 'd2', 'vy9uxj4', 'wb', 50.647649, 185.427628);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483640, 1, 1, 'gndqwnqc', 'x5hncprjtu0', 'z', 521.610309, 654.674676);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483639, 1, 1, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 279.382219, 170.168747);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483638, 1, 1, '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 276.61064, 399.319982);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483637, -2147483647, 1, '6nijjai5dh', 'ogrgjd8y', 't1afgog', 279.731401, 630.468925);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483636, -2147483647, 1, 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 854.793228, 983.924121);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483635, -2147483647, 1, 'w1of77pz', '72ct', 'c', 803.582738, 695.452114);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483634, 1, 1, 'g6', 'g0v5q8qd', 'jpe1io22785', 993.555996, 848.763933);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483633, 1, 1, 'tjpttg', 'bnou5zi36', '4', 17.379583, 166.297151);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483632, 1, 1, 'oacd07z2zez', 'o7w', 'xd', 965.506647, 377.388457);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483631, -2147483647, 1, 'm', '0oztd', 'j5', 125.223349, 172.799686);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483630, -2147483647, 1, 'npi', '5k58', 's27p2', 848.622384, 555.274052);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483629, -2147483647, 1, 'th', '2mnajjla3o', 'v8u', 311.951038, 298.104305);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483628, 1, 1, '2ne578', 'fvy', '7zzbe8y', 335.639672, 743.007715);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483627, -2147483647, 1, 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 191.1711, 225.279122);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483626, -2147483647, 1, 'a9n0jxfo', 'ws', 'do2zobb', 407.368744, 983.253685);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483625, -2147483647, 1, '32o', 'w', 'l', 708.448101, 988.402461);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483624, 1, 1, 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 124.067083, 302.258495);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483623, 1, 1, 'qyxuzk', '5', '1gwnlas6', 907.723998, 65.338043);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483622, 1, 1, 'boeowii1z5nx', 'h66', 'q2xlyoto', 913.199755, 547.887692);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483621, 1, 1, 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', 36.996954, 314.953709);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483620, 1, 1, '3', 'tdu6bd0w96', '3vzxw1r', 372.360229, 65.653061);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483619, -2147483647, 1, 'k7', 'k162n', '55', 990.308943, 467.033126);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483618, 1, 1, 'vu', '6dza35r', 'mkio18ri2hy', 745.189516, 852.871276);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483617, -2147483647, 1, '8ftp6ewtqx', 'njabym', 'n2mfx7h', 463.637542, 753.382585);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483616, 1, 1, '6sto1cj8sh5k', 'zys7', 'y', 670.297308, 376.149796);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483615, -2147483647, 1, 'jmgjach8qt', 'a8y3a17v4yg', 'mayq3qdpua', 237.529885, 910.552252);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483614, -2147483647, 1, 'tdqr', 'm5', 'wlic7dn2np', 480.228838, 898.682383);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483613, -2147483647, 1, 'dmsqtg', 'lc', 'qb9i9f', 446.993541, 41.090755);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483612, 1, 1, 'kjq1qu', 'k1y', 'hb08hlst1pq', 961.035335, 784.591475);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483611, 1, 1, 'tvb6m4i', '78aqqlu', '8', 82.054778, 720.830622);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483610, 1, 1, 'r9114qbre', '6bjeuuwsj8k', 'h85', 358.01048, 368.667363);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483609, 1, 1, 'vrisurz0ka', 'qtncgc8s3b7', 'v88kwdmdbd', 120.684261, 507.914607);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483608, 1, 1, '7nxar50h', 'sjhanzxdpu', 'mwfw', 373.299809, 276.873433);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483607, 1, 1, 'k014r5', 'dqtsmg97aqz2', '20pj', 878.502931, 50.158445);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483606, 1, 1, 'ysu', 'iphdku2gi', '31vwq', 776.759844, 981.395878);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483605, -2147483647, 1, 'a2sb', 'uoi1pavc', 'wnyqro', 973.214347, 713.663081);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483604, 1, 1, 'lrpou', 't63', 'xyfvmjwpp26', 945.48391, 20.124208);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483603, 1, 1, '0ju', '0h3r133ir1ax', 'yhpl2i9', 72.185429, 13.527735);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483602, 1, 1, 'pgckqwtsr', '54o6qjektb1', '2', 211.896872, 392.889739);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483601, -2147483647, 1, 'rjkwns47j2ja', '8dccy3vjwq49', 'yrnxs6dvdx', 57.516956, 445.910628);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483600, -2147483647, 1, 'gvplj9fj', 'uun7k1', 'z2my1og', 386.03549, 422.35441);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483599, 1, 1, 'za', 'xc1clupgly', '8oitxeilp', 592.613785, 935.379175);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483598, 1, 1, '19cy7od', '033dlhdsvnh', 'd2', 642.766569, 176.647154);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (2, 2, 1, 'e', 'uekhllbw', 'dpu5v0', 70.074089, 326.821585);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airport_id AS id, n AS count___ FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.airport_id AS airport_id, RHS.n AS n FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, RHS.type AS TYPE, RHS.principal_activities AS principal_activities, RHS.incorporated_in AS incorporated_in, RHS.group_equity_shareholding AS group_equity_shareholding FROM airport AS LHS INNER JOIN operate_company AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name)) AS LHS CROSS JOIN (SELECT airport_id, COUNT(*) AS n FROM flight GROUP BY airport_id) AS RHS) ORDER BY id, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.id, COUNT(*) FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id JOIN airport AS T3 ON T2.airport_id = T3.id GROUP BY T3.id;

/*
Prediction Result:
(1, 52)
*/