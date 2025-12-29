from fpdf import FPDF
import matplotlib.pyplot as plt
import json
import os

# 1. Generate Charts
def create_charts():
    # Load Data
    with open("dashboard/data/stats.json", "r") as f:
        data = json.load(f)
    
    sectors = [s['sector'] for s in data['sectors'] if s['count'] > 10] # Filter tiny sectors
    women_pct = [s['avg_women_pct'] for s in data['sectors'] if s['count'] > 10]
    tech_exp = [s['avg_tech_experts'] for s in data['sectors'] if s['count'] > 10]
    
    # Diversity Chart
    plt.figure(figsize=(10, 6))
    plt.barh(sectors, women_pct, color='#2563eb')
    plt.xlabel('Average % Women on Boards')
    plt.title('Gender Diversity by Sector')
    plt.tight_layout()
    plt.savefig('dashboard/assets/chart_diversity.png')
    plt.close()
    
    # Tech Experts Chart
    plt.figure(figsize=(10, 6))
    plt.barh(sectors, tech_exp, color='#10b981')
    plt.xlabel('Average Technical Experts per Board')
    plt.title('Technical Expertise by Sector')
    plt.tight_layout()
    plt.savefig('dashboard/assets/chart_tech.png')
    plt.close()

# 2. Generate PDF
class PDF(FPDF):
    def header(self):
        self.set_font('Arial', 'B', 16)
        self.cell(0, 10, 'Deep Tech Proxy Season 2026: What Should You Know?', 0, 1, 'C')
        self.ln(5)

    def footer(self):
        self.set_y(-15)
        self.set_font('Arial', 'I', 8)
        self.cell(0, 10, 'Page ' + str(self.page_no()) + ' | Co-authored by Tanya Matanda | Matanda Advisory Services | RiskAnchor', 0, 0, 'C')

    def chapter_title(self, label):
        self.set_font('Arial', 'B', 14)
        self.set_fill_color(240, 240, 240)
        self.cell(0, 10, label, 0, 1, 'L', 1)
        self.ln(4)

    def chapter_subtitle(self, label):
        self.set_font('Arial', 'B', 12)
        self.cell(0, 8, label, 0, 1, 'L')
        self.ln(2)

    def chapter_body(self, body):
        self.set_font('Arial', '', 11)
        self.multi_cell(0, 5, body)
        self.ln()

def generate_pdf():
    create_charts()
    
    pdf = PDF()
    # Do NOT add_page() here, it will be added by the first header
    
    with open("dashboard/assets/deep_tech_2026_comprehensive_report.md", "r", encoding='utf-8') as f:
        lines = f.readlines()
        
    buffer = ""
    current_header = ""
    
    for line in lines:
        line = line.strip()
        
        # Handle Page Breaks (---)
        if line == "---":
            if buffer:
                pdf.chapter_body(buffer)
                buffer = ""
            pdf.add_page()
            continue
            
        if not line:
            if buffer:
                pdf.chapter_body(buffer)
                buffer = ""
            continue
            
        # Headers
        if line.startswith('#'):
            if buffer:
                pdf.chapter_body(buffer)
                buffer = ""
            
            # Count the number of # to determine level
            level = 0
            while level < len(line) and line[level] == '#':
                level += 1
            
            header_text = line.replace('#' * level, '').strip()
            current_header = header_text
            
            # Major sections (Level 1 or Level 2) get a new page if not already at the top
            if level <= 2 and pdf.page_no() > 0 and pdf.get_y() > 30:
                pdf.add_page()
            elif pdf.page_no() == 0:
                pdf.add_page()
                
            if level == 1:
                pdf.chapter_title(header_text)
            elif level == 2:
                pdf.chapter_title(header_text)
            else:
                pdf.chapter_subtitle(header_text)
                
            # Insert Charts after specific headers
            if "Executive Summary" in header_text:
                if os.path.exists('dashboard/assets/chart_diversity.png'):
                    pdf.image('dashboard/assets/chart_diversity.png', x=10, w=190)
                    pdf.ln(5)
            elif "Sector Analysis" in header_text:
                if os.path.exists('dashboard/assets/chart_tech.png'):
                    pdf.image('dashboard/assets/chart_tech.png', x=10, w=190)
                    pdf.ln(5)
            continue

        # Bullet points
        if line.startswith('* ') or line.startswith('- '):
            if buffer:
                pdf.chapter_body(buffer)
                buffer = ""
            # Simple bullet point formatting
            clean_line = "  • " + line[2:].replace('**', '')
            clean_line = clean_line.encode('latin-1', 'replace').decode('latin-1')
            pdf.chapter_body(clean_line)
            continue

        # Numbered lists
        if line[0:1].isdigit() and line[1:3] == ". ":
            if buffer:
                pdf.chapter_body(buffer)
                buffer = ""
            clean_line = "  " + line.replace('**', '')
            clean_line = clean_line.encode('latin-1', 'replace').decode('latin-1')
            pdf.chapter_body(clean_line)
            continue

        # Regular text
        clean_line = line.replace('**', '')
        # Handle encoding
        clean_line = clean_line.encode('latin-1', 'replace').decode('latin-1')
        buffer += clean_line + " "

    if buffer:
        pdf.chapter_body(buffer)
        
    output_path = "dashboard/assets/Deep_Tech_2026_Report.pdf"
    pdf.output(output_path)
    print(f"PDF Generated Successfully: {output_path}")

if __name__ == "__main__":
    generate_pdf()
