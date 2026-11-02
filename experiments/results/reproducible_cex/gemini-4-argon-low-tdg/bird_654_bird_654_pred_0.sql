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
-- Tests basic matching path alongside wrong-column join mutants (WikiPostId vs ExcerptPostId, LastEditorUserId vs OwnerUserId, ParentId, AcceptedAnswerId, Tag.Id vs Post.Id) and wrong-table projection mutants (OwnerDisplayName, LastEditorDisplayName).
INSERT INTO users (Id, DisplayName, Location) VALUES (1, 'CorrectOwner', 'CorrectLocation');
INSERT INTO users (Id, DisplayName, Location) VALUES (2, 'WrongEditor', 'WrongEditorLoc');
INSERT INTO users (Id, DisplayName, Location) VALUES (3, 'WikiOwner', 'WikiLoc');
INSERT INTO users (Id, DisplayName, Location) VALUES (10, 'IdMatchUser', 'IdMatchLoc');
INSERT INTO users (Id, DisplayName, Location) VALUES (100, 'PostIdMatchUser', 'PostIdMatchLoc');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, OwnerDisplayName, LastEditorDisplayName, Tags) VALUES (10, 3, 3, 3, 3, 'Post10OwnerDisp', 'Post10EditorDisp', '<hypothesis-testing>');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, OwnerDisplayName, LastEditorDisplayName, Tags) VALUES (100, 1, 2, 2, 2, 'WrongOwnerDisp', 'WrongEditorDisp', '<other-tag>');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, OwnerDisplayName, LastEditorDisplayName, Tags) VALUES (200, 3, 1, 1, 1, 'WikiOwnerDisp', 'WikiEditorDisp', 'hypothesis-testing');
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (10, 'hypothesis-testing', 100, 100, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.DisplayName, T3.Location FROM tags AS T1 INNER JOIN posts AS T2 ON T1.ExcerptPostId = T2.Id INNER JOIN users AS T3 ON T3.Id = T2.OwnerUserId WHERE T1.TagName = 'hypothesis-testing';

/*
Gold Result:
('CorrectOwner', 'CorrectLocation')
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Location FROM tags AS T1 INNER JOIN users AS T2 ON T1.ExcerptPostId = T2.Id WHERE T1.TagName = 'hypothesis-testing';

/*
Prediction Result:
('PostIdMatchUser', 'PostIdMatchLoc')
*/