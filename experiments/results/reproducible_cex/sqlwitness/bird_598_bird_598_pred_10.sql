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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (-1, 99, '2023-01-01 00:00:00.000000', NULL, NULL, '%Y', 'default1', 'Student', NULL, 100, -1, -1, NULL, 'default2'), (99, 1, '2023-01-01 01:00:00.000000', 'default2', '2010-10-27 00:00:00.000000', 'Student', 'Student', '%Y', 101, 101, 1, -1, 99, '%Y'), (101, 2, NULL, 'default2', '2010-10-27 00:00:00.000000', 'default1', '2011', '2011', 1, 1, 0, 101, 2, '%Y'), (1, 100, '2023-01-01 00:00:00.000000', NULL, '2011-10-27 00:00:00.000000', '2011', '%Y', 'default2', 2, -1, 0, 1, -1, 'default1'), (2, -1, '2010-10-27 00:00:00.000000', '%Y', '2023-01-01 00:00:00.000000', 'Student', 'default2', 'default2', 99, 2, 0, 2, NULL, 'Student'), (0, 1, '2023-01-01 00:00:00.000000', NULL, '2011-10-27 00:00:00.000000', '2010', 'default2', '2010', 2, 0, 99, 101, NULL, '%Y'), (100, 2, NULL, NULL, NULL, 'Student', 'Student', NULL, 2, 2, 2, 1, NULL, '2010'), (3, 101, '2023-01-01 01:00:00.000000', '2010', '2023-01-01 00:00:00.000000', '%Y', 'Student', NULL, NULL, NULL, 99, 1, 2, NULL), (4, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', '2010', '2011', '2011', 2, NULL, 1, 101, -1, '2010');
INSERT INTO badges (id, userid, name, date) VALUES (100, NULL, '2011', '2010-10-27 00:00:00.000000'), (101, 0, '2010', '2010-10-27 00:00:00.000000'), (0, 99, 'default1', NULL), (99, 1, '2011', '2010-10-27 00:00:00.000000'), (-1, NULL, '%Y', '2010-10-27 00:00:00.000000'), (1, 1, NULL, NULL), (2, 4, 'Student', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', Date) = '2010', 1, 0)) AS REAL) * 100 / COUNT(Id) - CAST(SUM(IIF(STRFTIME('%Y', Date) = '2011', 1, 0)) AS REAL) * 100 / COUNT(Id) FROM badges WHERE Name = 'Student';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ((CAST(SUM(CASE WHEN STRFTIME('%Y', Date) = '2010' THEN 1 ELSE 0 END) AS REAL) / COUNT(Date)) - (CAST(SUM(CASE WHEN STRFTIME('%Y', Date) = '2011' THEN 1 ELSE 0 END) AS REAL) / COUNT(Date))) * 100 AS PercentageDifference FROM badges WHERE Name = 'Student';

/*
Prediction Result:
(None,)
*/