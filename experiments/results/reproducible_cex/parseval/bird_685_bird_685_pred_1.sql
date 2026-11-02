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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, 1, 'nprmdposii', 1, '2020-08-22 06:30:10+00:00', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, 1, '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1937207087, 1675430660, '2022-11-21 09:24:31+00:00', 233994589, 1, 'j4hwbd', 1, '2022-10-17 07:55:28+00:00', 'ph2', 'nd', -1052964641, -1245682094, -1660358170, 1, '2020-05-10 07:36:02+00:00', '2022-01-23 03:13:33+00:00', -988981234, '2022-08-03 01:56:16+00:00', '0dz79f', 'gq8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1, 'cb98ozk3zbil', 1, '2023-03-28 14:41:46+00:00', 'kn6vc', '6ah', -348113485, 138842628, -932772113, 1, '2022-12-26 19:34:44+00:00', '2021-07-03 08:58:16+00:00', 1255343543, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', 'z16ni');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1250290042, -1717646459, '2020-11-22 11:14:57+00:00', -946046410, -902895762, 'ayxp1q43', -2147483647, '2023-06-28 02:52:00+00:00', 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, -47052816, -2147483647, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -2072838897, -1173368267, '2025-01-04 09:05:19+00:00', -1950324754, 2115816682, '7z2zezjo7wg', -2147483647, '2023-03-07 00:15:11+00:00', '5', 'sxcmr0o', 853709925, -870767087, -1699185893, 1, '2025-12-26 14:53:02+00:00', '2024-03-18 21:27:42+00:00', -1609653472, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 2, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 5, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 4, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483647, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1692174491, -1025564911, '2023-10-21 02:54:45+00:00', -975213201, -705985602, 'x58pz0f8je', 2, '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', -736979194, 2103044118, -1642259219, 6, '2020-12-04 21:49:29+00:00', '2021-09-30 11:37:26+00:00', 1968874827, '2022-12-08 23:34:02+00:00', 'qcx5', 'hncprjtu0dz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 2, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1583472758, 1449284300, '2022-04-26 08:43:58+00:00', -1714354341, -458359144, '1afgogritsj', -2147483647, '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 1923912467, 518609210, 1948383687, 7, '2020-06-27 17:29:33+00:00', '2020-08-20 06:07:09+00:00', 195720193, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, -526612570, -546516406, '2021-08-06 04:52:45+00:00', 1721638020, 983324983, 'ztdg', 7, '2021-03-26 14:01:04+00:00', '5i3lq5lnpim5', '58q', 1817366143, 1615073310, 1055237066, 8, '2023-11-07 06:34:01+00:00', '2022-05-04 05:18:58+00:00', -95808609, '2022-08-10 04:39:07+00:00', '2m', 'ajjl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 7, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, -1197954156, -2019656607, '2022-03-19 07:41:34+00:00', -366775518, 575038073, 'dwcl', 9, '2024-03-21 20:48:17+00:00', 'amsorlwyng', '1', 681061317, 1935791961, 595714424, 9, '2023-06-08 15:48:15+00:00', '2020-11-27 04:53:28+00:00', 761519897, '2023-08-24 14:09:34+00:00', 'yoeyo6l0hdt6', 'uq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (15, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 5, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 748154000, 1148916014, '2020-04-24 22:41:34+00:00', -1694533100, -1275298282, '3', 2, '2025-03-26 09:37:26+00:00', 'tdu6bd0w96', '3vzxw1r', 237552112, -1046720861, 643589729, 10, '2021-10-24 14:42:01+00:00', '2020-12-13 20:46:34+00:00', 956819642, '2025-10-15 00:12:43+00:00', 'y3dohvu0', 'dza35rmki');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (17, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't3__b1aa85', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -305670381, '2021-03-25 19:22:18+00:00', 't3__b1aa85', '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 618058035, '2022-09-17 08:42:23+00:00', 't3__b1aa85', '2023-10-19 18:37:00+00:00', 'e578', 'fvy', '7zzbe8y', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1849819405, '2025-11-25 02:19:30+00:00', 'us3auvmkrp', '2020-06-03 10:00:15+00:00', 'wzw', 'chn9mo70', 'a9n0jxfo', -1793230843, -441521858, 2015094998, 1010672881, -1197954156, '0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', '2020-12-13 17:48:30+00:00', '72k', 'ex1', 'ji7zwau2', 364869063, -953437896, -1097120355, 244829661, -1362461264, 'l0b4y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 172461907, '2023-05-31 07:22:36+00:00', '3zb', '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 2119806856, '2025-08-02 16:41:48+00:00', 'cvtjpttg6', '2020-03-23 04:17:18+00:00', 'ou5z', '36c', 'bfkfoacd', 2115816682, 76987628, -253138337, 641521863, 304189298, 'xd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -2060082151, '2025-08-08 12:00:20+00:00', 'maus', '2023-11-09 04:27:38+00:00', 'u', 'mkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -2076274980, '2020-08-28 14:27:04+00:00', 'wii1', '2023-05-07 14:15:39+00:00', 'nxih662q', 'xlyotow9', 'aawg', 1044710644, 966412849, -2061634386, -850941333, -1216952047, '39tajz9');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 328305758, 1, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -1483100200, 2, '5dh', '2024-02-27 00:46:50+00:00', 1, 'Computer Game Datasets', 'grgj', '8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, -698610044, 3, 'q8qdjpe1io22', '2024-05-29 05:19:47+00:00', 1, 'Computer Game Datasets', '507cvtjpt', 'tg6bnou5zi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1817366143, 4, '7p2r94gt', '2020-12-28 23:17:24+00:00', -2147483647, 'Computer Game Datasets', '2mnajjla3o', 'v8u');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1449226553, 1, '2odwcl5amso', '2022-04-21 05:35:41+00:00', 4, 'Computer Game Datasets', 'wyn', 'gc1dj9erhi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 761519897, 4, 'yoeyo6l', '2023-07-16 23:01:09+00:00', 1, 'Computer Game Datasets', 'dt', 'fuqyxuzkb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -277407746, 1, 'nlas6e', '2025-09-08 01:16:35+00:00', 4, 'Computer Game Datasets', 'boe', 'wii1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 1557188093, 4, 'xih662q2xly', '2025-01-25 14:56:35+00:00', 4, 'Computer Game Datasets', 'tow9', 'aawg');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -2061634386, 1, 'bindz', '2023-12-20 17:13:08+00:00', 3, 'Computer Game Datasets', 'tajz9td8n', '5wcgumbc3td');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 1071401016, 1, 'w9603vz', '2025-10-31 13:59:15+00:00', 1, 'Computer Game Datasets', 'xw1rxe9yfk7', 'k162n');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 956819642, 1, '5y3dohvu06d', '2023-05-21 01:39:33+00:00', 1, 'Computer Game Datasets', '3', 'rmkio18r');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 389700824, 3, '08ftp6ewtqxx', '2021-10-16 13:25:30+00:00', 1, 'Computer Game Datasets', 'jabymzn2mfx7', '33');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 170892881, 3, '5k', '2021-10-06 21:42:28+00:00', 1, 'Computer Game Datasets', 'zys7dyyd1jmg', 'jach8qta8y3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, -2081662466, 3, '3qdpu', '2020-02-17 04:43:11+00:00', 1, 'Computer Game Datasets', '96rn', 'dqrhm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, -1369148652, 1, '7', '2025-06-14 15:18:28+00:00', 3, 't1__41ac2a', 'dn2np490xdms', 'tgelc');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 1, 5, 'value', '2024-06-15 00:00:00+00:00', -2147483647, NULL, 'value', 'value');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 781505063, 6, 'rofqyp5s5b', '2020-03-11 14:09:37+00:00', -2147483647, 'Computer Game Datasets', '02eu', 'liqa1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 401805964, 8, 'gq8', '2021-10-07 12:15:00+00:00', 5, 'Computer Game Datasets', 'f3dqv0gc', '9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 1992637800, 10, 'dctmf', '2020-11-14 00:31:21+00:00', 4, 'Computer Game Datasets', '2g0v5q8qd', 'jpe1io22785');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1428186898, 12, 'uttmu2ne5', '2024-11-14 17:33:35+00:00', 4, 'Computer Game Datasets', '8lfvyz7zz', 'be8yvkv42q7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 1755752040, 14, 'b52', '2023-09-14 18:35:43+00:00', 5, 'Computer Game Datasets', 'wn', 'as6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 769234989, 16, '8ftp6ewtqx', '2023-01-28 06:02:52+00:00', 8, 'Computer Game Datasets', 'jaby', 'mzn2mfx7h3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(1, 't3__b1aa85')
(1, 't3__b1aa85')
(-902895762, 't3__b1aa85')
(2115816682, 't3__b1aa85')
(1, 't3__b1aa85')
(2115816682, 't3__b1aa85')
(1, 't3__b1aa85')
(2115816682, 't3__b1aa85')
(1, 't3__b1aa85')
(-902895762, 't3__b1aa85')
(-902895762, 't3__b1aa85')
(-902895762, 't3__b1aa85')
(1, 't3__b1aa85')
(1, 't3__b1aa85')
(1019800248, 'wwqcg')
(-705985602, 'ytoo3o9')
(-458359144, '3zb')
(983324983, 'cvtjpttg6')
(575038073, 'maus')
(-1275298282, 'wii1')
*/

-- Prediction Query
SELECT p.ViewCount, u.DisplayName FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE p.Title = 'Computer Game Datasets';

/*
Prediction Result:
*/