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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', 1, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, -1, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 1255343543, -541746689, '2024-12-20 11:42:02+00:00', -961217731, -1888505890, 'z16nijjai5d', 1, '2025-07-17 09:46:47+00:00', '5o', 'rg', -1478247928, 1074760385, 1129658414, -2147483646, '2022-08-16 10:09:33+00:00', '2025-06-10 19:01:27+00:00', 1250290042, '2020-11-06 22:27:04+00:00', 'grit', 'sj3ayxp1q430');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -206528034, -1686002788, '2021-10-10 22:42:32+00:00', -2140468103, 469838697, 'lboeowii1z5', 1, '2021-10-05 09:01:22+00:00', 'xih662q2xly', 'otow9oaawg', 1044710644, 966412849, -2061634386, -2147483641, '2022-07-26 21:24:54+00:00', '2020-02-29 08:50:35+00:00', -1216952047, '2023-05-07 05:01:37+00:00', '9tajz9td', 'n5wcgumbc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 789756515, -1160642134, '2024-07-20 09:13:00+00:00', 769234989, 168442149, 'tp6ewtqxxn', 1, '2021-04-23 14:15:38+00:00', 'b', 'mzn2mfx', 1243701948, -156175571, 1220047834, -2147483646, '2024-05-18 01:33:40+00:00', '2022-06-27 12:50:13+00:00', -843082635, '2023-09-09 05:17:59+00:00', 'j', 'sh5knzys7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -1502591405, -2008781089, '2024-07-16 00:46:06+00:00', 973811121, 280292620, 'a8y3a17v4yg', 1, '2024-11-09 23:43:28+00:00', 'ayq3', 'dpuap', -845136979, -1042976410, -1670945624, -2147483646, '2024-02-22 22:48:55+00:00', '2025-01-14 14:36:19+00:00', -648564084, '2021-02-19 01:26:12+00:00', '7', 'dn2np490xdm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -1974774786, 422046500, '2020-03-25 16:06:09+00:00', 1374676344, 238243966, 'ccukjq1q', 1, '2022-09-04 04:40:22+00:00', 'k1y', 'hb08hlst1pq', 1980131681, 1222311103, 2141720493, -2147483646, '2025-05-30 09:57:11+00:00', '2022-11-15 11:41:33+00:00', -1304516770, '2021-03-02 05:21:54+00:00', '78aqqlu', '8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 1618264449, 1639204149, '2020-03-01 13:40:47+00:00', -1004098188, 316163741, 'uu', 1, '2022-12-10 16:57:51+00:00', 'j8kjh', '5wpxlvris', 2042428747, 1228655416, -388527046, -2147483642, '2020-01-29 00:07:37+00:00', '2025-06-05 03:28:36+00:00', -1040951738, '2024-12-16 15:00:57+00:00', 'ncgc8s3b7v8', 'kwdmdbdht');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 2, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -977635379, 1661181156, '2021-07-14 21:04:24+00:00', -346339240, 1692174491, 'qi2rkf9v', 3, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, -2147483640, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, -961217731, 'dr', 4, '2025-10-16 14:52:58+00:00', '16nijja', '5dh', 1583472758, 1449284300, -977470238, 0, '2021-04-29 02:40:32+00:00', '2020-06-19 19:37:13+00:00', 1074760385, '2023-05-06 21:04:41+00:00', '1afgo', 'ri');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -847293924, -2033879835, '2021-12-07 07:01:12+00:00', 944975670, -1575410149, 'c4bfkfoac', 5, '2020-07-08 07:50:44+00:00', '7z2zezj', '7wgx', -57705450, -915385605, -2005628382, -2147483646, '2022-04-20 03:52:20+00:00', '2023-06-27 00:46:15+00:00', 1269522000, '2025-12-11 00:03:18+00:00', 'tdgj5i3', 'q5l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -699574669, 274891948, '2025-06-17 13:01:08+00:00', -1140595602, -609553675, 'w5chn9mo705a', 6, '2025-07-08 06:16:45+00:00', 'n0jxfofws', 'do2zobb', -397848196, -366775518, 575038073, -2147483638, '2021-12-14 11:59:29+00:00', '2020-06-28 23:31:51+00:00', -613916489, '2021-07-10 06:02:47+00:00', '5amsorlwyngc', 'dj9erhi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2094843966, -1048779857, '2023-07-01 11:41:54+00:00', -850941333, -1216952047, '39tajz9', 7, '2022-08-02 17:02:31+00:00', '8', '5wcg', -794767771, 989306270, 1147652228, -2147483641, '2020-07-01 00:06:39+00:00', '2024-11-28 14:19:46+00:00', 1964331395, '2024-04-21 17:44:41+00:00', 'd', 'w9603vz');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -868774469, '1970-01-01 00:00:01+00:00', 'qa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483646, -361507387, '1970-01-01 00:00:00+00:00', '79fjgq8', '2021-10-07 12:15:00+00:00', 'f3dqv0gc', '9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483645, 1523825314, '1970-01-01 00:00:00+00:00', 'u5', '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', '62', -1744557630, 1870300798, 820970595, 1421303999, -1488156735, '1i');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1944978593, '1970-01-01 00:00:01+00:00', 'bfkfoacd', '2023-07-08 08:00:15+00:00', '7z2zezjo7wg', 'd5ysxc', 'r0oz', -870767087, -1699185893, 875300074, -1609653472, -1405314653, '5lnpim5k58qs');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, 1497321728, '1969-12-31 23:59:59+00:00', '4gth2mnaj', '2021-04-29 06:47:06+00:00', 'a3o', 'v8u', 'tmu2n', -1817527403, -1402164108, 2123471885, -526633767, 448935289, 'be8yvkv');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 756202403, '1969-12-31 23:59:59+00:00', '8b4pmaus3au', '2022-11-13 09:18:31+00:00', 'krpd', 'wzw', 'chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 375841374, '1969-12-31 23:59:59+00:00', '32o', '2020-06-28 23:31:51+00:00', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 1483450542, 513375398, 718167481, 1428194830, -1614619556, '6fuqy');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, -982188592, '1970-01-01 00:00:00+00:00', 'hsjhanz', '2023-02-27 07:54:12+00:00', 'p', 'nmwfwx', 'rlawk', 558684943, -120625031, 572453185, 1348973408, -911953404, '97');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1148194959, '1970-01-01 00:00:00+00:00', 'pj6ddly', '2022-06-01 09:30:47+00:00', 'u6iphdku2gi', '31vwq', '1oa2sb3u', 1388661799, -1574319760, 473443538, 1754053934, 1206923461, 'wnyqro');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, -1143329124, '1969-12-31 23:59:59+00:00', 't63', '2025-05-24 07:05:59+00:00', 'yfvmjw', 'p26m', '3', 1893953818, -364462246, 982289268, 493701528, 461842658, 'ir1axyyh');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -868774469, '2021-03-04 19:22:02+00:00', 'a11ry', '2024-10-18 05:00:47+00:00', 'too3o9h', '72k', 'ex1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', '2020-06-29 02:04:50+00:00', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -683007527, '2020-05-02 02:12:13+00:00', 'x7afu5w1of77', '2022-01-27 19:59:15+00:00', 'o72ctdc', 'mfg62', '0v', 820970595, 1421303999, -1488156735, -1858644047, -1180042408, '78507cvt');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1719383707, '2020-12-28 23:17:24+00:00', '2mnajjla3o', '2021-06-04 07:47:26+00:00', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 1043710187, 318331233, -233617564, 79330142, 1735561423, '58b4pmaus3a');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1418927432, '2025-06-29 01:47:27+00:00', '521gwnlas6', '2025-03-08 07:37:26+00:00', 'lb', 'eowi', '1z5', 1557188093, 548968280, -1552469358, 7342822, -1034034171, 'lyotow');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 'qrofqyp5s5b', '2020-03-11 14:09:37+00:00', 1, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, -1, -1245682094, 'x', '2025-09-07 08:46:54+00:00', -1, 'hncprjtu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 0, -163600466, 'n8', '2025-01-28 02:00:27+00:00', 1, 'c68x8vacx7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 0, 2119806856, '7cvtjpttg6b', '2021-11-07 01:38:36+00:00', -2147483645, 'u5zi');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, 1964331395, 'bd0w9603v', '2023-05-02 20:56:40+00:00', 1, 'xw1rxe9yfk7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 312804300, '62nh55y3dohv', '2022-09-26 18:21:28+00:00', 0, '6dza35r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 2, 902887186, 'qrofqyp5s5b', '2020-03-11 14:09:37+00:00', -2147483645, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 3, -1052964641, 'qcx5', '2025-05-27 16:57:17+00:00', 1, 'nc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 4, 710458518, 'sj3ayxp1q430', '2023-08-17 20:15:35+00:00', -2147483638, 'jh3den8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 5, -1212676731, 'm5k', '2024-03-11 05:11:39+00:00', 3, 'qs27p2r94');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 6, -499913447, 'yo', '2024-05-17 09:41:22+00:00', 3, 'l0hdt6fuqyx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 7, -639616320, 'xe9yf', '2021-05-30 10:13:06+00:00', 2, 'qk162nh55');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T3.PostId = T2.Id ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(T2.Id), COUNT(T3.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T1.Id = T3.UserId WHERE T1.CreationDate = (SELECT MAX(CreationDate) FROM users);

/*
Prediction Result:
(0, 0)
*/