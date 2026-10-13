-- =====================================================================
-- Flyway Migration V159: Update Recruiter Questions Ground Truth & Taxonomy
--
-- Sets subject = NULL and concept = NULL for all Recruiter Assessment questions
-- because Recruiter calls evaluate candidate narrative, logistics, compensation,
-- and professional fit rather than technical engineering taxonomy domains.
-- (Database subject/concept ENUMs are strictly reserved for Technical questions).
--
-- Resolves database data inconsistency where 10 Recruiter questions inserted in V142
-- were mistakenly tagged with subject = 'AI Engineering' and concept = 'Generative AI & LLMs',
-- while 14 Recruiter questions (IDs 513-526) had subject: null and concept: null.
--
-- Updates ground truths with calibrated, non-repetitive production-grade rubrics
-- containing Recruiter Listening Cues, Candidate Behavioral Signals, and Critical Knockout Red Flags.
--
-- Also reclassifies 5 deep architectural questions mistakenly grouped into
-- recruiter batches back to SYSTEM_DESIGN / TECHNICAL with valid AI Engineering taxonomy.
--
-- Total updates: 36 Recruiter questions + 5 Technical/System Design reclassifications
-- + Universal RECRUITER taxonomy cleanup sweep.
-- Fully idempotent via WHERE `question_text` = '...'
-- =====================================================================

-- ---------------------------------------------------------------------
-- Part 1A: Universal Taxonomy Sweep & Existing Recruiter Assessment Questions
-- ---------------------------------------------------------------------

UPDATE `ai_prep_question_bank`
SET `subject` = NULL,
    `concept` = NULL
WHERE `category` = 'RECRUITER';

-- ID 1151: Give a quick introduction of your work and experiences in this world....
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Delivers a structured, 60-90 second elevator pitch covering technical identity, primary engineering specialization, and cumulative years of experience.", "required": true, "acceptable_evidence": ["Listening cues: Software Engineer / AI Systems Engineer, backend distributed systems foundation, GenAI / Agentic specialization.", "Clearly states total years of relevant experience, current role, and high-level technical domain without rambling.", "Frames career evolution with a cohesive narrative rather than reciting a disjointed resume line-by-line."]}, {"id": "KP2", "description": "Highlights recent flagship production contributions and the concrete technology stack leveraged.", "required": true, "acceptable_evidence": ["Listening cues: Python, FastAPI, LangGraph, RAG, Milvus/Pinecone, Docker/K8s, streaming APIs, CI/CD.", "Identifies 1-2 concrete, deployed systems (e.g., enterprise RAG assistant, multi-agent triage orchestrator, real-time ML serving platform).", "Briefly mentions the business context and end users served by the platforms."]}, {"id": "KP3", "description": "Articulates motivation, forward-looking goals, and alignment with the target team''s engineering mission.", "required": true, "acceptable_evidence": ["Listening cues: production rigor, zero-to-one engineering, scaling challenges, ownership, team enablement.", "Connects past achievements to what excites them about current market challenges in AI/ML systems engineering.", "Expresses clear intent regarding the type of engineering problems they want to solve next."]}], "critical_failures": ["Delivers a rambling monologue exceeding 3 minutes without clear structure or narrative arc.", "Focuses exclusively on academic degrees or non-technical hobbies without articulating hands-on engineering capabilities.", "Fails to name specific tools, systems, or platforms built during their career."]}'
WHERE `question_text` = 'Give a quick introduction of your work and experiences in this world.';

-- ID 1142: Can you walk me through your current role, responsibilities, and recen...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Defines organizational context, current team charter, and personal scope of ownership.", "required": true, "acceptable_evidence": ["Listening cues: Senior/Lead AI Engineer, core platform team, cross-functional ownership, individual contributor (IC).", "Clarifies whether responsibilities lean toward greenfield architecture, model deployment/serving, or pipeline maintenance.", "Explains how daily work interfaces with product managers, data scientists, and frontend/backend engineers."]}, {"id": "KP2", "description": "Walks through recent hands-on technical deliverables in production AI/ML systems.", "required": true, "acceptable_evidence": ["Listening cues: RAG pipelines, agentic orchestration, chunking/indexing, vector databases, prompt engineering, LLM guardrails.", "Provides concrete architecture examples: e.g., migrated semantic search to Milvus, built LangGraph state workflows, or set up automated evaluation with RAGAS.", "Differentiates their personal contributions from work done by the broader team."]}, {"id": "KP3", "description": "Quantifies operational performance, business impact, and reliability metrics achieved in the current role.", "required": true, "acceptable_evidence": ["Listening cues: query latency reduction, p95 SLA, deflection rate, cost-per-token savings, test coverage, uptime.", "Cites measurable outcomes (e.g., reduced response latency from 3s to 800ms, achieved 40% support ticket deflection, or reduced vector storage costs by 30%)."]}], "critical_failures": ["Speaks entirely in passive voice (''we did'', ''the company did'') without identifying personal ownership or individual contributions.", "Cannot articulate the business purpose or user value of the systems they currently maintain.", "Reveals confidential client or proprietary employer data inappropriately."]}'
WHERE `question_text` = 'Can you walk me through your current role, responsibilities, and recent work in AI/ML systems?';

-- ID 1143: Can you walk me through your overall experience and transition from so...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Demonstrates how core software engineering fundamentals provide stability for modern AI platforms.", "required": true, "acceptable_evidence": ["Listening cues: OOP principles, REST/gRPC API design, microservices, relational/NoSQL databases, CI/CD pipelines, unit testing.", "Explains how software engineering rigor (code reviews, concurrency, error handling, system architecture) prevents fragile AI prototypes.", "Frames software engineering as an enduring foundation rather than discarded past experience."]}, {"id": "KP2", "description": "Details the intentional transition milestones into ML, MLOps, and Generative/Agentic AI.", "required": true, "acceptable_evidence": ["Listening cues: statistical ML, predictive modeling, Docker/Kubernetes, MLflow model registries, LLM integration, LangGraph.", "Identifies specific catalyst projects or internal opportunities that sparked the transition into AI/ML.", "Explains self-directed upskilling, practical system implementations, and overcoming the non-deterministic nature of LLMs."]}, {"id": "KP3", "description": "Synthesizes the hybrid value proposition: an engineer who builds production-ready AI with full-stack software reliability.", "required": true, "acceptable_evidence": ["Listening cues: bridge between data science and production, deployment readiness, observability, scalability.", "Articulates why having both disciplines makes them effective at delivering reliable, maintainable AI products."]}], "critical_failures": ["Dismisses traditional software engineering as irrelevant or obsolete in the era of LLMs.", "Claims an abrupt pivot to AI without demonstrating understanding of underlying data pipelines, infrastructure, or ML lifecycle.", "Presents an incoherent career narrative with unexplained gaps or contradictory timelines."]}'
WHERE `question_text` = 'Can you walk me through your overall experience and transition from software engineering to AI/ML, including key projects you''ve worked on?';

-- ID 2250: Can you walk us through your background and experience building end-to...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Outlines hands-on experience across the end-to-end RAG lifecycle from ingestion to generation.", "required": true, "acceptable_evidence": ["Listening cues: document parsing, chunking strategies, dense/sparse embeddings, Milvus/Pinecone/Chroma, hybrid search (BM25 + vector), cross-encoder reranking.", "Details handling unstructured file formats (PDFs, docs, tables) and optimizing retrieval precision/recall.", "Explains prompt synthesis, context injection, and citation/attribution mechanisms."]}, {"id": "KP2", "description": "Details experience with agentic workflows, dynamic tool calling, and multi-agent orchestration.", "required": true, "acceptable_evidence": ["Listening cues: LangGraph, StateGraph, autonomous routing, MCP tool servers, Human-in-the-Loop checkpointers, memory persistence.", "Explains designing agent topologies with bounded execution contexts, tool schemas, and cycle limits.", "Contrasts deterministic sequential chains with adaptive multi-agent coordination."]}, {"id": "KP3", "description": "Emphasizes production reliability, automated evaluation, and latency/cost guardrails.", "required": true, "acceptable_evidence": ["Listening cues: RAGAS framework, faithfulness/relevancy metrics, streaming tokens (SSE), Redis caching, PII filtering (Presidio).", "Discusses real-world trade-offs between model size, reasoning latency, and API operational expenses."]}], "critical_failures": ["Confuses standard tutorial code snippets (e.g., naive in-memory LangChain chains) with production enterprise systems.", "Fails to articulate any mechanism for evaluation, hallucination reduction, or retrieval quality measurement.", "Cannot explain how agent state, memory, or tool errors are handled in a live environment."]}'
WHERE `question_text` = 'Can you walk us through your background and experience building end-to-end AI systems using RAG and agentic architectures?';

