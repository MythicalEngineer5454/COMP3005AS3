-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    enrollment_date DATE
);

-- Insert initial data
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-09-01'),
('Jim', 'Beam', 'jim.beam@example.com', '2023-09-02');

-- Function to retrieve all students
CREATE OR REPLACE FUNCTION get_all_students()
RETURNS TABLE (
    student_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    enrollment_date DATE
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM students;
END;
$$ LANGUAGE plpgsql;

-- Function to add a student
CREATE OR REPLACE FUNCTION add_student(
    in_first_name TEXT,
    in_last_name TEXT,
    in_email TEXT,
    in_enrollment_date DATE
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO students (first_name, last_name, email, enrollment_date)
    VALUES (in_first_name, in_last_name, in_email, in_enrollment_date);
END;
$$ LANGUAGE plpgsql;

-- Function to update a student's email
CREATE OR REPLACE FUNCTION update_student_email(
    in_student_id INTEGER,
    in_new_email TEXT
)
RETURNS VOID AS $$
BEGIN
    UPDATE students SET email = in_new_email WHERE student_id = in_student_id;
END;
$$ LANGUAGE plpgsql;

-- Function to delete a student
CREATE OR REPLACE FUNCTION delete_student(
    in_student_id INTEGER
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM students WHERE student_id = in_student_id;
END;
$$ LANGUAGE plpgsql;
