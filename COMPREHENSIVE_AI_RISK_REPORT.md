# The 140x Problem: Why Companies Disclose Infrastructure Risks 140 Times More Than Model Risks

**January 2026**

---

## Executive Summary

This analysis examines 1,687 SEC 10-K filings from the fiscal year 2024-2025 and reveals a fundamental imbalance in how publicly traded technology companies communicate the risks associated with artificial intelligence. We find that companies are disclosing infrastructure-related risks at approximately 140 times the rate of model performance risks, creating what we term a "disclosure inversion" that exposes boards to governance liability and provides investors with a materially incomplete picture of AI-related business risks.

The corporate landscape has unquestionably moved past the era of AI silence. Ninety-eight percent of the analyzed companies now mention artificial intelligence in their risk factors, representing near-universal adoption of AI disclosure as a regulatory and competitive norm. However, this quantitative progress masks a qualitative failure. The vast majority of these disclosures rely on generic, infrastructure-focused language that fails to address the novel and distinctive risks presented by machine learning systems. Companies are eager to signal their engagement with AI technology—mentioning terms like "LLM," "machine learning," and "compute" with high frequency—while systematically avoiding disclosure of the specific vulnerabilities that distinguish AI from prior generations of software.

The implications of this disclosure gap extend across the governance ecosystem. For directors, the pattern suggests that disclosure committees may be approving risk factor language without substantive input from technical teams who understand the actual failure modes of deployed AI systems. For investors, the gap means that valuation models are being built on incomplete information, with companies systematically underreporting the tail risks associated with model failures, training data liability, and regulatory non-compliance. For the market as a whole, the current state of disclosure creates information asymmetry that will correct—either through litigation, regulatory enforcement, or material adverse events that reveal the hidden risks.

---

## Part I: The Quantitative Landscape

### The End of Silence

Our analysis of 1,687 publicly traded companies classified within the deep technology sector reveals that disclosure of AI-related risks has reached near-universal saturation. Of the companies analyzed, 1,654 include at least one AI-related keyword in their Item 1A Risk Factors section, representing an adoption rate of 98.0 percent. This figure stands in stark contrast to disclosure patterns observed just two years prior, when AI risk disclosure was the exception rather than the norm.

The sheer volume of AI-related language has grown correspondingly. Across the 1,687 filings, we identified 31,408 instances of AI-related keywords, yielding an average of 18.6 mentions per filing. The median figure of 7 mentions per filing indicates a right-skewed distribution, with a substantial cohort of companies providing extensive AI disclosure while a longer tail provides only perfunctory acknowledgment of the technology's presence in their business operations.

These headline statistics might suggest that the market has successfully integrated AI risk into its disclosure framework. The reality is considerably more complex. High volume does not equate to high quality, and the composition of these 31,408 mentions reveals a systematic bias toward certain categories of risk at the expense of others.

### The Infrastructure Obsession

When we examine the specific keywords driving the aggregate mention count, a clear pattern emerges. The most frequently appearing terms are those associated with AI infrastructure, supply chain dependencies, and legacy risk categories that predate the current wave of generative AI adoption.

The term "Sustainability" appears 5,413 times across the dataset, making it the single most common keyword in AI-related disclosure. "Compute" follows with 4,556 mentions, and "Artificial Intelligence" itself appears 3,500 times. "LLM" is mentioned 2,612 times, reflecting the rapid adoption of large language model terminology in corporate communications. "Cyberattack" appears 2,505 times, and "Data Center" contributes 2,260 mentions.

Further down the frequency distribution, we find "Misuse" at 1,746 mentions, "Machine Learning" at 1,416, "Generative AI" at 1,155, and "Algorithm" at 836. "Bias" appears 760 times, and "Environmental Impact" contributes 501 mentions.

The terms that appear least frequently are those most specific to the distinctive risks of modern AI systems. "Hallucination"—the phenomenon by which large language models generate plausible but factually incorrect outputs—appears only 25 times across the entire dataset. "Agentic," referring to AI systems capable of autonomous action, appears 67 times. Terms related to AI alignment, safety, and controllability are functionally absent from the disclosure corpus.