-- ID 1149: Do you have experience working in specific domains such as biotech, ph...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Provides an honest, transparent assessment of direct industry experience vs. adjacent technical competencies.", "required": true, "acceptable_evidence": ["Listening cues: direct clinical/biotech experience OR transparent pivot to highly regulated domain parallels (FinTech, LegalTech, Healthcare).", "Clearly confirms or clarifies lack of direct bio/pharma background without bluffing or misrepresenting credentials.", "Demonstrates respect for specialized domain knowledge and terminology."]}, {"id": "KP2", "description": "Draws concrete parallels from experience in data governance, security, and regulatory compliance.", "required": true, "acceptable_evidence": ["Listening cues: HIPAA, SOC2, GDPR, audit logging, data lineage, strict provenance, air-gapped models, PII redaction.", "Explains how past work handling sensitive, compliance-bound customer data directly transfers to clinical trial or life sciences constraints.", "Emphasizes zero-hallucination tolerance and strict citation traceability in scientific knowledge retrieval."]}, {"id": "KP3", "description": "Demonstrates rapid learning agility and effective collaboration with non-technical Subject Matter Experts (SMEs).", "required": true, "acceptable_evidence": ["Listening cues: SME interview loops, ontology mapping, medical terminology disambiguation, active listening.", "Outlines a proactive strategy for onboarding into complex domain ontologies (e.g., PubMed, FDA documentation) during the initial 30-60 days."]}], "critical_failures": ["Fabricates domain credentials or claims expertise in biology/pharma without substantive background.", "Dismisses regulatory, privacy, and compliance requirements as trivial administrative overhead.", "Shows unwillingness to learn specialized domain nomenclatures or partner with domain specialists."]}'
WHERE `question_text` = 'Do you have experience working in specific domains such as biotech, pharma, or life sciences, and how relevant is your background to those industries?';

-- ID 2978: Are you interested in transitioning into a research-oriented role, and...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Clarifies career identity: distinguishes between fundamental academic research and applied engineering research.", "required": true, "acceptable_evidence": ["Listening cues: applied research, empirical benchmarking, research paper implementation, production-grade ML, model fine-tuning.", "Articulates whether personal goals align with novel model architecture discovery or translating state-of-the-art research into scalable production systems.", "Displays self-awareness regarding where their skills generate the highest business impact."]}, {"id": "KP2", "description": "Highlights concrete, proactive steps taken to engage with cutting-edge AI literature and methodologies.", "required": true, "acceptable_evidence": ["Listening cues: arXiv papers, Hugging Face repos, reproducing baseline benchmarks, PyTorch experimentation, PEFT/LoRA fine-tuning.", "Discusses specific recent papers or architectural advances (e.g., GraphRAG, reasoning distillation, agentic memory mechanisms).", "Shares examples of reproducing or adapting research findings to practical codebases."]}, {"id": "KP3", "description": "Balances scientific curiosity with engineering discipline, delivery milestones, and business value.", "required": true, "acceptable_evidence": ["Listening cues: business alignment, pragmatic trade-offs, ROI, time-to-market, avoiding perpetual prototyping.", "Emphasizes that research exploration must ultimately serve product objectives, performance SLAs, or efficiency gains."]}], "critical_failures": ["Expresses a desire to do pure theoretical research while interviewing for a production software/AI engineering role.", "Cannot name recent papers, researchers, or fundamental advancements in the AI/ML landscape.", "Shows contempt for delivery deadlines, commercial realities, or production maintainability."]}'
WHERE `question_text` = 'Are you interested in transitioning into a research-oriented role, and what steps have you taken toward that?';

-- ID 945: What professional certifications or continuous learning initiatives ha...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Cites credible, recognized certifications or structured professional learning programs.", "required": true, "acceptable_evidence": ["Listening cues: AWS Certified Solutions Architect, Kubernetes (CKA/CKAD), DeepLearning.AI, Coursera/Fast.ai, open-source repositories.", "Mentions specific structured technical programs or certifications in cloud, distributed systems, or ML.", "Frames learning as a continuous professional discipline rather than a one-time credential grab."]}, {"id": "KP2", "description": "Directly links theoretical study to tangible improvements in real-world code and architecture.", "required": true, "acceptable_evidence": ["Listening cues: Infrastructure as Code (Terraform), 12-factor principles, strict typing (Pydantic), async programming, observability.", "Explains how specific concepts learned (e.g., well-architected framework, distributed consensus, or zero-shot evaluation) changed how they build software.", "Shares a concrete before-and-after example of applying an acquired practice to a production system."]}, {"id": "KP3", "description": "Demonstrates knowledge dissemination and elevating team capabilities.", "required": true, "acceptable_evidence": ["Listening cues: internal tech talks, lunch-and-learns, architecture RFCs, documentation, peer mentorship.", "Explains sharing newly acquired knowledge with colleagues through code reviews, documentation, or internal workshops."]}], "critical_failures": ["Recites a list of certifications as empty badges without being able to explain how any concept improved their daily engineering practices.", "Displays complacency toward learning, showing no interest in staying current with the fast-evolving AI ecosystem.", "Cannot explain core concepts from certifications they claim to hold."]}'
WHERE `question_text` = 'What professional certifications or continuous learning initiatives have you completed, and how have they influenced your engineering practices?';

-- ID 236: What are your base compensation and equity expectations for your next ...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Communicates calibrated, realistic compensation benchmarks aligned with market rates and seniority level.", "required": true, "acceptable_evidence": ["Listening cues: base salary range, total target cash, annual equity grant, Levels.fyi benchmarking, geographical tiering.", "Quotes a specific, realistic target base salary range (e.g., $180k-$210k base depending on equity and benefits package).", "Avoids extreme vagueness (''I just want fair pay'') while maintaining reasonable negotiation flexibility."]}, {"id": "KP2", "description": "Articulates understanding of total compensation components (Base + Bonus + Equity + Benefits).", "required": true, "acceptable_evidence": ["Listening cues: RSUs vs stock options (ISOs/NSOs), vesting schedule (4-year / 1-year cliff), target performance bonus, 401k match.", "Differentiates cash compensation preferences based on company stage (e.g., higher base in enterprise vs. higher equity percentage in early-stage startups).", "Inquires respectfully about the company''s compensation philosophy and band structure."]}, {"id": "KP3", "description": "Grounds salary requirements in proven engineering impact and current market demand for AI/ML skills.", "required": false, "acceptable_evidence": ["Listening cues: value delivery, end-to-end platform ownership, production track record, competitive landscape.", "Frames compensation around the business value they generate in accelerating AI delivery and platform reliability."]}], "critical_failures": ["Refuses obstinately to provide any range or ballpark figure, creating an impasse during the initial screening call.", "Quotes numbers wildly divergent from market reality without justification (e.g., demanding top-of-market FAANG executive compensation for mid-level startup roles).", "Displays hostile or aggressive behavior during standard compensation calibration questions."]}'
WHERE `question_text` = 'What are your base compensation and equity expectations for your next AI Engineering role?';

