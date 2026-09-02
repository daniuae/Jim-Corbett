# 3. Online Learning Course Progress
#
# The required operations are:
#
# Create progress DataFrame
# Calculate completion percentage
# Classify progress as High/Medium/Low
# Sort students by completion
# Create course-wise summary

import pandas as pd


class CourseProgressAnalyzer:

    # ---------------------------------------------------------
    # 1. Create Course Progress DataFrame
    # ---------------------------------------------------------
    def create_progress_df(
        self,
        data: list
    ) -> pd.DataFrame:

        df = pd.DataFrame(
            data,
            columns=[
                "StudentID",
                "Course",
                "EnrollmentDate",
                "CompletedLessons",
                "TotalLessons",
                "Status"
            ]
        )

        return df

    # ---------------------------------------------------------
    # 2. Calculate Completion Percentage
    # ---------------------------------------------------------
    def add_completion_percentage(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = df.assign(
            **{
                "Completion Percentage":
                    (
                        df["CompletedLessons"]
                        / df["TotalLessons"]
                        * 100
                    ).round(2)
            }
        )

        return result

    # ---------------------------------------------------------
    # 3. Classify Learner Progress
    # ---------------------------------------------------------
    def classify_progress_level(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        df = df.copy()

        def classify(percentage):

            if percentage >= 75:
                return "High"

            elif percentage >= 40:
                return "Medium"

            else:
                return "Low"

        df["ProgressLevel"] = (
            df["Completion Percentage"]
            .apply(classify)
        )

        return df

    # ---------------------------------------------------------
    # 4. Sort Students by Completion Percentage
    # ---------------------------------------------------------
    def sort_by_completion(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = (
            df.sort_values(
                by="Completion Percentage",
                ascending=False
            )
            .reset_index(drop=True)
        )

        return result

    # ---------------------------------------------------------
    # 5. Course-wise Progress Summary
    # ---------------------------------------------------------
    def course_progress_summary(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = (
            df.groupby("Course")
              .agg(
                  **{
                      "Average Completion":
                          ("Completion Percentage", "mean"),
                      "Student Count":
                          ("StudentID", "count")
                  }
              )
              .reset_index()
        )

        result["Average Completion"] = (
            result["Average Completion"]
            .round(2)
        )

        return result


# =============================================================
# DRIVER CODE
# =============================================================

if __name__ == "__main__":

    analyzer = CourseProgressAnalyzer()

    progress_data = [
        [701, "Python Basics", "2024-09-01", 8, 10, "Active"],
        [702, "Data Analysis", "2024-09-02", 15, 15, "Completed"],
        [703, "Python Basics", "2024-09-03", 2, 10, "Active"],
        [704, "Machine Learning", "2024-09-04", 12, 20, "Active"],
        [705, "Data Analysis", "2024-09-05", 10, 15, "Active"],
        [706, "Machine Learning", "2024-09-06", 20, 20, "Completed"]
    ]

    # 1. Create DataFrame
    df = analyzer.create_progress_df(progress_data)

    print("=" * 60)
    print("COURSE PROGRESS DATA")
    print("=" * 60)
    print(df)

    # 2. Add completion percentage
    percentage_df = analyzer.add_completion_percentage(df)

    print("\n" + "=" * 60)
    print("COURSE PROGRESS WITH COMPLETION PERCENTAGE")
    print("=" * 60)
    print(percentage_df)

    # 3. Classify progress
    classified_df = analyzer.classify_progress_level(
        percentage_df
    )

    print("\n" + "=" * 60)
    print("COURSE PROGRESS WITH PROGRESS LEVEL")
    print("=" * 60)
    print(classified_df)

    # 4. Sort students
    sorted_df = analyzer.sort_by_completion(
        classified_df
    )

    print("\n" + "=" * 60)
    print("STUDENTS SORTED BY COMPLETION")
    print("=" * 60)
    print(sorted_df)

    # 5. Course summary
    summary = analyzer.course_progress_summary(
        classified_df
    )

    print("\n" + "=" * 60)
    print("COURSE PROGRESS SUMMARY")
    print("=" * 60)
    print(summary)
