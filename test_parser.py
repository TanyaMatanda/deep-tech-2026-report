import re

def split_sql_values(line):
    # Split by comma, respecting quotes and brackets []
    values = []
    current_val = []
    in_quote = False
    quote_char = ''
    bracket_depth = 0
    
    for char in line:
        if in_quote:
            current_val.append(char)
            if char == quote_char:
                # Check for escape (double quote) - simplified
                in_quote = False
        else:
            if char == "'":
                in_quote = True
                quote_char = "'"
                current_val.append(char)
            elif char == '[':
                bracket_depth += 1
                current_val.append(char)
            elif char == ']':
                bracket_depth -= 1
                current_val.append(char)
            elif char == ',' and bracket_depth == 0:
                # Split!
                values.append("".join(current_val).strip())
                current_val = []
            else:
                current_val.append(char)
                
    if current_val:
        values.append("".join(current_val).strip())
        
    return values

def remove_comments(line):
    # Remove -- comment but respect quotes
    # Simple regex might fail if -- is inside a string
    # But for this dataset, -- is usually at the end of the line
    # Let's try to split by -- and take the first part, UNLESS it's inside a quote.
    # This is hard to do perfectly with simple regex.
    # But we can iterate.
    
    clean = []
    in_quote = False
    quote_char = ''
    i = 0
    while i < len(line):
        char = line[i]
        if in_quote:
            clean.append(char)
            if char == quote_char:
                in_quote = False
        else:
            if char == "'":
                in_quote = True
                quote_char = "'"
                clean.append(char)
            elif char == '-' and i+1 < len(line) and line[i+1] == '-':
                # Found comment start!
                break
            else:
                clean.append(char)
        i += 1
    return "".join(clean).strip()

def test():
    print("Testing Parser...")
    
    # Case 1: Governance Data with comments
    gov_line = "87, -- 2/7"
    print(f"\nCase 1: {gov_line}")
    clean = remove_comments(gov_line)
    print(f"  Clean: '{clean}'")
    parts = split_sql_values(clean)
    print(f"  Parts: {parts}")
    
    # Case 2: Patent Data with Array
    pat_line = "'QUALCOMM INC', 2010, 'US', 'Advanced Technology', ARRAY['patents','innovation'], 2, 208098"
    print(f"\nCase 2: {pat_line}")
    parts = split_sql_values(pat_line)
    print(f"  Parts: {parts}")
    print(f"  Count: {len(parts)} (Expected 7)")

    # Case 3: Complex Governance Line
    complex_line = "6, -- Tech background (most have quantum/tech expertise)"
    print(f"\nCase 3: {complex_line}")
    clean = remove_comments(complex_line)
    print(f"  Clean: '{clean}'")
    parts = split_sql_values(clean)
    print(f"  Parts: {parts}")

if __name__ == "__main__":
    test()
