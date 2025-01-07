# COURSE REGISTRATION SYSTEM

## CREATED BY: 
**JADHAV KRUSHNA VISHWANATH**

## COLLEGE NAME: 
**AMRUTVAHINI COLLEGE OF ENGINEERING, SANGAMNER**

---

## **DESCRIPTION**  
This is a **Course Registration System** built using PL/SQL. The system manages student course registrations, prerequisites, and credit requirements. It ensures that students meet the required prerequisites before registering for a course, calculates total credits earned by each student, and prevents over-enrollment in any course. 

---

## **KEY FEATURES**  
- **Student Management**: Maintain detailed student records, including ID, name, and registered courses.  
- **Course Management**: Manage course details like course name, credits, maximum capacity, and current enrollment.  
- **Prerequisite Validation**: Ensure students meet course prerequisites before registering.  
- **Credit Calculation**: Calculate total credits for a student using PL/SQL procedures.  
- **Over-Enrollment Prevention**: Use triggers to prevent students from enrolling in courses exceeding their maximum capacity.  
- **Historical Data**: Maintain records of student registrations and course statuses for auditing and reporting.  

---

## **TABLES**  
1. **students**: Stores student information (ID, name, email, etc.).  
2. **courses**: Stores course details (course ID, name, credits, capacity, and current enrollment).  
3. **registrations**: Tracks student course registrations (student ID, course ID, registration status, and date).  
4. **prerequisites**: Tracks course prerequisites (course ID and prerequisite course ID).  

---

## **BENEFITS**  
- **Prerequisite Enforcement**: Ensures students are academically prepared before enrolling in advanced courses.  
- **Capacity Management**: Prevents over-enrollment in courses, ensuring fair distribution of resources.  
- **Efficient Credit Tracking**: Automated calculation of total credits helps in monitoring student progress.  
- **Comprehensive Auditing**: Maintains detailed records for transparency and accountability.  
- **Streamlined Process**: Automation reduces manual errors and administrative workload.  

---

## **IMPLEMENTATION DETAILS**  

### **Constraints**
- Prerequisites are enforced using `CHECK` constraints and validations in PL/SQL.  

### **Procedures**
1. **`calculate_total_credits`**: A procedure to compute the total credits earned by a student across all completed courses.  
2. **`register_student`**: A procedure to register a student for a course, validating prerequisites before proceeding.  

### **Triggers**
1. **`prevent_over_enrollment`**: A trigger to block registrations when the course's maximum capacity is reached.  

---

## **GUIDANCE**  
**Faculty Guide**: **ANIRUDDHA GAIKWAD**  

---

## **USAGE INSTRUCTIONS**  

1. **Run the Scripts**  
   - Execute the provided SQL script files to create tables, constraints, procedures, and triggers.  

2. **Insert Initial Data**  
   - Populate the tables with sample data for students, courses, and prerequisites.  

3. **Test Functionality**  
   - Test the system by registering students for courses and checking prerequisite validations, credit calculations, and over-enrollment handling.  

4. **Queries for Reporting**  
   - Use the provided SQL queries to generate reports such as:
     - Total credits earned by a student.
     - List of students registered for a course.
     - Audit trail for course registrations.  

---

## **BENEFITS FOR USERS**  
- **Students**: Seamless course registration experience with automated credit tracking.  
- **Administrators**: Simplified course and student management with reliable validations.  

---
