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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'How to tell if something happened in a data set which monitors a value over time', 'nprmdposii', -1823627488, -1209887326, -1399556171, -2147483648, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 757448742, -1179823637, '2021-09-24 11:50:48+00:00', 781505063, 418417917, 'fqyp', -2147483648, '2024-02-28 04:46:49+00:00', 'How to tell if something happened in a data set which monitors a value over time', '5bbp0', 743312762, -1822992503, -868774469, -2147483648, '2021-03-04 19:22:02+00:00', '2022-02-19 15:51:21+00:00', -2118135981, '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1775126557, -74849714, '2021-02-17 21:51:43+00:00', -453362185, 481163439, '2dwyrq', -2147483648, '2023-09-08 22:37:16+00:00', 't3__9cc94a', '3pyu78d99r', -1362461264, -904834265, -346339240, -2147483648, '2023-12-31 18:03:51+00:00', '2023-04-11 01:23:11+00:00', -1116181514, '2022-03-22 13:45:21+00:00', '2rk', '9v');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 176555546, -1937207087, '2023-09-10 09:37:01+00:00', -688509700, -792092619, 'j4hwbdvlph', -2147483648, '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', 722884590, 580968159, -1245312912, -2147483648, '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00', -1509264256, '2022-09-06 20:15:01+00:00', 'dz79fjg', '8n2f3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1443629118, -155284187, '2020-02-20 05:24:11+00:00', -1554531873, 982314585, 'kn6vc', -2147483648, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', 'q7x', -541746689, 1294666887, -515895469, -2147483648, '2020-07-06 08:08:29+00:00', '2022-05-09 09:35:03+00:00', 777149609, '2025-05-15 17:08:24+00:00', '6nijjai', 'dh5ogrgj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', 't2__8619af', '4h', -992890117, 1914020640, 1268590800, -2147483648, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', -1670923962, '2025-08-22 00:34:24+00:00', 'wbbp6', 'uhv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -845863578, -1610064545, '2020-03-11 00:23:16+00:00', -1257178728, 1236688122, 'dpos', -2147483648, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, -2147483648, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 902887186, -967741825, '2025-10-15 06:50:58+00:00', -1031969798, -1106983592, '5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 't2__8619af', 'eutliqa1', 2074205376, 274769912, -188151580, -2147483648, '2024-09-13 14:36:04+00:00', '2020-12-13 17:48:30+00:00', 90119032, '2021-05-27 14:39:41+00:00', 'ex1', 'ji7zwau2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -511185946, -1021749117, '2025-01-11 14:32:08+00:00', -1097120355, 244829661, 'jsl', -2147483648, '2023-07-26 21:52:05+00:00', '4', 'p5qi2rk', -705985602, 537874887, -461695645, -2147483648, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1581736075, -261132974, '2021-09-30 11:37:26+00:00', 1968874827, -664193365, 'cx5hn', -2147483648, '2020-05-10 07:36:02+00:00', 't2__8619af', 'rjtu', -361507387, 401805964, -1485777725, -2147483648, '2022-03-23 04:34:16+00:00', '2024-08-10 07:57:32+00:00', -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 32204797, -1672720816, '2020-10-15 18:29:15+00:00', 138842628, -932772113, 'lq7xb7', -2147483648, '2025-04-29 15:45:27+00:00', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 1449284300, -977470238, -2147483648, '2021-04-29 02:40:32+00:00', '2020-06-19 19:37:13+00:00', 1074760385, '2023-05-06 21:04:41+00:00', '1afgo', 'ri');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -197933860, 2111987706, '2023-01-25 15:19:02+00:00', -106471771, 1235416111, 'jh3den8', -2147483648, '2025-01-28 02:00:27+00:00', 't2__8619af', 'c68x8vacx7', 1523825314, 2078438287, -47052816, -2147483648, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1870300798, 820970595, '2024-07-28 14:01:55+00:00', -1021978385, 569007824, 'e1io', -2147483648, '2023-10-10 11:56:21+00:00', '78507cvt', 'ptt', 1467355421, -1171104889, -29242208, -2147483648, '2021-02-17 19:49:53+00:00', '2023-12-14 20:00:33+00:00', -68044929, '2020-09-25 02:07:37+00:00', 'foa', 'cd07z2zezjo7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, 1999335832, -526612570, '2023-03-04 02:34:12+00:00', -2005628382, 1721638020, '0oztdgj5i3lq', -2147483648, '2025-11-16 21:50:04+00:00', 't2__8619af', 'lnpim5k5', 195202164, 1817366143, 1615073310, -2147483648, '2025-05-07 04:09:25+00:00', '2024-06-08 02:27:24+00:00', 1055237066, '2023-11-07 06:34:01+00:00', '94gth', '2mnajjla3o');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, -761353513, 362376128, '2024-12-23 03:48:38+00:00', 618058035, 1553368934, 'e578', -2147483648, '2021-06-23 03:34:31+00:00', 'vy', '7zzbe8y', -705922211, 1043710187, 318331233, -2147483648, '2023-10-16 10:50:30+00:00', '2022-03-14 12:32:27+00:00', 79330142, '2023-02-22 13:15:37+00:00', '58b4pmaus3a', 'vmkrpd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (15, -55494714, -1674145149, '2024-09-19 09:49:38+00:00', 101754718, 628082526, '9n0jxfofwsz', -2147483648, '2020-06-20 19:03:43+00:00', 't2__8619af', '2zob', -2019656607, 375841374, -1449226553, -2147483648, '2025-08-18 08:22:12+00:00', '2025-06-17 10:56:06+00:00', -225238282, '2020-06-28 23:31:51+00:00', 'cl5ams', 'orlwyngc1dj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 1935791961, 595714424, '2023-06-08 15:48:15+00:00', -499913447, -360096930, 't', -2147483648, '2024-04-21 11:49:54+00:00', 'uq', 'xuzkb52', -277407746, -670154354, -2140468103, -2147483648, '2024-04-30 14:56:46+00:00', '2025-03-08 07:37:26+00:00', -2076274980, '2020-08-28 14:27:04+00:00', 'wii1', '5nxih66');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (17, 1614799674, 1083479253, '2022-12-15 20:09:37+00:00', 205676091, -2094843966, '96', -2147483648, '2020-01-10 04:27:01+00:00', 't2__8619af', 'qb0tbindz39t', 2038321753, 1376887048, 261633665, -2147483648, '2020-06-02 05:30:58+00:00', '2024-07-21 17:54:15+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (18, 1071401016, 40558455, '2023-12-02 04:32:05+00:00', -541917667, -961629819, '9y', -2147483648, '2020-09-21 12:30:27+00:00', '7qk', '162nh55y3d', 440797047, -732999244, 1654100852, -2147483648, '2024-04-24 18:29:26+00:00', '2020-06-02 22:00:04+00:00', -438741674, '2023-12-12 21:29:29+00:00', 'rmkio18r', 'i2hy08ftp6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (19, 2013745856, 917362079, '2023-03-16 17:59:19+00:00', 462225708, 1528227252, 'fx7h', -2147483648, '2023-12-11 11:19:14+00:00', 't2__8619af', 'p6sto1cj', 1728926031, -63214972, 1106724223, -2147483648, '2025-06-29 15:21:32+00:00', '2023-03-26 14:26:48+00:00', 1487347213, '2023-03-15 00:23:20+00:00', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (20, 1168225104, -499203870, '2023-12-18 01:48:18+00:00', 1432875972, 1032339628, 'uap9', -2147483648, '2024-05-15 00:40:21+00:00', 'ntdqr', 'm5', -648564084, -1573704891, -1260548409, -2147483648, '2021-10-14 23:04:20+00:00', '2024-11-06 01:26:20+00:00', 833568923, '2024-02-01 00:27:26+00:00', '0xdmsqtge', 'cuq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (21, 277649518, 908468929, '2022-09-09 18:35:07+00:00', -1414362698, 1046248997, 'uik1y', -2147483648, '2025-10-15 06:35:43+00:00', 't2__8619af', 'b0', 166124233, 1862197286, 1040753276, -2147483648, '2023-08-12 01:29:22+00:00', '2022-02-01 03:33:20+00:00', -1333785554, '2023-06-06 02:04:32+00:00', 'tvb6m4iz78', 'q');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (22, -753065777, 190510318, '2022-08-06 20:35:20+00:00', 1183069552, -1057355067, 'e6bje', -2147483648, '2024-12-21 23:01:28+00:00', 'uwsj8k', 'h85', -609840352, 486475144, -679850352, -2147483648, '2021-02-03 14:27:41+00:00', '2022-06-18 15:18:07+00:00', 2042428747, '2022-05-09 23:34:41+00:00', '0kaqtnc', 'gc8s3b7v88k');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483648, '2021-02-10 21:10:52+00:00', 1, 1, -761141909);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2024-02-28 14:45:41+00:00', 1, 2, 1836127587);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483646, '2025-11-06 14:42:57+00:00', 1, 3, -1056308489);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483645, '2020-06-19 19:37:13+00:00', 4, 1, 1074760385);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483644, '2020-09-12 13:47:57+00:00', 1, 4, -1717646459);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483643, '2025-08-05 22:21:48+00:00', 4, 1, -902895762);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483642, '2022-01-13 07:24:35+00:00', 1, 4, 1972233925);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483641, '2023-08-17 20:15:35+00:00', 4, 1, 518609210);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483640, '2021-11-04 04:05:36+00:00', 1, 4, 357330522);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, '2023-02-22 19:24:03+00:00', 1, 1, -1762140823);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (3, '2024-02-28 09:48:47+00:00', 1, 1, -290314193);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483637, '2023-09-06 20:49:17+00:00', 1, 1, -1180042408);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (4, '2025-09-21 09:36:38+00:00', 5, 6, -443340271);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (5, '2021-01-22 00:53:52+00:00', 7, 8, -629784617);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (6, '2025-05-12 19:10:13+00:00', 9, 10, 710458518);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (7, '2024-11-08 11:45:59+00:00', 11, 12, -604098478);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (8, '2021-03-23 21:08:32+00:00', 13, 14, 1105964624);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (9, '2023-10-03 17:29:40+00:00', 15, 16, -1034034171);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (10, '2020-07-31 07:58:47+00:00', 17, 18, -646944990);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (11, '2020-03-25 16:06:09+00:00', 19, 20, 1374676344);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (12, '2023-01-07 20:03:41+00:00', 21, 22, -2070247503);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Title FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN posts AS T3 ON T1.RelatedPostId = T3.Id WHERE T2.Title = 'How to tell if something happened in a data set which monitors a value over time';

/*
Gold Result:
('How to tell if something happened in a data set which monitors a value over time',)
('t3__9cc94a',)
('nd',)
('ah0f8jsww',)
('ah0f8jsww',)
('ah0f8jsww',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
*/

-- Prediction Query
SELECT posts.Title AS RelatedPostTitle FROM posts INNER JOIN postLinks ON posts.Id = postLinks.PostId WHERE posts.Title = 'How to tell if something happened in a data set which monitors a value over time';

/*
Prediction Result:
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
('How to tell if something happened in a data set which monitors a value over time',)
*/