-- ID 760: How do you evaluate risk, runway, and the balance between base cash co...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Rigorous financial due diligence on company health: runway, burn rate, and capitalization table.", "required": true, "acceptable_evidence": ["Listening cues: 18-24 months runway, monthly cash burn, Series A/B lead investors, fully diluted share count, 409A valuation vs preferred price.", "Asks or analyzes critical business survival metrics before committing to an early-stage venture.", "Evaluates investor pedigree and the syndicate''s ability to provide follow-on funding during market downturns."]}, {"id": "KP2", "description": "Calculates equity mechanics, potential liquidation outcomes, and dilution expectations.", "required": true, "acceptable_evidence": ["Listening cues: stock option strike price, 4-year vesting with 1-year cliff, dilution across subsequent rounds, secondary market liquidity, liquidation preferences.", "Demonstrates understanding that equity value is contingent on growth, exit multiple, and non-participating preferred liquidation rights.", "Avoids treating paper equity as guaranteed cash."]}, {"id": "KP3", "description": "Aligns personal financial baseline with high-upside career risk tolerance.", "required": true, "acceptable_evidence": ["Listening cues: baseline cash survival floor, risk tolerance, high-ownership learning multiplier, product-market fit (PMF).", "Articulates a clear personal threshold: base salary must comfortably cover living essentials while equity represents upside for high conviction.", "Evaluates founder credibility, early customer traction, and engineering autonomy as compensating factors for financial risk."]}], "critical_failures": ["Evaluates startup offers solely based on percentage ownership without asking for total outstanding shares, strike price, or valuation.", "Has no concept of runway, burn rate, or venture capital funding stages.", "Expects zero-risk enterprise compensation while demanding early-stage founder-level equity."]}'
WHERE `question_text` = 'How do you evaluate risk, runway, and the balance between base cash compensation and long-term equity upside when deciding whether to join an early-stage startup?';

-- ID 713: How do you evaluate opportunities across different types of companies,...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Evaluates early-stage startups through technical autonomy, iteration velocity, and end-to-end ownership.", "required": true, "acceptable_evidence": ["Listening cues: 0-to-1 building, wearing multiple hats, rapid deployment cycles, direct customer feedback, high architectural autonomy.", "Values the opportunity to make foundational architectural choices and build core platforms without excessive red tape.", "Acknowledges the inherent trade-offs: ambiguity, shifting roadmaps, lack of dedicated tooling, and high operational responsibility."]}, {"id": "KP2", "description": "Evaluates established enterprises regarding systemic scale, engineering rigor, and specialized infrastructure.", "required": true, "acceptable_evidence": ["Listening cues: petabyte-scale data, high-availability SLAs, robust CI/CD, cross-functional specialization, established mentorship.", "Appreciates solving deep scalability, security, and governance challenges on platforms with millions of users.", "Recognizes the associated trade-offs: longer consensus cycles, specialized scope, and compliance gates."]}, {"id": "KP3", "description": "Aligns current career priorities, learning goals, and impact objectives with company stage.", "required": true, "acceptable_evidence": ["Listening cues: career phase alignment, building production agent platforms vs scaling existing infrastructure, team caliber, engineering leadership.", "Articulates why the target company''s specific stage (e.g., Series B growth stage) matches their sweet spot right now."]}], "critical_failures": ["Demonstrates rigid dogmatism dismissing either startups or enterprises entirely as ''bad'' environments.", "Fails to recognize any difference in development velocity, infrastructure support, or governance between company stages.", "Shows no self-awareness regarding what work environment enables their personal success."]}'
WHERE `question_text` = 'How do you evaluate opportunities across different types of companies, such as startups versus established organizations?';

-- ID 1109: How do you evaluate opportunities that require immediate relocation ve...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Evaluates personal, family, and logistical feasibility with complete honesty.", "required": true, "acceptable_evidence": ["Listening cues: lease obligations, family commitments, partner employment, housing search, cost-of-living index (COLI).", "Clearly identifies hard logistical constraints (e.g., active apartment lease ending in 60 days, school semester schedules) upfront.", "Demonstrates practical foresight rather than making unrealistic commitments."]}, {"id": "KP2", "description": "Inquires about corporate relocation support and onboarding policies.", "required": true, "acceptable_evidence": ["Listening cues: relocation package/stipend, temporary corporate housing, moving assistance, tax gross-up.", "Discusses how corporate relocation assistance enables rapid physical transition without personal financial disruption.", "Frames relocation as a shared partnership between employee and employer."]}, {"id": "KP3", "description": "Proposes viable phased onboarding bridges to maintain immediate engineering productivity.", "required": true, "acceptable_evidence": ["Listening cues: remote start period, staging phase, in-person travel for onboarding week, definitive relocation cutoff date.", "Proposes starting remotely on day one to begin code commits and knowledge acquisition, followed by physical move within 30-60 days."]}], "critical_failures": ["Agrees enthusiastically to immediate relocation during the screen, only to walk back the commitment later in the interview loop.", "Has no realistic assessment of moving costs, lease penalties, or regional cost-of-living adjustments.", "Demands 100% remote work when interviewing for explicitly on-site or hybrid roles."]}'
WHERE `question_text` = 'How do you evaluate opportunities that require immediate relocation versus delayed relocation?';

-- ID 1130: How would you communicate relocation timelines clearly and professiona...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Provides definitive dates, milestone buffers, and notice periods without ambiguity.", "required": true, "acceptable_evidence": ["Listening cues: two-week notice, moving buffer, concrete calendar dates, lease termination date, start date commitment.", "Provides a structured chronological timeline: e.g., Offer Signed -> 2 Weeks Notice -> 1 Week Moving/Unpack -> Day 1 Onboarding.", "Maintains complete transparency about dependent factors (e.g., background check clearance or visa transfer)."]}, {"id": "KP2", "description": "Maintains strict narrative consistency across all interview stages.", "required": true, "acceptable_evidence": ["Listening cues: message consistency, single source of truth, proactive updates to recruiter, alignment with hiring manager.", "Ensures the dates communicated to the recruiter match what is told to the engineering hiring manager and HR team.", "Proactively informs the recruiter immediately if personal circumstances alter the timeline."]}, {"id": "KP3", "description": "Demonstrates focus on minimizing business disruption and ensuring immediate ramp-up.", "required": true, "acceptable_evidence": ["Listening cues: onboarding readiness, day-one impact, setup completion, equipment delivery.", "Assures the team that moving logistics will be finalized prior to day one so full attention is dedicated to team onboarding."]}], "critical_failures": ["Gives evasive, non-committal answers (''sometime soon'', ''whenever'') that prevent scheduling and planning.", "Provides contradictory timelines to different interviewers in the same process.", "Conceals geographic relocation unwillingness until after an offer is extended."]}'
WHERE `question_text` = 'How would you communicate relocation timelines clearly and professionally during interviews?';

-- ID 2083: Are you comfortable participating in a live coding interview using Pyt...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Affirms clear confidence and enthusiasm for live Python coding environments.", "required": true, "acceptable_evidence": ["Listening cues: fully comfortable, idiomatic Python, standard library (collections, itertools, heapq), pair programming mindset.", "Welcomes live coding as a positive opportunity to showcase clean coding standards and algorithmic problem solving.", "Confirms familiarity with standard collaborative platforms (CoderPad, HackerRank, CodeSignal, VS Code Live Share)."]}, {"id": "KP2", "description": "Emphasizes collaborative ''think-aloud'' problem solving rather than silent code writing.", "required": true, "acceptable_evidence": ["Listening cues: think-aloud protocol, verbalizing trade-offs, clarifying inputs/outputs, edge case discussion, interactive collaboration.", "Explains how they treat the interviewer as a teammate: communicating thought processes, checking assumptions, and inviting feedback before coding."]}, {"id": "KP3", "description": "Commits to writing production-quality code with immediate test verification.", "required": true, "acceptable_evidence": ["Listening cues: modular functions, descriptive naming, type hints, boundary test cases, time and space complexity derivation.", "Highlights validating code with dry runs, assertions, and boundary checks before claiming completion."]}], "critical_failures": ["Expresses strong resistance, anxiety, or disdain for live coding rounds.", "Demands take-home assignments only or refuses standard live evaluation.", "Prefers silent typing, stating they cannot talk and code at the same time."]}'
WHERE `question_text` = 'Are you comfortable participating in a live coding interview using Python?';

