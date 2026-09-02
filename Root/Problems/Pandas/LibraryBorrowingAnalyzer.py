#1 . Library Borrowing Analysis
# The required operations are:
# Create DataFrame
# Calculate monthly return rate
# Add overdue flag
# Find members with high overdue count
# Generate section-wise return-status summary
# Complete library_solution.py

import pandas as pd


class LibraryBorrowingAnalyzer:

    # ---------------------------------------------------------
    # 1. Create Library Borrowing DataFrame
    # ---------------------------------------------------------
    def create_borrowing_df(self, data: list) -> pd.DataFrame:

        df = pd.DataFrame(
            data,
            columns=[
                "MemberID",
                "Section",
                "Date",
                "ReturnStatus"
            ]
        )

        return df

    # ---------------------------------------------------------
    # 2. Calculate Monthly Return Rate per Member
    # ---------------------------------------------------------
    def compute_monthly_return_rate(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        df = df.copy()

        # Extract YYYY-MM from Date
        df["Month"] = df["Date"].str[:7]

        # -----------------------------------------------------
        # Table 1: Total borrowed books
        # -----------------------------------------------------
        total_df = (
            df.groupby(["MemberID", "Month"])
              .size()
              .reset_index(name="Total")
        )

        # -----------------------------------------------------
        # Table 2: Total returned books
        # -----------------------------------------------------
        returned_df = df[
            df["ReturnStatus"] == "Returned"
        ]

        returned_count_df = (
            returned_df.groupby(["MemberID", "Month"])
                       .size()
                       .reset_index(name="Returned")
        )

        # -----------------------------------------------------
        # Join total and returned counts
        # -----------------------------------------------------
        joined_df = pd.merge(
            total_df,
            returned_count_df,
            on=["MemberID", "Month"],
            how="left"
        )

        # Members with no returned books should have 0
        joined_df["Returned"] = (
            joined_df["Returned"]
            .fillna(0)
        )

        # Calculate percentage
        joined_df["Return Rate"] = (
            joined_df["Returned"]
            / joined_df["Total"]
            * 100
        )

        # Round percentage
        joined_df["Return Rate"] = (
            joined_df["Return Rate"]
            .round(2)
        )

        # Return required columns
        return joined_df[
            ["MemberID", "Month", "Return Rate"]
        ]

    # ---------------------------------------------------------
    # 3. Add Overdue Flag
    # ---------------------------------------------------------
    def add_overdue_flag(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        df = df.copy()

        df["IsOverdue"] = (
            df["ReturnStatus"] == "Overdue"
        ).astype(int)

        return df

    # ---------------------------------------------------------
    # 4. Find Members with High Overdue Count
    # ---------------------------------------------------------
    def high_overdue_members(
        self,
        df: pd.DataFrame,
        threshold: int
    ) -> pd.DataFrame:

        # Filter overdue records
        overdue_df = df[
            df["ReturnStatus"] == "Overdue"
        ]

        # Count overdue records per member
        result = (
            overdue_df.groupby("MemberID")
                      .size()
                      .reset_index(name="Overdue Count")
        )

        # Keep members whose count is greater than threshold
        result = result[
            result["Overdue Count"] > threshold
        ]

        # Reset index
        result = result.reset_index(drop=True)

        return result

    # ---------------------------------------------------------
    # 5. Section-wise Return Status Summary
    # ---------------------------------------------------------
    def section_return_summary(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = pd.crosstab(
            df["Section"],
            df["ReturnStatus"]
        )

        # Ensure all required columns exist
        result = result.reindex(
            columns=[
                "Returned",
                "Pending",
                "Overdue"
            ],
            fill_value=0
        )

        # Convert index back to column
        result = result.reset_index()

        return result


# =============================================================
# DRIVER CODE
# =============================================================

if __name__ == "__main__":

    analyzer = LibraryBorrowingAnalyzer()

    data = [
        [301, "Fiction", "2024-07-01", "Returned"],
        [302, "Science", "2024-07-01", "Overdue"],
        [301, "Fiction", "2024-07-02", "Pending"],
        [302, "Science", "2024-07-02", "Overdue"],
        [303, "History", "2024-07-01", "Returned"],
        [303, "History", "2024-07-03", "Overdue"],
        [304, "Fiction", "2024-07-03", "Returned"],
        [305, "Science", "2024-07-04", "Overdue"],
        [305, "Science", "2024-07-05", "Overdue"],
        [301, "Fiction", "2024-07-06", "Returned"],
        [304, "Fiction", "2024-07-07", "Pending"],
        [302, "Science", "2024-07-08", "Overdue"]
    ]

    # 1. Create DataFrame
    df = analyzer.create_borrowing_df(data)

    print("=" * 60)
    print("LIBRARY BORROWING DATA")
    print("=" * 60)
    print(df)

    # 2. Monthly return rate
    monthly_rate = analyzer.compute_monthly_return_rate(df)

    print("\n" + "=" * 60)
    print("MONTHLY RETURN RATE")
    print("=" * 60)
    print(monthly_rate)

    # 3. Add overdue flag
    flagged_df = analyzer.add_overdue_flag(df)

    print("\n" + "=" * 60)
    print("BORROWING DATA WITH OVERDUE FLAG")
    print("=" * 60)
    print(flagged_df)

    # 4. High overdue members
    high_overdue = analyzer.high_overdue_members(df, 1)

    print("\n" + "=" * 60)
    print("HIGH OVERDUE MEMBERS")
    print("=" * 60)
    print(high_overdue)

    # 5. Section summary
    summary = analyzer.section_return_summary(df)

    print("\n" + "=" * 60)
    print("SECTION-WISE RETURN STATUS SUMMARY")
    print("=" * 60)
    print(summary)
