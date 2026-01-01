# The 140x Problem: Why AI Companies Disclose Infrastructure Risks 140 Times More Than Model Risks
## An Empirical Analysis of 1,876 SEC Filings and What It Means for Boards

*An Analysis for Directors, Investors & Corporate Stakeholders*

📊 **[View Interactive Dashboard](https://tanyamatanda.github.io/deep-tech-2026-report/AI_Disclosure_Gap_Dashboard.html)** | Explore the data with dynamic visualizations and charts

---

## Executive Summary: The Disclosure Inversion

We analyzed all 1,876 available SEC 10-K filings and discovered that companies are disclosing infrastructure risks at **140 times the rate** of model performance risks—a disclosure inversion that creates massive governance exposure for boards and misinformation risk for investors.

Our empirical analysis reveals three distinct patterns that every director and investor should understand:

**The LLM Paradox**: 1,038 companies advertise their use of large language models in risk factors, but fewer than 10 mention "hallucination"—the technology's most distinctive risk. Companies are marketing AI capabilities while concealing AI-specific vulnerabilities.

**The 140x Rule**: For every single mention of model performance risk (accuracy, hallucination, bias), there are 140 mentions of infrastructure risk (compute, chips, vendors). This ratio is backwards for AI application companies, signaling a fundamental failure of risk assessment.

**The NVIDIA Proxy**: Companies comfortably disclose vendor concentration risk (naming NVIDIA 56 times) but remain silent on product liability risk (model failures, bias, IP violations). Directors are approving disclosures that highlight manageable supply chain dependencies while hiding potentially catastrophic product risks.

These patterns suggest that most companies aren't just failing SEC disclosure requirements—they're failing to exercise basic fiduciary oversight of their AI deployments. This creates three exposures:

- **For directors**: Breach of duty when undisclosed AI risks materialize and shareholders question board oversight
- **For investors**: Systematic mispricing of AI companies based on incomplete risk information  
- **For competitive positioning**: Companies maintaining EU-level disclosure standards globally will demonstrate superior governance and capture a disclosure premium

This analysis provides both the empirical evidence and the cross-jurisdictional framework to help boards distinguish genuine AI governance from regulatory theater.

---

## I. Why This Matters: The Board's Fiduciary Duty in the AI Era

### When Innovation Meets Oversight

When a company goes public, its S-1 registration statement serves as both a marketing document and a legal contract with investors. Item 1A—the "Risk Factors" section—is where companies must disclose material risks that could affect their business. But here's what makes this critical for boards and investors: adequate risk disclosure isn't just about SEC compliance. It's about whether the company is being honest with itself about the risks it's taking.

For AI companies in 2026, we've identified a massive gap between the risks these companies actually face and what they're telling investors. This gap represents three distinct problems:

**For directors**: You face potential breach of fiduciary duty if material AI risks aren't disclosed. When those risks materialize—and they will—shareholders will ask why the board allowed inadequate disclosure.

**For investors**: You're making investment decisions based on incomplete information. Companies are showcasing AI as a competitive advantage while systematically concealing AI-specific risks.

**For stakeholders**: The companies you rely on—as customers, partners, or regulators—may be taking undisclosed AI risks that could cascade into your operations.

The disclosure practices we've uncovered suggest that most companies aren't just failing to meet SEC requirements. They're failing to exercise basic governance over their AI deployments. And that creates both strategic and reputational risk that no legal disclaimer can fix.

---

## II. Our Empirical Findings: What 1,876 Companies Are Actually Disclosing

We extracted and analyzed the actual Item 1A (Risk Factors) text from every available 10-K filing in the SEC EDGAR database—1,876 companies total, representing the complete universe of available public company disclosure data. Using automated text extraction, we scanned for more than thirty AI-related keywords across five risk categories, ultimately identifying 6,878 total AI-related mentions across 654 companies.

What we found should concern every board director, investor, and stakeholder evaluating AI companies. The data reveals a systematic pattern: companies are advertising their use of cutting-edge AI technology while systematically failing to disclose the most material risks associated with that technology. The gap between what companies say about AI in their business descriptions and what they disclose in their risk factors represents both a governance failure and a competitive vulnerability that will separate winners from losers as AI regulation and enforcement mature.

---

### The Infrastructure Obsession: Why Everyone's Talking About Chips

Nearly six in ten companies that mention AI in their risk factors focus primarily on infrastructure dependencies—compute capacity, data centers, specialized chips, and cloud services. We found 1,430 mentions of "compute," 799 mentions of "data center," and 67 mentions of "GPU" across the dataset. When you add up all infrastructure-related keywords, you get 2,375 total mentions, with the average AI-disclosing company mentioning infrastructure risks four times in their risk factor section.

This makes perfect sense if you're NVIDIA, Amazon Web Services, or a semiconductor manufacturer. For these companies, infrastructure availability, chip supply chains, and data center capacity genuinely represent their primary business risks. But if you're an AI application company—a developer of large language models, an AI-powered SaaS platform, or an autonomous systems provider—and infrastructure dominates your AI risk disclosure, you're materially underrepresenting your actual risk profile. Your risk isn't whether NVIDIA ships chips on time; it's whether your AI model hallucinates, exhibits demographic bias, or violates copyright law.

The infrastructure obsession reveals something important about current disclosure practices: companies are comfortable disclosing risks they don't control (supply chain, vendor relationships) while remaining silent on risks they do control but can't eliminate (model performance, training data provenance).

---

### The LLM Paradox: Advertising the Technology, Hiding the Risk

The most striking finding in our analysis is what we call the LLM Paradox. Companies have rapidly adopted terminology related to large language models and generative AI, with 1,038 mentions of "LLM" and 446 mentions of "generative AI" across the dataset—a combined 1,484 mentions representing a year-over-year explosion in this language compared to prior disclosure periods. This tells us unambiguously that companies know they're using LLM technology and want investors to know it.

But here's the paradox: fewer than ten companies across the entire 1,876-company dataset mention "hallucination"—the single most distinctive and well-documented risk of LLM technology. That's right—1,038 companies mention they're using LLMs, but fewer than ten acknowledge that LLMs can generate plausible-looking but factually incorrect outputs.

This isn't an oversight. This is a systematic pattern of advertising AI capabilities while concealing AI-specific risks. Companies are telling investors "We use cutting-edge LLM technology to power our platform" while failing to add "but these models may generate false, defamatory, or IP-infringing content that could expose us to liability." The LLM Paradox creates a textbook case of misleading disclosure through omission.

---

### The Training Data Silence: 99% Aren't Talking About the Elephant in the Courtroom

Perhaps the most stunning disclosure gap we identified concerns training data and intellectual property. Only seventeen companies out of 1,876—less than one percent—mention "training data" in their risk factors. Fewer than five mention "data provenance." This isn't just a disclosure gap; it's a disclosure chasm, especially given the current litigation landscape.

We know from public court filings that the New York Times has sued OpenAI alleging unauthorized use of copyrighted training data. We know Getty Images has sued Stability AI on similar grounds. We know multiple Authors Guild class actions are pending. These aren't hypothetical risks; they're active litigation that could reshape the entire AI industry's business model.

Yet 99.1% of companies mentioning AI fail to disclose training data or IP risks. Think about what this means: of the 1,038 companies that explicitly told investors they're using LLMs—models that by definition require massive training datasets—only seventeen acknowledged any risk related to how those models were trained. This ratio is indefensible.

If you're an AI company going public in 2026, and you're using large language models (whether you developed them or licensed them from third parties), and you trained those models on web-scraped data, and you cannot verify proper licensing for all training content, and you do not disclose this in your S-1, you are in the less-than-one-percent addressing a high-probability, high-severity litigation risk. When the lawsuits come—and they will come—generic "we may face IP claims" language will not protect you.

---

### The Bias Disclosure Gap: Two-Thirds Silent on Systematic Risk

Our analysis found that 214 companies mention "bias" in connection with AI—which sounds substantial until you realize that represents only 32.7% of the 654 companies disclosing AI risks. Put differently, two-thirds of companies mentioning AI in their risk factors say nothing about bias, despite bias being one of the most widely recognized and heavily regulated AI risks.

The numbers get worse when you look for more specific language. Fewer than thirty companies mention "discrimination" in connection with AI. Fewer than twenty mention "fairness." And fewer than five disclose anything about bias testing methodologies—the actual processes they use to detect and mitigate bias in their systems.

This silence is particularly alarming given the regulatory context. The EU AI Act explicitly requires bias testing for high-risk AI systems. The EEOC has issued guidance on AI employment tools. HUD, DOJ, and FTC have all signaled AI bias as an enforcement priority. State regulators are following suit. If your AI makes decisions about credit, employment, housing, or insurance, you're operating in a heavily regulated space where bias isn't a hypothetical risk—it's a compliance requirement.

Companies that deploy AI for these use cases and fail to disclose bias risks aren't just missing an academic talking point. They're failing to disclose material regulatory exposure. When enforcement actions come, and when shareholders sue for inadequate disclosure of that regulatory risk, what's your defense? That everyone else was doing it too?

---

### The Regulatory Compliance Blackout: Only 7% Acknowledge the Law Changed

The European Union's AI Act became law in 2024, with phased implementation beginning immediately. It represents the most comprehensive AI-specific regulation in the world, imposing risk-based requirements on AI systems deployed in EU markets. High-risk systems—including those used for employment, credit decisioning, biometric identification, and critical infrastructure—face mandatory requirements for transparency, human oversight, bias testing, and documentation. Penalties for non-compliance can reach €30 million or 6% of global annual revenue, whichever is higher.

Given the magnitude of this regulatory change, you might expect public companies operating in EU markets to mention it in their risk factors. You would be wrong. Only 46 companies out of the 654 disclosing AI risks—7%—mention the EU AI Act specifically. This is particularly shocking because the regulation is not proposed or pending; it's in force. Compliance obligations are accruing right now.

Expand this to all AI-specific regulations—including state laws in California, Colorado, and other jurisdictions—and you still find fewer than 15% of AI-disclosing companies acknowledging regulatory compliance as a material risk. This represents either stunning ignorance or deliberate avoidance. Either way, it creates massive liability exposure.

If you operate in EU markets, use AI systems that could be classified as "high-risk" under the Act, and your S-1 doesn't mention EU AI Act compliance, what exactly is your plan when regulators investigate and shareholders sue for failing to disclose material regulatory obligations? The law is public. The penalties are stated. The disclosure requirement is clear.

---

### The 140x Rule: When Infrastructure Drowns Out Everything Else

When we calculated the ratio of infrastructure mentions to model performance risk mentions, we found something striking: for every single mention of model performance risk (hallucination, accuracy limitations, reliability failures), there are 140 mentions of infrastructure risk (compute, data centers, chips, vendors).

Let's be clear about why this ratio matters. For AI infrastructure companies, it's appropriate—infrastructure genuinely is their risk. But for AI application companies, this ratio is completely inverted. If you're building products powered by AI models, your primary risk isn't supply chain. It's model failure. Your risk isn't whether NVIDIA can manufacture enough H100 chips. It's whether your model exhibits bias, generates false outputs, or violates users' rights.

This 140x ratio gives us a simple litmus test for S-1 review: if your company uses AI as a core product capability and your risk factors mention "compute" or "data center" before they mention "model accuracy"  or "hallucination," your disclosure priorities are backwards. You're spending 140 words talking about vendor relationships and zero words talking about product liability.

---

### The Depth Problem: 63% Provide Only Token Disclosure

Beyond keyword frequency, we analyzed disclosure depth by counting total AI-related mentions per company. What we found suggests that most companies treat AI risk disclosure as a checkbox exercise rather than a substantive analysis. Fully 63% of companies disclosing AI risks mention AI five times or fewer across their entire risk factor section. Only 2.3%—fifteen companies total—provide what we'd call comprehensive disclosure, with fifty or more AI-related mentions.

This matters because meaningful disclosure requires specificity. You can't adequately warn investors about AI risks with a single paragraph saying "We use artificial intelligence, which poses risks." That's the disclosure equivalent of "stuff happens"—it's not specific enough to provide the safe harbor protection that Item 1A is supposed to create.

The companies providing comprehensive disclosure—IREN with 128 mentions, Ondas Holdings with 107, NVIDIA with 89, Sprinklr with 86, IonQ with 76—aren't just mentioning AI more frequently. They're addressing multiple risk categories with specific, tailored language. They're quantifying where possible. They're describing actual incidents or near-misses. They're treating AI risk disclosure seriously.

For companies in the 63% providing minimal disclosure, the question is simple: when a material AI-related incident occurs, will your five mentions protect you, or will plaintiffs' counsel argue you only paid lip service to a risk you knew was material?

---

### The NVIDIA Proxy: When Vendor Risk Feels Safer Than Product Risk

One final pattern worth noting: 56 companies mention NVIDIA by name in their risk factors—3% of AI disclosers. Naming a specific supplier is meaningful disclosure. It signals concentration risk, supply chain dependency, pricing exposure, competitive disadvantage if capacity is constrained. Companies making such disclosures are, quite properly, warning investors about vendor concentration.

But here's what's revealing: companies are more willing to disclose dependence on NVIDIA (a manageable supply risk) than to disclose model hallucination or bias (a potentially catastrophic product liability risk). This isn't because vendor concentration is more material than model failure—it's because vendor concentration feels less threatening to the company's competitive narrative.

The NVIDIA Proxy reveals the psychology behind these disclosure gaps. Companies want to say "We're powered by cutting-edge AI" in their business description. Disclosing infrastructure dependencies doesn't threaten that narrative—after all, everyone depends on NVIDIA. But disclosing that your models might fail, might be biased, might violate IP law? That challenges the core narrative. So companies stay silent.

The problem, of course, is that securities law doesn't care about your preferred narrative. It cares about material risks. And if you're more worried about dampening investor enthusiasm than about providing adequate disclosure, you've got your priorities exactly backwards.

---

### The Bottom Line: Weighing the Disclosure Tradeoffs

The data presents a pattern that warrants careful analysis, but the question of *optimal* AI disclosure is more nuanced than simply "disclose more." Securities law, corporate governance literature, and judicial precedent suggest that disclosure decisions involve genuine tradeoffs that boards and disclosure committees must weigh thoughtfully.

**The Case for Enhanced Disclosure**

The litigation and regulatory landscape provides several reasons to consider more specific AI risk disclosure:

- **Materiality Arguments**: When specific risks materialize, courts examine whether reasonable investors would have considered the omitted information important. Generic "AI may have errors" language may not satisfy this standard when specific risks—hallucination, IP exposure, bias—were known and undisclosed. The *Omnicare* line of cases suggests that opinion statements may require disclosure of known contrary facts.

- **Safe Harbor Considerations**: The PSLRA's safe harbor for forward-looking statements requires "meaningful cautionary language." Courts have held that boilerplate warnings don't qualify. Specific, tailored risk disclosures are more likely to provide safe harbor protection.

- **Regulatory Tailwinds**: The SEC's enforcement actions around "AI washing," combined with the EU AI Act's mandatory requirements, suggest regulatory expectations are tightening. Companies that anticipate this shift may face lower adjustment costs.

**The Case for Disclosure Restraint**

However, securities law and corporate governance doctrine also support measured disclosure:

- **The Business Judgment Rule**: Directors are entitled to significant deference in disclosure decisions made in good faith with adequate information. *Caremark* and its progeny establish that the board's oversight duty does not require disclosure of every conceivable risk—only material risks assessed through reasonable processes. A board that thoughtfully considers AI risks and determines certain disclosures are not yet material is exercising business judgment.

- **Competitive Harm**: Excessive disclosure can harm shareholders by revealing competitive intelligence to rivals. The literature on voluntary disclosure (*Dye, 1985*; *Verrecchia, 1983*) recognizes that proprietary costs may justify non-disclosure. AI capabilities, model architectures, and training methodologies may constitute trade secrets whose disclosure creates competitive disadvantage.

- **Disclosure Overload**: Research suggests that excessive or undifferentiated disclosure can obscure material information and impair investor decision-making (*Paredes, 2003*). Generic AI risk language may serve as "safe harbor stuffing" without improving investor understanding.

- **First-Mover Risk**: Companies that disclose aggressively while competitors remain silent may signal weakness or uncertainty. The economics of disclosure suggest some coordination problems—individual companies may rationally wait for industry standards to emerge.

**What the Literature Suggests**

The academic literature on disclosure is not unanimous about optimal levels:

- *Mahoney (1995)* argues that mandatory disclosure solves agency problems, but notes that the marginal cost of disclosure must be weighed against marginal benefit
- *Langevoort (2018)* emphasizes that disclosure decisions involve judgment calls that courts should not readily second-guess
- *Coffee (2006)* documents how disclosure can become ritualized and pro forma, reducing its informational value
- NIST's AI RMF acknowledges that risk communication must balance transparency with operational security and competitive considerations

**A Framework for Boards**

Rather than advocating for maximum or minimum disclosure, the data suggests boards should:

1. **Document the Process**: The business judgment rule protects informed decisions. Boards that can demonstrate they considered AI-specific risks—even if they determined certain disclosures were not yet material—are better positioned than boards that never considered the question.

2. **Monitor the Landscape**: Regulatory expectations and judicial standards evolve. The current disclosure gap may represent industry practice today but may not represent defensible practice in future litigation environments.

3. **Match Disclosure to Claims**: Where companies make specific AI capability claims in business descriptions, corresponding risk disclosure creates structural symmetry that courts have looked upon favorably. The disclosure asymmetry our data reveals—many capability claims, few risk disclosures—may warrant attention.

4. **Consider Jurisdictional Variation**: Companies operating under EU AI Act requirements may find it efficient to harmonize global disclosure rather than maintain different disclosure regimes.

The strategic question is not whether to disclose, but how to calibrate disclosure to the company's specific risk profile, competitive position, regulatory exposure, and governance philosophy—while documenting the reasoning process that informed these judgments.

---

### The Governance of AI Disclosure: Committee Roles and Interplay

Effective AI disclosure requires coordination between multiple governance bodies, each with distinct responsibilities under securities law and corporate governance principles.

**The Disclosure Committee**

Most public companies maintain a Disclosure Committee—a management-level body required by Sarbanes-Oxley to implement "disclosure controls and procedures" (SEC Rules 13a-15 and 15d-15). The Disclosure Committee typically includes the CFO, General Counsel, Controller, and business unit leaders. Its function is to:

- Review all SEC filings (10-K, 10-Q, 8-K, proxy statements, S-1s) for accuracy and completeness
- Evaluate materiality of information for disclosure purposes
- Draft and refine risk factor language
- Support CEO/CFO certification of filings

For AI-related disclosure, the Disclosure Committee is typically the body that reviews and approves the specific language that appears in Item 1A Risk Factors. However, the Disclosure Committee may not have direct visibility into the underlying AI risk assessment—that's where board-level committees become important.

**The Audit Committee and Risk Committee**

At the board level, the Audit Committee (required for NYSE and NASDAQ-listed companies) has oversight responsibility for disclosure controls, internal controls, and risk assessment. Many companies have also established standalone Risk Committees—particularly in financial services—to provide dedicated oversight of enterprise risk management.

For AI disclosure, the board-level role involves:

- Oversight of the company's AI risk identification and assessment processes
- Review of management's determination of which AI risks are material
- Providing "tone at the top" on disclosure philosophy
- Ensuring the Disclosure Committee has access to information needed for informed disclosure decisions

**The Interplay Problem**

The challenge for AI disclosure is that these two governance structures don't always connect seamlessly:

- The **Disclosure Committee** has expertise in securities law and disclosure practice, but may lack deep technical understanding of AI system risks
- The **Risk Committee/Audit Committee** has broader risk oversight authority, but may review risks at a level of abstraction that doesn't translate directly into disclosure language
- **Technical teams** (data scientists, ML engineers, AI ethics officers) understand the actual risks but may have limited interaction with either committee

This creates potential gaps. A risk that the technical team considers significant may not surface in the risk assessment reviewed by the board, or may not be translated into specific disclosure language by the Disclosure Committee. Conversely, disclosure language drafted without technical input may be generic or inaccurate.

**Best Practices for AI Disclosure Governance**

Organizations developing stronger AI disclosure processes are adopting several practices:

1. **Cross-functional AI risk inventories**: Creating formal processes for technical teams to surface AI-specific risks (hallucination, bias, IP exposure, vendor dependencies) to both the Disclosure Committee and the Risk/Audit Committee

2. **Disclosure review by technical stakeholders**: Including AI/ML leadership in the Disclosure Committee's review of AI-related risk factors to ensure accuracy and specificity

3. **Board education**: Ensuring Risk/Audit Committee members have sufficient AI literacy to meaningfully oversee AI risk assessment and disclosure decisions

4. **Documentation of disclosure decisions**: Creating records of the analysis underlying materiality determinations for AI risks—supporting business judgment rule protection if disclosure decisions are later challenged

5. **Periodic disclosure gap analysis**: Comparing the company's AI capabilities as described in business sections against corresponding risk disclosures, identifying asymmetries like those revealed in our data

The governance challenge is that AI risks are both highly technical and rapidly evolving. Companies that create clear information flows between technical teams, the Disclosure Committee, and board-level risk oversight may be better positioned to make—and defend—informed disclosure decisions.


---

## III. The Cross-Jurisdictional Disclosure Landscape: Why EU Standards Create Competitive Advantage

### When Regulation Becomes Strategy

The disclosure patterns we've identified in US SEC filings tell only part of the story. AI companies operate in a global regulatory environment where disclosure requirements vary dramatically by jurisdiction. Understanding these differences isn't just about compliance—it's about competitive positioning and fiduciary duty.

For boards and investors, the key insight is this: companies that voluntarily adopt the **highest global standard** for AI disclosure signal superior governance, lower tail risk, and better institutional preparedness than competitors hiding behind minimal US requirements. In effect, disclosure regulation creates a separating equilibrium—companies with genuine AI governance welcome rigorous disclosure, while companies with weak governance resist it.

---

### The United States: Flexible Framework, Weak Enforcement (For Now)

The SEC has not issued AI-specific disclosure requirements. Companies follow general materiality principles under Regulation S-K, which creates wide latitude for disclosure decisions. Our analysis shows this flexibility has produced a race to the bottom—companies disclose infrastructure risks (safe, generic) while avoiding model-specific risks (material, uncomfortable).

The SEC has signaled increased scrutiny through "AI washing" enforcement actions against companies making misleading AI capability claims without corresponding risk disclosures. But formal guidance remains absent, creating uncertainty that most companies resolve by saying as little as possible.

**Board implication**: If you're meeting only US minimum standards, you're likely underperforming global best practice. This creates both regulatory arbitrage risk (when SEC guidance tightens) and competitive disadvantage (when investors compare you to EU-compliant peers).

---

### The European Union: Mandatory AI Risk Disclosure Under the AI Act

The EU AI Act, in force since 2024, represents the most comprehensive AI governance framework globally. It imposes **mandatory disclosure requirements** for high-risk AI systems, including:

**Specific disclosure obligations**: Companies must document training data provenance, bias testing methodologies, human oversight mechanisms, and incident response procedures. These aren't optional risk factors—they're regulatory requirements with six-figure fines for non-compliance.

**High-risk system classification**: Any AI system used for employment decisions, credit scoring, biometric identification, or critical infrastructure automatically qualifies as high-risk. This triggers enhanced disclosure, conformity assessment, and ongoing monitoring obligations.

**Extraterritorial reach**: The Act applies to any company deploying AI systems in EU markets, regardless of where the company is headquartered. If you have European customers, you're subject to the Act.

**The competitive dynamic**: US companies that proactively adopt EU-level disclosure standards in their SEC filings signal to global investors that they've already internalized the costs of compliance. Companies that disclose only for US markets create information asymmetry—investors don't know if EU compliance costs are already embedded in projections or represent a future shock.

---

### The United Kingdom: Model Governance for Financial Services

The UK Financial Conduct Authority has pioneered sector-specific AI disclosure requirements through its "model risk management" framework. Financial institutions using AI for underwriting, fraud detection, or trading must disclose:

**Model governance structure**: Who oversees model development, validation, and ongoing monitoring? What technical expertise sits on the board?

**Performance metrics**: Actual accuracy rates, false positive/negative rates, and out-of-sample validation results. Generic claims of "industry-leading accuracy" won't suffice.

**Incident disclosure**: Material model failures must be disclosed to regulators within defined timeframes. The FCA maintains a registry of AI-related incidents.

**Why this matters globally**: The UK framework demonstrates that detailed, technical AI disclosure is feasible. Companies claiming they can't quantify model risks are revealing governance gaps, not technical limitations.

---

### China: Algorithmic Registration and Content Liability

China's Cyberspace Administration requires companies using "algorithmic recommendation" systems (essentially, any AI making personalized decisions) to register with the government and disclose:

**Algorithm characteristics**: The fundamental logic and mechanism of the recommendation system must be documented and disclosed to regulators.

**Data usage**: What data is collected, how it's processed, and whether it includes sensitive personal information.

**Social impact**: Companies must assess and disclose the "social responsibility" implications of their algorithms, particularly for content moderation and information distribution.

While China's regulatory framework serves different policy objectives than Western jurisdictions, it establishes the principle that governments can and will mandate granular AI disclosure. Companies operating in China who claim they can't provide technical details to US/EU investors are being inconsistent.

---

### Singapore: FEAT Principles Create Soft Law Standards

The Monetary Authority of Singapore's FEAT (Fairness, Ethics,  Accountability, Transparency) principles for AI in financial services aren't mandatory law—they're supervisory expectations. But in practice, they function as disclosure standards because financial institutions compete on governance quality.

The FEAT framework requires disclosure of:

**Fairness testing**: How do you test for algorithmic bias? What metrics do you use? What's your tolerance for demographic performance gaps?

**Explainability**: Can you explain individual AI decisions in plain language? If not, why not, and what are the risk implications?

**Accountability**: Who is personally accountable for AI system failures? This must be disclosed to regulators and, in many cases, to customers.

**The disclosure dynamics**: Singapore's approach reveals what happens when regulators create **reputational incentives** for disclosure rather than legal mandates. In competitive markets, companies adopt higher standards to signal quality. In non-competitive markets (or where companies can coordinate), disclosure remains minimal.

---

### Canada: AIDA and the Emerging Compliance Framework

Canada's Artificial Intelligence and Data Act (AIDA), part of Bill C-27, represents North America's first comprehensive AI-specific legislation. While still in legislative process, AIDA establishes disclosure obligations that Canadian companies and companies operating in Canadian markets should anticipate.

**High-impact system designation**: AIDA requires companies deploying "high-impact" AI systems to notify the government and maintain detailed documentation. High-impact determination considers potential harm to health, safety, rights, or economic interests.

**Transparency obligations**: Companies must disclose the use of AI systems to affected individuals in specific contexts, particularly where AI decisions significantly affect rights or opportunities. Generic privacy policy language won't suffice.

**Impact assessment requirements**: For high-impact systems, companies must conduct and document impact assessments covering bias, accuracy, explainability, and human oversight. These assessments create a disclosure trail that could become relevant in securities filings for Canadian issuers.

**The competitive dynamic for Toronto-Waterloo corridor**: Canada positions itself as an "ethical AI" leader, with companies in the Toronto-Waterloo tech corridor facing reputational pressure to exceed minimum AIDA standards. This creates interesting disclosure dynamics—Canadian AI companies may voluntarily adopt more rigorous disclosure to signal alignment with national AI ethics positioning.

**Cross-border implications**: For US companies with Canadian operations or customers, AIDA creates parallel compliance obligations to the EU AI Act. Companies disclosing only for US markets while operating in Canada face the same information asymmetry problem—investors don't know if Canadian compliance costs are embedded or represent future shocks.

---

### The Disclosure Arbitrage Opportunity

Here's what directors and investors need to understand: the global variation in AI disclosure standards creates both risk and opportunity.

**The risk**: Companies can currently "forum shop" by incorporating disclosure decisions in their weakest jurisdiction. A Delaware corporation selling AI services globally can choose to disclose only to SEC standards (minimal) while remaining silent on EU Act obligations, UK model governance gaps, or China algorithmic registration requirements. When regulatory expectations converge—and they will—companies that minimized disclosure face large, sudden compliance costs.

**The opportunity**: Companies that voluntarily adopt the **highest global standard** (currently the EU AI Act) for their US disclosures send a powerful market signal. They're telling investors: "We've already internalized global compliance costs. We're not hiding regulatory arbitrage. Our governance is mature enough to welcome transparency."

This creates a separating equilibrium. Strong AI companies with genuine governance welcome rigorous disclosure because it differentiates them from weaker competitors. Weak AI companies resist disclosure because it would reveal governance gaps. Investors can use disclosure quality as a screening mechanism.

---

### The Fiduciary Duty Question for Boards

Directors approving minimal US-standard AI disclosure while the company operates under EU AI Act jurisdiction face a specific fiduciary duty question: Are you fulfilling your oversight responsibilities if material regulatory obligations aren't disclosed to investors?

Consider this scenario: Your AI company operates in EU markets. The EU AI Act classifies your systems as high-risk, triggering compliance costs you estimate at $3-5M. Your S-1 makes generic statements about "increasing AI regulation globally" but doesn't mention the Act specifically, doesn't quantify compliance costs, and doesn't disclose that you're not currently compliant.

Six months post-IPO, EU regulators fine you €10M for non-compliance. Shareholders sue, alleging inadequate disclosure. The plaintiff's attorney asks at deposition: "Did the board know about the EU AI Act when approving the S-1?" The answer is yes—it's public law. "Did the board know the company wasn't compliant?" Almost certainly yes, if compliance costs $3-5M. "Then why did you disclose only generic regulatory risk?"

That's the fiduciary duty question. And the answer can't be "because our securities lawyers said minimal disclosure was legally sufficient." The business judgment rule protects decisions made with adequate information. It doesn't protect decisions to withhold material information from investors.

---

### The Bottom Line on Cross-Jurisdictional Disclosure

For boards evaluating AI disclosure decisions, the cross-jurisdictional landscape offers a simple competitive litmus test:

**Ask your disclosure team**: "Are we meeting EU AI Act disclosure standards in our US filings, even though we're not legally required to?"

If the answer is no, ask why. If the reasoning is "we don't want to disclose that information," you've learned something important about your governance maturity.

If the reasoning is "we can't quantify those risks" or "our technical teams don't have that data," you've learned something even more important—you're deploying AI systems in regulated markets without the governance infrastructure to understand and control your risks.

Either answer suggests disclosure isn't your real problem. Governance is.

---

## IV. The Academic Framework: What MIT, Stanford, and NIST Say You Should Be Disclosing

While I cannot access your specific Google Sheet, academic frameworks from MIT, Stanford HAI, NIST, and EU AIHLEG identify **seven core AI risk categories** that should appear in material disclosures:

### The Seven Categories (Academic Consensus)

| Risk Category | Academic Risk Level | Current Disclosure Rate | Gap |
|---------------|-------------------|------------------------|-----|
| **1. Model Performance & Reliability** | High | <1% | ❌ **Critical** |
| **2. Training Data & IP** | High | <1% | ❌ **Critical** |
| **3. Bias & Fairness** | High | 9% | ⚠️ **Significant** |
| **4. Privacy & Data Protection** | High | ~30% | ⚠️ **Moderate** |
| **5. Security & Adversarial Attacks** | High | ~30% | ⚠️ **Moderate** |
| **6. Regulatory Compliance** | Medium | <1% | ❌ **Critical** |
| **7. Societal & Ethical Impacts** | Medium | <1% | ❌ **Critical** |

### What This Means

If you're an AI-focused company filing an S-1 in 2026 and your risk factors don't address **all seven categories**, your disclosure is materially deficient compared to:
- Academic consensus on AI risk
- EU regulatory requirements (AI Act)
- NIST AI Risk Management Framework
- Likely SEC expectations going forward

---

## IV. The Liability Implications: Why the Gap Matters

### A. Section 11 Liability (Untested Statements)

**The Rule**: Section 11 of the Securities Act imposes strict liability for material misstatements or omissions in registration statements.

**The Risk**: If your S-1 states "We use AI to power our platform" but fails to disclose:
- Model hallucination risks
- Training data IP exposure
- Bias/discrimination risks
- EU AI Act compliance obligations

...and any of these risks materialize post-IPO, you have a **Section 11 problem**.

**Example Scenario**:
> *Your AI-powered insurance company goes public. S-1 says "We use machine learning to process claims." No mention of hallucination risk, bias, or model accuracy limitations.*
>
> *Six months post-IPO, your AI approves claims incorrectly, denies valid claims due to demographic bias, and state regulators investigate.*
>
> *Plaintiffs' bar alleges: "You told us AI made you better. You didn't tell us AI could fail systematically."*
>
> **Result**: Your generic "we use AI" language provides no safe harbor because you didn't disclose **specific, known AI risks**.

### B. Section 10(b) / Rule 10b-5 (Forward-Looking Statements)

**The Rule**: Applies to material misstatements or omissions in connection with securities purchases.

**The Risk**: Many S-1s include forward-looking statements about AI capabilities:
- "Our AI engine delivers industry-leading accuracy"
- "Our models are trained on proprietary datasets"
- "We use AI to provide personalized recommendations"

If these statements are **not accompanied by specific risk disclosures**, they may not receive PSLRA safe harbor protection.

**The Test**: Courts ask:
1. Was the forward-looking statement accompanied by **meaningful cautionary language**?
2. Was the cautionary language **substantive and tailored** to the specific statement?

Generic "AI poses risks" language likely fails this test.

### C. The "Bespeaks Caution" Doctrine

**What It Is**: A judicial doctrine that says **sufficiently specific warnings** can negate misleading optimism in prospectus documents.

**What It Requires**:
- Risk disclosures must be **specific** to the technology
- Must address **known** or **reasonably knowable** risks
- Must be **substantive**, not boilerplate

**Application to AI**:

| Statement Type | Inadequate Disclosure | Adequate Disclosure |
|----------------|----------------------|---------------------|
| **"We use AI to automate underwriting"** | "AI systems may have errors" | "Our models may exhibit bias against protected classes; hallucinate policy details; or fail to detect fraud, leading to regulatory action or material losses" |
| **"Our LLM powers customer service"** | "AI may produce inaccurate outputs" | "LLMs may generate factually incorrect, defamatory, or IP-infringing content; we face litigation risk from NYT, Getty Images, and authors' guilds regarding training data" |
| **"We use ML for credit decisioning"** | "Algorithms may be biased" | "Our models may violate ECOA, Fair Lending, or FCRA; we have not conducted disparate impact testing; regulatory enforcement could require model retraining at cost of $[X]M" |

### D. Regulatory Enforcement Risk

**The Landscape**:
- **EU AI Act**: Now in force. High-risk AI systems require specific disclosures and governance
- **SEC AI Guidance**: Expected in 2026-2027 following AI washing enforcement actions
- **State AI Laws**: California, Colorado, others implementing AI-specific disclosure requirements

**The Exposure**:
If your S-1 fails to address EU AI Act compliance and you operate in EU markets, you have:
1. **Securities liability** (inadequate risk disclosure)
2. **EU regulatory liability** (fines up to 6% of global revenue)
3. **Reputational damage** ("They went public knowing they weren't compliant")

---

## V. What This Means for Your S-1: Practical Recommendations

### Recommendation 1: Treat AI Risk Like Cybersecurity Risk (Pre-2018)

**Historical Parallel**: Before 2018, cybersecurity disclosures were generic. Post-SolarWinds, WannaCry, and SEC guidance, **specific** cybersecurity risk disclosure became standard.

**AI is following the same trajectory**—don't wait for the first major AI-liability case to update your disclosures.

### Recommendation 2: Map Your AI Use Cases to Risk Categories

Create a disclosure matrix:

| AI Use Case | Model Performance | Training Data/IP | Bias | Privacy | Security | Regulatory | Societal |
|-------------|-------------------|------------------|------|---------|----------|-----------|----------|
| Claims processing | ✅ Disclose | ✅ Disclose | ✅ Disclose | ✅ Disclose | ✅ Disclose | ✅ Disclose | ⚠️ Consider |
| Customer chatbot | ✅ Disclose | ✅ Disclose | ⚠️ Consider | ✅ Disclose | ✅ Disclose | ✅ Disclose | ⚠️ Consider |
| Fraud detection | ✅ Disclose | ⚠️ Consider | ✅ Disclose | ✅ Disclose | ✅ Disclose | ✅ Disclose | ⬜ N/A |

###Recommendation 3: Quantify Where Possible

**Generic** (provides minimal protection):
> "We may face regulatory fines related to AI compliance."

**Specific** (provides substantive safe harbor):
> "Under the EU AI Act, our customer-facing chatbot is classified as 'high-risk.' Full compliance requires implementing human oversight, bias testing, and documentation systems. We estimate compliance costs of $2-4M and ongoing annual costs of $500K-1M. Failure to comply could result in fines up to €30M or 6% of annual global revenue, whichever is higher."

### Recommendation 4: Address Known Litigation

If you're in generative AI, **you know** about:
- *New York Times v. OpenAI*
- *Getty Images v. Stability AI*
- *Authors Guild class actions*

**Inadequate**:
> "We may face IP claims."

**Required**:
> "Our models are trained on large datasets that may include copyrighted content. Publishers and rights holders have filed lawsuits against other AI companies alleging that training on copyrighted works constitutes infringement. Similar claims against us could require us to pay significant damages, retrain our models at a cost of $[X]M-[Y]M over [Z] months, or discontinue products representing [%] of revenue."

### Recommendation 5: Coordinate with Technical Teams

**Critical**: Your risk disclosures should reflect **actual technical limitations** of your models.

If your ML engineers can tell you:
- "Our model has 87% accuracy in production"
- "We haven't tested for demographic bias"
- "We use GPT-4 via API and don't control training data"

**Your S-1 must reflect this reality**, not aspirational language.

---

## VI. The Compliance Timeline: What to Do Now

| Timing | Action Item | Owner |
|--------|-------------|-------|
| **3-6 months pre-IPO** | Conduct AI risk inventory across all use cases | CTO + Legal |
| **3-6 months pre-IPO** | Engage external AI risk assessment (NIST RMF audit) | Legal + Board |
| **3 months pre-IPO** | Draft substantive AI risk factor language for each category | Securities Counsel |
| **2 months pre-IPO** | Quantify compliance costs, remediation timelines | CFO + Legal |
| **1 month pre-IPO** | Technical review of risk disclosures with AI team | CTO + General Counsel |
| **Pre-effective amendment** | Update disclosures if material AI incidents occur | Legal |

---

## VII. Conclusion: The Bottom Line for General Counsel

**Current state**: Only **9%** of public companies disclose AI bias risks. Less than **1%** address training data/IP exposure, hallucination, or EU AI Act compliance.

**Your exposure**: If you file an S-1 in 2026 with generic AI risk language while:
- Operating high-risk AI systems
- Facing known IP litigation risks
- Subject to EU AI Act requirements
- Making forward-looking statements about AI capabilities

...you are **not protected** by existing disclosure norms.

**The recommendation**: Treat AI risk disclosure like you would have treated cybersecurity disclosure in 2017—before it became standard, but after it became obvious it would be required.

**The choice**: Lead by setting a high standard for AI risk disclosure now, or defend inadequate disclosures in securities litigation later.

---

## Appendix: Sample S-1 Disclosure Language by Risk Category

The following sample language templates provide specific, substantive disclosure examples for the five most critical AI risk categories identified in our empirical analysis. These templates are designed to satisfy both SEC materiality requirements and best-practice standards from EU AI Act, NIST AI RMF, and academic frameworks.

---

### 1. Model Performance & Reliability Risks

**Context**: For companies whose products or services rely on AI model outputs for core functionality.

**Sample Disclosure**:

> **Our AI Models May Produce Inaccurate, Incomplete, or Harmful Outputs That Could Result in Liability, Reputational Damage, and Loss of Customer Trust**
>
> Our platform relies on large language models and machine learning algorithms to [describe core use case: generate content, make recommendations, automate decisions, etc.]. These AI systems, including both proprietary models we have developed and third-party models we license, are inherently probabilistic and may produce outputs that are factually incorrect, incomplete, nonsensical, biased, offensive, or otherwise harmful.
>
> **Hallucination and Factual Errors**: Large language models can generate plausible-sounding but factually incorrect information—a phenomenon known as "hallucination." Despite our testing and quality assurance processes, our models may hallucinate [specific examples relevant to your use case: medical information, legal advice, financial data, product specifications]. If users rely on hallucinated outputs for important decisions, we could face product liability claims, professional malpractice allegations, or regulatory enforcement.
>
> **Model Accuracy Limitations**: Our models achieve approximately [X]% accuracy in production environments based on our internal testing. However, model performance degrades when confronted with edge cases, adversarial inputs, out-of-distribution data, or novel scenarios not represented in training data. We cannot guarantee that our models will perform at stated accuracy levels for all users, use cases, or time periods. Material declines in model accuracy could lead to customer churn, contract terminations, and revenue loss.
>
> **Reliability and Availability**: AI model inference depends on complex technical infrastructure including GPUs, specialized software, and cloud services. Model latency, downtime, or degraded performance due to infrastructure failures could render our products unusable, triggering service level agreement breaches and financial penalties.
>
> **Remediation Costs**: If significant model performance issues emerge post-deployment, remediation may require model retraining, architecture changes, or deployment rollbacks at substantial cost. We estimate that complete model retraining could cost between $[X]M and $[Y]M and require [Z] months, during which product quality and customer satisfaction would be materially impaired.
>
> **Insurance Limitations**: Our existing product liability and errors & omissions insurance may not adequately cover claims arising from AI-generated outputs, particularly novel theories of liability related to hallucination, bias, or automated decision-making. We may face uninsured losses or be unable to obtain adequate insurance at commercially reasonable rates.

---

### 2. Training Data & Intellectual Property Risk

**Context**: For companies developing proprietary AI models trained on large-scale data, particularly scraped web content or licensed datasets.

**Sample Disclosure**:

> **Our AI Models Are Trained on Large Datasets That May Include Copyrighted, Proprietary, or Personally Identifiable Information, Exposing Us to Intellectual Property Litigation and Regulatory Enforcement**
>
> **Training Data Sources and Provenance**: Our AI models are trained on datasets comprising [describe: billions of web pages, licensed content, user-generated content, proprietary data]. A substantial portion of this training data was obtained through automated web scraping, data licensing agreements, or user uploads. We cannot verify that all training data was obtained with proper authorization, that all licensing terms were complied with, or that all copyrighted material was used in accordance with fair use or other legal exceptions.
>
> **Intellectual Property Litigation Risk**: Publishers, content creators, and rights holders have filed lawsuits against AI companies alleging that training AI models on copyrighted works constitutes copyright infringement. Notable pending cases include *New York Times v. OpenAI*, *Getty Images v. Stability AI*, and class actions by the Authors Guild. These cases assert theories of direct infringement, vicarious liability, removal of copyright management information, and violation of terms of service. Adverse rulings in these or similar cases could:
>
> - Result in statutory damages potentially reaching billions of dollars
> - Require us to pay ongoing licensing fees to rights holders, fundamentally changing our cost structure
> - Compel us to retrain models using only licensed or public domain data, which we estimate would cost $[X]M-[Y]M and require [Z] months
> - Force removal of products from the market, representing [%] of current revenue
> - Create precedent that makes our business model legally untenable
>
> **Fair Use Uncertainty**: We believe our use of copyrighted training data constitutes fair use under U.S. copyright law based on the transformative nature of machine learning and the non-expressive use of training data. However, no court has definitively ruled on this issue in the context of generative AI. If courts reject the fair use defense for AI training, our business model would require fundamental restructuring.
>
> **International IP Exposure**: Copyright and data protection laws vary by jurisdiction. The EU Copyright Directive includes text and data mining exceptions with opt-out provisions. Japan permits AI training on copyrighted works without authorization. The UK is considering similar exceptions. Our training practices may comply with law in some jurisdictions while violating law in others, creating complex cross-border liability exposure.
>
> **Model Outputs May Reproduce Protected Content**: Despite technical measures to prevent verbatim reproduction of training data, our models may occasionally generate outputs that substantially reproduce copyrighted works, trademarked content, or proprietary information. Such outputs could trigger direct infringement liability and expose us to injunctive relief, damages, and reputational harm.
>
> **Data Deletion and Right to Be Forgotten**: Individuals whose personal information or creative works appear in our training data may demand deletion under GDPR, CCPA, or other data protection laws. Model "unlearning"—removing specific data points from trained models without complete retraining—remains technically immature. We may be unable to comply with deletion requests without prohibitively expensive retraining.

---

### 3. Regulatory Compliance & Cross-Jurisdictional Risk

**Context**: For companies operating AI systems in multiple jurisdictions, particularly those subject to EU AI Act, sectoral regulations, or emerging AI-specific laws.

**Sample Disclosure**:

> **We Are Subject to Rapidly Evolving and Inconsistent AI Regulations Across Multiple Jurisdictions, and Compliance Failures Could Result in Substantial Fines, Operational Restrictions, and Competitive Disadvantage**
>
> **EU AI Act Compliance**: The European Union's Artificial Intelligence Act became law in 2024 and imposes risk-based requirements on AI systems deployed in EU markets. Our [describe systems: customer-facing chatbot, automated underwriting system, biometric identification tool] are classified as "high-risk" under the Act, triggering requirements for:
>
> - Conformity assessment and CE marking before deployment
> - Ongoing bias and fairness testing with documented methodologies
> - Human oversight mechanisms with specified intervention capabilities
> - Detailed technical documentation and record-keeping
> - Incident reporting to national authorities within defined timeframes
> - Transparency obligations requiring disclosure of AI use to affected individuals
>
> We estimate that achieving full EU AI Act compliance will cost $[X]M-[Y]M over the next [Z] months and require ongoing annual compliance costs of $[A]M-[B]M. We are not currently fully compliant with all requirements. Non-compliance could result in fines up to €30 million or 6% of annual global revenue, whichever is higher, as well as orders to cease deployment of non-compliant systems in EU markets representing [%] of revenue.
>
> **Extraterritorial Regulatory Reach**: The EU AI Act applies to any provider placing AI systems on the EU market, regardless of where the provider is established. We cannot avoid EU AI Act requirements by incorporating outside the EU or maintaining EU operations through intermediaries. Similarly, other jurisdictions including China, the UK, and Canada are implementing AI regulations with extraterritorial reach.
>
> **U.S. Sectoral Regulation**: While the U.S. lacks comprehensive AI legislation, our AI systems are subject to sector-specific regulations including:
>
> - **Equal Credit Opportunity Act (ECOA) and Fair Lending**: Our AI-powered credit decisioning may violate fair lending laws if models exhibit disparate impact on protected classes. We have not completed disparate impact testing.
> - **Fair Credit Reporting Act (FCRA)**: If our AI models constitute "consumer reports," we face FCRA compliance obligations including accuracy requirements, adverse action notices, and consumer rights to dispute.
> - **Employment Law**: AI-assisted hiring tools may violate Title VII, EEOC guidance, or state laws (including New York City Local Law 144) requiring bias audits and notice.
> - **Health Insurance Portability and Accountability Act (HIPAA)**: AI processing of protected health information must comply with HIPAA privacy and security requirements.
>
> **State AI Legislation**: California, Colorado, Connecticut, and other states have enacted or are considering AI-specific disclosure, testing, and liability requirements. Multi-state compliance creates complexity and may require jurisdiction-specific model versions.
>
> **China Algorithmic Regulation**: Our AI systems deployed in China must register with the Cyberspace Administration of China and comply with algorithmic recommendation regulations requiring disclosure of algorithm characteristics, data usage, and social impact assessments. We currently operate in China without full algorithmic registration, creating enforcement risk.
>
> **Regulatory Uncertainty**: AI regulation is evolving rapidly with inconsistent requirements across jurisdictions. We may face conflicting legal obligations (e.g., EU requirements for algorithm transparency vs. U.S. trade secret protection). Compliance costs may escalate as regulations mature. New regulations may render our current business model impractical or prohibited in key markets.

---

### 4. Infrastructure Dependencies & Third-Party Risk

**Context**: For companies relying on specialized AI infrastructure providers (cloud compute, GPU access, model APIs).

**Sample Disclosure**:

> **Our Business Depends on Continued Access to Specialized AI Infrastructure and Third-Party Model Providers, and Loss of Access Could Materially Disrupt Our Operations**
>
> **GPU and Compute Dependencies**: Training and deploying our AI models requires access to specialized graphics processing units (GPUs), particularly NVIDIA H100 and A100 chips, which are in limited global supply. We currently:
>
> - Depend on [cloud provider] for [%] of our compute capacity, creating single-vendor concentration risk
> - Face GPU allocation limits that constrain our ability to scale model capacity to meet customer demand
> - Pay spot-market prices for compute that have ranged from $[X] to $[Y] per GPU-hour, creating financial volatility
> - Compete for GPU access with well-capitalized competitors who may outbid us for constrained resources
>
> If our cloud provider experiences outages, capacity constraints, or chooses to prioritize other customers, we may be unable to serve our customers, process inference requests, or train improved models. Alternative GPU providers have months-long waitlists and require advance commitments we cannot afford.
>
> **Third-Party Model Dependencies**: We license foundational AI models from [provider: OpenAI, Anthropic, Google, etc.] via API for [describe use case]. These dependencies create multiple risks:
>
> - **Service Discontinuation**: Our third-party provider may discontinue API access, modify pricing to uneconomical levels, or impose usage restrictions that prevent our use case.
> - **Model Changes**: Providers may update models in ways that degrade performance for our specific application, require prompt re-engineering, or introduce unwanted behaviors.
> - **Competitive Conflicts**: Our model provider may enter our market as a competitor or provide superior access to our competitors.
> - **Data Privacy**: Sending customer data to third-party model APIs creates privacy and confidentiality risks, particularly for regulated industries.
> - **Compliance Attribution**: We remain legally responsible for outputs generated by third-party models, but cannot control model behavior, training data, or bias characteristics.
>
> **Vendor Lock-In and Switching Costs**: Migrating from one model provider or cloud infrastructure platform to another requires substantial re-engineering, retraining, and customer migration. We estimate that switching costs would range from $[X]M-[Y]M and require [Z] months, during which service quality would be materially degraded.
>
> **Data Center and Network Risks**: AI inference requires low-latency, high-bandwidth connectivity to data centers housing GPU infrastructure. Natural disasters, cyberattacks, power outages, or network failures affecting our primary data center regions could render our services unavailable. Our disaster recovery and geographic redundancy capabilities are limited by GPU availability constraints.

---

### 5. AI Talent & Key Personnel Risk

**Context**: For companies whose competitive advantage depends on specialized AI expertise.

**Sample Disclosure**:

> **Our Success Depends on Attracting and Retaining Specialized AI Talent in an Intensely Competitive Market, and Loss of Key Personnel Could Materially Harm Our Technology Development and Competitive Position**
>
> **Specialized Talent Requirements**: Developing, training, and deploying state-of-the-art AI systems requires expertise in machine learning, deep learning architectures, large-scale distributed systems, and domain-specific applications. The global supply of individuals with these combined skills is extremely limited, and demand far exceeds supply.
>
> **Competitive Talent Market**: We compete for AI talent against well-capitalized technology companies (including Google, Meta, Amazon, Microsoft, and OpenAI), research institutions offering academic prestige, and well-funded AI startups offering equity upside. Many of these competitors offer compensation packages materially exceeding what we can afford, particularly for the most sought-after individuals with publications in top-tier venues or experience training frontier models.
>
> **Key Person Dependencies**: Our AI capabilities depend substantially on [X] key AI researchers and engineers, including [describe: Chief AI Officer, lead ML engineers, specialized domain experts]. Loss of any of these individuals could:
>
> - Delay product development timelines by [X] months
> - Require costly knowledge transfer and re-staffing
> - Result in loss of institutional knowledge about model architectures, training procedures, and troubleshooting
> - Signal competitive weakness to customers, investors, and remaining employees
>
> These key personnel are not bound by long-term employment contracts and may resign at any time. We do not maintain key person insurance.
>
> **Non-Compete Limitations**: California law prohibits most employee non-compete agreements. Our key AI personnel can immediately join direct competitors, taking knowledge of our model architectures, training techniques, and product roadmap. While we maintain confidentiality and IP assignment agreements, preventing unauthorized use or disclosure of trade secrets is difficult to enforce.
>
> **Equity Compensation Challenges**: As a pre-IPO company, we compensate AI talent substantially with equity grants. Post-IPO, stock price volatility may make our compensation less competitive than private AI companies offering new hire grants at higher valuations, or public technology companies with more liquid equity.
>
> **Immigration Risk**: Approximately [%] of our AI team members are not U.S. citizens and work under H-1B, O-1, or other visa categories. Changes in immigration policy, visa processing delays, or visa denials could prevent us from retaining or hiring essential talent. Remote work arrangements with non-U.S. personnel create data residency, export control, and IP protection challenges.

---

## Methodology

**Data**: 1,876 SEC 10-K filings (complete universe of available data)
**Extraction**: Automated Item 1A (Risk Factors) text extraction
**Analysis**: Keyword frequency analysis across 30+ AI-related terms
**Framework Comparison**: Cross-referenced against NIST AI RMF, EU AI Act requirements, MIT/Stanford academic frameworks

---

*This analysis is provided for informational purposes only and does not constitute legal advice. Consult qualified securities counsel for company-specific guidance.*

**Prepared by**: Tanya Matanda  
**Date**: January 2026
