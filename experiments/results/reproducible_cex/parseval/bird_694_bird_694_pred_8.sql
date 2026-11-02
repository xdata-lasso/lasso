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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', 1, '2022-03-30 02:18:34+00:00', 'Analysing wind data with R', 'x58pz0f8je', 1196308825, 910894705, -283454505, 3, '2023-04-27 18:28:48+00:00', '2025-07-25 08:53:04+00:00', 233994589, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 1449284300, -977470238, '2021-04-29 02:40:32+00:00', -458359144, 600440952, 'f', 0, '2020-11-06 22:27:04+00:00', 'Analysing wind data with R', 'grit', 678047687, -1478134144, -491938169, 3, '2022-01-13 07:24:35+00:00', '2023-08-04 05:42:30+00:00', 1792827279, '2025-05-18 14:45:15+00:00', '4301jh3den8', 'c68x8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -2072838897, -1173368267, '2025-01-04 09:05:19+00:00', -1950324754, 2115816682, '7z2zezjo7wg', 0, '2023-03-07 00:15:11+00:00', 'Analysing wind data with R', '5', -526612570, -546516406, -405743609, 0, '2020-06-02 03:52:50+00:00', '2020-11-20 06:56:49+00:00', -20116244, '2023-11-26 16:36:47+00:00', 'q5l', 'pim5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 872694102, 618058035, '2022-09-17 08:42:23+00:00', -229022515, -1817527403, '78lfvyz7zz', 1, '2025-05-30 03:33:11+00:00', 'Analysing wind data with R', 'be8yvkv42q', 79330142, 1735561423, 756202403, 3, '2025-11-05 01:55:16+00:00', '2024-07-28 06:33:48+00:00', 782684333, '2024-01-18 21:37:49+00:00', 'pmaus3auvmkr', 'pdjwzw5chn9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -1514700303, -1796351243, '2020-09-13 06:13:20+00:00', -634585028, 1719800120, 'o', 1, '2023-11-02 10:05:42+00:00', 'Analysing wind data with R', 'obb0q0k', 575038073, -1161141730, -613916489, 3, '2021-07-10 06:02:47+00:00', '2024-03-21 20:48:17+00:00', 364043263, '2024-10-31 01:49:19+00:00', 'orlwy', 'gc1d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -499913447, -360096930, '2020-05-28 05:20:14+00:00', 1435223075, 1617348603, 'yxuzk', 1, '2020-03-04 20:06:24+00:00', 'Analysing wind data with R', '521gwnlas6e', 1468640756, 1048147204, -1814875250, 0, '2022-12-20 18:28:11+00:00', '2021-02-07 13:23:16+00:00', -1610380698, '2023-05-07 14:15:39+00:00', 'nxih662q', 'xlyotow9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 966412849, -2061634386, '2022-07-26 21:24:54+00:00', 868039568, 503053726, 'z', 1, '2023-12-20 17:13:08+00:00', 'Analysing wind data with R', 'tajz9td8n', -625404808, -1694533100, -1275298282, 1, '2020-04-18 15:13:13+00:00', '2025-11-17 06:38:18+00:00', 1295379066, '2020-05-27 07:55:45+00:00', 'w9603vz', 'xw1rxe9yfk7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 956819642, 774922170, '2023-03-25 22:22:29+00:00', -141591627, 440797047, 'vu', 1, '2023-07-30 22:23:05+00:00', 'Analysing wind data with R', 'dza35rmki', -1160642134, 769234989, 168442149, 1, '2025-03-31 02:33:27+00:00', '2022-08-22 09:26:04+00:00', 2066302536, '2024-04-19 20:17:36+00:00', 'wt', 'xxnja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 2, '2020-03-11 00:23:16+00:00', 't2__1cdf93', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 4, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 5, '2020-03-11 00:23:16+00:00', 'Analysing wind data with R', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -2081315180, 1909986641, '2023-01-13 04:58:30+00:00', -511185946, -1021749117, '3pyu78d99r', 6, '2021-07-21 20:51:39+00:00', 'Analysing wind data with R', 'sl0', -2031361952, 1649269347, -1116181514, 5, '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', -227162283, '2021-05-26 08:15:06+00:00', '9v', 'x58pz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1581736075, -261132974, '2021-09-30 11:37:26+00:00', 1968874827, -664193365, 'cx5hn', 7, '2020-05-10 07:36:02+00:00', 'Analysing wind data with R', 'rjtu', -361507387, 401805964, -1485777725, -2147483643, '2022-03-23 04:34:16+00:00', '2024-08-10 07:57:32+00:00', -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', 'ozk3zbily');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__594eac', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1106983592, '2022-06-06 01:51:46+00:00', 't1__594eac', '2024-04-01 02:40:29+00:00', 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', -305670381, -1525670226, -453362185, 481163439, 2123196517, 'dwyrq13pyu78');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -988981234, '1970-01-01 00:00:01+00:00', 't1__594eac', '2022-08-03 01:56:16+00:00', '0dz79f', 'gq8', 'n2f3dqv0gcb9', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1038566008, '1970-01-01 00:00:00+00:00', 't1__6ca616', '2025-03-26 10:17:14+00:00', 'n6vck6ah0f8', 'sww', 'q7x', -541746689, 1294666887, -515895469, 1427161052, 564390026, '6nijjai5dh');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 687330820, '1970-01-01 00:00:00+00:00', 't1__6ca616', '2023-10-23 03:02:26+00:00', 'fx7h', '3p6sto1c', '8sh', -63214972, 1106724223, 1966809332, 1487347213, 1328948152, '1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, 1122899168, '1970-01-01 00:00:00+00:00', 't1__6ca616', '2023-12-07 21:40:21+00:00', '1', 'v4ygmayq3', 'dpuap', -845136979, -1042976410, -1670945624, 555368535, -1369148652, '7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, -1685482179, '1970-01-01 00:00:00+00:00', 't1__6ca616', '2021-06-30 19:59:42+00:00', 'u', 'qb9i9f2ccu', 'jq1', 1584429327, -1575692857, 1570917601, 775289854, -2052350430, 'hlst1pqom');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 373262291, '2023-04-26 07:28:40+00:00', '5s5b', '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -472966518, '2024-02-28 04:46:49+00:00', '5bbp0', '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 't3__b751d3', '2025-10-19 18:29:54+00:00', 1, 'rofqy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 580968159, 't3__b751d3', '2021-10-14 14:41:11+00:00', 3, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, 1, -47052816, 't3__c7af10', '2025-07-13 05:36:35+00:00', 1, 'of77pzo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, 1870300798, 't3__c7af10', '2024-03-11 08:01:44+00:00', 0, 'q8qdjpe1io22');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, 453836040, 't3__c7af10', '2020-11-29 15:34:58+00:00', -1, 'bnou5zi36');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 418247369, 't3__c7af10', '2021-03-26 16:58:48+00:00', 3, 'la3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, 729543907, 't3__c7af10', '2020-01-28 22:49:30+00:00', 1, 'h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, -1260548409, 't3__c7af10', '2021-10-14 23:04:20+00:00', -2147483643, 'p490xdmsqt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, 1793241362, 't3__c7af10', '2020-02-24 04:19:02+00:00', -1, 'm4iz78aqq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 2, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', 2, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 3, -511185946, '13pyu', '2024-06-05 19:22:34+00:00', -2147483643, 'd99rljsl0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 4, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', 2, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 2, 1, NULL, '2024-06-15 00:00:00+00:00', -2147483644, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 5, 836513442, '8jegd21vy9ux', '2024-12-23 02:48:29+00:00', -2147483642, '4hw');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 1, 1, NULL, '2024-06-15 00:00:00+00:00', 1, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 6, 1038566008, 'n6vck6ah0f', '2024-07-11 21:09:52+00:00', -2147483644, 'sww');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('n6vck6ah0f', None)
*/

-- Prediction Query
SELECT c.Text, c.UserDisplayName FROM posts AS p JOIN comments AS c ON p.Id = c.PostId WHERE p.Title = 'Analysing wind data with R' ORDER BY c.CreationDate DESC, p.id NULLS LAST, c.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('t3__b751d3', 'rofqy')
('t3__c7af10', 'of77pzo')
('8jegd21vy9ux', '4hw')
('n6vck6ah0f', 'sww')
(None, 'value')
('t3__c7af10', 'q8qdjpe1io22')
('um5', 'zbuo4nrqrof')
('t3__c7af10', 'p490xdmsqt')
('t3__b751d3', 'p')
('t3__c7af10', 'la3')
*/