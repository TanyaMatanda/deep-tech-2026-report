#!/usr/bin/env python3
"""
Fix all Plotly charts in app.py to use white template
"""

import re

# Read the file
with open('dashboard/app.py', 'r') as f:
    content = f.read()

# Pattern to match px chart creations
patterns = [
    (r'(px\.(scatter|bar|histogram|pie|box|line|area|sunburst|treemap)\([^)]*)\)', 
     r'\1, template="plotly_white")'),
]

# Track changes
changes = 0
for pattern, replacement in patterns:
    # Only add template if not already present
    def add_template(match):
        global changes
        if 'template=' not in match.group(0):
            changes += 1
            return replacement.replace(r'\1', match.group(1))
        return match.group(0)
    
    content = re.sub(pattern, add_template, content, flags=re.DOTALL | re.MULTILINE)

# Write back
with open('dashboard/app.py', 'w') as f:
    f.write(content)

print(f"Fixed {changes} Plotly charts to use white template")
print("Changes applied to dashboard/app.py")
