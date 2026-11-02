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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', 61, -1349201381, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 't1__b8e378', 'dposiie5unw', -1399556171, 1038707349, 1419861592, -2147483648, '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', 374105386, '2020-05-12 00:10:04+00:00', 'gce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 775304493, 373262291, '2023-04-26 07:28:40+00:00', 61, -1106983592, '5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 't1__b8e378', 'eutliqa1', 2074205376, 274769912, -188151580, -2147483648, '2024-09-13 14:36:04+00:00', '2020-12-13 17:48:30+00:00', 90119032, '2021-05-27 14:39:41+00:00', 'ex1', 'ji7zwau2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -511185946, -1021749117, '2025-01-11 14:32:08+00:00', 61, -1097120355, '78d99r', -2147483648, '2021-07-21 20:51:39+00:00', 't1__b8e378', 'sl0', -2031361952, 1649269347, -1116181514, -2147483648, '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', -227162283, '2021-05-26 08:15:06+00:00', '9v', 'x58pz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 1442655647, -87647544, '2023-01-02 20:56:29+00:00', 60, -2050247126, 'lph2gn', -2147483648, '2020-07-01 12:41:54+00:00', 't1__b8e378', 'wnqcx', 722884590, 580968159, -1245312912, -2147483648, '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00', -1509264256, '2022-09-06 20:15:01+00:00', 'dz79fjg', '8n2f3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -992890117, 1914020640, '2023-10-02 15:43:02+00:00', 1219478689, -1670923962, 'rwbbp6luhvd', -2147483648, '2021-07-11 07:27:32+00:00', 'tilbn', 'rmdp', 2026480202, -1576219117, -1823627488, -2147483648, '2022-10-15 07:04:26+00:00', '2021-11-09 05:42:50+00:00', 44952191, '2021-06-25 00:51:07+00:00', 'a9', '00t5c4e');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 775304493, 373262291, '2023-04-26 07:28:40+00:00', -1106983592, 1884179925, 'bbp02eut', -2147483648, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, -2147483648, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 537874887, -461695645, 'f8jegd21vy9u', -2147483648, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc', 555413010, 722884590, 580968159, -2147483648, '2021-10-14 14:41:11+00:00', '2020-05-10 07:36:02+00:00', 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1443629118, -155284187, '2020-02-20 05:24:11+00:00', -1554531873, 982314585, 'kn6vc', -2147483648, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', 'q7x', -541746689, 1294666887, -515895469, -2147483648, '2020-07-06 08:08:29+00:00', '2022-05-09 09:35:03+00:00', 777149609, '2025-05-15 17:08:24+00:00', '6nijjai', 'dh5ogrgj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -598313376, 1972233925, '2022-03-04 13:07:03+00:00', 804529642, -1538707438, 'den8c68x', -2147483648, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7', 76996700, -435350511, 1992637800, -2147483648, '2022-08-17 19:55:37+00:00', '2020-06-07 10:59:23+00:00', 481546706, '2020-09-19 12:51:08+00:00', '62', '0v');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 199672698, 2119806856, '2025-08-02 16:41:48+00:00', -1962347906, -866772222, 'ttg6', -2147483648, '2020-03-23 04:17:18+00:00', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, -2147483648, '2025-01-04 09:05:19+00:00', '2020-05-22 14:53:50+00:00', -406331049, '2023-05-04 15:58:08+00:00', 'zj', '7wgx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -1609653472, -1405314653, '2025-11-16 21:50:04+00:00', 1816660482, -1212676731, 'm5k', -2147483648, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, -2147483648, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 782684333, 681598285, '2021-09-11 06:16:30+00:00', 1849819405, -929383517, 'u', -2147483648, '2022-11-13 09:18:31+00:00', 'krpd', 'wzw', -55494714, -1674145149, 234957614, -2147483648, '2025-11-19 09:24:25+00:00', '2021-11-30 22:01:43+00:00', -354292049, '2025-06-30 18:54:45+00:00', '9', '0jxf');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, -2147483648, 757448742, '4nrq', '2025-01-30 02:54:07+00:00', -2147483648, 't2__8b0e4c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 2, 176555546, 'gd', '2023-11-06 04:09:03+00:00', -2147483648, 't2__8b0e4c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, -921145356, 'qcgsk9', '2021-10-04 22:30:57+00:00', -2147483648, '8c4pgu7vfe');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 5, -1683203397, 'e376nium52', '2025-09-21 09:36:38+00:00', -2147483648, 'buo4nrq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 4, -977635379, 'sl0', '2020-03-25 00:00:06+00:00', -2147483648, 'yp5qi2rk');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 2, -1742081330, 'n2f3dqv0g', '2020-04-25 22:30:05+00:00', -2147483648, '9');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, 1129658414, '1afgo', '2020-11-22 11:14:57+00:00', -2147483648, 'itsj3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 7, 1421303999, 'j', '2021-12-29 21:32:16+00:00', -2147483648, '1i');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, -526612570, 'cmr0oz', '2022-07-12 13:13:05+00:00', -2147483648, 'g');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 2, -1402164108, 'yz7zzb', '2020-08-06 07:31:44+00:00', -2147483648, 'yvkv42q7s');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, -2147483645, -634585028, 'do2zobb', '2023-06-19 15:36:55+00:00', -2147483648, '0k32o');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T2.PostId = T2.Id WHERE T1.Score > 60;

/*
Gold Result:
('t1__b8e378', '8c4pgu7vfe')
('t1__b8e378', 't2__8b0e4c')
('t1__b8e378', 'yp5qi2rk')
('t1__b8e378', '1i')
('t1__b8e378', '8c4pgu7vfe')
('t1__b8e378', 't2__8b0e4c')
('t1__b8e378', 'yp5qi2rk')
('t1__b8e378', '1i')
('t1__b8e378', '8c4pgu7vfe')
('t1__b8e378', 't2__8b0e4c')
('t1__b8e378', 'yp5qi2rk')
('t1__b8e378', '1i')
('tilbn', '8c4pgu7vfe')
('tilbn', 't2__8b0e4c')
('tilbn', 'yp5qi2rk')
('tilbn', '1i')
('j4hwbdvlph', '8c4pgu7vfe')
('j4hwbdvlph', 't2__8b0e4c')
('j4hwbdvlph', 'yp5qi2rk')
('j4hwbdvlph', '1i')
('acx7af', '8c4pgu7vfe')
('acx7af', 't2__8b0e4c')
('acx7af', 'yp5qi2rk')
('acx7af', '1i')
('qs27p2r94', '8c4pgu7vfe')
('qs27p2r94', 't2__8b0e4c')
('qs27p2r94', 'yp5qi2rk')
('qs27p2r94', '1i')
('krpd', '8c4pgu7vfe')
('krpd', 't2__8b0e4c')
('krpd', 'yp5qi2rk')
('krpd', '1i')
*/

-- Prediction Query
SELECT T2.Title, T1.UserDisplayName FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.Score > 60;

/*
Prediction Result:
('t1__b8e378', 't2__8b0e4c')
('t1__b8e378', 't2__8b0e4c')
('t1__b8e378', 'itsj3')
('j4hwbdvlph', '1i')
*/