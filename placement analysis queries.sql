-- ============================================
-- CAMPUS PLACEMENT ANALYTICS PROJECT
-- SQL ANALYSIS QUERIES
-- Developed by B. Siva Sai Aswath
-- ============================================



-- ============================================
-- BASIC ANALYSIS QUERIES
-- ============================================


-- 1. TOTAL NUMBER OF STUDENTS

SELECT COUNT(*) AS total_students
FROM students;



-- 2. SHOW UNIQUE DEPARTMENTS

SELECT DISTINCT department
FROM students;



-- 3. STUDENTS WITH CGPA ABOVE 8

SELECT student_id,
       student_name,
       cgpa
FROM students
WHERE cgpa > 8;



-- 4. STUDENTS WITH LOW COMMUNICATION SKILL

SELECT student_id,
       student_name,
       communication_skill
FROM students
WHERE communication_skill < 2;



-- 5. AVERAGE CGPA OF STUDENTS

SELECT AVG(cgpa) AS average_cgpa
FROM students;



-- 6. HIGHEST SALARY PACKAGE

SELECT MAX(package_lpa) AS highest_package
FROM placements;



-- 7. LOWEST SALARY PACKAGE

SELECT MIN(package_lpa) AS lowest_package
FROM placements;



-- 8. AVERAGE SALARY PACKAGE

SELECT AVG(package_lpa) AS average_package
FROM placements;



-- 9. TOTAL PLACED STUDENTS

SELECT COUNT(*) AS placed_students
FROM placements
WHERE placement_status = 'Placed';



-- 10. TOTAL UNPLACED STUDENTS

SELECT COUNT(*) AS unplaced_students
FROM placements
WHERE placement_status = 'Not Placed';




-- ============================================
-- GROUP BY & BUSINESS ANALYSIS QUERIES
-- ============================================


-- 11. TOTAL STUDENTS BY DEPARTMENT

SELECT department,
       COUNT(*) AS total_students
FROM students
GROUP BY department;



-- 12. AVERAGE CGPA BY DEPARTMENT

SELECT department,
       AVG(cgpa) AS average_cgpa
FROM students
GROUP BY department;



-- 13. AVERAGE SQL SKILL BY DEPARTMENT

SELECT department,
       AVG(sql_skill) AS avg_sql_skill
FROM students
GROUP BY department;



-- 14. AVERAGE COMMUNICATION SKILL BY DEPARTMENT

SELECT department,
       AVG(communication_skill) AS avg_communication_skill
FROM students
GROUP BY department;



-- 15. PLACED STUDENTS BY DEPARTMENT

SELECT s.department,
       COUNT(*) AS placed_students
FROM students s
JOIN placements p
ON s.student_id = p.student_id
WHERE p.placement_status = 'Placed'
GROUP BY s.department;



-- 16. TOP HIRING COMPANIES

SELECT company_name,
       COUNT(*) AS total_hired
FROM placements
WHERE placement_status = 'Placed'
GROUP BY company_name
ORDER BY total_hired DESC;



-- 17. AVERAGE PACKAGE BY DEPARTMENT

SELECT s.department,
       AVG(p.package_lpa) AS avg_package
FROM students s
JOIN placements p
ON s.student_id = p.student_id
WHERE p.placement_status = 'Placed'
GROUP BY s.department
ORDER BY avg_package DESC;



-- 18. INTERNSHIP PARTICIPATION BY DEPARTMENT

SELECT s.department,
       COUNT(*) AS internship_students
FROM students s
JOIN internships i
ON s.student_id = i.student_id
WHERE i.internship_completed = 'Yes'
GROUP BY s.department;



-- 19. STUDENTS COUNT BY RISK CATEGORY

SELECT risk_category,
       COUNT(*) AS total_students
FROM students
GROUP BY risk_category;



-- 20. PLACEMENT STATUS DISTRIBUTION

SELECT placement_status,
       COUNT(*) AS total_students
FROM placements
GROUP BY placement_status;




-- ============================================
-- ADVANCED DATA ANALYST QUERIES
-- ============================================


-- 21. PERFORMANCE CATEGORY USING CASE STATEMENT

SELECT student_name,
       cgpa,
       CASE
           WHEN cgpa >= 8 THEN 'Excellent'
           WHEN cgpa >= 7 THEN 'Good'
           ELSE 'Needs Improvement'
       END AS performance_category
FROM students;



-- 22. STUDENTS WITH ABOVE AVERAGE CGPA

SELECT student_name,
       cgpa
FROM students
WHERE cgpa >
(
    SELECT AVG(cgpa)
    FROM students
);



-- 23. STUDENT WITH HIGHEST PACKAGE

SELECT s.student_name,
       p.package_lpa
FROM students s
JOIN placements p
ON s.student_id = p.student_id
WHERE p.package_lpa =
(
    SELECT MAX(package_lpa)
    FROM placements
);



-- 24. AVERAGE PACKAGE BASED ON INTERNSHIP STATUS

SELECT i.internship_completed,
       AVG(p.package_lpa) AS avg_package
FROM internships i
JOIN placements p
ON i.student_id = p.student_id
WHERE p.placement_status = 'Placed'
GROUP BY i.internship_completed;



-- 25. TOP 5 STUDENTS BY INTERVIEW SCORE

SELECT student_name,
       interview_score
FROM students
ORDER BY interview_score DESC
LIMIT 5;



-- 26. DEPARTMENTS WITH LOW SQL SKILLS

SELECT department,
       AVG(sql_skill) AS avg_sql_skill
FROM students
GROUP BY department
HAVING AVG(sql_skill) < 2;



-- 27. PLACEMENT PERCENTAGE BY DEPARTMENT

SELECT s.department,
       ROUND(
           SUM(
               CASE
                   WHEN p.placement_status = 'Placed'
                   THEN 1
                   ELSE 0
               END
           ) * 100.0 / COUNT(*),
           2
       ) AS placement_percentage
FROM students s
JOIN placements p
ON s.student_id = p.student_id
GROUP BY s.department;



-- 28. STUDENTS WITHOUT INTERNSHIP

SELECT s.student_name,
       s.department
FROM students s
JOIN internships i
ON s.student_id = i.student_id
WHERE i.internship_completed = 'No';



-- 29. HIGH RISK STUDENTS

SELECT student_name,
       cgpa,
       communication_skill
FROM students
WHERE cgpa < 6.5
AND communication_skill < 2;



-- 30. COMPANY-WISE AVERAGE PACKAGE

SELECT company_name,
       AVG(package_lpa) AS avg_package
FROM placements
WHERE placement_status = 'Placed'
GROUP BY company_name
ORDER BY avg_package DESC;