-- ID 2109: How do you prepare for coding interviews, particularly those focused o...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Focuses on fundamental algorithmic patterns rather than brute-force problem memorization.", "required": true, "acceptable_evidence": ["Listening cues: two pointers, sliding window, BFS/DFS, heaps, dynamic programming, topological sort, NeetCode/LeetCode patterns.", "Explains studying core data structures and algorithmic motifs to quickly recognize underlying problem classes in unseen questions."]}, {"id": "KP2", "description": "Simulates realistic interview pressure through timed mock sessions without IDE crutches.", "required": true, "acceptable_evidence": ["Listening cues: 30-45 minute timebox, no autocomplete/Copilot, CoderPad practice, mock interviews with peers (Pramp/Interviewing.io).", "Practices coding in plain text editors to ensure fluency with language syntax, indentation, and built-in library methods without relying on IntelliSense."]}, {"id": "KP3", "description": "Emphasizes idiomatic Python, modular structure, and explicit complexity derivation.", "required": true, "acceptable_evidence": ["Listening cues: list/dict comprehensions, type annotations, helper functions, Big-O time and space complexity analysis.", "Habitually states Big-O time and space complexity upon proposing a solution."]}], "critical_failures": ["Admits to memorizing specific LeetCode problem solutions without understanding foundational principles.", "Relies entirely on AI code generators or IDE autocompletion and cannot write basic syntax in plain text pads.", "Ignores time/space complexity analysis completely."]}'
WHERE `question_text` = 'How do you prepare for coding interviews, particularly those focused on Python and real-time problem solving?';

-- ID 1931: How do you prepare for technical interviews involving Python coding, m...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Three-pillar preparation strategy covering coding, ML theory, and system design.", "required": true, "acceptable_evidence": ["Listening cues: algorithmic coding (DSA), ML math & fundamentals, end-to-end system design architecture.", "Structures study across three core disciplines: coding fluency, ML lifecycle/modeling fundamentals, and scalable distributed system design.", "Allocates preparation time strategically according to the target company''s interview breakdown."]}, {"id": "KP2", "description": "Scenario-based system design review: structures end-to-end platform blueprints.", "required": true, "acceptable_evidence": ["Listening cues: requirements scoping, functional vs non-functional constraints, data ingestion, vector indexing, latency SLAs, caching, failover.", "Practices structured frameworks for open-ended architectural scenarios (e.g., designing an enterprise RAG system or fraud detection engine).", "Focuses on articulating trade-offs (latency vs cost, consistency vs availability)."]}, {"id": "KP3", "description": "Review of foundational ML theory and modern GenAI/Agent paradigms.", "required": true, "acceptable_evidence": ["Listening cues: bias/variance, precision/recall, loss functions, transformer attention, embeddings, RAG evaluation, agent loops.", "Reviews both classical ML evaluation principles and modern LLM orchestration frameworks."]}, {"id": "KP4", "description": "Mock interview rehearsal and communication refinement.", "required": false, "acceptable_evidence": ["Listening cues: mock panels, think-aloud practice, time management, concise technical explanations.", "Conducts practice sessions focusing on clear pacing, answering directly, and reading interviewer cues."]}], "critical_failures": ["Crams only LeetCode algorithms while ignoring ML engineering concepts and architectural system design.", "Cannot articulate a structured framework for approaching ambiguous system design questions.", "Fails to allocate time for communication and behavioral alignment."]}'
WHERE `question_text` = 'How do you prepare for technical interviews involving Python coding, machine learning concepts, and scenario-based problem solving?';

-- ID 2179: How do you handle situations where you are unable to demonstrate code ...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Maintains calm professional composure, avoids panic, and acknowledges the issue constructively.", "required": true, "acceptable_evidence": ["Listening cues: emotional regulation, professional poise, blameless troubleshooting, adaptability, positive attitude.", "Remains calm when technical tooling, interpreters, or shared environments glitch.", "Quickly checks basic syntax/environment variables without spending excessive interview time debugging the platform."]}, {"id": "KP2", "description": "Proactively pivots to manual execution tracing, step-by-step dry runs, and state table simulation.", "required": true, "acceptable_evidence": ["Listening cues: manual execution walkthrough, variable trace table, stepping through loop iterations, state tracking.", "Confidently states: ''Since the environment isn''t executing, let me walk you through an execution trace line by line with sample input.''", "Demonstrates that their logical correctness does not rely on a machine compiler to think."]}, {"id": "KP3", "description": "Rigorous edge-case analysis, boundary proof, and complexity verification.", "required": true, "acceptable_evidence": ["Listening cues: empty inputs, single element, boundary conditions, off-by-one errors, formal time/space complexity proof.", "Tests edge cases manually to verify invariant conditions and mathematically proves correctness."]}], "critical_failures": ["Panics, becomes visibly agitated, argumentative, or defensive when code does not execute.", "Freezes completely, unable to reason about code without an active run button.", "Blames the interviewer or the platform aggressively, ruining candidate rapport."]}'
WHERE `question_text` = 'How do you handle situations where you are unable to demonstrate code execution during an interview or live session?';

-- ID 1154: Have you previously been submitted to a client or company for a simila...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Provides full ethical transparency regarding third-party agency representation and Right to Represent (RTR) agreements.", "required": true, "acceptable_evidence": ["Listening cues: Right to Represent (RTR), vendor representation, direct vs agency application, duplicate submission prevention.", "Explicitly discloses whether another staffing firm or recruiter has submitted their profile to this client or partner within the past 6-12 months.", "Demonstrates integrity regarding non-compete and submission representation rules."]}, {"id": "KP2", "description": "Maintains a structured, organized tracking system for all active applications and recruiter touchpoints.", "required": true, "acceptable_evidence": ["Listening cues: personal tracker (Notion, Google Sheets, Excel), company name, role title, requisition ID, date submitted, agency recruiter contact.", "Explains their system for logging every agency interaction to prevent accidental double-submissions.", "Demonstrates organizational diligence and professional reliability."]}, {"id": "KP3", "description": "Proactively protects candidate and client integrity by enforcing single-agency representation.", "required": true, "acceptable_evidence": ["Listening cues: professional ethics, prompt verification, written consent before submission, client relationship preservation.", "Confirms they require written confirmation before allowing any agency to submit their resume to an employer."]}], "critical_failures": ["Gives vague, careless answers showing no awareness of which companies or agencies hold their resume.", "Has permitted multiple competing agencies to submit them to the same client, creating commission disputes and disqualification.", "Refuses to disclose prior submissions, hiding agency conflicts until background verification."]}'
WHERE `question_text` = 'Have you previously been submitted to a client or company for a similar role, and how do you track such submissions?';

-- ID 976: What are your expectations regarding the hiring process and next steps...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Inquires professionally about stage progression, panel structure, and evaluation milestones.", "required": true, "acceptable_evidence": ["Listening cues: technical screen, hiring manager conversation, system design interview, turnaround timeline, feedback cadence.", "Respectfully asks what the typical hiring sequence looks like and what key competencies each round assesses.", "Demonstrates enthusiasm and eagerness to prepare thoroughly for each milestone."]}, {"id": "KP2", "description": "Transparently shares active interview pipeline status, availability, and competing offer timelines.", "required": true, "acceptable_evidence": ["Listening cues: interview pipeline status, other final rounds, pending offers, scheduling availability, fast-track consideration.", "Informs the recruiter of competing timelines so the recruiting team can coordinate interviews without scheduling crunches.", "Commits to responsive communication throughout the process."]}, {"id": "KP3", "description": "Requests actionable guidance and evaluation focus areas to best showcase their skills.", "required": false, "acceptable_evidence": ["Listening cues: preparation expectations, tech stack focus, presentation format, case study guidelines.", "Asks if there are particular architectural topics or coding patterns the team recommends brushing up on."]}], "critical_failures": ["Demands immediate hiring offers or circumventing standard technical evaluations.", "Displays complete apathy or disinterest regarding subsequent interview rounds.", "Conceals imminent offer deadlines until the last second, blindsiding the recruiting team."]}'
WHERE `question_text` = 'What are your expectations regarding the hiring process and next steps after recruiter screening?';

