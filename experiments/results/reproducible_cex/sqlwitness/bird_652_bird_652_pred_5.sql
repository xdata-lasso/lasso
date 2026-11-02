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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 01:00:00.000000', 'Samuel', '2013-01-01 00:00:00.000000', 'default1', '%Y', '2013', 1, 1, NULL, 1, NULL, '2013-12-31'), (0, 0, '2013-10-27 00:00:00.000000', 'Samuel', '2023-01-01 01:00:00.000000', '2013-12-31', '%Y', NULL, 0, 1, 0, 0, 1, 'default2'), (2, 1, '2013-12-31 00:00:00.000000', '2013', NULL, 'Samuel', NULL, 'default2', NULL, NULL, 0, 0, 0, '2013-12-31'), (3, 1, NULL, '2013', '2023-01-01 00:00:00.000000', '2013-12-31', '2013', 'default2', 1, 1, 1, NULL, NULL, 'Samuel'), (4, 1, '2013-10-27 00:00:00.000000', '2013-01-01', '2023-01-01 00:00:00.000000', '%Y', '%Y', 'default2', 0, NULL, 1, 0, 0, 'default1'), (5, 1, '2023-01-01 01:00:00.000000', '2013', '2013-12-31 00:00:00.000000', '2013-01-01', 'default2', NULL, 0, NULL, 1, 1, 0, '%Y'), (6, 0, '2013-10-27 00:00:00.000000', 'Samuel', '2013-12-31 00:00:00.000000', '2013', '%Y', '2013-12-31', 1, 1, NULL, 1, 0, 'Samuel'), (7, 0, '2013-01-01 00:00:00.000000', 'Samuel', '2013-12-31 00:00:00.000000', 'Samuel', 'default2', 'default2', 0, NULL, 0, 1, 1, '2013');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, NULL, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', '2013', '2013-01-01', '2013-01-01'), (0, NULL, NULL, NULL, '2013-01-01', '2013-12-31 00:00:00.000000', '2013', '2013-12-31', NULL), (2, NULL, 7, 1, 'default1', '2013-01-01 00:00:00.000000', 'default2', 'Samuel', 'default1'), (3, NULL, 7, NULL, '2013-12-31', NULL, '2013-12-31', 'default2', '2013'), (4, NULL, NULL, NULL, '2013-01-01', '2013-12-31 00:00:00.000000', 'Samuel', '%Y', 'Samuel'), (5, NULL, 2, 1, 'Samuel', '2013-10-27 00:00:00.000000', 'default2', 'default1', '2013'), (6, NULL, 3, NULL, NULL, '2013-12-31 00:00:00.000000', 'default1', 'default2', '2013-01-01'), (7, NULL, 6, NULL, 'default1', NULL, '2013-01-01', '2013-12-31', 'default1'), (8, NULL, NULL, 0, '2013', NULL, 'default1', 'Samuel', '2013'), (9, NULL, 7, 0, '%Y', '2013-12-31 00:00:00.000000', NULL, 'default1', '2013-12-31'), (10, NULL, 5, 1, 'Samuel', '2013-12-31 00:00:00.000000', '2013', 'Samuel', '2013'), (11, NULL, 7, NULL, '2013-12-31', '2013-10-27 00:00:00.000000', NULL, '2013-12-31', 'default2'), (12, NULL, 3, 0, 'default1', '2013-10-27 00:00:00.000000', 'Samuel', '2013-01-01', 'default2'), (13, NULL, 0, 1, '2013', '2013-01-01 00:00:00.000000', NULL, '2013-01-01', '%Y'), (14, NULL, 1, NULL, '2013-01-01', '2013-12-31 00:00:00.000000', 'Samuel', 'default1', 'default2'), (15, NULL, 3, NULL, '2013-01-01', NULL, 'Samuel', '2013-01-01', NULL), (16, NULL, 4, 1, '2013-12-31', '2013-01-01 00:00:00.000000', '2013-12-31', 'default2', 'Samuel');
INSERT INTO badges (id, userid, name, date) VALUES (1, NULL, NULL, '2013-01-01 00:00:00.000000'), (0, 1, '2013-12-31', '2013-10-27 00:00:00.000000'), (2, 3, 'default1', '2023-01-01 00:00:00.000000'), (3, 5, 'Samuel', '2013-01-01 00:00:00.000000'), (4, 4, '2013-12-31', '2013-12-31 00:00:00.000000'), (5, 4, 'default1', '2013-01-01 00:00:00.000000'), (6, NULL, 'default2', '2013-01-01 00:00:00.000000'), (7, 0, 'default2', '2023-01-01 01:00:00.000000'), (8, 6, '%Y', '2023-01-01 00:00:00.000000'), (9, 0, '2013', '2013-01-01 00:00:00.000000'), (10, 4, 'default1', NULL), (11, 1, 'Samuel', '2023-01-01 01:00:00.000000'), (12, 6, '%Y', '2013-01-01 00:00:00.000000'), (13, 5, 'Samuel', '2023-01-01 00:00:00.000000'), (14, 7, 'default1', '2023-01-01 01:00:00.000000'), (15, 2, NULL, '2023-01-01 01:00:00.000000'), (16, 0, '2013-01-01', '2013-12-31 00:00:00.000000'), (17, 4, 'default1', '2013-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(None, '2013-12-31')
(None, 'default1')
(None, 'default1')
*/

-- Prediction Query
SELECT postHistory.PostId, badges.Name FROM users INNER JOIN postHistory ON users.Id = postHistory.UserId INNER JOIN badges ON users.Id = badges.UserId WHERE users.DisplayName = 'Samuel' AND postHistory.CreationDate BETWEEN '2013-01-01' AND '2013-12-31' AND badges.Date BETWEEN '2013-01-01' AND '2013-12-31';

/*
Prediction Result:
(None, '2013')
*/