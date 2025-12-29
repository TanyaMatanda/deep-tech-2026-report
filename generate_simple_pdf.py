from fpdf import FPDF
import os

class PDF(FPDF):
    def header(self):
        self.set_font('Arial', 'B', 15)
        self.cell(0, 10, 'Deep Tech 2026 Proxy Season Report', 0, 1, 'C')
        self.ln(5)

    def footer(self):
        self.set_y(-15)
        self.set_font('Arial', 'I', 8)
        self.cell(0, 10, 'Page ' + str(self.page_no()) + ' | Co-authored by Tanya Matanda | Matanda Advisory Services | RiskAnchor', 0, 0, 'C')

def generate_pdf(input_file, output_file):
    pdf = PDF()
    pdf.add_page()
    pdf.set_font("Arial", size=11)
    
    with open(input_file, "r", encoding='utf-8') as f:
        for line in f:
            # Basic Markdown stripping/formatting
            line = line.replace('**', '').replace('### ', '').replace('## ', '').replace('# ', '')
            
            # Handle unicode characters that might break latin-1
            line = line.encode('latin-1', 'replace').decode('latin-1')
            
            pdf.multi_cell(0, 5, line)
            
    pdf.output(output_file)
    print(f"PDF generated: {output_file}")

if __name__ == "__main__":
    generate_pdf("dashboard/assets/deep_tech_2026_comprehensive_report.md", "dashboard/assets/Deep_Tech_2026_Report.pdf")