-- ID 1042: What would you like to know about the next steps in the hiring process...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Asks targeted questions regarding interview timeline, next stage formats, and turnaround expectations.", "required": true, "acceptable_evidence": ["Listening cues: estimated feedback turnaround (e.g., 2-3 business days), technical screening format, panel composition.", "Asks: ''What is the expected timeline for hearing back after this call, and what does the next technical stage entail?''", "Clarifies whether the next round is a 1-on-1 coding assessment, system design deep dive, or hiring manager alignment."]}, {"id": "KP2", "description": "Seeks insight into team priorities and how best to prepare for the engineering team''s expectations.", "required": true, "acceptable_evidence": ["Listening cues: preparation tips, key architectural challenges, team tech stack priorities.", "Inquires: ''Are there specific technologies, documentation, or domain topics the team would appreciate me reviewing prior to the next round?''"]}, {"id": "KP3", "description": "Concludes the screening call with professional courtesy, gratitude, and confirmed availability.", "required": true, "acceptable_evidence": ["Listening cues: gratitude for time, reiterated enthusiasm for role, prompt scheduling availability.", "Reiterates genuine interest in the company''s mission and confirms rapid responsiveness for scheduling."]}], "critical_failures": ["States abruptly ''I have no questions'', missing the opportunity to build rapport and demonstrate curiosity.", "Asks purely administrative questions about vacation days or perks before establishing technical mutual fit.", "Displays entitled or impatient behavior regarding company review cadences."]}'
WHERE `question_text` = 'What would you like to know about the next steps in the hiring process?';

-- ID 747: How would you present yourself to align with a team culture that value...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Demonstrates authentic engineering passion, curiosity, and craftsmanship.", "required": true, "acceptable_evidence": ["Listening cues: intrinsic motivation, excitement about building, curiosity, deep dives, prototype experimentation, open source.", "Shares genuine enthusiasm for solving complex software and AI system bottlenecks.", "Talks passionately about building high-leverage tools that make colleagues or users more productive."]}, {"id": "KP2", "description": "Exemplifies a solutions-oriented, constructive mindset during outages, tight deadlines, or setbacks.", "required": true, "acceptable_evidence": ["Listening cues: blameless culture, resilience, optimistic problem-solving, psychological safety, growth mindset.", "Explains how they approach production bugs or blockers as learning opportunities rather than occasions for finger-pointing.", "Describes maintaining calm energy that lifts team morale during stressful on-call incidents or compressed sprints."]}, {"id": "KP3", "description": "Highlights active collaboration, ego-free communication, peer mentorship, and inclusive teamwork.", "required": true, "acceptable_evidence": ["Listening cues: ego-free code reviews, active listening, pairing with juniors, documentation, elevating teammates.", "Provides concrete examples of celebrating colleagues'' wins and creating welcoming review discussions where feedback is actionable and kind."]}], "critical_failures": ["Portrays a cynical, detached attitude toward previous teams, management, or company initiatives.", "Celebrates a ''lone wolf'' persona that dismisses pair programming, documentation, or peer feedback.", "Gives scripted corporate buzzwords without sharing authentic personal anecdotes."]}'
WHERE `question_text` = 'How would you present yourself to align with a team culture that values positivity, passion, and collaboration?';

-- ID 780: What qualities define an ideal candidate for this role, and how do you...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Defines core competencies of a high-impact AI engineer: technical depth, production focus, and ownership.", "required": true, "acceptable_evidence": ["Listening cues: systems thinking, end-to-end ownership, pragmatic engineering trade-offs, continuous learning, humble collaboration.", "Emphasizes taking broad, ambiguous business problems and driving them to measurable production outcomes.", "Values clean, maintainable architecture over fragile, over-engineered hype."]}, {"id": "KP2", "description": "Applies a structured, data-driven approach to de-escalate and resolve technical debates.", "required": true, "acceptable_evidence": ["Listening cues: objective evaluation matrix, latency/cost/maintainability criteria, proof-of-concept (POC) spike, benchmark data, RFC/ADR.", "Depersonalizes disagreements by evaluating competing approaches against explicit system requirements (SLAs, complexity, cost).", "Proposes building quick timeboxed benchmark spikes to let empirical empirical performance metrics settle conflicting opinions."]}, {"id": "KP3", "description": "Embraces ''Disagree and Commit'' to preserve team velocity and psychological safety.", "required": true, "acceptable_evidence": ["Listening cues: disagree and commit, team velocity, institutional trust, Architectural Decision Records (ADRs).", "Explains that after debating passionately with data, they fully commit to the team''s chosen direction without passive-aggressive resistance."]}], "critical_failures": ["Exhibits a dogmatic, unyielding approach to technical debates, insisting their way is the only right way.", "Passively avoids voicing valid technical concerns during architecture reviews to avoid minor conflict.", "Under-mines decisions behind the scenes after the team reaches consensus."]}'
WHERE `question_text` = 'What qualities define an ideal candidate for this role, and how do you evaluate technical disagreements within a team?';

-- ID 946: What questions do you typically ask the hiring team to evaluate team c...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Probes technical autonomy, architecture ownership, and decision-making governance.", "required": true, "acceptable_evidence": ["Listening cues: RFC/ADR documentation, technical debt allocation (e.g., 20% time), tech stack adoption decisions.", "Asks: ''How are major architectural choices evaluated and documented when adopting new frameworks or migrating databases?''", "Asks: ''How does the engineering team balance building new product features against paying down technical debt?''"]}, {"id": "KP2", "description": "Evaluates deployment rigor, testing safety nets, and engineering velocity.", "required": true, "acceptable_evidence": ["Listening cues: deployment cadence, CI/CD automated gates, test coverage expectations, blameless postmortems.", "Asks: ''What is the typical path from a merged PR to production deployment, and what automated tests must pass?''", "Asks: ''Can you describe how the team handled a recent production incident and what postmortem improvements resulted?''"]}, {"id": "KP3", "description": "Investigates team health, feedback loops, mentorship, and psychological safety.", "required": true, "acceptable_evidence": ["Listening cues: 1-on-1 cadence, mentorship programs, handling disagreement between product and engineering.", "Asks: ''How do product managers and engineers resolve disagreements when sprint deadlines conflict with engineering quality?''"]}], "critical_failures": ["States they never ask questions about engineering practices, signaling passive disinterest.", "Asks only superficial administrative questions without evaluating engineering rigor or code quality.", "Shows complete indifference toward team health or psychological safety."]}'
WHERE `question_text` = 'What questions do you typically ask the hiring team to evaluate team culture, technical autonomy, and engineering practices?';

-- ID 724: How do you handle situations where you are blocked by another team and...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Initiates direct, empathetic communication to diagnose root constraints rather than complaining.", "required": true, "acceptable_evidence": ["Listening cues: direct communication, 1-on-1 huddle/Slack, understanding upstream priorities, active listening, shared goals.", "Reaches out directly to understand if the upstream team is facing competing fires, resource shortages, or spec ambiguities.", "Seeks to find a mutually agreeable timeline rather than lobbing passive-aggressive tickets across teams."]}, {"id": "KP2", "description": "Implements technical decoupling strategies: API mocks, contracts, and synthetic stubs.", "required": true, "acceptable_evidence": ["Listening cues: API contract mocking, WireMock, synthetic test fixtures, feature flags, modular decoupling, parallel workstreams.", "Agrees on an API interface specification (e.g., OpenAPI / Pydantic schema) and mocks the service locally.", "Continues developing downstream logic against synthetic fixtures so progress is not halted."]}, {"id": "KP3", "description": "Utilizes objective, constructive escalation mechanisms only when peer-to-peer alignment fails.", "required": true, "acceptable_evidence": ["Listening cues: transparent escalation, engineering manager alignment, impact assessment on roadmap, neutral framing.", "Escalates to engineering managers with concrete data on milestone impact and proposed compromise solutions, without pointing fingers."]}], "critical_failures": ["Waits passively and idly for the other team without communicating or taking any initiative to mock dependencies.", "Escalates aggressively to executive leadership immediately before attempting direct peer-to-peer collaboration.", "Expresses bitter or hostile resentment toward other engineering departments."]}'
WHERE `question_text` = 'How do you handle situations where you are blocked by another team and need to move forward?';

