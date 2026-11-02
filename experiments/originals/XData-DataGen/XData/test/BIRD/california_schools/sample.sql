INSERT INTO school (cdscode, school, city, state, zip, charter, opendate, lastupdate) VALUES 
('01611760130229', 'Alameda High', 'Alameda', 'CA', '94501', 0, '1980-09-01', '2023-01-15'),
('19647331933639', 'Beverly Hills High', 'Beverly Hills', 'CA', '90212', 0, '1927-11-01', '2023-02-10'),
('38684783834603', 'Lowell High', 'San Francisco', 'CA', '94132', 0, '1856-08-25', '2023-03-05');

INSERT INTO satscore (cdscode, sname, enroll12c, numtsttakr, avgscrread, avgscrmath, avgscrwrite) VALUES 
('01611760130229', 'Alameda High', 400, 250, 580, 600, 570),
('19647331933639', 'Beverly Hills High', 350, 310, 620, 640, 630),
('38684783834603', 'Lowell High', 650, 600, 680, 710, 690);

INSERT INTO frpms (cdscode, AcademicYear, Enrollment, FreeMealCount, PercentEligibleFree, irc) VALUES 
('01611760130229', '2023-2024', 1850.0, 450.0, 24.3, 1),
('19647331933639', '2023-2024', 1200.0, 100.0, 8.3, 1),
('38684783834603', '2023-2024', 2700.0, 950.0, 35.1, 1);