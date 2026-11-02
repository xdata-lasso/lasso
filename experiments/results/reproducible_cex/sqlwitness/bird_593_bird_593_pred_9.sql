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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Teacher', 'New York', 'default1', 1, 1, NULL, NULL, NULL, NULL), (0, 0, '2023-01-01 00:00:00.000000', 'Teacher', '2023-01-01 00:00:00.000000', 'Teacher', 'New York', 'default2', NULL, 0, NULL, 0, 1, 'default2'), (2, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'New York', 'New York', 'New York', NULL, NULL, 1, 0, 0, 'Supporter'), (3, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', NULL, NULL, NULL, NULL, 1, NULL, 0, 'default2'), (4, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'New York', 'New York', 'default1', 0, NULL, 1, 1, 0, NULL), (5, NULL, '2023-01-01 00:00:00.000000', 'Teacher', NULL, 'New York', 'Teacher', 'Teacher', NULL, 0, NULL, 0, NULL, 'default2'), (6, 0, '2023-01-01 00:00:00.000000', 'New York', NULL, NULL, 'Teacher', NULL, NULL, NULL, 1, 0, 0, 'default2'), (7, NULL, '2023-01-01 01:00:00.000000', 'Teacher', '2023-01-01 00:00:00.000000', 'New York', 'Supporter', 'default2', NULL, 1, 1, NULL, NULL, 'default1');
INSERT INTO badges (id, userid, name, date) VALUES (0, NULL, 'Teacher', NULL), (1, 7, 'New York', '2023-01-01 01:00:00.000000'), (2, 5, 'Supporter', '2023-01-01 01:00:00.000000'), (3, 1, 'Teacher', NULL), (4, 2, 'default1', '2023-01-01 01:00:00.000000'), (5, 6, 'Teacher', '2023-01-01 01:00:00.000000'), (6, 5, 'Teacher', '2023-01-01 01:00:00.000000'), (7, 7, 'New York', '2023-01-01 01:00:00.000000'), (8, 7, 'New York', NULL), (9, 4, 'default2', '2023-01-01 01:00:00.000000'), (10, 4, NULL, NULL), (11, 5, 'default2', NULL), (12, 4, 'default2', NULL), (13, 7, 'Supporter', '2023-01-01 01:00:00.000000'), (14, NULL, NULL, '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Name IN ('Supporter', 'Teacher') AND T2.Location = 'New York';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT u.Id) FROM users AS u JOIN badges AS b1 ON u.Id = b1.UserId AND b1.Name = 'Supporter' JOIN badges AS b2 ON u.Id = b2.UserId AND b2.Name = 'Teacher' WHERE u.Location = 'New York';

/*
Prediction Result:
(0,)
*/