-- ID 1071: How do you collaborate with non-technical stakeholders to scope realis...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Translates high-level business goals into concrete, technically feasible problem formulations.", "required": true, "acceptable_evidence": ["Listening cues: active listening, demystifying AI capabilities, framing user pain points, setting realistic boundaries.", "Bridges business desires (e.g., ''we need an AI that answers all customer questions'') into scoped technical capabilities and failure modes.", "Clarifies what generative AI can reliably deliver vs. what requires deterministic programmatic logic."]}, {"id": "KP2", "description": "Educates stakeholders on non-determinism, hallucination mitigation, and probabilistic error rates.", "required": true, "acceptable_evidence": ["Listening cues: probabilistic models, accuracy vs precision/recall, human-in-the-loop fallback, SLA expectations, risk disclosure.", "Transparently explains that LLMs are not 100% deterministic and establishes acceptable error thresholds upfront.", "Designs human-in-the-loop escalation mechanisms for high-stakes workflows (e.g., financial or legal approvals)."]}, {"id": "KP3", "description": "Adopts an iterative co-design process with rapid mockups, feedback loops, and progressive releases.", "required": true, "acceptable_evidence": ["Listening cues: low-fidelity prototype, Streamlit demo, phased rollout, shared feedback spreadsheet/portal, user testing.", "Builds early proof-of-concept prototypes to let non-technical stakeholders test prompts and data outputs before full platform rollout."]}], "critical_failures": ["Over-promises 100% perfection or infallibility for generative AI solutions to please stakeholders.", "Uses dismissive, overly dense academic jargon that alienates non-technical business partners.", "Builds in isolation for months without validating requirements against real stakeholder needs."]}'
WHERE `question_text` = 'How do you collaborate with non-technical stakeholders to scope realistic AI requirements?';

-- ID 1779: How do you maintain engineering quality when facing aggressive deadlin...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Protects core quality gates: ruthless scope negotiation rather than compromising testing and security.", "required": true, "acceptable_evidence": ["Listening cues: MVP scope trimming, phased rollout, core vs nice-to-have features, preserving CI/CD tests, non-negotiable security.", "Collaborates with product managers to cut non-essential features so core reliability, data security, and unit tests are never sacrificed.", "Understands that cutting testing under pressure exponentially increases costly production outages later."]}, {"id": "KP2", "description": "Transparently logs and tracks deliberate technical debt with explicit repayment commitments.", "required": true, "acceptable_evidence": ["Listening cues: conscious technical debt, Jira debt backlog, documented architectural compromises, repayment sprint.", "When expedient architectural compromises must be made, documents them clearly and schedules remediation tickets in the immediate following sprint."]}, {"id": "KP3", "description": "Maintains clear stakeholder communication and proactive risk visibility.", "required": true, "acceptable_evidence": ["Listening cues: early escalation, risk burndown, transparent status updates, no eleventh-hour surprises.", "Flags scope creep or velocity bottlenecks early, giving product leadership time to re-prioritize before launch day."]}], "critical_failures": ["Silently cuts corners on unit testing, data validation, or security guardrails to hit an arbitrary deadline.", "Agrees passively to impossible timelines without pushing back on scope, leading to inevitable project burnout and failure.", "Conceals delays until the scheduled launch date, blindsiding the entire organization."]}'
WHERE `question_text` = 'How do you maintain engineering quality when facing aggressive deadlines and shifting scopes?';

-- ID 1815: How do you resolve conflicting product feedback from multiple cross-fu...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Brings competing feedback into the open: centralizes requests against core North Star business metrics.", "required": true, "acceptable_evidence": ["Listening cues: alignment on North Star metric, user personas, business objectives, shared meeting / review doc.", "Creates a single comparative matrix summarizing differing leadership viewpoints, customer impact, and technical feasibility.", "Anchors conversations around agreed-upon company objectives rather than individual executive seniority."]}, {"id": "KP2", "description": "Proposes empirical data resolution: A/B testing, user research spikes, and analytics.", "required": true, "acceptable_evidence": ["Listening cues: user testing, telemetry data, A/B experiments, prototype bake-off, feature flagging.", "Suggests letting live user behavior, conversion metrics, or qualitative user research resolve competing UI or functional opinions."]}, {"id": "KP3", "description": "Maintains professional neutrality, builds consensus, and documents the resolution.", "required": true, "acceptable_evidence": ["Listening cues: diplomatic mediation, decision documentation, executive alignment, clear ownership.", "Facilitates alignment meetings without taking emotional sides, and records the agreed trade-off in an architecture/product brief."]}], "critical_failures": ["Attempts to build conflicting features simultaneously to please everyone, resulting in an incoherent Frankenstein product.", "Chooses sides based purely on politics or personal relationships rather than data and user value.", "Complains privately about executive indecision without taking initiative to organize an alignment session."]}'
WHERE `question_text` = 'How do you resolve conflicting product feedback from multiple cross-functional leaders?';

-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Part 1B: Fix V142 Recruiter Questions (Clearing Misassigned 'AI Engineering' / 'Generative AI & LLMs')
-- ---------------------------------------------------------------------

-- DB ID 1144: Can you walk us through your resume and overall work experience?...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Presents a structured chronological career trajectory highlighting progression from foundational software engineering to AI/ML systems.", "required": true, "acceptable_evidence": ["Listening cues: Software engineering foundation, transition milestones, senior/lead platform responsibilities, production track record.", "Delivers a crisp 60-90 second narrative explaining how their engineering identity evolved.", "Articulates deliberate motivations behind career moves rather than reciting resume bullets line-by-line."]}, {"id": "KP2", "description": "Highlights flagship production systems delivered and the concrete modern tech stack leveraged.", "required": true, "acceptable_evidence": ["Listening cues: Python, FastAPI, RAG architectures, LangGraph/Agent frameworks, Vector DBs (Milvus, Pinecone), Docker, Kubernetes, CI/CD.", "Identifies 1-2 marquee production systems deployed to real users.", "Quantifies business impact, latency improvements, or efficiency gains achieved."]}, {"id": "KP3", "description": "Articulates team scope, cross-functional collaboration, and ownership boundaries.", "required": true, "acceptable_evidence": ["Listening cues: Individual contributor (IC) ownership, cross-functional pods, partnership with PMs/data scientists, peer mentorship.", "Clearly distinguishes their individual architectural and coding contributions from broader team deliverables."]}], "critical_failures": ["Delivers a rambling monologue exceeding 3 minutes without clear structure or narrative arc.", "Recites resume line-by-line without explaining the impact, rationale, or context of their work.", "Speaks entirely in passive voice (''we built'', ''the company did'') without identifying personal ownership."]}'
WHERE `question_text` = 'Can you walk us through your resume and overall work experience?';

