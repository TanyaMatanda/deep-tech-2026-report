from db_connection import init_connection
supabase = init_connection()
if supabase:
    res = supabase.table('companies').select('id', count='exact').limit(1).execute()
    print(f"Total companies count: {res.count}")
else:
    print("Failed to connect")
