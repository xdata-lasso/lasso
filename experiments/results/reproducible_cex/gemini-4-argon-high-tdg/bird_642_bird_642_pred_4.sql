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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (10, 100, '2009-01-01 00:00:00', 'Alice');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId, Title) VALUES (20, 1, '2009-05-01 00:00:00', 5, 10, 'Sample Post');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (101, 2, 20, 'guid-1', '2010-07-21 00:00:00', 10, 'Initial text', 'First edit', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (102, 2, 20, 'guid-2', '2010-07-21 14:23:45', 10, 'Updated text', 'Second edit', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (103, 2, 20, 'guid-3', '2010-07-21 23:59:59', 10, 'Final text', 'Third edit', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (104, 2, 20, 'guid-4', '2010-07-21', 10, 'Date only text', 'Fourth edit', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (105, 2, 20, 'guid-5', '2010-07-20 23:59:59', 10, 'Previous day', 'Before boundary', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (106, 2, 20, 'guid-6', '2010-07-22 00:00:00', 10, 'Next day', 'After boundary', 'Alice');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (107, 2, 20, 'guid-7', NULL, 10, 'Null date', 'No date', 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(id) FROM postHistory WHERE DATE(CreationDate) = '2010-07-21';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM posts WHERE STRFTIME('%Y-%m-%d', CreaionDate) = '2010-07-21';

/*
Prediction Result:
(0,)
*/