-- DB ID 1181: How do you communicate your technical experience clearly to recruiters...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Demonstrates audience awareness by translating low-level technical jargon into clear business value and system outcomes.", "required": true, "acceptable_evidence": ["Listening cues: Business impact, user outcomes, high-level architecture, executive summary, plain English.", "Tailors explanations to recruiter personas by framing achievements around what the system solved rather than obscure syntax.", "Explains complex AI/ML concepts using accessible, high-level analogies."]}, {"id": "KP2", "description": "Utilizes structured communication frameworks (such as STAR or CAR) with quantified metrics.", "required": true, "acceptable_evidence": ["Listening cues: Situation-Task-Action-Result, concise narrative, quantifiable metrics (latency, cost, throughput).", "Packages accomplishments into punchy 60-second answers that recruiters can easily champion to hiring managers.", "Highlights measurable results (e.g., ''reduced API response times by 40%'', ''lowered token spend by 25%'')."]}, {"id": "KP3", "description": "Engages in collaborative conversation and checks for understanding.", "required": true, "acceptable_evidence": ["Listening cues: Active listening, checking for understanding, conversational pacing, clarifying questions.", "Pauses to ensure the recruiter has the information they need before diving deeper.", "Directly links past experience to the explicit requirements listed in the job description."]}], "critical_failures": ["Displays arrogance or condescension when speaking to non-technical talent partners.", "Overwhelms the interviewer with dense mathematical jargon or code-level minutiae without explaining the ''why''.", "Inability to summarize technical projects in plain English."]}'
WHERE `question_text` = 'How do you communicate your technical experience clearly to recruiters to improve your chances of progressing to interviews?';

-- DB ID 1187: How do you ensure your resume effectively represents your projects, to...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Applies an impact-driven bullet formulation focusing on quantifiable engineering outcomes (XYZ framework).", "required": true, "acceptable_evidence": ["Listening cues: Accomplished [X] measured by [Y] by doing [Z], action verbs, latency, throughput, cost reduction, scale.", "Quantifies accomplishments with concrete metrics rather than vague qualitative claims.", "Emphasizes business and system impact alongside technical implementation."]}, {"id": "KP2", "description": "Contextualizes technologies within real projects rather than presenting isolated skill lists.", "required": true, "acceptable_evidence": ["Listening cues: Tech stack contextualization, production vs self-study distinction, architectural depth.", "Pairs tools (e.g., Python, LangGraph, Redis, PostgreSQL) directly with the systems they were used to build.", "Clearly distinguishes production-grade systems from hobby prototypes or tutorial projects."]}, {"id": "KP3", "description": "Optimizes for visual hierarchy, scannability, and ATS keyword alignment.", "required": true, "acceptable_evidence": ["Listening cues: Clean hierarchy, ATS compatibility, scannable layout, eliminating outdated technologies.", "Organizes sections so technical recruiters can assess core strengths within a 15-30 second initial scan.", "Aligns core terminology with target AI Engineering job descriptions."]}], "critical_failures": ["Stuffing resumes with buzzwords and technologies the candidate cannot defend in a technical deep dive.", "Writing passive duty lists (e.g., ''Responsible for writing Python code'') without mentioning impact or tools.", "Claiming broad ownership of enterprise platforms without specifying their concrete module or role."]}'
WHERE `question_text` = 'How do you ensure your resume effectively represents your projects, tools, and technical expertise?';

-- DB ID 1190: How do you maintain professional relationships with recruiters or hiri...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Practices prompt, gracious, and transparent communication when declining or pausing opportunities.", "required": true, "acceptable_evidence": ["Listening cues: Prompt response, polite decline, transparent reasoning, professional appreciation.", "Acknowledges outreach promptly rather than leaving recruiters hanging or ghosting.", "Respectfully explains why the current timing, role level, or tech focus isn''t an immediate fit."]}, {"id": "KP2", "description": "Proactively nurtures long-term professional networks for future alignment.", "required": true, "acceptable_evidence": ["Listening cues: LinkedIn connection, mutual follow-up timeline, staying in touch, keeping doors open.", "Connects on professional channels and expresses genuine interest in staying in touch for future openings.", "Suggests reconnecting after specific career milestones (e.g., 6-12 months)."]}, {"id": "KP3", "description": "Adds mutual value by recommending qualified peers or colleagues when applicable.", "required": false, "acceptable_evidence": ["Listening cues: Peer referrals, community networking, recommending former colleagues.", "Offers to connect the recruiter with qualified colleagues in their network who are actively seeking roles."]}], "critical_failures": ["Ghosting recruiters or hiring teams after initial outreach, screening, or interview scheduling.", "Responding with rude, arrogant, or dismissive messages when an opportunity doesn''t match preferences.", "Breaking commitments or failing to communicate changes in job search status."]}'
WHERE `question_text` = 'How do you maintain professional relationships with recruiters or hiring managers when timing does not align?';

