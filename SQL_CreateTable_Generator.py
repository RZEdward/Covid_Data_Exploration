import pandas as pd

csv_file = 'C:/1Projects/Covid_Data_Exploration/1_Covid_Deaths.csv'

df = pd.read_csv(csv_file)

column_data_types = {}

for column in df.columns:
    if df[column].dtype == 'float64':
        column_data_types[column] = 'NUMERIC(16, 3)'
    else:
        # Check if the column contains integers (no decimals) within valid numeric values
        is_integer = df[column].apply(lambda x: str(x).replace('.', '', 1).isdigit() if pd.notna(x) else True).all()
        if is_integer:
            column_data_types[column] = 'INTEGER'
        else:
            if 'date' in column.lower():
                column_data_types[column] = 'DATE'
            else:
                if df[column].dtype == 'object':
                    column_data_types[column] = 'VARCHAR(255)'
                else:
                    column_data_types[column] = 'NUMERIC(16, 3)'

# Check and redefine numeric columns as INTEGER if they primarily contain integers with zero decimals
for column in column_data_types.keys():
    if column_data_types[column] == 'NUMERIC(16, 3)':
        is_integer_column = df[column].apply(lambda x: x % 1 == 0 if pd.notna(x) else True).all()
        if is_integer_column:
            column_data_types[column] = 'INTEGER'

create_table_sql = "CREATE TABLE FATALITIES (\n"
for column, data_type in column_data_types.items():
    create_table_sql += f"    {column} {data_type},"
create_table_sql = create_table_sql.rstrip(',\n') + "\n);"

print(create_table_sql)
