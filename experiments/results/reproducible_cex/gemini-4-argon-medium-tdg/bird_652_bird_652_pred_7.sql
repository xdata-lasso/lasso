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
-- DATASET 1
-- Tests basic positive match, join condition on UserId vs Id, and table column confusions (e.g., users.DisplayName vs postHistory.UserDisplayName, badges.Name vs UserDisplayName, posts.OwnerDisplayName).
INSERT INTO users (Id, DisplayName, CreationDate) VALUES (1, 'NotSamuel', '2010-01-01 00:00:00');
INSERT INTO users (Id, DisplayName, CreationDate) VALUES (2, 'Samuel', '2013-01-01 00:00:00');
INSERT INTO posts (Id, OwnerUserId, OwnerDisplayName, CreaionDate) VALUES (100, 2, 'Samuel', '2013-01-01 00:00:00');
INSERT INTO posts (Id, OwnerUserId, OwnerDisplayName, CreaionDate) VALUES (101, 1, 'NotSamuel', '2013-01-01 00:00:00');
-- Valid match: UserId=1, UserDisplayName='Samuel', Year=2013
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate, Text, Comment) VALUES (10, 100, 1, 'Samuel', '2013-05-15 12:30:00', 'HistoryText', 'HistoryComment');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (20, 1, 'Scholar', '2013-08-20 09:15:00');
-- Trap for joining on T1.Id = T2.Id or T1.UserId = users.Id where users.DisplayName = 'Samuel'
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (20, 101, 2, 'OtherName', '2013-05-15 12:30:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 2, 'Samuel', '2013-08-20 09:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(100, 'Scholar')
*/

-- Prediction Query
SELECT T2.PostId, T1.Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = T2.UserId INNER JOIN users AS T3 ON T2.UserId = T3.Id WHERE T3.DisplayName = 'Samuel' AND STRFTIME('%Y', T2.CreationDate) = '2013' AND STRFTIME('%Y', T1.Date) = '2013';

/*
Prediction Result:
*/