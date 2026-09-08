import pandas as pd

class LibraryLendingAnalyzer:

    def create_lending_df(self, data: list) -> pd.DataFrame:
        columns = ["MemberID", "Category", "Date", "Status"]

        df = pd.DataFrame(data, columns=columns)

        return df

    def compute_monthly_return_rate(self, df: pd.DataFrame) -> pd.DataFrame:

        df = df.copy()

        df["Month"] = df["Date"].str[:7]

        total = (
            df.groupby(["MemberID", "Month"])
            .size()
            .reset_index(name="Total")
        )

        returned = (
            df[df["Status"] == "Returned"]
            .groupby(["MemberID", "Month"])
            .size()
            .reset_index(name="Returned")
        )

        result = total.merge(
            returned,
            on=["MemberID", "Month"],
            how="left"
        )

        result["Returned"] = result["Returned"].fillna(0)

        result["Return Rate"] = (
            result["Returned"] / result["Total"]
        ) * 100

        result = result[
            ["MemberID", "Month", "Return Rate"]
        ]

        return result

    def add_overdue_flag(self, df: pd.DataFrame) -> pd.DataFrame:

        df = df.copy()

        df["IsOverdue"] = (
            df["Status"] == "Overdue"
        ).astype(int)

        return df

    def high_overdue_members(
        self,
        df: pd.DataFrame,
        threshold: int
    ) -> pd.DataFrame:

        overdue = df[df["Status"] == "Overdue"]

        result = (
            overdue.groupby("MemberID")
            .size()
            .reset_index(name="Overdue Count")
        )

        result = result[
            result["Overdue Count"] > threshold
        ]

        return result.reset_index(drop=True)

    def category_lending_summary(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = pd.crosstab(
            df["Category"],
            df["Status"]
        )

        result.columns.name = None

        result = result.reindex(
            columns=["Borrowed", "Returned", "Overdue"],
            fill_value=0
        )

        result = result.reset_index()

        return result



obj = LibraryLendingAnalyzer()

data = [
    [501, "Fiction", "2024-06-01", "Borrowed"],
    [502, "Science", "2024-06-01", "Returned"],
    [501, "Fiction", "2024-06-02", "Overdue"],
    [501, "Fiction", "2024-06-03", "Returned"],
    [502, "Science", "2024-06-02", "Returned"]
]

df = obj.create_lending_df(data)

print(df)


result = obj.add_overdue_flag(df)

print(result)
