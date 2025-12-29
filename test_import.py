print("Starting test_import.py")
try:
    import db_connection
    print("db_connection imported")
except Exception as e:
    print(f"Error importing db_connection: {e}")
