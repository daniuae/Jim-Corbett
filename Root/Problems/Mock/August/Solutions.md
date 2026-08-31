# 1. Books — Filtering + Sorting
   SELECT
    b.book_id,
    b.book_name,
    published_year
FROM Books b
WHERE published_year > 2015
ORDER BY published_year;


# 2. Courses — JOIN + Correlated Subquery

SELECT
    cr.course_name,
    (
        SELECT SUM(ei.quantity)
        FROM Enrollment_Items ei
        WHERE ei.course_id = cr.course_id
    ) AS total_enrollments,
    s.student_name
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Enrollment_Items ei
    ON e.enrollment_id = ei.enrollment_id
JOIN Courses cr
    ON cr.course_id = ei.course_id
ORDER BY course_name;

# 3. Monthly Expenses — Subquery + LAG()

SELECT
    month_start,
    total_expense,
    previous_month_expense,
    total_expense - previous_month_expense AS expense_change
FROM
(
    SELECT
        month_start,
        total_expense,
        LAG(total_expense)
            OVER (ORDER BY month_start) AS previous_month_expense
    FROM MonthlyExpenses
) AS ExpenseData
ORDER BY month_start DESC;


# 4. Employees & Training — JOIN + Filtering

SELECT
    t.training_id,
    t.training_date,
    e.employee_name,
    e.department
FROM Employees e
JOIN Trainings t
    ON e.employee_id = t.employee_id
WHERE t.status = 'Scheduled';
