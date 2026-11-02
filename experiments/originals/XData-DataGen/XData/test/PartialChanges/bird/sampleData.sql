-- 1) Majors
INSERT INTO major (major_id, major_name, department, college) VALUES
  ('MJR1',  'Engineering',      'Electrical & Computer Engineering Dept.', 'College of Engineering'),
  ('MJR2',  'Biology',          'Biological Sciences Dept.',             'College of Science'),
  ('MJR3',  'History',          'History Dept.',                         'College of Humanities'),
  ('MJR4',  'Business',         'Business Administration Dept.',         'School of Business'),
  ('MJR5',  'Psychology',       'Psychology Dept.',                      'College of Education'),
  ('MJR6',  'Mathematics',      'Mathematics Dept.',                     'College of Science'),
  ('MJR7',  'Art',              'Fine Arts Dept.',                       'College of Arts'),
  ('MJR8',  'Computer Sci.',    'Computer Science Dept.',                'College of Engineering'),
  ('MJR9',  'Physics',          'Physics Dept.',                         'College of Science'),
  ('MJR10', 'Sociology',        'Sociology Dept.',                       'College of Humanities');

-- 2) Members
INSERT INTO member
  (member_id, first_name, last_name, email, "position", t_shirt_size, phone, zip, link_to_major) VALUES
  ('MEM1',  'Alice',    'Anderson',   'alice@uni.edu',   'Member',    'M',   '555-0101', 10001, 'MJR1'),
  ('MEM2',  'Bob',      'Brown',      'bob@uni.edu',     'Treasurer', 'L',   '555-0102', 10002, 'MJR2'),
  ('MEM3',  'Charlie',  'Clark',      'charlie@uni.edu', 'Member',    'S',   '555-0103', 10003, 'MJR3'),
  ('MEM4',  'Dana',     'Davis',      'dana@uni.edu',    'Member',    'XL',  '555-0104', 10004, 'MJR4'),
  ('MEM5',  'Evan',     'Evans',      'evan@uni.edu',    'President', 'L',   '555-0105', 10005, 'MJR5'),
  ('MEM6',  'Fiona',    'Frost',      'fiona@uni.edu',   'Member',    'M',   '555-0106', 10006, 'MJR6'),
  ('MEM7',  'George',   'Green',      'george@uni.edu',  'Member',    'M',   '555-0107', 10007, 'MJR7'),
  ('MEM8',  'Hannah',   'Hughes',     'hannah@uni.edu',  'Secretary', 'S',   '555-0108', 10008, 'MJR8'),
  ('MEM9',  'Ian',      'Irwin',      'ian@uni.edu',     'Member',    'L',   '555-0109', 10009, 'MJR9'),
  ('MEM10', 'Julia',    'Jones',      'julia@uni.edu',   'Member',    'XL',  '555-0110', 10010, 'MJR10');

-- 3) Events
INSERT INTO event
  (event_id, event_name, event_date, type, notes, location, status) VALUES
  ('EVT1',  'Hackathon',         '2025-09-15T09:00:00', 'Competition', '24h coding event',   'Lab A',      'Planned'),
  ('EVT2',  'Guest Lecture',     '2025-10-01T14:00:00', 'Seminar',     'AI in Healthcare',   'Auditorium', 'Open'),
  ('EVT3',  'Career Fair',       '2025-11-10T10:00:00', 'Fair',        'Meet top employers', 'Gym',        'Open'),
  ('EVT4',  'Art Exhibition',    '2025-08-20T17:00:00', 'Exhibit',     'Student artwork',    'Gallery',    'Closed'),
  ('EVT5',  'Music Concert',     '2025-12-05T19:00:00', 'Concert',     'Winter showcase',    'Hall B',     'Planned'),
  ('EVT6',  'Volunteer Day',     '2025-07-25T08:00:00', 'Community',   'Park cleanup',       'Central Park','Open'),
  ('EVT7',  'Alumni Meetup',     '2025-09-30T18:00:00', 'Social',      'Networking',         'Cafe 101',   'Open'),
  ('EVT8',  'Workshop: Robotics','2025-10-15T13:00:00','Workshop',    'Build simple bots',  'Lab B',      'Planned'),
  ('EVT9',  'Film Screening',    '2025-11-20T20:00:00','Screening',   'Indie films',        'Theater',    'Closed'),
  ('EVT10', 'Science Fair',      '2025-12-12T09:00:00','Exhibition',  'Student projects',   'Expo Hall',  'Open');

-- 4) Budgets
INSERT INTO budget
  (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES
  ('BUD1',  'Food',          200.00,  300.00, 500, 'Open',    'EVT1'),
  ('BUD2',  'Speakers',      150.00,   50.00, 200, 'Open',    'EVT2'),
  ('BUD3',  'Stalls',        100.00,  400.00, 500, 'Open',    'EVT3'),
  ('BUD4',  'Artwork',        50.00,  150.00, 200, 'Closed',  'EVT4'),
  ('BUD5',  'Sound System',  300.00,  200.00, 500, 'Planned', 'EVT5'),
  ('BUD6',  'Equipment',      80.00,  120.00, 200, 'Open',    'EVT6'),
  ('BUD7',  'Venue',         400.00,  100.00, 500, 'Open',    'EVT7'),
  ('BUD8',  'Materials',     120.00,  180.00, 300, 'Planned', 'EVT8'),
  ('BUD9',  'Licensing',      60.00,   40.00, 100, 'Closed',  'EVT9'),
  ('BUD10', 'Prizes',         90.00,  110.00, 200, 'Open',    'EVT10');

-- 5) Expenses
INSERT INTO expense
  (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES
  ('EXP1',  'Pizza for coding',      '2025-09-15T09:00:00',150.00,'true',  'MEM1',  'BUD1'),
  ('EXP2',  'Keynote honorarium',    '2025-10-01T14:00:00',100.00,'true',  'MEM2',  'BUD2'),
  ('EXP3',  'Booth setup',           '2025-11-10T10:00:00', 80.00,'false', 'MEM3',  'BUD3'),
  ('EXP4',  'Frame materials',       '2025-08-20T17:00:00', 45.00,'true',  'MEM4',  'BUD4'),
  ('EXP5',  'PA rental',             '2025-12-05T19:00:00',250.00,'false', 'MEM5',  'BUD5'),
  ('EXP6',  'Gloves & trash bags',   '2025-07-25T08:00:00', 60.00,'true',  'MEM6',  'BUD6'),
  ('EXP7',  'Coffee & snacks',       '2025-09-30T18:00:00',120.00,'true',  'MEM7',  'BUD7'),
  ('EXP8',  'Robot kits',            '2025-10-15T13:00:00',180.00,'false', 'MEM8',  'BUD8'),
  ('EXP9',  'Screening license',     '2025-11-20T20:00:00', 40.00,'true',  'MEM9',  'BUD9'),
  ('EXP10', 'Fair trophies',         '2025-12-12T09:00:00', 90.00,'true',  'MEM10', 'BUD10');

-- 6) Attendance
INSERT INTO attendance (link_to_event, link_to_member) VALUES
  ('EVT1',  'MEM1'),
  ('EVT2',  'MEM2'),
  ('EVT3',  'MEM3'),
  ('EVT4',  'MEM4'),
  ('EVT5',  'MEM5'),
  ('EVT6',  'MEM6'),
  ('EVT7',  'MEM7'),
  ('EVT8',  'MEM8'),
  ('EVT9',  'MEM9'),
  ('EVT10', 'MEM10');
