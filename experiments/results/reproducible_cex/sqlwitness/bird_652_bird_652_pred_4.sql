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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default2', '%Y', 'Samuel', NULL, NULL, 0, 1, NULL, 'default1'), (0, 1, '2013-10-27 00:00:00.000000', 'default2', '2013-10-27 00:00:00.000000', 'Samuel', '%Y', 'default2', NULL, 0, 0, NULL, NULL, '%Y'), (2, NULL, NULL, 'Samuel', '2023-01-01 01:00:00.000000', 'default1', 'default2', '%Y', 0, 1, 1, 1, 1, NULL), (3, NULL, '2013-10-27 00:00:00.000000', 'Samuel', '2023-01-01 00:00:00.000000', 'default1', 'Samuel', NULL, 1, 0, 0, NULL, 0, '%Y'), (4, NULL, NULL, 'Samuel', '2013-10-27 00:00:00.000000', NULL, NULL, 'Samuel', 0, 1, 0, 0, 0, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 2, 1, NULL, 1, '2023-01-01 01:00:00.000000', 0, NULL, '%Y', NULL, '2013', NULL, 0, NULL, NULL, '2023-01-01 00:00:00.000000', '2013-10-27 00:00:00.000000', 0, '2013-10-27 00:00:00.000000', NULL, 'Samuel'), (0, 4, 1, 0, 1, NULL, 1, 0, 'Samuel', '2023-01-01 01:00:00.000000', 'default2', '2013', NULL, 0, 1, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'default1', '%Y'), (2, 3, 1, 0, 1, '2023-01-01 00:00:00.000000', NULL, NULL, '%Y', '2013-10-27 00:00:00.000000', '%Y', 'default2', NULL, 0, 0, '2013-10-27 00:00:00.000000', '2013-10-27 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default1', 'Samuel'), (3, NULL, 2, 0, NULL, NULL, 1, 1, 'Samuel', '2013-10-27 00:00:00.000000', '%Y', '%Y', NULL, NULL, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, NULL, '%Y', NULL);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, 1, 1, NULL, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', '%Y'), (0, 2, NULL, 0, NULL, '2013-10-27 00:00:00.000000', '2013', 'Samuel', '%Y'), (2, 3, 1, 0, 'default1', NULL, 'default2', 'default2', 'Samuel'), (3, 2, NULL, 1, '2013', '2023-01-01 00:00:00.000000', '%Y', 'default2', NULL), (4, 1, NULL, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, '2013', 'Samuel'), (5, 3, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', NULL, 'Samuel', 'default2'), (6, 3, 0, 0, 'Samuel', '2013-10-27 00:00:00.000000', NULL, 'Samuel', 'Samuel');
INSERT INTO badges (id, userid, name, date) VALUES (0, 2, NULL, '2013-10-27 00:00:00.000000'), (1, 1, NULL, '2013-10-27 00:00:00.000000'), (2, 1, '2013', NULL), (3, 0, 'Samuel', '2013-10-27 00:00:00.000000'), (4, NULL, 'Samuel', '2013-10-27 00:00:00.000000'), (5, 4, NULL, '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(3, 'Samuel')
*/

-- Prediction Query
SELECT T1.Id, T2.Name FROM posts AS T1 INNER JOIN badges AS T2 ON T1.OwnerUserId = T2.UserId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreaionDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Prediction Result:
*/