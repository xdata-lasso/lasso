-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1666765085, 1178636309, '2021-07-01 18:29:24+00:00', -305670381, -1525670226, '7zwau2dwyr', 1, '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 1649269347, -1116181514, 1255852738, -2147483647, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, -211209314, 'dqv0gcb9', 3, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 1, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 76996700, -435350511, '2025-11-10 20:25:30+00:00', 87529806, -1957268147, 'c', 6, '2022-08-05 18:12:12+00:00', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, 2, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1722106924, -2072838897, '2021-05-31 16:00:51+00:00', 1201273976, 1923659053, 'c', 6, '2020-07-08 07:50:44+00:00', '7z2zezj', '7wgx', -57705450, -915385605, -2005628382, 1, '2022-04-20 03:52:20+00:00', '2023-06-27 00:46:15+00:00', 1269522000, '2025-12-11 00:03:18+00:00', 'tdgj5i3', 'q5l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -1556979799, -55240145, '2024-03-11 05:11:39+00:00', 195202164, 1817366143, '7p2r94gt', 6, '2020-12-28 23:17:24+00:00', '2mnajjla3o', 'v8u', 618058035, 1553368934, -1252009958, -2147483647, '2024-03-25 10:50:51+00:00', '2024-11-14 17:33:35+00:00', 1908593332, '2020-09-26 00:22:30+00:00', 'yz7zzb', '8y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -72442907, -2060082151, '2025-08-08 12:00:20+00:00', -1122409769, 1849819405, 'us3auvmkrpdj', 6, '2025-10-04 15:32:15+00:00', 'zw5chn', 'mo705a9n0', 1731843275, -582376271, -1165594842, 3, '2022-12-30 09:36:03+00:00', '2022-07-09 16:59:45+00:00', 1719800120, '2020-06-20 19:03:43+00:00', '2zob', '0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -366775518, 575038073, '2021-12-14 11:59:29+00:00', -1898678660, 440115543, 'msorlwyngc', 1, '2023-08-12 12:46:14+00:00', 'j', '9erhizgk1yoe', 1483450542, 513375398, 718167481, 3, '2023-07-16 23:01:09+00:00', '2021-01-20 11:06:45+00:00', -1942581013, '2024-04-21 11:49:54+00:00', 'uq', 'xuzkb52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1686002788, -1250380401, '2020-01-06 01:47:51+00:00', -2076274980, 1731324803, 'wii1', 1, '2023-05-07 14:15:39+00:00', 'nxih662q', 'xlyotow9', 727608179, 456034296, -628433041, 2, '2024-09-22 16:04:20+00:00', '2024-05-20 15:01:09+00:00', 1044710644, '2022-03-05 18:43:06+00:00', '0', 'bindz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -921187550, -2070843029, '2022-01-05 17:19:47+00:00', 2, 882961052, '2eutliqa11r', 5, '2023-03-22 03:47:49+00:00', 'ytoo3o9hl7', 'klex14ji', -453362185, 481163439, 2123196517, 2, '2025-11-10 22:24:59+00:00', '2020-06-29 05:47:52+00:00', 1485335077, '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1692174491, -1025564911, '2023-10-21 02:54:45+00:00', 3, -975213201, '9v', 1, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, 4, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1583472758, 1449284300, '2022-04-26 08:43:58+00:00', 1, -1714354341, '8', 9, '2023-04-21 03:11:26+00:00', 't1afgog', 'itsj3', -491938169, -106471771, 1235416111, -2147483647, '2023-08-17 20:15:35+00:00', '2024-11-10 21:13:22+00:00', -1538707438, '2023-12-06 02:24:58+00:00', 'e', '8c68');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1774087382, 1732258051, '2024-05-22 05:48:31+00:00', 1, 1523825314, 'u5', 7, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, 5, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 418247369, -1524425594, '2021-07-29 14:03:28+00:00', 1, -2096405521, 'okv8uttmu2', 13, '2021-10-09 18:25:05+00:00', '57', 'lfvyz7zzb', 924693315, -705922211, 1043710187, 2, '2024-11-18 17:17:10+00:00', '2024-02-10 01:00:46+00:00', -233617564, '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, 1105964624, -663234145, '2020-04-07 03:05:00+00:00', 1, -1674145149, 'mo705a9n0', 11, '2021-04-02 17:49:19+00:00', 'fofwsz', 'o', 1010672881, -1197954156, -2019656607, 13, '2022-03-19 07:41:34+00:00', '2025-04-29 20:31:18+00:00', -366775518, '2023-11-21 15:04:11+00:00', '2odwcl5amso', 'lwyng');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 1244279905, -1396673167, '2025-01-25 14:56:35+00:00', 1, 1614799674, 'ow9oaawg96a', 17, '2022-03-05 18:43:06+00:00', '0', 'bindz', 2085299664, 2038321753, 1376887048, -2147483641, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (18, 1964331395, -1943814113, '2023-01-15 14:52:54+00:00', 1, -379749892, 'vzxw1rxe9y', 9, '2020-09-21 12:30:27+00:00', '7qk', '162nh55y3d', 440797047, -732999244, 1654100852, 17, '2024-04-24 18:29:26+00:00', '2020-06-02 22:00:04+00:00', -438741674, '2023-12-12 21:29:29+00:00', 'rmkio18r', 'i2hy08ftp6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -646944990, -1051623642, '2023-01-28 06:02:52+00:00', 1664452437, -1485875026, 'bymzn2mfx7h3', 8, '2023-11-11 00:49:07+00:00', '6sto', 'cj8sh5k', 1106724223, 1966809332, 1487347213, -2147483647, '2023-03-15 00:23:20+00:00', '2025-09-13 12:59:23+00:00', 1328948152, '2020-06-11 08:05:04+00:00', 'jmgjach', 'qta8y3a17');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', 10, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1833165707, 1155439218, '2021-02-10 21:10:52+00:00', -761141909, 283598170, 'zbuo4nrq', 12, '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, 2, '2020-01-22 05:30:29+00:00', '2023-08-20 20:02:04+00:00', 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', 'l7');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 't2__6b8da6', 'wqcgsk', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1179823637, '2021-09-24 11:50:48+00:00', 'Yevgeny', '2025-01-09 01:18:18+00:00', 't2__6b8da6', 'rqrofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -87647544, '2023-01-02 20:56:29+00:00', 'd', '2022-10-17 07:55:28+00:00', 'ph2', 'nd', 'wnqcx', 722884590, 580968159, -1245312912, 1575412235, -988981234, 'u0dz7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 602161869, '2020-09-05 12:25:49+00:00', 'Yevgeny', '2023-03-07 13:22:39+00:00', 't2__6b8da6', '7', 'yfdrz', 61479715, -1496556994, -2115841792, 1746373317, 1360271423, 'ogrgjd8y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1250290042, '2020-11-06 22:27:04+00:00', 'grit', '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43', '1jh3den', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 't2__d0bfa1', 'wqcgsk', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1908028688, '2020-03-08 22:40:47+00:00', 'Yevgeny', '2022-01-03 02:42:55+00:00', 't2__d0bfa1', 'luhvdltti', 'bnp', 1236688122, 2087640001, 907682809, 2026480202, -1576219117, '5u');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 1861536320, '2022-12-10 02:38:39+00:00', 'klfa9000t', '2024-03-03 15:52:53+00:00', 'use_5bd1e4', '4', 'ecigce376n', 1313172851, -761141909, 283598170, 742285925, -747753377, 'nrqrofqy');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1968874827, '2022-12-08 23:34:02+00:00', 'Yevgeny', '2021-10-14 08:16:37+00:00', 'cx5hn', 'p', 'jtu0d', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -155284187, '2020-02-20 05:24:11+00:00', 'Yevgeny', '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 2004147439, '2022-11-19 00:43:43+00:00', 'Yevgeny', '2022-07-15 10:34:24+00:00', 'ptt', '6b', 'ou5z', 1691780814, 1944978593, 1722106924, -2072838897, -1173368267, 'cd07z2zezjo7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 304189298, '2020-12-04 11:46:08+00:00', 'Yevgeny', '2023-03-07 00:15:11+00:00', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 1339733032, -1556979799, -55240145, 1379859112, 195202164, 's27p2r94gth2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, -1960313034, '2020-06-01 03:41:47+00:00', 'Yevgeny', '2025-02-24 09:11:47+00:00', '9er', 'iz', 'k1', 955267863, -1156828895, 1483450542, 513375398, 718167481, 'hdt6fuq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1294064538, '2023-01-26 17:19:01+00:00', 'Yevgeny', '2025-10-17 20:09:18+00:00', 'zkb521', 'wn', 'as6', -2076274980, 1731324803, -1159083009, -1589605308, -268740517, 'nxih662q');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483632, 1019800248, '2022-11-06 10:19:41+00:00', 'l', '2022-07-30 13:34:14+00:00', 'val_1', 'ilbnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', NULL, 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Score), T2.WebsiteUrl FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Yevgeny' GROUP BY T2.WebsiteUrl;

/*
Gold Result:
(1, '5')
(1, 'cx5hn')
(1, 'ptt')
(-5629825399, 't2__6b8da6')
(2, 't2__d0bfa1')
(None, 'wqcgsk')
(2, 'yrk')
(1, 'zkb521')
*/

-- Prediction Query
SELECT SUM(T2.Score), T1.WebsiteUrl FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.LastEditorUserId WHERE T1.DisplayName = 'Yevgeny';

/*
Prediction Result:
(-449587326, 't2__6b8da6')
*/