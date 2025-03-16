

USE hospital_management_system_project;

SELECT * FROM affiliated_with;
SELECT * FROM department;
SELECT * FROM medical_procedures;
SELECT * FROM nurse;
SELECT * FROM patient;
SELECT * FROM patient_diagnosis;
SELECT * FROM physician;

#1.Write a query in SQL to obtain the name of the physician in alphabetical order.
 SELECT name AS physician_name
 FROM physician
 ORDER BY name ASC;
 
 #2. Write a query in SQL to obtain the fullname of the patients whose gender is male.
SELECT CONCAT(name,' ',surname) AS full_name, gender
FROM patient
WHERE gender = 'Male';

#3. Write a query in SQL to find the name of the nurse who are the head of their department and are registered.
SELECT name 
FROM nurse
WHERE position = 'Head Nurse' AND registered = 'Yes';

#4. Write a query in SQL to find the name of the nurse who are Team Leader or not registered.
SELECT name 
FROM nurse
WHERE position = 'Team Leader' OR registered = 'No';

#5. Write a query to obtain the avg cost of all the medical procedures.
SELECT AVG(cost) AS cost_of_procedures
FROM medical_procedures;

#6 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.
SELECT name, cost
FROM medical_procedures
WHERE cost > 2000;

#7. Write a query to update the name of the patient to Robert Fernandez having patientid as 5.
UPDATE patient
SET name = 'Robert', surname = 'Fernandez'
WHERE patient_id = 5;

#8. Write a query to drop phone column from patient table.
ALTER TABLE patient
DROP phone;

#9. Second maximum cost of medical procedure
SELECT name, MAX(cost) AS max_cost
FROM medical_procedures
GROUP BY name
ORDER BY max_cost DESC
LIMIT 1,1;

#10. Write a query in SQL to obtain the name of the patients starting with letter A.
SELECT name, surname
FROM patient
WHERE name LIKE 'A%';

#11. Write a query in SQL to obtain the name of the patients whose third letter is M.
SELECT name, surname
FROM patient
WHERE name LIKE '__M%';

#12. Write a query in SQL to obtain the name of the patients whose name start with letter J and ends with Z. 
SELECT CONCAT(name,' ',surname) AS full_name
FROM patient
WHERE CONCAT(name,' ',surname) LIKE 'J%Z';

#13. Write a query to obtain patient details having patient_id 11 to 20.
SELECT *
FROM patient
LIMIT 10,10;

#14.  Write a query in SQL to obtain the name of the physicians who are the head of each department
 SELECT name, dept_name, head
 FROM physician AS p INNER JOIN department AS d
 ON p.employeeid = d.head;

#15. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement
SELECT p.name AS patient_name, py.name AS doctor_name
FROM patient AS p LEFT JOIN physician AS py
ON p.primary_physician = py.employeeid;

#16. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.
SELECT p.name AS doc_name, dept_name
FROM physician AS p INNER JOIN affiliated_with AS aw
ON p.employeeid = aw.physicianid
INNER JOIN department AS d ON aw.departmentid = d.department_id
WHERE primaryaffiliation = '1';

#17. Write a query to obtain physician name,position and department they are affiliated with.
SELECT p.name AS doc_name, p.position AS doc_position, d.dept_name AS departname_name
FROM physician AS p INNER JOIN affiliated_with AS aw
ON p.employeeid = aw.physicianid
INNER JOIN department AS d ON aw.departmentid = d.department_id;

#18. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.
SELECT p.name AS patient_name, py.name AS doc_name, p.primary_physician, pd.diagnosis, pd.prescription 
FROM patient_diagnosis AS pd LEFT JOIN physician AS py
ON pd.physician_id = py.employeeid
LEFT JOIN patient AS p ON p.patient_id = pd.patient_id;

#19. Write a query in SQL to obtain the maximum cost of the medical procedure.
SELECT name,cost
FROM medical_procedures
WHERE cost IN (SELECT MAX(cost) FROM medical_procedures);

#20. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.
SELECT *
FROM patient
WHERE patient_id IN (SELECT patient_id 
					 FROM patient_diagnosis 
                     WHERE diagnosis = 'Chronic Pain');

#21. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.
SELECT name AS p_name, cost AS p_cost
FROM medical_procedures
WHERE cost > (SELECT AVG(cost)
				FROM medical_procedures);

#22. Write a query in SQL to obtain the procedure name and cost whose cost is less than the avg cost of all the procedure.
SELECT name AS p_name, cost AS p_cost
FROM medical_procedures
WHERE cost < (SELECT AVG(cost)
				FROM medical_procedures);

#23. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.                
SELECT * 
FROM Physician 
WHERE position IN (SELECT position FROM Physician
                   WHERE position
                   LIKE '%Senior%' OR position LIKE '%Head Chief%');
                   
 #24.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 

SELECT * 
FROM Physician 
WHERE employeeid IN (SELECT physicianid 
                     FROM affiliated_with 
                     WHERE primaryaffiliation = '0');                  