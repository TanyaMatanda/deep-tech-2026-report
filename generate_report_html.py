import markdown
import os

def convert_md_to_html(source_md, output_html):
    # 1. Read Markdown
    with open(source_md, 'r') as f:
        text = f.read()
        
    # 2. Convert to HTML
    html_content = markdown.markdown(text, extensions=['tables'])
    
    # 3. Add Styling (Print-friendly)
    styled_html = f"""
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8">
    <title>Deep Tech Proxy Season 2026: What Should You Know?</title>
    <style>
        body {{
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 12pt;
            line-height: 1.6;
            color: #333;
            max_width: 800px;
            margin: 0 auto;
            padding: 40px;
        }}
        @media print {{
            body {{
                max_width: 100%;
                padding: 20px;
            }}
            a {{
                text-decoration: none;
                color: #000;
            }}
        }}
        h1 {{
            color: #1E3A8A;
            font-size: 28pt;
            border-bottom: 4px solid #1E3A8A;
            padding-bottom: 15px;
            margin-top: 50px;
        }}
        h2 {{
            color: #1E3A8A;
            font-size: 20pt;
            margin-top: 40px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }}
        h3 {{
            color: #2563EB;
            font-size: 16pt;
            margin-top: 30px;
        }}
        blockquote {{
            background-color: #F3F4F6;
            border-left: 5px solid #1E3A8A;
            padding: 15px;
            margin: 20px 0;
            color: #555;
            font-style: italic;
        }}
        table {{
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
        }}
        th, td {{
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }}
        th {{
            background-color: #1E3A8A;
            color: white;
        }}
        tr:nth-child(even) {{
            background-color: #f9f9f9;
        }}
        .footer {{
            margin-top: 50px;
            text-align: center;
            font-size: 9pt;
            color: #999;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }}
    </style>
    </head>
    <body>
        {html_content}
        <div class="footer">
            <p>Deep Tech Proxy Season 2026: What Should You Know?</p>
            <p>Co-authored by Tanya Matanda | Matanda Advisory Services | RiskAnchor</p>
        </div>
    </body>
    </html>
    """
    
    # 4. Write HTML
    with open(output_html, "w") as f:
        f.write(styled_html)
        
    print(f"HTML Report successfully created at {output_html}")

if __name__ == "__main__":
    source = "dashboard/assets/deep_tech_2026_comprehensive_report.md"
    output = "dashboard/assets/Deep_Tech_2026_Report.html"
    
    if not os.path.exists(source):
        print(f"Error: Source file {source} not found.")
    else:
        convert_md_to_html(source, output)