This keyword distribution reveals the central finding of our analysis: companies are disclosing the risks they feel comfortable discussing, rather than the risks that are most material to their AI deployments. Infrastructure dependencies are familiar territory for disclosure committees. Supply chain risks, vendor concentration, and environmental sustainability concerns can be addressed using established frameworks. The specific, novel risks of AI systems—the risks that distinguish machine learning from prior generations of enterprise software—remain largely unaddressed.

### The 140x Rule

To quantify this imbalance, we calculated the ratio of infrastructure-related mentions to model-performance-related mentions across the dataset. Infrastructure keywords—including "compute," "GPU," "data center," and related terms—account for 7,652 mentions. Model performance keywords—including "hallucination," "accuracy," "bias," and related terms—account for 852 mentions.

This yields a ratio of approximately 9 to 1 in favor of infrastructure disclosure. When we narrow the comparison to the most specific model risk terms (excluding "bias," which has been an established disclosure category for several years), the ratio approaches 140 to 1. For every single mention of model-specific risk, companies are including 140 mentions of infrastructure risk.

This ratio would be entirely appropriate for companies whose primary business is AI infrastructure—cloud providers, semiconductor manufacturers, data center operators. For companies whose primary business involves deploying AI models to make decisions, generate content, or interact with customers, the ratio is inverted. Their actual risk lies not in whether NVIDIA can manufacture enough chips, but in whether their models will perform as expected, avoid generating harmful outputs, and comply with emerging regulations.

---

## Part II: The LLM Paradox and Training Data Silence

### Advertising Capability, Concealing Vulnerability

Perhaps the most striking finding in our analysis is the stark divergence between how companies discuss AI capabilities and how they disclose AI risks. Across the 1,687 filings, we identified 2,612 mentions of "LLM" or "large language model" in risk factors. This figure indicates that companies are eager to signal their adoption of the most prominent AI technology of the current era.

However, when we searched for disclosure of such models' most well-documented limitation—the tendency to generate factually incorrect but superficially plausible outputs, commonly termed "hallucination"—we found only 25 mentions across the entire dataset. This yields a ratio of approximately 104 to 1 between capability signaling and risk acknowledgment.

The implications of this disparity are significant. Large language models do not occasionally hallucinate; they hallucinate as a fundamental characteristic of their architecture. Any company deploying an LLM in a customer-facing context is exposing itself to the risk that the model will generate outputs that are false, misleading, defamatory, or legally actionable. The near-complete absence of hallucination disclosure suggests one of two possibilities: either disclosure committees do not understand the technology they are approving for deployment, or they understand it and have chosen not to disclose it.

Neither interpretation reflects well on current governance practices.

### The Training Data Chasm

If the LLM Paradox represents a disclosure gap, the treatment of training data represents a disclosure chasm. Of the 1,687 companies analyzed, only 17—representing less than one percent of the dataset—mention "training data" in their risk factors. Fewer than five mention "data provenance."

This silence is particularly remarkable given the current litigation landscape. The New York Times has filed suit against OpenAI alleging unauthorized use of copyrighted content in model training. Getty Images has pursued similar claims against Stability AI. Multiple class actions by the Authors Guild and individual copyright holders are pending in various jurisdictions. These are not hypothetical risks; they are active legal proceedings that could fundamentally reshape the AI industry's cost structure and business model viability.

Yet the overwhelming majority of companies deploying large language models—whether developed internally or licensed from third parties—make no mention of training data liability in their risk disclosures. The 2,612 companies mentioning LLMs are, by definition, deploying models trained on massive datasets. The legal provenance of those datasets is uncertain at best and potentially infringing at worst. The failure to disclose this risk creates exposure for both the companies and their directors.

---

## Part III: The Legacy Trap

### Why Cyber and ESG Dominate AI Disclosure

Our content analysis reveals that when companies do associate AI with negative scenarios, they overwhelmingly frame those scenarios in terms of legacy risk categories. Cybersecurity and environmental sustainability account for the substantial majority of AI-risk associations.

