-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'U1', 'L1', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'U2', 'L2', 'R', '1990-01-02', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'U3', 'L3', 'R', '1990-01-03', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'U4', 'L4', 'R', '1990-01-04', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'U5', 'L5', 'R', '1990-01-05', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'U6', 'L6', 'R', '1990-01-06', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'U7', 'L7', 'R', '1990-01-07', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (8, 'U8', 'L8', 'R', '1990-01-08', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (9, 'U9', 'L9', 'R', '1990-01-09', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'U10', 'L10', 'R', '1990-01-10', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (11, 'U11', 'L11', 'R', '1990-01-11', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (12, 'U12', 'L12', 'R', '1990-01-12', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (13, 'U13', 'L13', 'R', '1990-01-13', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (14, 'U14', 'L14', 'R', '1990-01-14', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (15, 'U15', 'L15', 'R', '1990-01-15', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (16, 'U16', 'L16', 'R', '1990-01-16', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (17, 'U17', 'L17', 'R', '1990-01-17', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (18, 'U18', 'L18', 'R', '1990-01-18', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (19, 'U19', 'L19', 'R', '1990-01-19', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (20, 'U20', 'L20', 'R', '1990-01-20', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (21, 'U21', 'L21', 'R', '1990-01-21', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (22, 'U22', 'L22', 'R', '1990-01-22', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (23, 'U23', 'L23', 'R', '1990-01-23', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (24, 'U24', 'L24', 'R', '1990-01-24', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (25, 'U25', 'L25', 'R', '1990-01-25', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (26, 'U26', 'L26', 'R', '1990-01-26', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (27, 'U27', 'L27', 'L', '1990-01-27', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (28, 'U28', 'L28', 'L', '1990-01-28', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (29, 'U29', 'L29', 'L', '1990-01-29', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (30, 'U30', 'L30', 'L', '1990-01-30', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (31, 'U31', 'L31', 'L', '1990-02-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (32, 'U32', 'L32', 'L', '1990-02-02', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (33, 'U33', 'L33', 'L', '1990-02-03', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (34, 'U34', 'L34', 'L', '1990-02-04', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (35, 'U35', 'L35', 'L', '1990-02-05', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (36, 'U36', 'L36', 'L', '1990-02-06', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (37, 'U37', 'L37', 'L', '1990-02-07', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (38, 'U38', 'L38', 'L', '1990-02-08', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (39, 'U39', 'L39', 'L', '1990-02-09', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (40, 'U40', 'L40', 'L', '1990-02-10', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (41, 'U41', 'L41', 'L', '1990-02-11', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (42, 'U42', 'L42', 'L', '1990-02-12', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (43, 'U43', 'L43', 'L', '1990-02-13', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (44, 'U44', 'L44', 'L', '1990-02-14', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (45, 'U45', 'L45', 'L', '1990-02-15', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (46, 'U46', 'L46', 'L', '1990-02-16', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (47, 'U47', 'L47', 'L', '1990-02-17', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (48, 'U48', 'L48', 'L', '1990-02-18', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (49, 'U49', 'L49', 'L', '1990-02-19', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (50, 'U50', 'L50', 'L', '1990-02-20', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (51, 'U51', 'L51', 'L', '1990-02-21', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (52, 'U52', 'L52', 'L', '1990-02-22', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (53, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (54, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (55, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (56, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (57, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (58, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (59, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (60, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (61, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (62, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (63, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (64, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (65, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (66, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (67, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (68, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (69, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (70, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (71, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (72, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (73, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (74, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (75, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (76, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (77, 'John', 'Doe', 'R', '1990-01-01', 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (78, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (79, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (80, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (81, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (82, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (83, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (84, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (85, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (86, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (87, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (88, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (89, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (90, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (91, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (92, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (93, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (94, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (95, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (96, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (97, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (98, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (99, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (100, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (101, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (102, NULL, NULL, NULL, NULL, 'ZWE');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (103, 'F1', 'L1', 'R', '1991-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (104, 'F2', 'L2', 'R', '1991-01-02', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (105, 'F3', 'L3', 'R', '1991-01-03', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (106, 'F4', 'L4', 'R', '1991-01-04', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (107, 'F5', 'L5', 'R', '1991-01-05', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (108, 'F6', 'L6', 'R', '1991-01-06', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (109, 'F7', 'L7', 'R', '1991-01-07', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (110, 'F8', 'L8', 'R', '1991-01-08', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (111, 'F9', 'L9', 'R', '1991-01-09', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (112, 'F10', 'L10', 'R', '1991-01-10', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (113, 'F11', 'L11', 'R', '1991-01-11', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (114, 'F12', 'L12', 'R', '1991-01-12', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (115, 'F13', 'L13', 'R', '1991-01-13', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (116, 'F14', 'L14', 'R', '1991-01-14', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (117, 'F15', 'L15', 'R', '1991-01-15', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (118, 'F16', 'L16', 'R', '1991-01-16', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (119, 'F17', 'L17', 'R', '1991-01-17', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (120, 'F18', 'L18', 'R', '1991-01-18', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (121, 'F19', 'L19', 'R', '1991-01-19', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (122, 'F20', 'L20', 'R', '1991-01-20', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (123, 'F21', 'L21', 'R', '1991-01-21', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (124, 'F22', 'L22', 'R', '1991-01-22', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (125, 'F23', 'L23', 'R', '1991-01-23', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (126, 'F24', 'L24', 'R', '1991-01-24', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (127, 'F25', 'L25', 'L', '1991-01-25', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (128, 'F26', 'L26', 'L', '1991-01-26', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (129, 'F27', 'L27', 'L', '1991-01-27', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (130, 'F28', 'L28', 'L', '1991-01-28', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (131, 'F29', 'L29', 'L', '1991-01-29', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (132, 'F30', 'L30', 'L', '1991-01-30', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (133, 'F31', 'L31', 'L', '1991-02-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (134, 'F32', 'L32', 'L', '1991-02-02', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (135, 'F33', 'L33', 'L', '1991-02-03', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (136, 'F34', 'L34', 'L', '1991-02-04', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (137, 'F35', 'L35', 'L', '1991-02-05', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (138, 'F36', 'L36', 'L', '1991-02-06', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (139, 'F37', 'L37', 'L', '1991-02-07', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (140, 'F38', 'L38', 'L', '1991-02-08', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (141, 'F39', 'L39', 'L', '1991-02-09', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (142, 'F40', 'L40', 'L', '1991-02-10', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (143, 'F41', 'L41', 'L', '1991-02-11', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (144, 'F42', 'L42', 'L', '1991-02-12', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (145, 'F43', 'L43', 'L', '1991-02-13', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (146, 'F44', 'L44', 'L', '1991-02-14', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (147, 'F45', 'L45', 'L', '1991-02-15', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (148, 'F46', 'L46', 'L', '1991-02-16', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (149, 'F47', 'L47', 'L', '1991-02-17', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (150, 'F48', 'L48', 'L', '1991-02-18', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (151, 'F49', 'L49', 'L', '1991-02-19', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (152, 'A1', 'L1', 'R', '1992-01-01', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (153, 'A2', 'L2', 'R', '1992-01-02', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (154, 'A3', 'L3', 'R', '1992-01-03', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (155, 'A4', 'L4', 'R', '1992-01-04', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (156, 'A5', 'L5', 'R', '1992-01-05', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (157, 'A6', 'L6', 'R', '1992-01-06', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (158, 'A7', 'L7', 'R', '1992-01-07', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (159, 'A8', 'L8', 'R', '1992-01-08', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (160, 'A9', 'L9', 'R', '1992-01-09', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (161, 'A10', 'L10', 'R', '1992-01-10', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (162, 'A11', 'L11', 'R', '1992-01-11', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (163, 'A12', 'L12', 'R', '1992-01-12', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (164, 'A13', 'L13', 'R', '1992-01-13', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (165, 'A14', 'L14', 'R', '1992-01-14', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (166, 'A15', 'L15', 'R', '1992-01-15', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (167, 'A16', 'L16', 'R', '1992-01-16', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (168, 'A17', 'L17', 'R', '1992-01-17', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (169, 'A18', 'L18', 'R', '1992-01-18', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (170, 'A19', 'L19', 'R', '1992-01-19', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (171, 'A20', 'L20', 'R', '1992-01-20', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (172, 'A21', 'L21', 'R', '1992-01-21', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (173, 'A22', 'L22', 'R', '1992-01-22', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (174, 'A23', 'L23', 'R', '1992-01-23', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (175, 'A24', 'L24', 'R', '1992-01-24', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (176, 'A25', 'L25', 'R', '1992-01-25', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (177, 'A26', 'L26', 'R', '1992-01-26', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (178, 'A27', 'L27', 'L', '1992-01-27', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (179, 'A28', 'L28', 'L', '1992-01-28', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (180, 'A29', 'L29', 'L', '1992-01-29', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (181, 'A30', 'L30', 'L', '1992-01-30', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (182, 'A31', 'L31', 'L', '1992-02-01', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (183, 'A32', 'L32', 'L', '1992-02-02', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (184, 'A33', 'L33', 'L', '1992-02-03', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (185, 'A34', 'L34', 'L', '1992-02-04', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (186, 'A35', 'L35', 'L', '1992-02-05', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (187, 'A36', 'L36', 'L', '1992-02-06', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (188, 'A37', 'L37', 'L', '1992-02-07', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (189, 'A38', 'L38', 'L', '1992-02-08', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (190, 'A39', 'L39', 'L', '1992-02-09', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (191, 'A40', 'L40', 'L', '1992-02-10', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (192, 'A41', 'L41', 'L', '1992-02-11', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (193, 'A42', 'L42', 'L', '1992-02-12', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (194, 'A43', 'L43', 'L', '1992-02-13', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (195, 'A44', 'L44', 'L', '1992-02-14', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (196, 'A45', 'L45', 'L', '1992-02-15', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (197, 'A46', 'L46', 'L', '1992-02-16', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (198, 'A47', 'L47', 'L', '1992-02-17', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (199, 'A48', 'L48', 'L', '1992-02-18', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (200, 'A49', 'L49', 'L', '1992-02-19', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (201, 'A50', 'L50', 'L', '1992-02-20', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (202, 'A51', 'L51', 'L', '1992-02-21', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (203, 'G1', 'L1', 'R', '1993-01-01', 'GBR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) WHERE (n >= 50) ORDER BY country_code;

/*
Gold Result:
('AUS',)
('USA',)
('ZWE',)
*/

-- Prediction Query
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50;

/*
Prediction Result:
('AUS',)
('USA',)
*/