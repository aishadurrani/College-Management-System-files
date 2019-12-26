  use CollegeManagementSystem;


#A
SELECT department.name as 'Department Name',
           COUNT(course.id) as '# Courses'
FROM course 
JOIN department ON department.id = course.deptid
GROUP BY deptid 
ORDER BY COUNT(course.id) ASC;


#B
SELECT course.name as 'Course Name', 
           COUNT(student.id) as '# Students'
FROM student
JOIN  studentcourse ON student.id = studentcourse.studentid
JOIN course ON studentcourse.courseid = course.id
GROUP BY course.id
ORDER BY COUNT(student.id) DESC, course.name ASC;


#C1
SELECT course.name as 'Name of Course'
FROM course
LEFT JOIN facultycourse ON facultycourse.courseid = course.id
LEFT JOIN faculty ON facultycourse.facultyid = faculty.id
GROUP BY course.name
HAVING COUNT(faculty.id) = 0
ORDER BY course.name ASC;


#C2
SELECT course.name as 'Course Name', COUNT(student.id) as '# Students'
FROM course
LEFT JOIN studentcourse ON course.id = studentcourse.courseid
LEFT JOIN student ON studentcourse.studentid = student.id 
LEFT JOIN facultycourse ON course.id = facultycourse.courseid
GROUP BY course.name
HAVING COUNT(facultyid) = 0
ORDER BY COUNT(student.id) DESC, course.name ASC;


#D
SELECT COUNT(distinct student.id) as 'Students', YEAR(studentcourse.startdate) as 'Year'
FROM student 
JOIN studentcourse ON student.id = studentcourse.studentid
GROUP BY YEAR(studentcourse.startdate);


#E
SELECT COUNT(distinct student.id) as '# of Student', YEAR(studentcourse.startdate) as 'YEAR'
FROM student
JOIN studentcourse ON studentcourse.studentid = student.id
WHERE MONTH(startdate) = 8 
GROUP BY YEAR(startdate);


#F
SELECT student.firstname as 'First Name', student.lastname as 'Last Name', 
  COUNT(studentcourse.courseid) as 'Number of Courses'
FROM student
JOIN studentcourse ON student.id = studentcourse.studentid
JOIN course ON course.id = studentcourse.courseid
WHERE student.majorid = course.deptid
GROUP BY student.id
ORDER BY COUNT(studentcourse.courseid) ASC, student.lastname ASC;


#G
SELECT student.firstname as 'First Name', student.lastname as 'Last Name', ROUND(AVG(progress), 1) as 'Average Progress'
FROM student
JOIN studentcourse ON studentcourse.studentid = student.id
GROUP BY student.id 
HAVING AVG(progress) < 50
ORDER BY AVG(progress) DESC;


#H1
SELECT course.name as 'Course Name', AVG(studentcourse.progress) as 'Average Progress'
FROM course 
JOIN studentcourse ON course.id = courseid
GROUP BY course.id
ORDER BY 2 DESC;

#H2
SELECT MAX(average)
FROM
 (SELECT course.name as 'Course Name', AVG(studentcourse.progress) as Average
    FROM course 
    JOIN studentcourse ON course.id = studentcourse.courseid 
    GROUP BY course.id
    ORDER BY 2 DESC) as maver;
    
#H3
SELECT faculty.firstname as 'First Name', faculty.lastname as 'Last Name', AVG(studentcourse.progress) as Average
FROM faculty 
JOIN facultycourse ON faculty.id = facultycourse.facultyid
JOIN course ON facultycourse.courseid = course.id
JOIN studentcourse ON course.id = studentcourse.courseid 
WHERE facultycourse.courseid = studentcourse.courseid
GROUP BY faculty.id;


#H4
SELECT faculty.firstname as 'First Name', faculty.lastname as 'Last Name', AVG(studentcourse.progress) as Average
FROM faculty 
JOIN facultycourse ON faculty.id = facultycourse.facultyid
JOIN course ON facultycourse.courseid = course.id
JOIN studentcourse ON course.id = studentcourse.courseid 
WHERE facultycourse.courseid = studentcourse.courseid
GROUP BY faculty.id
HAVING  AVG(studentcourse.progress) >= 0.9* (
 SELECT MAX(average)
 FROM
  (SELECT course.name as 'Course Name', AVG(studentcourse.progress) as Average
  FROM course 
  JOIN studentcourse ON course.id = studentcourse.courseid 
  GROUP BY course.id
  ORDER BY 2 DESC) as maver);
       

# I
SELECT student.firstname as 'First Name', student.lastname as 'Last Name',
CASE WHEN MIN(studentcourse.progress) < 40 THEN 'F'
  WHEN MIN(studentcourse.progress) < 50 THEN 'D'
     WHEN MIN(studentcourse.progress) < 60 THEN 'C'
     WHEN MIN(studentcourse.progress) < 70 THEN 'B'
     WHEN MIN(studentcourse.progress) >= 70 THEN 'A'
 END as 'Min Grade',
CASE WHEN MAX(studentcourse.progress) < 40 THEN 'F'
  WHEN MAX(studentcourse.progress) < 50 THEN 'D'
  WHEN MAX(studentcourse.progress) < 60 THEN 'C'
  WHEN MAX(studentcourse.progress) < 70 THEN 'B'
  WHEN MAX(studentcourse.progress) >= 70 THEN 'A'
 END as 'Max Grade'
 FROM student
 JOIN studentcourse ON student.id = studentcourse.studentid
 GROUP BY studentcourse.studentid;

















/*SELECT @@sql_mode;

SET GLOBAL sql_mode='';
SELECT @@GLOBAL.sql_mode;