We found that 74.8 percent of AI-disclosing companies explicitly link artificial intelligence to "cyberattack" or "malicious use" scenarios. This makes cybersecurity the dominant frame through which companies interpret AI risk. Similarly, 61.4 percent link AI to "sustainability" or "energy consumption" concerns, reflecting the integration of AI disclosure into existing ESG reporting frameworks.

The prevalence of these associations is not inherently problematic—AI systems do create cybersecurity exposure, and large-scale model training does consume substantial energy. The problem lies in the relative absence of AI-specific risk categories. Companies have, in effect, taken their existing risk frameworks—frameworks developed for prior generations of technology—and applied AI terminology to them. The result is disclosure that sounds comprehensive but fails to address the distinctive characteristics of AI failure modes.

A model alignment failure is not a cybersecurity breach. An algorithmic discrimination event is not an environmental sustainability issue. A hallucination that exposes the company to liability is not a supply chain disruption. By forcing AI risk into the shape of legacy categories, companies are creating a false sense of security among boards and investors who may believe that existing oversight mechanisms are adequate.

### Sector-Specific Blind Spots

The pattern of legacy-dominated disclosure varies by sector in revealing ways. Healthcare and biotechnology companies show strong disclosure around data privacy concerns—a natural extension of HIPAA compliance frameworks—but weak disclosure around algorithmic bias despite its direct relevance to patient outcomes and treatment recommendations. Financial services companies show strong disclosure around fraud and cybersecurity—reflecting existing regulatory requirements—but weak disclosure around systemic AI risk and model control despite the potential for algorithmic trading and underwriting systems to generate correlated failures.

These sector-specific patterns suggest that disclosure is being driven by existing compliance infrastructure rather than by substantive AI risk assessment. Companies are disclosing what their current frameworks can measure, rather than conducting de novo analysis of what their AI deployments actually put at risk.

---

## Part IV: Company-Level Analysis

### The Disclosure Leaders

Within the dataset, a small cohort of companies demonstrates what mature AI risk disclosure looks like. These organizations address multiple risk categories with specific, tailored language and demonstrate awareness of both infrastructure and model-level concerns.

IREN Ltd leads the dataset with 128 AI-related mentions and a specificity score of 47, indicating extensive coverage of malicious use, environmental impact, and safety concerns. Ondas Holdings follows with 107 mentions and substantial attention to automation and human oversight considerations. NVIDIA Corporation, despite being an infrastructure company, provides 89 mentions with attention to supply chain, regulatory, and dual-use concerns that reflect the company's position at the center of the AI ecosystem. Sprinklr Inc and IonQ Inc round out the top performers with balanced disclosure across bias, customer data, model accuracy, and intellectual property categories.

What distinguishes these companies is not simply the volume of their disclosure but its composition. They are not merely mentioning AI more frequently; they are addressing the specific categories of risk that are most relevant to their deployments and business models. This suggests that high-quality AI disclosure is achievable within existing regulatory frameworks—the question is whether other companies will follow their lead or continue with generic approaches.

### The Generic Disclosers

At the opposite end of the spectrum, we identified 112 companies that exhibit high volumes of AI-related disclosure (more than five mentions) but provide zero specific risk disclosures addressing safety, bias, or regulatory concerns. These organizations mention AI extensively—often in the context of strategic positioning or competitive advantage—but fail to connect those mentions to any acknowledgment of downside risk.

This pattern suggests that disclosure committees at these companies may be approaching AI risk as a compliance checkbox rather than a substantive governance exercise. The likely process involves outside counsel adding "standard AI language" to existing risk factors without input from technical teams who understand the actual risks of deployed systems. The result is disclosure that satisfies the formal requirement to mention AI while providing no substantive information to investors.

---

## Part V: Governance Implications

### The Board's Fiduciary Duty

The disclosure patterns we have identified create concrete exposure for corporate directors. Under the Caremark standard, boards are required to maintain functioning systems of control and information reporting. When a material risk is known to the organization but not disclosed to investors, and that risk subsequently materializes, plaintiffs will argue that the board failed to exercise adequate oversight.

