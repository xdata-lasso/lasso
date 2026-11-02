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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1454058168, -2078052421, '2021-07-02 01:45:48+00:00', 982314585, 1, 'kn6vc', 3, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', 'q7x', -541746689, 1294666887, -515895469, 3, '2020-07-06 08:08:29+00:00', '2022-05-09 09:35:03+00:00', 777149609, '2025-05-15 17:08:24+00:00', '6nijjai', 'dh5ogrgj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 87529806, -1957268147, '2020-06-07 10:59:23+00:00', 481546706, 1, 'g6', -2147483647, '2023-10-09 23:10:02+00:00', '0v', 'q8qdjpe1', -1180042408, 199672698, 2119806856, 1, '2025-08-02 16:41:48+00:00', '2024-06-06 16:33:41+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -2072838897, -1173368267, '2025-01-04 09:05:19+00:00', -1950324754, 2115816682, '7z2zezjo7wg', -2147483647, '2023-03-07 00:15:11+00:00', '5', 'sxcmr0o', 853709925, -870767087, -1699185893, 1, '2025-12-26 14:53:02+00:00', '2024-03-18 21:27:42+00:00', -1609653472, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 729449685, -1580984044, '2023-08-06 06:41:23+00:00', 769234989, 1, '8ftp6ewtqx', 4, '2023-01-28 06:02:52+00:00', 'jaby', 'mzn2mfx7h3', -891525031, -1154091048, -1971560508, 1, '2024-08-04 01:35:33+00:00', '2022-06-23 21:35:58+00:00', -1643065004, '2021-05-28 00:09:07+00:00', 'zys7', 'y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 2, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 328305758, -751275471, '2021-08-01 11:21:15+00:00', -1068298341, -314162272, 'ytoo3o9', 1, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 6, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 4, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 8, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1099855564, 87529806, '2020-05-17 14:21:08+00:00', -820614248, 481546706, 'g6', 8, '2023-10-09 23:10:02+00:00', '0v', 'q8qdjpe1', -1180042408, 199672698, 2119806856, 10, '2025-08-02 16:41:48+00:00', '2024-06-06 16:33:41+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -244633520, 418247369, '2021-03-26 16:58:48+00:00', -1478011227, -2096405521, 'okv8uttmu2', 9, '2021-10-09 18:25:05+00:00', '57', 'lfvyz7zzb', 924693315, -705922211, 1043710187, 12, '2024-11-18 17:17:10+00:00', '2024-02-10 01:00:46+00:00', -233617564, '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1048147204, -1814875250, '2022-12-20 18:28:11+00:00', -1589605308, -268740517, 'nxih662q', 5, '2023-10-18 11:51:31+00:00', 'lyotow', 'oaawg96aq', -2061634386, -850941333, -1216952047, 14, '2023-05-07 05:01:37+00:00', '2023-12-20 17:13:08+00:00', -2140923099, '2023-05-09 01:10:53+00:00', 'td8n5wcgu', 'bc3t');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't3__fc3f19', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -305670381, '2021-03-25 19:22:18+00:00', 't3__fc3f19', '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1937207087, '2023-09-10 09:37:01+00:00', 'y9uxj4', '2021-01-22 00:53:52+00:00', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', -1898531797, -1748371085, -1742081330, 894242932, -211209314, 'dqv0gcb9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 618058035, '2022-09-17 08:42:23+00:00', 'ne578lfv', '2025-08-19 19:51:44+00:00', 'z7zzbe8', 'yvkv42q7sx58', 'b4pmaus3auv', -1278087274, -1140595602, -609553675, 989018473, -55494714, 'n9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1576219117, '2020-08-22 06:30:10+00:00', 'unw6klfa', '2024-12-31 04:19:17+00:00', '000t5c4ec', 'gce', '76nium52', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1612443122, '2020-03-11 08:08:02+00:00', 'v', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1250290042, '2020-11-06 22:27:04+00:00', 'grit', '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43', '1jh3den', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 304189298, '2020-12-04 11:46:08+00:00', 'd5ysxc', '2021-08-06 04:52:45+00:00', '0oztd', 'j5', '3lq', 1816660482, -1212676731, 1692046802, -1300180872, -1125548818, '94gth');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, -397848196, '2025-04-29 20:31:18+00:00', '0k32odwcl5a', '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556, 1435223075, 1617348603, -477129795, -1418927432, '521gwnlas6e');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 328305758, 1, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 1074760385, 1, 't1afgog', '2022-05-19 02:17:07+00:00', 1, 'Computer Game Datasets', 'tsj', 'ayxp1q43');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 1923912467, 1, 'jh3den8c68', '2023-02-21 21:59:10+00:00', -2147483647, 'Computer Game Datasets', 'vacx7afu5', '1of77p');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1817366143, 4, '7p2r94gt', '2020-12-28 23:17:24+00:00', -2147483647, 'Computer Game Datasets', '2mnajjla3o', 'v8u');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -354292049, 1, 'a9n0jxfofws', '2023-05-19 01:23:31+00:00', -2147483647, 'Computer Game Datasets', 'o', '2zobb0q0k32o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 440115543, 4, 'msorlwyngc', '2023-08-12 12:46:14+00:00', 3, 'Computer Game Datasets', 'j', '9erhizgk1yoe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 718167481, 1, 'hdt6fuq', '2023-04-23 07:11:55+00:00', -2147483647, 'Computer Game Datasets', 'uzkb52', 'gwnlas6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 1048147204, 4, 'eowi', '2021-01-23 12:42:14+00:00', -2147483647, 'Computer Game Datasets', 'z5nxih6', '2q2xlyoto');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -2094843966, 1, '96', '2020-01-10 04:27:01+00:00', -2147483647, 'Computer Game Datasets', 'qb0tbindz39t', 'j');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 748154000, 1, 'cgumbc', '2025-11-17 06:38:18+00:00', 3, 'Computer Game Datasets', '3tdu6bd0w9', '03vzxw1rx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -505019168, 1, '7qk', '2024-12-06 05:16:35+00:00', 1, 'Computer Game Datasets', '162nh55y3d', 'ohvu06dza3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 357443379, 3, 'gjac', '2020-12-11 19:02:49+00:00', 1, 'Computer Game Datasets', 'qta8y3a17', 'v4ygmayq3qdp');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 1139012231, 3, 'hm5wl', '2021-02-19 01:26:12+00:00', 3, 'Computer Game Datasets', '7', 'dn2np490xdm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, -1974774786, 3, 'qb9i9f2ccu', '2021-06-14 07:47:39+00:00', -2147483647, 'Computer Game Datasets', 'q1q', 'ik1yhb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 1862197286, 1, 't1pqo', '2021-08-11 14:42:10+00:00', 1, 't1__c93ebf', 'ztv', '6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 1, 5, 'value', '2024-06-15 00:00:00+00:00', -2147483647, NULL, 'value', 'value');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 13244799, 6, 'hvdltt', '2021-01-23 18:11:33+00:00', -2147483647, 'Computer Game Datasets', 'bnp', 'mdpos');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, -1025564911, 7, 'rkf9vqx5', '2024-08-09 01:13:45+00:00', 4, 'Computer Game Datasets', 'pz0f8jegd21', 'y9uxj4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 1350414441, 8, 'a7ryfd', '2022-05-09 09:35:03+00:00', 7, 'Computer Game Datasets', 'z16nijjai5d', 'h5ogrgjd8yz');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1722106924, 9, 'f', '2021-05-31 16:00:51+00:00', 1, 'Computer Game Datasets', 'oa', 'cd07z2zezjo7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, -609553675, 10, 'w5chn9mo705a', '2025-07-08 06:16:45+00:00', 11, 'Computer Game Datasets', 'n0jxfofws', 'do2zobb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 1964331395, 11, 'bd0w9603v', '2023-05-02 20:56:40+00:00', -2147483647, 'Computer Game Datasets', 'xw1rxe9yfk7', 'k162n');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(2115816682, 't3__fc3f19')
(1, 't3__fc3f19')
(2115816682, 't3__fc3f19')
(1, 't3__fc3f19')
(2115816682, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(1, 't3__fc3f19')
(None, 't3__fc3f19')
(-314162272, 'unw6klfa')
(1382410067, 'v')
(481546706, 'grit')
(-2096405521, 'd5ysxc')
(-268740517, '0k32odwcl5a')
*/

-- Prediction Query
SELECT T1.ViewCount, T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Title = 'Computer game datasets';

/*
Prediction Result:
*/