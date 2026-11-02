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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', 61, -1349201381, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 't1__c96f66', 'dposiie5unw', -1399556171, 1038707349, 1419861592, -2147483648, '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', 374105386, '2020-05-12 00:10:04+00:00', 'gce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 775304493, 373262291, '2023-04-26 07:28:40+00:00', 61, -1106983592, '5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 't1__c96f66', 'eutliqa1', 2074205376, 274769912, -188151580, -2147483648, '2024-09-13 14:36:04+00:00', '2020-12-13 17:48:30+00:00', 90119032, '2021-05-27 14:39:41+00:00', 'ex1', 'ji7zwau2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -511185946, -1021749117, '2025-01-11 14:32:08+00:00', 61, -1097120355, '78d99r', -2147483648, '2021-07-21 20:51:39+00:00', 't1__c96f66', 'sl0', -2031361952, 1649269347, -1116181514, -2147483648, '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', -227162283, '2021-05-26 08:15:06+00:00', '9v', 'x58pz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1929953647, 1581736075, '2023-09-26 13:08:37+00:00', 60, 1298861365, 'q', -2147483648, '2022-12-08 23:34:02+00:00', 't1__c96f66', 'qcx5', 580968159, -1245312912, 1575412235, -2147483648, '2022-04-18 00:53:20+00:00', '2021-04-06 16:11:52+00:00', -841004020, '2023-07-15 22:31:56+00:00', 'z', '9fjgq8n2f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 172461907, 1606439408, '2021-05-16 14:38:12+00:00', 61, -155284187, 'i', -2147483648, '2021-07-02 01:45:48+00:00', 'yrkn6vck6ah0', '8j', -932772113, -639539893, 1255343543, -2147483648, '2020-03-06 15:32:29+00:00', '2025-02-02 06:02:30+00:00', -541746689, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1360271423, 1583472758, '2020-10-22 21:08:07+00:00', 61, -977470238, 'd8y', -2147483648, '2023-05-06 21:04:41+00:00', '1afgo', 'ri', -902895762, -197933860, 2111987706, -2147483648, '2023-01-25 15:19:02+00:00', '2022-01-13 07:24:35+00:00', 1972233925, '2022-03-04 13:07:03+00:00', '4301jh3den8', 'c68x8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -992890117, 1914020640, '2023-10-02 15:43:02+00:00', 1219478689, -1670923962, 'rwbbp6luhvd', -2147483648, '2021-07-11 07:27:32+00:00', 'tilbn', 'rmdp', 2026480202, -1576219117, -1823627488, -2147483648, '2022-10-15 07:04:26+00:00', '2021-11-09 05:42:50+00:00', 44952191, '2021-06-25 00:51:07+00:00', 'a9', '00t5c4e');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 902887186, -967741825, '2025-10-15 06:50:58+00:00', -1031969798, -1106983592, '5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, -2147483648, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 537874887, -461695645, 'f8jegd21vy9u', -2147483648, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc', 555413010, 722884590, 580968159, -2147483648, '2021-10-14 14:41:11+00:00', '2020-05-10 07:36:02+00:00', 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 331812443, 1382410067, '2020-04-02 07:45:47+00:00', 172461907, 1606439408, '3zb', -2147483648, '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f', 138842628, -932772113, -639539893, -2147483648, '2022-03-20 09:18:33+00:00', '2024-06-08 00:23:27+00:00', 1255343543, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', 'z16ni');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -902895762, -197933860, '2023-04-12 14:06:32+00:00', -598313376, 1972233925, '4301j', -2147483648, '2021-01-17 17:19:55+00:00', 'den8c68x', 'vacx7afu5', -290314193, 76996700, -435350511, -2147483648, '2025-11-10 20:25:30+00:00', '2025-12-23 18:43:58+00:00', 87529806, '2020-05-17 14:21:08+00:00', 'dctmf', '62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -1962347906, -866772222, '2022-01-28 18:02:07+00:00', 1582582341, 453836040, '6b', -2147483648, '2021-11-07 01:38:36+00:00', 'u5zi', '6c4bfkfo', -1950324754, 2115816682, 76987628, -2147483648, '2023-10-02 07:56:21+00:00', '2023-05-04 15:58:08+00:00', 641521863, '2021-04-04 14:38:19+00:00', '7wgx', '5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, -1609653472, -1405314653, '2025-11-16 21:50:04+00:00', 1816660482, -1212676731, 'm5k', -2147483648, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, -2147483648, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, -2147483648, 757448742, '4nrq', '2025-01-30 02:54:07+00:00', -2147483648, 't2__f5ead6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 3, -1937207087, 'vy9uxj4', '2021-01-22 00:53:52+00:00', -2147483648, 't2__f5ead6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 4, 2078438287, '5w1of7', '2024-05-28 03:27:01+00:00', -2147483648, 'zo72');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 4, -820614248, 't', '2025-11-30 16:40:04+00:00', -2147483648, 'mfg62g0v5q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 6, -921145356, 'qcgsk9', '2021-10-04 22:30:57+00:00', -2147483648, '8c4pgu7vfe');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, 1149850321, 'e', '2023-12-22 03:17:01+00:00', -2147483648, '6nium52zb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 7, -977635379, 'sl0', '2020-03-25 00:00:06+00:00', -2147483648, 'yp5qi2rk');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 7, -1485777725, '8n2f3', '2025-11-06 14:42:57+00:00', -2147483648, 'q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 3, -2115841792, 'dh5ogrgj', '2020-06-19 19:37:13+00:00', -2147483648, 'yzt1afgog');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 2, 1870300798, 'q8qdjpe1', '2021-03-11 03:10:40+00:00', -2147483648, '2278');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 6, -546516406, 'r0oz', '2022-07-12 13:13:05+00:00', -2147483648, 'g');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (11, 2, -1402164108, 'yz7zzb', '2020-08-06 07:31:44+00:00', -2147483648, 'yvkv42q7s');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T2.PostId = T2.Id WHERE T1.Score > 60;

/*
Gold Result:
('t1__c96f66', 'zo72')
('t1__c96f66', '8c4pgu7vfe')
('t1__c96f66', 'q')
('yrkn6vck6ah0', 'zo72')
('yrkn6vck6ah0', '8c4pgu7vfe')
('yrkn6vck6ah0', 'q')
('t1__c96f66', 'zo72')
('t1__c96f66', '8c4pgu7vfe')
('t1__c96f66', 'q')
('t1__c96f66', 'zo72')
('t1__c96f66', '8c4pgu7vfe')
('t1__c96f66', 'q')
('1afgo', 'zo72')
('1afgo', '8c4pgu7vfe')
('1afgo', 'q')
('tilbn', 'zo72')
('tilbn', '8c4pgu7vfe')
('tilbn', 'q')
('j4hwbdvlph', 'zo72')
('j4hwbdvlph', '8c4pgu7vfe')
('j4hwbdvlph', 'q')
('yrk', 'zo72')
('yrk', '8c4pgu7vfe')
('yrk', 'q')
('u5zi', 'zo72')
('u5zi', '8c4pgu7vfe')
('u5zi', 'q')
('qs27p2r94', 'zo72')
('qs27p2r94', '8c4pgu7vfe')
('qs27p2r94', 'q')
*/

-- Prediction Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T2.Score > 60;

/*
Prediction Result:
('t1__c96f66', 't2__f5ead6')
('t1__c96f66', '6nium52zb')
('1afgo', 'zo72')
('t1__c96f66', '2278')
*/