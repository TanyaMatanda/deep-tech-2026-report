
filename = "2_companies_part_3.sql"

def check_file(filename):
    print(f"Checking {filename}...")
    with open(filename, 'r') as f:
        content = f.read()
    
    # Check balanced quotes
    in_quote = False
    quote_char = ''
    line_num = 1
    col_num = 0
    
    for i, char in enumerate(content):
        if char == '\n':
            line_num += 1
            col_num = 0
        else:
            col_num += 1
            
        if char == "'" and (i == 0 or content[i-1] != '\\'): # Simple check, ignoring escaped quotes for now (Postgres uses '' for escape usually)
            if in_quote:
                if quote_char == "'":
                    # Check for double single quote escape
                    if i + 1 < len(content) and content[i+1] == "'":
                        continue # It's an escape
                    # Check if it was an escape (previous char was ')
                    if i > 0 and content[i-1] == "'":
                        # We already handled this in the previous iteration? No, we need to be careful.
                        pass
                    
                    in_quote = False
            else:
                in_quote = True
                quote_char = "'"
                
    if in_quote:
        print(f"ERROR: Unclosed quote starting at some point (simple check failed)")
    else:
        print("Quotes seem balanced (simple check).")

    # Check balanced parentheses (outside of quotes)
    # This is harder to do correctly without a full lexer, but let's try a simple count
    # assuming no parentheses in strings for a moment, or just counting all.
    # Actually, parentheses in strings are common. We need to respect quotes.
    
    balance = 0
    in_quote = False
    quote_char = ''
    
    # Re-scan properly
    i = 0
    while i < len(content):
        char = content[i]
        
        if not in_quote:
            if char == "'":
                in_quote = True
                quote_char = "'"
            elif char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
        else:
            if char == "'":
                if i + 1 < len(content) and content[i+1] == "'":
                    i += 1 # Skip next quote (escape)
                else:
                    in_quote = False
        i += 1
        
    if balance != 0:
        print(f"ERROR: Unbalanced parentheses! Balance: {balance}")
    else:
        print("Parentheses seem balanced.")

    # Check if file ends with semicolon
    stripped = content.strip()
    if not stripped.endswith(';'):
        print("ERROR: File does NOT end with a semicolon!")
        print(f"Last 100 chars: {stripped[-100:]}")
    else:
        print("File ends with a semicolon.")

check_file(filename)