-- DB ID 1230: What are your key considerations when choosing between contract (hourl...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Analyzes the total financial picture and compensation mechanics between W2 FTE and contract hourly rates.", "required": true, "acceptable_evidence": ["Listening cues: Hourly bill rate vs annual salary, self-employment taxes (1099/C2C), health benefits, PTO, equity upside (RSUs/options).", "Demonstrates understanding that contract hourly rates must incorporate the cash equivalent of benefits, unpaid leave, and taxes.", "Compares equity potential at high-growth startups against guaranteed cash in contract engagements."]}, {"id": "KP2", "description": "Evaluates platform ownership, architectural longevity, and career trajectory goals.", "required": true, "acceptable_evidence": ["Listening cues: Long-term platform stewardship, product roadmap influence, organizational culture vs specialized burst consulting.", "Explains how full-time roles foster deep multi-year architecture ownership and cultural integration.", "Identifies contract benefits such as rapid exposure to varied technology stacks and focused delivery."]}, {"id": "KP3", "description": "Balances personal risk tolerance, market volatility, and engagement duration.", "required": true, "acceptable_evidence": ["Listening cues: Financial runway, contract stability, project extensions, market demand for niche AI expertise.", "Articulates personal career preferences based on current life stage, market conditions, and stability requirements."]}], "critical_failures": ["Demonstrating total ignorance of contractor tax and overhead implications (expecting contract rates equal to base salaries).", "Showing unmanaged bias or disdain toward either engagement model rather than analyzing them professionally.", "Unable to articulate personal career criteria and compensation requirements."]}'
WHERE `question_text` = 'What are your key considerations when choosing between contract (hourly) and full-time roles in AI/ML engineering?';

-- DB ID 1247: What factors do you consider when evaluating contract roles, including...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Evaluates financial terms, billing structure, and contract terms thoroughly.", "required": true, "acceptable_evidence": ["Listening cues: All-inclusive hourly rate, overtime compensation (1.5x vs straight time), payment cadence (Net 15/30), W2 vs C2C.", "Ensures the rate accounts for unpaid holidays, sick time, and gaps between assignments.", "Clarifies payment terms and billing verification processes."]}, {"id": "KP2", "description": "Assesses project scope clarity, Statement of Work (SOW) boundaries, and technical stack modernity.", "required": true, "acceptable_evidence": ["Listening cues: Well-defined SOW, deliverable milestones, modern tech stack (Python, LangGraph, vector DBs), realistic timelines.", "Investigates whether the client has clear architectural milestones versus chaotic, undefined requirements.", "Confirms the role offers meaningful engineering work rather than legacy maintenance."]}, {"id": "KP3", "description": "Investigates project runway, funding stability, extension track record, and potential conversion paths.", "required": true, "acceptable_evidence": ["Listening cues: Project runway, budget allocation, extension history, conversion to FTE possibility.", "Asks about client budget approvals and historical contract extension rates for engineering contractors.", "Clarifies whether contract extensions or FTE conversions are realistic possibilities."]}], "critical_failures": ["Accepting contract engagements without verifying scope, hours, or payment structures.", "Demanding contract rates disconnected from market reality without commensurate expertise.", "Failing to evaluate project viability and client stability."]}'
WHERE `question_text` = 'What factors do you consider when evaluating contract roles, including duration, pay rate, and potential for extension?';

-- DB ID 1270: What is your understanding of the role and engagement model (contract-...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Accurately explains the contract-to-hire structural timeline and transition mechanics.", "required": true, "acceptable_evidence": ["Listening cues: Initial contract evaluation period (typically 3-6 months), agency payroll, conversion milestone, transition to permanent W2.", "Demonstrates clear understanding that the engagement begins as an hourly contract before converting to a full-time role.", "Recognizes the role of the staffing agency during the initial contract phase."]}, {"id": "KP2", "description": "Frames the contract period as a mutual evaluation and de-risking opportunity.", "required": true, "acceptable_evidence": ["Listening cues: Two-way evaluation, cultural fit, technical velocity, mutual alignment, de-risking hiring decisions.", "Explains how C2H allows both the engineer to evaluate team culture/projects and the employer to evaluate technical capabilities.", "Treats the contract period as an active opportunity to prove engineering leadership and system ownership."]}, {"id": "KP3", "description": "Highlights the importance of pre-established conversion terms and clear performance benchmarks.", "required": true, "acceptable_evidence": ["Listening cues: Pre-negotiated conversion salary/equity, written performance criteria, clear conversion timeline.", "Advocates for clarity regarding target full-time compensation bands and performance expectations before starting."]}], "critical_failures": ["Assuming contract-to-hire guarantees automatic full-time conversion regardless of performance or budget.", "Confusing contract-to-hire with open-ended staff augmentation with no intention to convert.", "Displaying resentment toward the evaluation phase while applying for a C2H position."]}'
WHERE `question_text` = 'What is your understanding of the role and engagement model (contract-to-hire)?';

-- DB ID 1274: What kind of roles are you currently seeking, and what factors are inf...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Clearly defines target job titles, engineering scope, and technical domains.", "required": true, "acceptable_evidence": ["Listening cues: Senior/Lead AI Engineer, GenAI Systems Architect, ML Platform Engineer, backend distributed systems.", "Specifies core technical areas of focus (e.g., enterprise RAG, agentic workflows, LLM orchestration, model deployment).", "Avoids broad, non-committal answers (''I am open to any software job'')."]}, {"id": "KP2", "description": "Provides deliberate rationale for employment type preference aligned with career objectives.", "required": true, "acceptable_evidence": ["Listening cues: Long-term platform stewardship, equity upside, team culture, stability, or hourly consulting flexibility.", "Articulates why FTE (or contract) best supports their current professional and personal growth goals.", "Connects employment preference to their desired level of product ownership and organizational impact."]}, {"id": "KP3", "description": "Demonstrates pragmatic flexibility for exceptional opportunities.", "required": false, "acceptable_evidence": ["Listening cues: Pragmatic evaluation, high-impact teams, compelling technical problems, compensation alignment.", "Indicates willingness to consider outstanding opportunities that may differ slightly in engagement type if technical scope and compensation align."]}], "critical_failures": ["Claiming to want ''anything available'', signaling lack of focus, direction, or engineering passion.", "Expressing contradictory requirements regarding commitment, hours, or compensation.", "Unreasonable expectations about role seniority without corresponding experience."]}'
WHERE `question_text` = 'What kind of roles are you currently seeking, and what factors are influencing your preference for full-time versus contract positions?';

-- DB ID 1298: What steps do you take to prepare for an initial screening interview, ...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'EASY',
    `time_limit_seconds` = 60,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Conducts thorough research on the company, product portfolio, and engineering culture.", "required": true, "acceptable_evidence": ["Listening cues: Company mission, core product lines, business model, recent announcements, engineering blog, tech stack.", "Researches how the company leverages AI/ML and what technical challenges they face in the market.", "Reviews background of the interviewer or leadership team on LinkedIn."]}, {"id": "KP2", "description": "Aligns personal experience with job requirements and prepares structured STAR narratives.", "required": true, "acceptable_evidence": ["Listening cues: Job description breakdown, mapping achievements to requirements, concise elevator pitch, STAR method.", "Prepares 2-3 specific project examples demonstrating required skills with quantified outcomes.", "Refines their 60-second self-introduction tailored to the specific role."]}, {"id": "KP3", "description": "Prepares high-impact questions and verifies professional interview logistics.", "required": true, "acceptable_evidence": ["Listening cues: Thoughtful questions for interviewer, audio/video check, quiet workspace, stable connection.", "Prepares 2-3 strategic questions regarding team priorities, engineering roadmap, or hiring process next steps.", "Tests video conferencing software, camera, and microphone in advance."]}], "critical_failures": ["Showing up with zero knowledge of the company, product, or role applied for.", "Having no questions prepared for the interviewer when prompted.", "Technical or logistical carelessness (noisy environment, non-functional webcam/microphone, late arrival)."]}'
WHERE `question_text` = 'What steps do you take to prepare for an initial screening interview, such as a 30-minute video call with a hiring team?';

-- DB ID 1324: Do you think that the lead role for internal development has different...
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER',
    `subject` = NULL,
    `concept` = NULL,
    `difficulty_level` = 'MEDIUM',
    `time_limit_seconds` = 90,
    `ground_truth` = '{"key_points": [{"id": "KP1", "description": "Contrasts long-term architectural stewardship and tech debt accountability with scoped delivery.", "required": true, "acceptable_evidence": ["Listening cues: Long-term architectural ownership, technical debt, lifecycle maintenance, on-call accountability, SOW delivery boundaries.", "Explains how internal leads must live with the long-term maintainability, scaling bottlenecks, and operational costs of their decisions.", "Identifies that consultants are evaluated against specific deliverables, timelines, and contractual Statement of Work (SOW) milestones."]}, {"id": "KP2", "description": "Analyzes stakeholder dynamics, organizational politics, and cross-functional alignment.", "required": true, "acceptable_evidence": ["Listening cues: Cross-functional partnership, internal stakeholder trust, team mentorship, client relationship management, commercial scope.", "Explains that internal leads build long-term alignment across product, data, and executive stakeholders while fostering team culture.", "Notes that consultants navigate client expectations, scope change management, and knowledge transfer."]}, {"id": "KP3", "description": "Evaluates differences in velocity, standards enforcement, and business impact measurement.", "required": true, "acceptable_evidence": ["Listening cues: Sustainable velocity, engineering culture, knowledge handoff, ROI, client satisfaction.", "Contrasts a consultant''s emphasis on rapid enablement and handoff with an internal lead''s focus on team growth, architectural standards, and lasting business value."]}], "critical_failures": ["Displaying disparaging bias toward either role (e.g., claiming consultants write throwaway code or internal leads are unproductive).", "Failing to recognize long-term maintenance and technical debt as fundamental differences.", "Unable to differentiate between internal organizational leadership and external client advisory."]}'
WHERE `question_text` = 'Do you think that the lead role for internal development has different expectations or stakes compared to a consultant working for a contracted client?';

-- Part 2: Reclassify Misclassified Technical / System Design Questions
-- ---------------------------------------------------------------------

-- ID 11: Can you explain a real-world scenario where multiple agents collaborat...
UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN',
    `subject` = 'AI Engineering',
    `concept` = 'Agentic AI & Multi-Agent Systems'
WHERE `question_text` = 'Can you explain a real-world scenario where multiple agents collaborate to complete a complex task, including how responsibilities are divided?';

-- ID 42: How did you approach ticket triage and routing using agentic AI, and w...
UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN',
    `subject` = 'AI Engineering',
    `concept` = 'Agentic AI & Multi-Agent Systems'
WHERE `question_text` = 'How did you approach ticket triage and routing using agentic AI, and what were the main challenges?';

-- ID 153: What input/output formats and communication protocols did you use for ...
UPDATE `ai_prep_question_bank`
SET `category` = 'TECHNICAL',
    `subject` = 'AI Engineering',
    `concept` = 'Agentic AI & Multi-Agent Systems'
WHERE `question_text` = 'What input/output formats and communication protocols did you use for MCP-based tool interactions?';

-- ID 242: How did you design feedback loops, success conditions, and escalation ...
UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN',
    `subject` = 'AI Engineering',
    `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability'
WHERE `question_text` = 'How did you design feedback loops, success conditions, and escalation mechanisms in your agent workflows?';

-- ID 768: What is your experience with building or understanding challenger·cham...
UPDATE `ai_prep_question_bank`
SET `category` = 'TECHNICAL',
    `subject` = 'AI Engineering',
    `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability'
WHERE `question_text` = 'What is your experience with building or understanding challenger·champion model setups in an experimentation framework?';
