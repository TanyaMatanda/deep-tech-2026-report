#!/usr/bin/env python3
"""Generate enhanced AI Disclosure Gap Dashboard with tabbed interface"""

import json

# Read the markdown content
with open('S1_AI_Risk_Disclosure_Liability_Analysis.md', 'r') as f:
    paper_content = f.read()

# Escape for JavaScript
paper_escaped = json.dumps(paper_content)

html_content = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The AI Disclosure Gap: Analysis & Research</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #2d3748;
            line-height: 1.6;
        }}

        .container {{
            max-width: 1600px;
            margin: 2rem auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }}

        header {{
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            color: white;
            padding: 3rem 2rem 1rem;
            text-align: center;
        }}

        h1 {{
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            letter-spacing: -0.05em;
        }}

        .subtitle {{
            font-size: 1.25rem;
            color: #cbd5e0;
            margin-bottom: 1.5rem;
        }}

        /* Tab Navigation */
        .tab-nav {{
            display: flex;
            gap: 0;
            background: rgba(0, 0, 0, 0.2);
            padding: 0;
            margin-top: 2rem;
        }}

        .tab-button {{
            flex: 1;
            padding: 1.25rem 2rem;
            background: transparent;
            color: #cbd5e0;
            border: none;
            cursor: pointer;
            font-size: 1.05rem;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }}

        .tab-button:hover {{
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }}

        .tab-button.active {{
            background: white;
            color: #1a202c;
        }}

        .tab-button.active::after {{
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }}

        .tab-content {{
            display: none;
        }}

        .tab-content.active {{
            display: block;
        }}

        /* Dashboard styles */
        .stats-banner {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            padding: 3rem 2rem;
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
        }}

        .stat-card {{
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1.75rem;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }}

        .stat-number {{
            font-size: 2.75rem;
            font-weight: 700;
            color: #fff;
        }}

        .stat-label {{
            font-size: 0.95rem;
            color: #cbd5e0;
            margin-top: 0.5rem;
        }}

        .content {{
            padding: 3rem 2rem;
        }}

        .section {{
            margin-bottom: 4rem;
        }}

        h2 {{
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #1a202c;
        }}

        h3 {{
            font-size: 1.5rem;
            font-weight: 600;
            margin: 2rem 0 1rem;
            color: #2d3748;
        }}

        .insight-box {{
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-left: 4px solid #667eea;
            padding: 1.5rem;
            margin: 1.5rem 0;
            border-radius: 8px;
        }}

        .insight-title {{
            font-weight: 700;
            color: #667eea;
            margin-bottom: 0.5rem;
        }}

        .chart-container {{
            position: relative;
            height: 400px;
            margin: 2rem 0;
            padding: 1.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }}

        .comparison-table {{
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 2rem 0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }}

        .comparison-table thead {{
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }}

        .comparison-table th {{
            padding: 1rem;
            text-align: left;
            font-weight: 600;
        }}

        .comparison-table td {{
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }}

        .comparison-table tbody tr:hover {{
            background: #f7fafc;
        }}

        .badge {{
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
        }}

        .badge-critical {{
            background: #fed7d7;
            color: #c53030;
        }}

        .badge-warning {{
            background: #feebc8;
            color: #c05621;
        }}

        .badge-good {{
            background: #c6f6d5;
            color: #276749;
        }}

        .pattern-card {{
            background: white;
            border-radius: 12px;
            padding: 2rem;
            margin: 1.5rem 0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border-top: 4px solid #667eea;
        }}

        .pattern-name {{
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 0.5rem;
        }}

        .pattern-stat {{
            font-size: 3rem;
            font-weight: 800;
            color: #1a202c;
            margin: 1rem 0;
        }}

        /* Paper Tab Styles */
        .paper-content {{
            max-width: 900px;
            margin: 0 auto;
            padding: 3rem 2rem;
            line-height: 1.8;
        }}

        .paper-content h1 {{
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: #1a202c;
        }}

        .paper-content h2 {{
            font-size: 2rem;
            margin: 3rem 0 1rem;
            color: #2d3748;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e2e8f0;
        }}

        .paper-content h3 {{
            font-size: 1.5rem;
            margin: 2rem 0 1rem;
            color: #4a5568;
        }}

        .paper-content p {{
            margin: 1rem 0;
            color: #2d3748;
        }}

        .paper-content strong {{
            color: #1a202c;
            font-weight: 600;
        }}

        .paper-content table {{
            width: 100%;
            margin: 2rem 0;
            border-collapse: collapse;
        }}

        .paper-content table th {{
            background: #f7fafc;
            padding: 0.75rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #e2e8f0;
        }}

        .paper-content table td {{
            padding: 0.75rem;
            border-bottom: 1px solid #e2e8f0;
        }}

        .paper-content blockquote {{
            border-left: 4px solid #667eea;
            padding-left: 1.5rem;
            margin: 1.5rem 0;
            color: #4a5568;
            font-style: italic;
        }}

        .paper-content ul, .paper-content ol {{
  margin-left: 2rem;
            margin: 1rem 0;
        }}

        .paper-content li {{
            margin: 0.5rem 0;
        }}

        .paper-content hr {{
            border: none;
            border-top: 2px solid #e2e8f0;
            margin: 3rem 0;
        }}

        footer {{
            background: #1a202c;
            color: #cbd5e0;
            padding: 2rem;
            text-align: center;
        }}

        .grid-2 {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }}

        @media (max-width: 768px) {{
            h1 {{
                font-size: 1.75rem;
            }}
            
            .grid-2 {{
                grid-template-columns: 1fr;
            }}
            
            .chart-container {{
                height: 300px;
            }}

            .paper-content {{
                padding: 2rem 1rem;
            }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>The AI Disclosure Gap</h1>
            <div class="subtitle">Empirical Analysis of 1,876 SEC Filings & Board Governance Implications</div>
            
            <div class="tab-nav">
                <button class="tab-button active" onclick="switchTab('dashboard')">
                    📊 Interactive Dashboard
                </button>
                <button class="tab-button" onclick="switchTab('paper')">
                    📄 Full Research Paper
                </button>
            </div>
        </header>

        <div id="dashboard-tab" class="tab-content active">
            <div class="stats-banner">
                <div class="stat-card">
                    <div class="stat-number">1,876</div>
                    <div class="stat-label">Companies Analyzed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">654</div>
                    <div class="stat-label">With AI Disclosures</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">6,878</div>
                    <div class="stat-label">AI-Related Mentions</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">140x</div>
                    <div class="stat-label">Disclosure Ratio Gap</div>
                </div>
            </div>

            <div class="content">
                <div class="section">
                    <h2>Executive Findings</h2>
                    <p style="font-size: 1.125rem; color: #4a5568; margin-bottom: 2rem;">
                        We extracted and analyzed every available SEC 10-K Item 1A (Risk Factors) filing—1,876 companies total—and discovered a systematic pattern: companies are advertising AI capabilities while concealing AI-specific risks.
                    </p>

                    <div class="pattern-card">
                        <div class="pattern-name">The LLM Paradox</div>
                        <div class="pattern-stat">1,038 : &lt;10</div>
                        <p>1,038 companies mention "LLM" in risk factors, but fewer than 10 mention "hallucination"—the technology's most distinctive risk.</p>
                    </div>

                    <div class="pattern-card">
                        <div class="pattern-name">The 140x Rule</div>
                        <div class="pattern-stat">140 : 1</div>
                        <p>For every mention of model performance risk, there are 140 mentions of infrastructure risk—backwards for AI application companies.</p>
                    </div>

                    <div class="pattern-card">
                        <div class="pattern-name">The NVIDIA Proxy</div>
                        <div class="pattern-stat">56 vs &lt;10</div>
                        <p>56 companies name NVIDIA (vendor concentration risk) while &lt;10 mention hallucination (product liability risk).</p>
                    </div>
                </div>

                <div class="section">
                    <h2>Disclosure by Risk Category</h2>
                    <div class="chart-container">
                        <canvas id="disclosureChart"></canvas>
                    </div>
                </div>

                <div class="section">
                    <h2>The Disclosure Inversion</h2>
                    <div class="grid-2">
                        <div class="chart-container">
                            <canvas id="infrastructureChart"></canvas>
                        </div>
                        <div class="chart-container">
                            <canvas id="modelRiskChart"></canvas>
                        </div>
                    </div>

                    <div class="insight-box">
                        <div class="insight-title">Key Insight</div>
                        <p>Companies are comfortable disclosing risks they don't control (supply chain, vendors) while remaining silent on risks they do control but can't eliminate (model performance, training data, bias).</p>
                    </div>
                </div>

                <div class="section">
                    <h2>AI Risk Categories: Academic Standards vs. Current Disclosure</h2>
                    <table class="comparison-table">
                        <thead>
                            <tr>
                                <th>Risk Category</th>
                                <th>Academic Priority</th>
                                <th>Current Disclosure Rate</th>
                                <th>Gap Assessment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>Model Performance & Reliability</strong></td>
                                <td>High</td>
                                <td>&lt;1%</td>
                                <td><span class="badge badge-critical">Critical Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Training Data & IP</strong></td>
                                <td>High</td>
                                <td>&lt;1% (17 mentions)</td>
                                <td><span class="badge badge-critical">Critical Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Bias & Fairness</strong></td>
                                <td>High</td>
                                <td>9% (214 mentions)</td>
                                <td><span class="badge badge-warning">Significant Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Regulatory Compliance</strong></td>
                                <td>High</td>
                                <td>7% (EU AI Act: 46 mentions)</td>
                                <td><span class="badge badge-critical">Critical Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Privacy & Data Protection</strong></td>
                                <td>High</td>
                                <td>~30%</td>
                                <td><span class="badge badge-warning">Moderate Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Security & Adversarial Attacks</strong></td>
                                <td>High</td>
                                <td>~30%</td>
                                <td><span class="badge badge-warning">Moderate Gap</span></td>
                            </tr>
                            <tr>
                                <td><strong>Infrastructure Dependencies</strong></td>
                                <td>Medium</td>
                                <td>58%</td>
                                <td><span class="badge badge-good">Well Covered</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2>Keyword Frequency Analysis</h2>
                    <div class="chart-container" style="height: 500px;">
                        <canvas id="keywordChart"></canvas>
                    </div>
                </div>

                <div class="section">
                    <h2>Disclosure Depth Analysis</h2>
                    <div class="chart-container">
                        <canvas id="depthChart"></canvas>
                    </div>

                    <div class="insight-box">
                        <div class="insight-title">Quality vs Quantity</div>
                        <p>63% of companies mentioning AI provide only minimal disclosure (≤5 mentions). Only 2.3% (15 companies) provide comprehensive disclosure (50+ mentions).</p>
                    </div>
                </div>

                <div class="section">
                    <h2>Cross-Jurisdictional Comparison</h2>
                    <table class="comparison-table">
                        <thead>
                            <tr>
                                <th>Jurisdiction</th>
                                <th>Disclosure Standard</th>
                                <th>Enforcement Level</th>
                                <th>Competitive Implication</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>United States (SEC)</strong></td>
                                <td>Flexible, principles-based</td>
                                <td>Weak (for now)</td>
                                <td>Race to the bottom—minimal disclosure</td>
                            </tr>
                            <tr>
                                <td><strong>European Union</strong></td>
                                <td>Mandatory (AI Act)</td>
                                <td>Strong (6% of revenue)</td>
                                <td>Highest global standard—signals governance quality</td>
                            </tr>
                            <tr>
                                <td><strong>United Kingdom</strong></td>
                                <td>Model governance framework</td>
                                <td>Sector-specific</td>
                                <td>Technical detail required—proves feasibility</td>
                            </tr>
                            <tr>
                                <td><strong>China</strong></td>
                                <td>Algorithm registration</td>
                                <td>Strong</td>
                                <td>Granular disclosure mandated</td>
                            </tr>
                            <tr>
                                <td><strong>Singapore</strong></td>
                                <td>FEAT principles (soft law)</td>
                                <td>Reputational</td>
                                <td>Competitive signaling in quality markets</td>
                            </tr>
                            <tr>
                                <td><strong>Canada</strong></td>
                                <td>AIDA (Artificial Intelligence and Data Act)</td>
                                <td>Emerging (legislative process)</td>
                                <td>North American leadership positioning—ethical AI disclosure premium</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="paper-tab" class="tab-content">
            <div class="paper-content" id="paper-rendered"></div>
        </div>

        <footer>
            <p><strong>Prepared by:</strong> Tanya Matanda | <strong>Date:</strong> January 2026</p>
            <p style="margin-top: 0.5rem; font-size: 0.875rem;">This analysis is provided for informational purposes only.</p>
        </footer>
    </div>

    <script>
        // Tab switching
        function switchTab(tabName) {{
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {{
                tab.classList.remove('active');
            }});
            document.querySelectorAll('.tab-button').forEach(btn => {{
                btn.classList.remove('active');
            }});

            // Show selected tab
            if (tabName === 'dashboard') {{
                document.getElementById('dashboard-tab').classList.add('active');
                document.querySelector('[onclick*="dashboard"]').classList.add('active');
            }} else if (tabName === 'paper') {{
                document.getElementById('paper-tab').classList.add('active');
                document.querySelector('[onclick*="paper"]').classList.add('active');
                
                // Render markdown if not already rendered
                if (document.getElementById('paper-rendered').innerHTML === '') {{
                    renderPaper();
                }}
            }}
        }}

        // Render the full paper
        function renderPaper() {{
            const paperMarkdown = {paper_escaped};
            const rendered = marked.parse(paperMarkdown);
            document.getElementById('paper-rendered').innerHTML = rendered;
        }}

        // Initialize charts (only when dashboard tab is active)
        window.addEventListener('load', function() {{
            initializeCharts();
        }});

        function initializeCharts() {{
            // Disclosure by Risk Category Chart
            const disclosureCtx = document.getElementById('disclosureChart').getContext('2d');
            new Chart(disclosureCtx, {{
                type: 'bar',
                data: {{
                    labels: ['Infrastructure', 'Generic AI', 'LLM/Gen AI', 'Algorithm', 'Bias', 'EU AI Act', 'Training Data', 'Hallucination'],
                    datasets: [{{
                        label: '% of AI Disclosers',
                        data: [58, 47, 41, 25, 9, 7, 0.9, 0.5],
                        backgroundColor: [
                            'rgba(102, 126, 234, 0.8)',
                            'rgba(118, 75, 162, 0.8)',
                            'rgba(237, 100, 166, 0.8)',
                            'rgba(255, 159, 28, 0.8)',
                            'rgba(255, 107, 107, 0.8)',
                            'rgba(252, 92, 101, 0.8)',
                            'rgba(240, 52, 52, 0.8)',
                            'rgba(220, 38, 38, 0.8)'
                        ],
                        borderColor: 'rgba(255, 255, 255, 1)',
                        borderWidth: 2
                    }}]
                }},
                options: {{
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {{
                        legend: {{
                            display: false
                        }},
                        title: {{
                            display: true,
                            text: 'What Companies Are Disclosing (% of 654 AI Disclosers)',
                            font: {{
                                size: 16,
                                weight: 'bold'
                            }}
                        }}
                    }},
                    scales: {{
                        y: {{
                            beginAtZero: true,
                            max: 100,
                            ticks: {{
                                callback: function(value) {{
                                    return value + '%';
                                }}
                            }}
                        }}
                    }}
                }}
            }});

            // Infrastructure vs Model Risk Charts
            const infraCtx = document.getElementById('infrastructureChart').getContext('2d');
            new Chart(infraCtx, {{
                type: 'doughnut',
                data: {{
                    labels: ['Infrastructure Mentions', 'Other'],
                    datasets: [{{
                        data: [2375, 4503],
                        backgroundColor: [
                            'rgba(102, 126, 234, 0.8)',
                            'rgba(226, 232, 240, 0.8)'
                        ]
                    }}]
                }},
                options: {{
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {{
                        legend: {{
                            position: 'bottom'
                        }},
                        title: {{
                            display: true,
                            text: 'Infrastructure Risk Mentions (2,375)',
                            font: {{
                                size: 14,
                                weight: 'bold'
                            }}
                        }}
                    }}
                }}
            }});

            const modelCtx = document.getElementById('modelRiskChart').getContext('2d');
            new Chart(modelCtx, {{
                type: 'doughnut',
                data: {{
                    labels: ['Model Performance Mentions', 'Other'],
                    datasets: [{{
                        data: [17, 6861],
                        backgroundColor: [
                            'rgba(252, 92, 101, 0.8)',
                            'rgba(226, 232, 240, 0.8)'
                        ]
                    }}]
                }},
                options: {{
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {{
                        legend: {{
                            position: 'bottom'
                        }},
                        title: {{
                            display: true,
                            text: 'Model Performance Risk Mentions (<17)',
                            font: {{
                                size: 14,
                                weight: 'bold'
                            }}
                        }}
                    }}
                }}
            }});

            // Keyword Frequency Chart
            const keywordCtx = document.getElementById('keywordChart').getContext('2d');
            new Chart(keywordCtx, {{
                type: 'bar',
                data: {{
                    labels: ['compute', 'artificial intelligence', 'llm', 'data center', 'machine learning', 'generative ai', 'automation', 'algorithm', 'bias', 'autonomous', 'ai model', 'ai system', 'gpu', 'nvidia', 'eu ai act'],
                    datasets: [{{
                        label: 'Total Mentions',
                        data: [1430, 1051, 1038, 799, 456, 446, 335, 312, 214, 173, 123, 91, 67, 56, 46],
                        backgroundColor: 'rgba(102, 126, 234, 0.8)',
                        borderColor: 'rgba(102, 126, 234, 1)',
                        borderWidth: 2
                    }}]
                }},
                options: {{
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {{
                        legend: {{
                            display: false
                        }},
                        title: {{
                            display: true,
                            text: 'Top 15 AI Keywords in Risk Factors (Total Mentions)',
                            font: {{
                                size: 16,
                                weight: 'bold'
                            }}
                        }}
                    }},
                    scales: {{
                        x: {{
                            beginAtZero: true
                        }}
                    }}
                }}
            }});

            // Disclosure Depth Chart
            const depthCtx = document.getElementById('depthChart').getContext('2d');
            new Chart(depthCtx, {{
                type: 'pie',
                data: {{
                    labels: ['1-5 mentions (Minimal)', '6-20 mentions (Moderate)', '21-50 mentions (Substantial)', '50+ mentions (Comprehensive)'],
                    datasets: [{{
                        data: [63, 28.9, 5.8, 2.3],
                        backgroundColor: [
                            'rgba(252, 92, 101, 0.8)',
                            'rgba(255, 159, 28, 0.8)',
                            'rgba(118, 75, 162, 0.8)',
                            'rgba(102, 126, 234, 0.8)'
                        ]
                    }}]
                }},
                options: {{
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {{
                        legend: {{
                            position: 'bottom'
                        }},
                        title: {{
                            display: true,
                            text: 'AI Disclosure Depth Distribution (% of 654 Companies)',
                            font: {{
                                size: 16,
                                weight: 'bold'
                            }}
                        }}
                    }}
                }}
            }});
        }}
    </script>
</body>
</html>
'''

# Write the file
with open('AI_Disclosure_Gap_Dashboard.html', 'w') as f:
    f.write(html_content)

print("Enhanced dashboard with tabs created successfully!")
print("File: AI_Disclosure_Gap_Dashboard.html")
