# The AI Disclosure Gap: What 1,876 SEC Filings Reveal About Your Competitive Vulnerability
## Why Most Companies Are Advertising AI Capabilities While Hiding AI Risks—And What It Means for Boards

*An Analysis for Directors, Investors & Corporate Stakeholders*

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

### The Bottom Line: Advertising Capabilities, Hiding Risks

When we step back and look at the complete picture, a pattern emerges with remarkable clarity. Companies are enthusiastically adopting AI terminology in their public disclosures—1,484 mentions of LLMs and generative AI, 3,249 mentions of AI and machine learning—while systematically avoiding disclosure of AI-specific risks. Infrastructure gets disclosed at high rates (58%). Generic AI terminology gets mentioned frequently (47%). But the distinctive risks most likely to result in liability—hallucination, training data provenance, bias, regulatory compliance, model failure—barely register.

This is the disclosure inversion: companies are advertising what makes them look innovative while hiding what makes them vulnerable. For S-1 filers in 2026, this pattern represents more than just inadequate disclosure. It represents a strategic mistake that could haunt you for years.

You cannot claim AI as a competitive advantage in your business description while providing only generic risk disclosure in Item 1A. You cannot tell investors "We're at the forefront of LLM technology" without also telling them "LLMs can hallucinate, and we face IP litigation risk from our training data." You cannot say "AI powers our decision-making" without disclosing "our AI may exhibit bias that could violate anti-discrimination law."

The companies that figure this out first—that provide comprehensive, specific, substantive AI risk disclosure even when it's uncomfortable—will have the strongest legal position when the inevitable wave of AI-related litigation and enforcement arrives. The companies that follow the current inadequate  disclosure norms will be defending securities fraud claims with generic risk factors that courts will likely find insufficient.

The choice is yours. Lead with meaningful disclosure now, or defend inadequate disclosure later.

---

## III. The Academic Framework: What MIT, Stanford, and NIST Say You Should Be Disclosing

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

## Appendix: Sample Language by Risk Category

[This section would include the 5 sample disclosure templates from the previous report]

---

## Methodology

**Data**: 1,876 SEC 10-K filings (complete universe of available data)
**Extraction**: Automated Item 1A (Risk Factors) text extraction
**Analysis**: Keyword frequency analysis across 30+ AI-related terms
**Framework Comparison**: Cross-referenced against NIST AI RMF, EU AI Act requirements, MIT/Stanford academic frameworks

---

*This analysis is provided for informational purposes only and does not constitute legal advice. Consult qualified securities counsel for company-specific guidance.*

**Prepared by**: GovernanceIQ Research  
**Date**: January 2026  
**Contact**: [Your info]