Consider the following scenario: A company deploys a customer-facing AI chatbot that generates false information about the company's products, leading to customer harm and regulatory investigation. The company's 10-K mentioned AI 50 times, all in the context of competitive advantage and infrastructure investment. It mentioned "hallucination" zero times. Plaintiffs' counsel will argue that the board knew, or should have known, that large language models hallucinate; that the company deployed such a model without disclosing this known risk; and that directors breached their fiduciary duty by approving inadequate disclosure.

The business judgment rule protects decisions made in good faith with adequate information. It does not protect decisions to withhold material information from investors. Boards that approve generic AI disclosure without substantive review of AI-specific risks are creating litigation exposure that will crystallize when the first material AI failure occurs.

### The Competence Gap

The prevalence of legacy-framed disclosure raises a more fundamental governance question: Do current board structures have the technical competence to oversee AI deployments? If audit committees are reviewing AI disclosure through the lens of cybersecurity, they may not recognize that model performance, training data liability, and regulatory compliance represent distinct risk categories requiring distinct oversight approaches.

The evidence suggests that many boards lack AI-native expertise. Directors with "digital" experience may understand e-commerce, cloud computing, and data analytics without understanding the specific characteristics of machine learning systems. The result is oversight that applies familiar frameworks to unfamiliar technologies—a recipe for undisclosed risk.

Companies that recognize this gap are beginning to constitute dedicated technology and science committees or to recruit directors with specific computational expertise. Those that do not are relying on disclosure committees that may not understand what they are approving.

### The Risk Committee's Framework Challenge

For risk committees, our findings suggest that current Enterprise Risk Management frameworks may be systematically underweighting AI exposure. If AI appears on the risk register only as a subcategory of IT security, it is being measured against the wrong baseline. AI is not an IT risk; it is a transverse risk that sits across operational, legal, reputational, and financial domains.

Model drift and decay represent operational risk—the possibility that a deployed model will degrade in performance over time without triggering existing monitoring systems. Algorithmic discrimination represents legal and reputational risk—the possibility that AI decisions will violate anti-discrimination law or damage brand equity. Training data liability represents legal and financial risk—the possibility that licensing or litigation costs will materially affect the company's cost structure. Agentic misalignment represents operational and existential risk—the possibility that autonomous AI systems will take actions that diverge from organizational intent.

None of these risks maps cleanly onto existing ERM categories. Risk committees that force AI into pre-existing frameworks are likely to underestimate exposure. Those that create standalone AI and autonomous systems categories—populated with specific scenarios rather than generic language—will develop more accurate risk pictures.

---

## Part VI: Investor Guidance

### Reading Disclosure for Signal

For institutional investors evaluating AI companies during the 2026 proxy season, our analysis suggests a revised heuristic. The presence of AI disclosure is no longer a signal of quality; near-universal adoption has reduced its informational value to zero. What matters is the composition of that disclosure.

Investors should look for evidence that companies are engaging with AI-specific risk categories rather than merely applying AI terminology to legacy concerns. Mentions of "hallucination," "training data," "alignment," "agentic," or "autonomous" suggest that the disclosure committee has engaged with substantive AI risk. Mentions of "cyberattack," "sustainability," and "compute" without corresponding specific risk language suggest that AI is being forced into legacy frameworks.

The ratio of capability claims to risk acknowledgment is informative. Companies that mention "LLM" or "generative AI" extensively without corresponding disclosure of model limitations are either unaware of those limitations or choosing not to disclose them. Both interpretations warrant concern.

Investors should also examine whether regulatory exposure is addressed with specificity. Generic statements about "evolving AI regulations" provide no information. Specific acknowledgment of the EU AI Act, quantification of compliance costs, and disclosure of current compliance status demonstrate that the company has engaged seriously with its regulatory environment.

### The Questions to Ask

Beyond disclosure analysis, investors can use the patterns we have identified to formulate direct questions for management teams and boards. The following inquiries address the core disclosure gaps:

Has the company quantified the liability exposure from model performance failures, and does its insurance coverage explicitly address algorithmic errors? Has the company conducted a legal review of training data provenance for models it has developed or licensed, and what is the estimated remediation cost if current practices are found to be infringing? Does the company's D&O insurance policy contain exclusions for AI-related claims, and has the board reviewed those exclusions in light of current deployment practices?

