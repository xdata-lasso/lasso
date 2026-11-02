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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'Analysing wind data with R', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', 2, '2022-03-30 02:18:34+00:00', 'Analysing wind data with R', 'x58pz0f8je', 1196308825, 910894705, -283454505, 2, '2023-04-27 18:28:48+00:00', '2025-07-25 08:53:04+00:00', 233994589, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 1972233925, 1792827279, '2025-05-18 14:45:15+00:00', -106471771, 1235416111, 'jh3den8', 0, '2025-01-28 02:00:27+00:00', 'Analysing wind data with R', 'c68x8vacx7', 1523825314, 2078438287, -47052816, 2, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -405743609, -1935752926, '2021-03-26 14:01:04+00:00', 875300074, -1609653472, 'q5l', 1, '2021-11-07 05:17:12+00:00', 'Analysing wind data with R', 'im5k', 1379859112, 195202164, 1817366143, 1, '2023-11-02 12:51:45+00:00', '2025-05-07 04:09:25+00:00', -1125548818, '2022-05-04 05:18:58+00:00', '4gth2mnaj', 'la3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 872694102, 618058035, '2022-09-17 08:42:23+00:00', -229022515, -1817527403, '78lfvyz7zz', 1, '2025-05-30 03:33:11+00:00', 'Analysing wind data with R', 'be8yvkv42q', 79330142, 1735561423, 756202403, -2147483644, '2025-11-05 01:55:16+00:00', '2024-07-28 06:33:48+00:00', 782684333, '2024-01-18 21:37:49+00:00', 'pmaus3auvmkr', 'pdjwzw5chn9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 681061317, 1935791961, '2025-06-07 08:57:59+00:00', -413043724, 761519897, 'yoeyo6l', 1, '2023-07-16 23:01:09+00:00', 'Analysing wind data with R', 'dt', -795975227, 1294064538, 778835680, -2147483644, '2023-05-18 17:35:26+00:00', '2021-06-11 00:32:43+00:00', 450555855, '2023-11-05 01:08:45+00:00', 'gwnlas6', 'elboeowii1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, 287256667, 1614799674, '2025-07-02 03:36:52+00:00', 727608179, 456034296, 'g96aqb', 1, '2023-07-01 11:41:54+00:00', 'Analysing wind data with R', 'bindz', 2085299664, 2038321753, 1376887048, -1, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -891525031, -1154091048, '2020-05-07 06:13:16+00:00', 170892881, -1643065004, 'nzy', 0, '2022-06-21 06:39:29+00:00', 'Analysing wind data with R', 'dyyd1jmgj', -2108844113, 973811121, 280292620, -2147483642, '2025-06-25 04:45:54+00:00', '2020-01-23 21:53:17+00:00', -531872415, '2020-01-17 03:20:32+00:00', '7v4ygma', 'q3qdpua');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -74691962, -2128972904, '2022-03-09 16:51:49+00:00', -1370566258, 948460309, '8', 1, '2022-05-23 00:59:46+00:00', 'Analysing wind data with R', '9114qbre6bj', -752650834, 2134937984, 1379644459, 0, '2024-07-09 19:52:48+00:00', '2021-05-18 10:41:47+00:00', -1486030107, '2024-07-28 21:22:41+00:00', 'wpxlvris', 'urz0kaqtncg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, -459764012, -1148194959, '2023-07-12 01:39:56+00:00', -1079009577, -1385967617, 'u6iph', 1, '2020-05-26 13:36:15+00:00', 'Analysing wind data with R', 'u2g', 1352531282, -269868995, 580887132, -2147483644, '2024-03-11 20:33:59+00:00', '2023-08-29 17:33:46+00:00', -1204806277, '2023-10-05 21:08:15+00:00', 'sb3uoi1pavcv', 'wnyqrouirlrp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483638, -471198540, 1394459557, '2021-08-10 12:45:01+00:00', 1977502251, -1094296226, '6mb3aj0j', 1, '2022-09-19 11:14:39+00:00', 'Analysing wind data with R', '0h3r133ir1ax', -485095266, -1617977597, -1366005916, -2147483641, '2021-02-10 22:21:32+00:00', '2024-09-16 02:54:30+00:00', -1837449583, '2020-02-12 00:42:02+00:00', '8pgc', 'qwt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483637, -1042838119, 1763821445, '2021-05-09 08:52:55+00:00', -860028884, 328574939, '2', 1, '2021-10-20 08:10:32+00:00', 'Analysing wind data with R', 'zg3rjkwns47j', -233564324, -1881008758, -1955129162, -2147483640, '2023-12-17 03:33:50+00:00', '2024-12-21 00:23:49+00:00', -1015337060, '2024-10-05 19:11:38+00:00', 'yrnxs6dvdx', 'o');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483636, -699779308, -1368221491, '2024-09-16 17:28:24+00:00', -1789708299, -743497747, '7k10', 1, '2025-09-05 08:53:26+00:00', 'Analysing wind data with R', '2my1ogy', -672126855, -966886446, -1873650788, 2, '2020-01-31 14:08:40+00:00', '2025-02-02 10:57:02+00:00', -560601844, '2025-04-29 11:57:37+00:00', 'clupgly', '8oitxeilp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483635, 72217086, -392891099, '2023-12-05 00:02:44+00:00', 1735624376, -1665891229, 'vnhed', 1, '2023-09-29 12:15:10+00:00', 'Analysing wind data with R', '9lqv26u331s', -1125491025, 764047845, -660620878, -2147483642, '2023-07-24 20:31:50+00:00', '2020-03-10 16:58:00+00:00', -1725714389, '2021-06-08 10:59:17+00:00', 'xginlj6idm', '61l2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 3, '2020-03-11 00:23:16+00:00', 't2__dbd2cb', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 4, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 3, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 5, '2020-03-11 00:23:16+00:00', 'Analysing wind data with R', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -188151580, 226938182, '2021-08-05 01:19:54+00:00', 1178636309, -1390245819, 'x14ji7zwau2d', 6, '2023-01-13 04:58:30+00:00', 'Analysing wind data with R', 'yrq13pyu78d9', 244829661, -1362461264, -904834265, 6, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 910894705, -283454505, '2023-04-27 18:28:48+00:00', -792092619, -1492524358, 'wb', 7, '2020-06-06 08:33:45+00:00', 'Analysing wind data with R', 'lph2gn', 1968874827, -664193365, -1070063173, 0, '2025-05-09 05:17:21+00:00', '2023-02-13 21:14:29+00:00', 722884590, '2025-05-27 16:57:17+00:00', 'nc', 'rjtu');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__1020e9', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1106983592, '2022-06-06 01:51:46+00:00', 't1__1020e9', '2024-04-01 02:40:29+00:00', 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', -305670381, -1525670226, -453362185, 481163439, 2123196517, 'dwyrq13pyu78');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1485777725, '1970-01-01 00:00:01+00:00', 't1__1020e9', '2022-03-23 04:34:16+00:00', 'n2f3dqv0g', 'cb98ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, -566887085, 602161869, 'xa');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1294666887, '1970-01-01 00:00:00+00:00', 't1__239403', '2023-03-26 06:11:01+00:00', 'dr', 'z16nijjai5d', 'h5ogrgjd8yz', 1250290042, -1717646459, -1696173285, 710458518, 678047687, '3ay');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 2004147439, '1970-01-01 00:00:00+00:00', 't1__239403', '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36', '4', -2072838897, -1173368267, 382831862, -406331049, -461418236, 'zjo7wgxd5ysx');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -1245584612, '1969-12-31 23:59:59+00:00', 't1__239403', '2021-04-02 17:49:19+00:00', 'fofwsz', 'o', '2zobb0q0k32o', -1898678660, 440115543, 292557306, 709097796, -984562992, 'yngc1d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 237552112, '1970-01-01 00:00:00+00:00', 't1__239403', '2020-09-21 12:30:27+00:00', '7qk', '162nh55y3d', 'ohvu06dza3', 1595632888, 2072023304, 789756515, -1160642134, 769234989, '8ftp6ewtqx');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 555368535, '1970-01-01 00:00:00+00:00', 't1__239403', '2021-07-17 00:45:37+00:00', 'c7d', 'n2np490xdms', 'tgelc', -1025517017, 1374676344, 238243966, -788896327, -1541581575, '1quik1yhb08h');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 438933248, '1970-01-01 00:00:00+00:00', 't1__239403', '2024-07-30 17:06:35+00:00', 'kwdmdbdht', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, -1243923337, 1231129324, 'wx');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1954048590, '1969-12-31 23:59:59+00:00', 't1__239403', '2020-11-03 15:09:11+00:00', 'eev', 'zxlu49', 'ubo', 833662145, -1943810603, 1557266002, -775706063, -1417040770, 'llbwvdpu5v0e');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, 1084895939, '1970-01-01 00:00:00+00:00', 't1__239403', '2020-08-19 01:32:21+00:00', 'acxd', 'b2f0c296xiye', '8xjhc', -1805244571, 66352888, 312333412, 871812581, -977983676, '6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 373262291, '2023-04-26 07:28:40+00:00', '5s5b', '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1155439218, '2021-02-10 21:10:52+00:00', 'm52zbu', '2021-11-30 23:39:10+00:00', 'nrqrofqy', '5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 't3__048eab', '2025-10-19 18:29:54+00:00', 1, 'rofqy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, 722884590, 't3__048eab', '2025-05-27 16:57:17+00:00', 2, 'nc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, -988981234, 't3__048eab', '2022-08-03 01:56:16+00:00', 1, '0dz79f');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, 1, 1870300798, 't3__25cc7d', '2024-03-11 08:01:44+00:00', 0, 'q8qdjpe1io22');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, -354292049, 't3__25cc7d', '2025-06-30 18:54:45+00:00', 2, '9');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 548968280, 't3__25cc7d', '2021-03-06 10:06:33+00:00', 2, '66');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, -1943814113, 't3__25cc7d', '2023-01-15 14:52:54+00:00', -1, '603vzxw1r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, 2013745856, 't3__25cc7d', '2020-01-09 12:53:38+00:00', -2147483642, 'bymzn2mfx7h3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, 1291298007, 't3__25cc7d', '2021-10-14 06:43:25+00:00', -2147483644, 'dqrhm');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, 1, 2101986789, 't3__25cc7d', '2021-12-09 20:20:01+00:00', -2147483642, 'iztv');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, 1, -641927001, 't3__25cc7d', '2023-07-20 15:35:59+00:00', 1, '14r5dqtsmg97');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -1, 824044840, 't3__25cc7d', '2023-10-30 05:13:03+00:00', -2147483642, '129835x');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 2, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', -2147483641, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 3, 1485335077, 'yrq13pyu78d9', '2024-09-26 13:13:01+00:00', 1, 'ljsl0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 2, 1, NULL, '2024-06-15 00:00:00+00:00', -2147483640, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 5, 1, NULL, '2024-06-15 00:00:00+00:00', -1, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 6, -1898531797, '9fjgq8n2f', '2023-11-18 03:19:57+00:00', 5, 'dqv0gcb98ozk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('9fjgq8n2f', None)
*/

-- Prediction Query
SELECT comments.Text, comments.UserDisplayName FROM posts INNER JOIN comments ON posts.Id = comments.PostId WHERE posts.Title = 'Analysing wind data with R' ORDER BY comments.CreationDate DESC, posts.id NULLS LAST, comments.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('t3__048eab', 'rofqy')
('t3__25cc7d', '9')
('t3__048eab', 'nc')
(None, 'value')
('t3__25cc7d', 'q8qdjpe1io22')
('9fjgq8n2f', 'dqv0gcb98ozk')
('t3__25cc7d', '129835x')
('t3__25cc7d', '14r5dqtsmg97')
('t3__25cc7d', '603vzxw1r')
('t3__048eab', '0dz79f')
*/