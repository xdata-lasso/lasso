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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 2103044118, -1642259219, '2020-12-04 21:49:29+00:00', -1264842910, -1052964641, 'qcx5', 2, '2025-05-27 16:57:17+00:00', 'Analysing wind data with R', 'nc', 1575412235, -988981234, -841004020, 1, '2023-07-15 22:31:56+00:00', '2020-06-29 02:04:50+00:00', 401805964, '2021-04-23 15:57:00+00:00', 'q8', 'n2f3dqv0gcb9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 1, '2023-08-17 20:15:35+00:00', 'Analysing wind data with R', 'jh3den8c68', -683007527, 2035306060, 1523825314, 3, '2020-10-05 17:58:46+00:00', '2022-09-01 11:41:59+00:00', 1371234901, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, -242584410, -698610044, '2025-11-17 07:39:50+00:00', -1021978385, 569007824, 'e1io', 1, '2023-10-10 11:56:21+00:00', 'Analysing wind data with R', '78507cvt', -1523347137, 1582582341, 453836040, 1, '2020-11-29 15:34:58+00:00', '2024-05-07 03:46:17+00:00', 1467355421, '2021-11-07 01:38:36+00:00', 'u5zi', '6c4bfkfo');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 339193890, -493230039, '2024-11-09 23:43:28+00:00', -2081662466, -1941472821, 'uap96rntdqr', 1, '2020-12-10 17:13:46+00:00', 'Analysing wind data with R', '5wli', 899787662, 594760660, 833568923, -2147483642, '2024-02-01 00:27:26+00:00', '2024-09-08 22:53:00+00:00', -384749431, '2020-06-22 13:18:04+00:00', 'sqtg', 'lc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 422046500, -1750715330, '2024-10-20 07:00:22+00:00', -788896327, -1541581575, '1quik1yhb08h', 1, '2021-07-19 11:24:33+00:00', 'Analysing wind data with R', 't1pqo', 1222311103, 2141720493, 1793241362, 0, '2020-02-24 04:19:02+00:00', '2024-05-04 23:14:41+00:00', -1304516770, '2021-03-02 05:21:54+00:00', '78aqqlu', '8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 4, '2020-03-11 00:23:16+00:00', 't2__a84c05', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 5, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 6, '2020-03-11 00:23:16+00:00', 'Analysing wind data with R', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -921187550, -2070843029, '2022-01-05 17:19:47+00:00', 882961052, 743312762, 'eutliqa11r', 7, '2023-03-22 03:47:49+00:00', 'Analysing wind data with R', 'ytoo3o9hl7', 1178636309, -1390245819, 1055976837, -2147483641, '2023-08-25 07:55:29+00:00', '2024-02-08 07:13:40+00:00', -1525670226, '2025-02-02 04:37:17+00:00', 'zwau2dwyr', '13pyu');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__acb2d2', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1106983592, '2022-06-06 01:51:46+00:00', 't1__acb2d2', '2024-04-01 02:40:29+00:00', 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', -305670381, -1525670226, -453362185, 481163439, 2123196517, 'dwyrq13pyu78');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 244829661, '2021-07-21 20:51:39+00:00', 't1__acb2d2', '2021-03-27 18:00:10+00:00', 'l0b4y', 'p5qi2rkf9v', 'x58pz', -1529584866, 1196308825, 910894705, -283454505, 233994589, 'j4hwbd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1520489792, '1970-01-01 00:00:01+00:00', 't1__acb2d2', '2022-12-13 04:17:12+00:00', 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 1448731351, '1970-01-01 00:00:00+00:00', 't1__ac169a', '2024-06-13 19:21:11+00:00', 'wgxd5ysxcm', '0oztd', 'j5', -1609653472, -1405314653, 1816660482, -1212676731, 1692046802, '5k58');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 333302050, '1970-01-01 00:00:01+00:00', 't1__acb2d2', '2021-08-24 18:58:08+00:00', 'ajjl', '3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -451030047, -2052653308, 'yvkv42q7s');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, -200807520, '1969-12-31 23:59:59+00:00', 't1__ac169a', '2022-09-08 09:11:51+00:00', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843, -441521858, 2015094998, 1010672881, -1197954156, '0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 211603887, '1969-12-31 23:59:59+00:00', 't1__ac169a', '2025-05-23 18:24:29+00:00', 'rhizgk1yoey', 'o6l0hdt6fu', 'yxuzk', 450555855, -206528034, -1686002788, -1250380401, 1718516876, '6elbo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 966412849, '1970-01-01 00:00:00+00:00', 't1__ac169a', '2020-03-03 02:26:18+00:00', 'tbindz3', 'tajz9td8n', '5wcgumbc3td', 1964331395, -1943814113, 1514371324, -379749892, -541917667, 'rxe9yfk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1853955201, '1970-01-01 00:00:00+00:00', 't1__ac169a', '2022-08-28 09:41:49+00:00', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 1106724223, 1966809332, 1487347213, 'yd1jmgj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, 1138926079, '1970-01-01 00:00:00+00:00', 't1__ac169a', '2023-01-17 07:11:46+00:00', 'xlvr', 'sur', '0kaqtnc', 697582781, 428944759, 1446366856, 438933248, 180947503, 'dmdbdh');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483637, 1981548099, '1970-01-01 00:00:00+00:00', 't1__ac169a', '2020-12-25 11:02:58+00:00', 'sjhanzxdpu', 'mwfw', 'qrlawk', 558684943, -120625031, 572453185, 1348973408, -911953404, '97');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483636, 1813965704, '1969-12-31 23:59:59+00:00', 't1__ac169a', '2025-09-05 04:17:44+00:00', '6iphdk', 'u2gir31vwq5', 'oa2sb3u', 1388661799, -1574319760, 473443538, 1754053934, 1206923461, 'wnyqro');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 373262291, '2023-04-26 07:28:40+00:00', '5s5b', '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 't3__bcbb98', '2025-10-19 18:29:54+00:00', 1, 'rofqy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, -1454058168, 't3__bcbb98', '2023-05-15 04:44:08+00:00', 3, 'i');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 982314585, 't3__bcbb98', '2022-05-18 00:14:53+00:00', 1, 'kn6vck6ah0f8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -1, -406331049, 't3__445d0d', '2023-05-04 15:58:08+00:00', 1, 'zj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 0, 1055237066, 't3__445d0d', '2023-11-07 06:34:01+00:00', -2147483644, '94gth');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -1, -2060082151, 't3__445d0d', '2025-08-08 12:00:20+00:00', 0, 'maus');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, -366775518, 't3__445d0d', '2023-11-21 15:04:11+00:00', -2147483644, '2odwcl5amso');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, -1, -1689155697, 't3__445d0d', '2023-08-12 12:46:14+00:00', -1, 'j');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 0, -1610380698, 't3__445d0d', '2023-05-07 14:15:39+00:00', 3, 'nxih662q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, 0, 412199481, 't3__445d0d', '2022-08-25 00:08:33+00:00', -2147483642, 'ow9oaawg96a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, 1, -246257698, 't3__445d0d', '2020-12-13 20:46:34+00:00', -2147483642, '55y3dohvu06d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, 0, 729449685, 't3__445d0d', '2021-05-25 07:37:07+00:00', -2147483641, 'io18ri2hy08');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, 0, 973811121, 't3__445d0d', '2024-10-22 04:53:36+00:00', -2147483640, 'a8y3a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, 1, 1946419004, 't3__445d0d', '2024-06-16 03:16:38+00:00', 3, 'xar5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, 1, -459764012, 't3__445d0d', '2021-12-23 20:45:43+00:00', -2147483644, '0pj6ddly');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, 1, -980625770, 't3__445d0d', '2025-09-06 04:06:16+00:00', 3, 'pouit');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 4, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', -2147483641, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 5, 1909986641, 'yrq13p', '2023-03-13 16:07:34+00:00', -2147483637, '78d99r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 6, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', 5, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 2, 1, NULL, '2024-06-15 00:00:00+00:00', -2147483636, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 7, 244829661, 'jsl', '2023-07-26 21:52:05+00:00', 7, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('jsl', None)
*/

-- Prediction Query
SELECT T1.Text, T1.UserDisplayName FROM comments AS T1 JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('t3__bcbb98', 'rofqy')
('t3__445d0d', 'pouit')
('t3__445d0d', 'maus')
('t3__445d0d', 'a8y3a')
('t3__445d0d', 'xar5')
(None, 'value')
('t3__445d0d', '2odwcl5amso')
('um5', 'zbuo4nrqrof')
('t3__445d0d', '94gth')
('t3__445d0d', 'j')
*/