These questions cut to the heart of the disclosure gaps we have identified. Companies that can answer them specifically demonstrate substantive AI governance. Companies that cannot should be valued accordingly.

---

## Part VII: What Surprised Us in the Data

Before presenting stakeholder-specific guidance, it is worth pausing to note the findings that surprised even experienced governance researchers. These unexpected patterns warrant particular attention because they reveal blind spots that may not be apparent from headline statistics alone.

The first surprise concerns the near-total absence of regulatory disclosure. Only 4.6 percent of companies—77 out of 1,687—mention AI-specific regulation in their risk factors. The EU AI Act is now in force. State-level legislation is proliferating. The SEC has signaled increased scrutiny of AI-related claims. Yet fewer than one in twenty companies acknowledge that AI regulation exists, let alone that it might affect their business. This is not a disclosure gap; it is a disclosure void that defies explanation.

The second surprise is the invisibility of human oversight. One of the central debates in AI governance concerns the appropriate level of human control over automated systems. The EU AI Act explicitly requires human oversight mechanisms for high-risk AI. Academic frameworks universally emphasize human-in-the-loop controls as a primary risk mitigation. Yet only 17.2 percent of companies mention human oversight in any context. The implication is that 83 percent of companies deploying AI have either not implemented human oversight or have implemented it and chosen not to disclose that fact. Neither interpretation is reassuring.

The third surprise is the concentration of complete disclosure failures. We identified 34 companies that mention AI more than five times in their risk factors—clearly acknowledging that AI is material to their business—yet provide zero specific risk disclosures. Not merely weak disclosure or generic disclosure, but literally zero mentions of bias, safety, regulation, or model performance risk. These companies have somehow simultaneously concluded that AI is important enough to discuss extensively and that none of its risks are worth mentioning.

This cohort includes companies across multiple sectors, with tickers including IBKR (Interactive Brokers, financial services), ITW (Illinois Tool Works, industrials), AMP (Ameriprise Financial), NTAP (NetApp, data infrastructure), ZBH (Zimmer Biomet, medical devices), and WING (Wingstop, consumer). The average company in this cohort mentions AI 11 times in its risk factors while providing zero specific risk disclosure—a ratio that defies explanation. These are not small companies with unsophisticated disclosure committees; they are established public companies that have apparently concluded that AI deployment carries no risks worth disclosing.

The fourth surprise is the socioeconomic silence. Only 10.9 percent of companies mention labor displacement, economic disruption, or social impact concerns related to AI. Given the public discourse around AI and employment, the political salience of automation, and the potential for stakeholder backlash, the near-complete absence of socioeconomic risk disclosure is remarkable. Companies are either unaware that their AI deployments have workforce implications or are choosing not to disclose them.

---

## Part VIII: Implications for D&O Insurers and Reinsurers

For executives in directors' and officers' liability insurance and reinsurance, the disclosure patterns we have documented should prompt immediate portfolio review. The combination of high AI deployment, low specific disclosure, and emerging liability exposure creates conditions for correlated claims that may not be adequately priced.

### The Underwriting Blind Spot

The fundamental challenge for D&O underwriting is that current disclosure practices make it difficult to distinguish between companies with adequate AI governance and those without. When 98 percent of companies mention AI but only 6.8 percent mention AI safety, the mention itself provides no signal. Underwriters cannot rely on 10-K disclosure to assess AI risk exposure because the disclosure is uniformly generic.

This creates adverse selection concerns. Companies with sophisticated AI governance may be indistinguishable from companies with none. Pricing based on disclosed risk will systematically underprice the actual risk in portfolios with significant technology exposure. The 34 companies with extensive AI mentions and zero specific disclosure represent the extreme case, but the problem pervades the dataset.

### The Correlated Claims Scenario

The disclosure patterns also suggest potential for correlated claims events that could generate aggregate exposure in the tens of billions of dollars. Consider the following scenario analysis.

If a major court ruling establishes liability for training data infringement—as could occur in the New York Times v. OpenAI litigation—the 1,670 companies (99 percent of our dataset) that have not disclosed training data risk will simultaneously face securities claims alleging inadequate disclosure. At an average settlement of $10 million per claim (conservative for technology company securities litigation), this represents aggregate exposure of approximately $16.7 billion. At $50 million per claim (closer to historical averages for material omission cases), aggregate exposure approaches $83.5 billion. These are not independent risks; they represent correlated exposure arising from a single legal development.

