-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, NULL, NULL, NULL, NULL, 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (8, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (9, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (11, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (12, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (13, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (14, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (15, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (16, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (17, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (18, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (19, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (20, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (21, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (22, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (23, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (24, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (25, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (26, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (27, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (28, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (29, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (30, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (31, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (32, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (33, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (34, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (35, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (36, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (37, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (38, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (39, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (40, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (41, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (42, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (43, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (44, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (45, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (46, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (47, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (48, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (49, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (50, 'A', 'B', 'R', '1990-01-01', 'ZAF');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (51, NULL, NULL, NULL, NULL, 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (52, NULL, NULL, NULL, NULL, 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (53, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (54, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (55, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (56, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (57, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (58, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (59, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (60, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (61, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (62, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (63, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (64, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (65, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (66, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (67, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (68, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (69, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (70, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (71, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (72, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (73, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (74, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (75, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (76, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (77, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (78, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (79, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (80, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (81, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (82, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (83, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (84, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (85, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (86, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (87, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (88, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (89, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (90, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (91, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (92, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (93, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (94, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (95, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (96, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (97, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (98, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (99, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (100, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (101, 'C', 'D', 'L', '1991-01-01', 'ARG');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (102, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (103, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (104, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (105, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (106, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (107, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (108, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (109, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (110, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (111, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (112, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (113, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (114, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (115, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (116, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (117, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (118, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (119, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (120, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (121, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (122, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (123, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (124, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (125, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (126, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (127, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (128, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (129, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (130, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (131, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (132, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (133, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (134, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (135, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (136, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (137, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (138, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (139, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (140, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (141, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (142, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (143, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (144, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (145, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (146, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (147, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (148, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (149, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (150, 'E', 'F', 'R', '1992-01-01', 'FRA');
INSERT INTO matches (winner_id, loser_id, winner_ioc, loser_ioc, match_num) VALUES (102, 103, 'FRA', 'FRA', 1);
INSERT INTO matches (winner_id, loser_id, winner_ioc, loser_ioc, match_num) VALUES (102, 104, 'FRA', 'FRA', 2);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (102, '2020-01-01', 1, 1000, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (102, '2020-01-08', 1, 1000, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) WHERE (n >= 50) ORDER BY country_code;

/*
Gold Result:
('ARG',)
('ZAF',)
*/

-- Prediction Query
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50;

/*
Prediction Result:
('ARG',)
*/