Similarly, the 1,610 companies (95.4 percent) that have not disclosed AI regulation risk are exposed to simultaneous regulatory enforcement events. If the EU AI Act enforcement results in material fines against US-headquartered companies, securities litigation will follow against every company that operated in EU markets without disclosing compliance risk.

### Materiality Thresholds and Securities Law Implications

For context, the SEC has historically treated a risk as "material" if there is a substantial likelihood that a reasonable investor would consider it important in making an investment decision. Courts have applied quantitative thresholds in the range of 5-10 percent of net income or total assets as rough benchmarks, though no bright-line rule applies.

Under the EU AI Act, fines for non-compliance with high-risk AI requirements can reach €15 million or 3 percent of global annual revenue, whichever is higher. For prohibited AI practices, fines can reach €35 million or 7 percent of global revenue. These penalty structures easily clear any materiality threshold for companies with EU market exposure—yet 95 percent of companies have not disclosed this exposure.

### Questions for Insurers to Ask

D&O insurers evaluating technology company risk should consider supplementing traditional underwriting with AI-specific inquiries. Has the company conducted a legal review of training data provenance for AI models it has developed or licensed? Does the company maintain documentation of AI system testing for bias, accuracy, and safety? Has the company assessed its compliance posture under the EU AI Act and other emerging regulations? What human oversight mechanisms exist for AI systems that make consequential decisions?

Companies that can answer these questions specifically represent lower tail risk than companies that cannot, regardless of what their 10-K disclosure contains. The disclosure gap our analysis reveals means that the 10-K itself is not a reliable signal of AI governance quality.

### The Policy Exclusion Question

Finally, insurers and reinsurers should review whether existing policy language adequately addresses AI-related claims. Many D&O policies contain exclusions for "technology errors" or "product liability" that may or may not apply to AI-generated harms depending on how courts interpret the policy language. The mismatch between company AI deployment (extensive) and company AI disclosure (generic) suggests that policyholder and insurer expectations may diverge when claims arise.

---

## Part IX: Guidance for Institutional Investors

For institutional investors evaluating AI companies during the 2026 proxy season, our analysis provides a framework for due diligence that goes beyond headline AI mentions. The near-universal presence of AI disclosure means that its presence provides no signal; what matters is its composition.

### The Proxy Season Screening Framework

Investors should screen for disclosure quality across four dimensions. First, does the company acknowledge AI-specific risks as distinct from legacy technology risks? Companies that discuss AI exclusively in the context of cybersecurity or infrastructure are applying old frameworks to new technology. Second, does the company address model performance limitations? The absence of any mention of accuracy, hallucination, or reliability concerns suggests that the company either does not understand these risks or is deliberately avoiding them. Third, does the company acknowledge regulatory exposure with specificity? Generic references to "evolving regulations" provide no information; specific acknowledgment of the EU AI Act, quantified compliance costs, or disclosure of current compliance status demonstrates substantive engagement. Fourth, does the company discuss training data provenance? Given the active litigation landscape, the absence of training data disclosure is increasingly difficult to justify.

### What to Watch for This Proxy Season

The 2026 proxy season will be the first full cycle in which generative AI has been deployed at scale across the enterprise landscape. Investors should watch for several signals in updated 10-K filings. Are companies updating their AI disclosure to reflect material deployments that occurred during the fiscal year, or are they recycling prior-year language? Are companies acknowledging the EU AI Act now that it is in force, or are they continuing to treat AI regulation as hypothetical? Are companies that experienced AI-related incidents—chatbot failures, algorithmic bias allegations, training data disputes—disclosing those incidents as material events?

Companies that demonstrate year-over-year improvement in disclosure specificity are signaling governance maturation. Companies that maintain static generic disclosure despite material AI deployment expansion are signaling governance stagnation. The trajectory of disclosure quality may be as informative as its absolute level.

### Engagement Recommendations

For investors pursuing active engagement strategies, the disclosure gaps we have identified provide concrete talking points. Engagement letters might request that companies provide board-level briefing on AI risk assessment processes, ideally with attendance by the Chief Technology Officer or equivalent technical leadership. Engagement might ask companies to disclose whether they have conducted IP audits of training data for any AI models deployed in customer-facing applications. Engagement might request that companies disclose the scope and results of bias testing for AI systems that affect customer outcomes.

These inquiries move beyond the 10-K to assess the governance substance that disclosure should, but currently does not, reflect. Companies that resist such inquiries or provide only generic responses are revealing governance gaps that warrant valuation adjustment.

---

## Part X: Methodology and Limitations

### Data and Analytical Approach

This analysis is based on 1,687 SEC 10-K filings from publicly traded companies classified within the deep technology sector based on SIC codes covering technology, biotechnology, semiconductors, and related industries. The filings analyzed cover fiscal year 2024-2025, with data extracted from the SEC EDGAR database as of December 31, 2025.

We employed Python-based natural language processing to extract the Item 1A Risk Factors section from each filing. Text was analyzed against a proprietary taxonomy of 35 AI-related keywords derived from the MIT AI Risk Repository, the NIST AI Risk Management Framework, and legal scholarship on AI disclosure requirements. Keywords were classified into generic terms (signaling AI adoption) and specific terms (addressing AI-specific risks), enabling calculation of the specificity scores that inform our analysis.

### Limitations

Several limitations should inform interpretation of these findings. First, our analysis relies on keyword frequency rather than semantic analysis. It is possible that some companies disclose substantive AI risks using non-standard terminology that does not appear in our keyword taxonomy. Legal drafting conventions, however, tend to converge on standard terms, making this limitation unlikely to substantially affect our conclusions.

Second, our analysis measures disclosure, not management. A company may maintain robust internal AI safety controls while choosing to disclose them generically for competitive reasons. Conversely, a company may provide detailed disclosure while maintaining inadequate internal processes. Disclosure quality is an imperfect proxy for governance quality, though it is the proxy available to external stakeholders.

Third, our dataset is limited to US public company filings. Multinational corporations may maintain different disclosure postures in European Union, United Kingdom, or Asian jurisdictions. Cross-border comparison of AI disclosure practices represents an avenue for future research.

---

## Conclusion: The Path Forward

The 2026 proxy season represents an inflection point in corporate AI governance. The era of AI silence has definitively ended—companies are talking about artificial intelligence at unprecedented volume. But the era of AI clarity has not yet begun. The disclosure practices we have documented suggest that most companies are treating AI risk as a compliance exercise rather than a governance imperative, applying legacy frameworks to novel technologies and hoping that generic language will provide adequate legal protection.

This approach will not survive contact with reality. The first major AI liability event—a model failure that generates substantial customer harm, a training data lawsuit that fundamentally reshapes licensing economics, a regulatory enforcement action that imposes material fines—will expose the inadequacy of current disclosure practices. Companies that have disclosed specifically will have created evidentiary records of good-faith risk acknowledgment. Companies that have relied on generic language will face both the liability exposure and the additional claim that they failed to warn investors of risks they knew, or should have known, existed.

The disclosure leaders in our dataset demonstrate that high-quality AI risk disclosure is achievable within existing regulatory frameworks. The question for the remaining companies is whether they will learn from these examples proactively or be compelled to do so by litigation, enforcement, or adverse events. For boards, risk committees, and disclosure committees, the time to engage substantively with AI-specific risk is now—not after the first claim is filed.

For investors, our analysis provides a screening mechanism. Companies that exhibit the disclosure patterns we have identified as problematic—high generic volume, low specific risk acknowledgment, absence of training data and hallucination disclosure, generic regulatory language—warrant elevated due diligence. Those that demonstrate mature disclosure practices represent lower tail risk and superior governance quality. In a market where 98 percent of companies mention AI, the quality of that mention has become the differentiating signal.

The market has validated that AI is present in the enterprise. The next phase of differentiation will separate those who control AI from those who are merely along for the ride. Specific, substantive disclosure is the hallmark of control.

---

*© 2026 GovernanceIQ Research. All rights reserved.*
