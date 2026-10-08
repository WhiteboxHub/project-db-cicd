-- =====================================================================
-- Flyway Migration V143: Normalize Subject-Concept Taxonomy
--
-- Corrects subject-concept misalignments from V140 and V141 by assigning
-- each concept to its canonical subject per the standardized 18-concept taxonomy:
--
--   AI Engineering:
--     Python & Data Manipulation, ML & Deep Learning Fundamentals,
--     ML Frameworks & Tooling, NLP, Generative AI & LLMs,
--     RAG & Retrieval, Agentic AI & Multi-Agent Systems,
--     Models & Context Engineering,
--     AI Systems Ops: Evaluation, Guardrails & Observability
--
--   Software Engineering:
--     System Architecture & Design, API Design & Microservices,
--     Databases & Caching, Concurrency & Async Systems,
--     Data Structures & Algorithms
--
--   DevOps and Cloud:
--     Containers & Orchestration, CI/CD & GitOps,
--     Cloud Architecture & Services, Infrastructure as Code & Security
--
-- TARGETED POPULATION SCOPE:
--   Precisely targets the exact 47 questions identified across V140 (37 rows)
--   and V141 (10 rows) using unique question_text identifiers.
--   Zero collateral impact on existing active/inactive statuses or unrelated rows.
--
-- ROLLBACK & RECOVERY STRATEGY:
--   This migration is a forward-only data normalization migration. Because multiple
--   source subjects (e.g. DevOps and Cloud, Software Engineering) are consolidated
--   into canonical subjects (e.g. AI Engineering), an inverse UPDATE based purely on
--   post-migration subject/concept values is non-deterministic. If recovery is required,
--   restore from the pre-migration database snapshot or apply a forward corrective migration.
-- =====================================================================

UPDATE `ai_prep_question_bank`
SET `subject` = CASE
    WHEN `concept` IN (
        'Python & Data Manipulation',
        'ML & Deep Learning Fundamentals',
        'ML Frameworks & Tooling',
        'NLP',
        'Generative AI & LLMs',
        'RAG & Retrieval',
        'Agentic AI & Multi-Agent Systems',
        'Models & Context Engineering',
        'AI Systems Ops: Evaluation, Guardrails & Observability'
    ) THEN 'AI Engineering'
    WHEN `concept` IN (
        'System Architecture & Design',
        'API Design & Microservices',
        'Databases & Caching',
        'Concurrency & Async Systems',
        'Data Structures & Algorithms'
    ) THEN 'Software Engineering'
    WHEN `concept` IN (
        'Containers & Orchestration',
        'CI/CD & GitOps',
        'Cloud Architecture & Services',
        'Infrastructure as Code & Security'
    ) THEN 'DevOps and Cloud'
    ELSE `subject`
END
WHERE `question_text` IN (
    -- V140 Misaligned Questions (37 rows)
    'What characteristics define an AI agent, and how do its core components (tools, memory, planning, control) interact during execution?',
    'What is the difference between LangChain and LangGraph? What are their strengths and limitations, and when would you choose each?',
    'What type of object does a successful tool call return (string, list, dict, message object), and how would you confirm from the response that the call actually succeeded?',
    'What considerations apply to AI in healthcare or manufacturing, and how do you build a pilot MVP in a regulated domain?',
    'How do you deploy agent systems, and what matters for production readiness?',
    'When should you use agents versus traditional deterministic or rule-based systems, and when should you avoid agents?',
    'How do you evaluate and choose between frameworks? Have you used both options in a comparison, and what drove the choice?',
    'What is a challenger-champion setup in an experimentation framework?',
    'How do you support experimentation and model evaluation for data scientists?',
    'How do you design AI infrastructure for alerts, logs and proactive troubleshooting?',
    'What dimensions of a data ecosystem do you know (ingestion, storage, processing, governance, quality, serving)?',
    'If you scale a workflow with multi-threading or horizontally, how do you track thread IDs and implement logging?',
    'How do you identify workflows suitable for automation, and when do you choose deterministic automation over AI?',
    'How do you design a reusable framework where multiple teams upload their data and configure their own AI assistants (modular, reusable AI libraries)?',
    'Have you used Copilot Studio, Azure AI Foundry and Power Platform, and how would you use them in a project?',
    'How would you adapt to C/C++ (pointers, manual memory management) if required?',
    'How do you decide between self-hosted or open-source models and cloud-hosted models, and what trade-offs do you consider?',
    'How do you plan for and scale to a target number of concurrent users on AWS?',
    'Given a JSON list of events, compute counts per type, the top event type, and total purchase revenue.',
    'How do you handle empty inputs and prevent runtime errors?',
    'How do you vertically stack two DataFrames, and how do you update a column row-wise efficiently (trade-offs of apply)?',
    'How do you find duplicate records in a Spark DataFrame, and which Spark operations have you used?',
    'How do a data lake and a Delta Lake differ?',
    'How do you understand a new data environment (schemas, quality, undocumented behavior, dependencies)?',
    'How do you preprocess and validate data (missing values, outliers, versioning)?',
    'How do you analyze a decline in new-user spend (cohorts, segment shifts, product, pricing and onboarding changes, external factors)?',
    'How do you extract, structure and store document metadata consistently?',
    'How do you normalize unstructured sources (PDFs, wikis, HTML, manuals)?',
    'How do you prove a change really improved efficiency?',
    'How do you test AI and full-stack systems (unit, integration, end-to-end, contract), including BLEU and automated quality evaluation?',
    'With 50,000 users on a horizontally scaled system, how do you track which queries went where and provide explainability?',
    'How do you monitor and maintain an AI system (logging, alerting, OpenTelemetry and its limits)?',
    'How do you use Cursor and AI coding tools, integrate AI into the SDLC, and what does "AI-native development" mean?',
    'What are the challenges of scaling AI for compliance use cases (evaluation, guardrails, context)?',
    'How do you use DeepEval and CI/CD (for example GitHub Actions) with a golden dataset?',
    'How do you monitor, trace and observe LLM applications in production (latency, token usage, errors)?',
    'How do you productionize an ML/LLM system (infrastructure, API deployment, monitoring)?',

    -- V141 Misaligned Questions (10 rows)
    'What is the Global Interpreter Lock (GIL) in Python, and how does it impact multi-threaded CPU-bound versus I/O-bound tasks?',
    'In what scenarios would you specifically use Pydantic within agent architectures or LLM data pipelines?',
    'How does Python''s asyncio event loop work under the hood, and what happens when blocking code is executed inside a coroutine?',
    'How do Python generators and asynchronous generators (async for) enable memory-efficient streaming of LLM tokens?',
    'How does CPython''s cyclic garbage collector complement reference counting, and how can reference cycles cause memory leaks in stateful agent graphs?',
    'How do Python decorators work under the hood, and how do you write a parameterized decorator that preserves function metadata using functools.wraps?',
    'What is the difference between nominal subtyping using abstract base classes (abc.ABC) and structural subtyping using typing.Protocol in modern Python?',
    'How do you profile and optimize memory usage in high-throughput Python applications using tracemalloc and memory_profiler?',
    'How do Polars and Pandas differ in memory management, execution engines, and performance when processing multi-gigabyte datasets?',
    'When designing tool return payloads in Python for agent consumption, how do you structure return objects (BaseModel vs dict vs primitive strings) to optimize model comprehension and token consumption?'
)
-- Defensive condition: ensures already-correct rows are not unnecessarily updated
-- and limits mutation to rows whose current subject differs from the canonical subject.
AND (`subject` <> CASE
    WHEN `concept` IN (
        'Python & Data Manipulation',
        'ML & Deep Learning Fundamentals',
        'ML Frameworks & Tooling',
        'NLP',
        'Generative AI & LLMs',
        'RAG & Retrieval',
        'Agentic AI & Multi-Agent Systems',
        'Models & Context Engineering',
        'AI Systems Ops: Evaluation, Guardrails & Observability'
    ) THEN 'AI Engineering'
    WHEN `concept` IN (
        'System Architecture & Design',
        'API Design & Microservices',
        'Databases & Caching',
        'Concurrency & Async Systems',
        'Data Structures & Algorithms'
    ) THEN 'Software Engineering'
    WHEN `concept` IN (
        'Containers & Orchestration',
        'CI/CD & GitOps',
        'Cloud Architecture & Services',
        'Infrastructure as Code & Security'
    ) THEN 'DevOps and Cloud'
    ELSE `subject`
END OR `subject` IS NULL);

-- =====================================================================
-- PRE & POST MIGRATION VALIDATION CHECKS (Deployment Runbook / CI Verification)
-- =====================================================================

-- Precondition Check 1: Verify exactly 47 target rows and 47 distinct question texts exist
-- Expected: matched_rows = 47, distinct_question_texts = 47
-- SELECT
--     COUNT(*) AS matched_rows,
--     COUNT(DISTINCT question_text) AS distinct_question_texts
-- FROM ai_prep_question_bank
-- WHERE question_text IN (
--     -- 47 unique question texts enumerated in UPDATE clause above
-- );

-- Precondition Check 2: Verify zero duplicates exist among targeted question texts
-- Expected: 0 rows
-- SELECT question_text, COUNT(*) AS row_count
-- FROM ai_prep_question_bank
-- WHERE question_text IN (
--     -- 47 unique question texts enumerated in UPDATE clause above
-- )
-- GROUP BY question_text
-- HAVING COUNT(*) <> 1;

-- Precondition Check 3: Verify all 47 target questions have valid canonical concepts
-- Expected: 0 rows
-- SELECT question_text, concept
-- FROM ai_prep_question_bank
-- WHERE question_text IN (
--     -- 47 unique question texts enumerated in UPDATE clause above
-- )
--   AND concept NOT IN (
--       'Python & Data Manipulation', 'ML & Deep Learning Fundamentals',
--       'ML Frameworks & Tooling', 'NLP', 'Generative AI & LLMs',
--       'RAG & Retrieval', 'Agentic AI & Multi-Agent Systems',
--       'Models & Context Engineering',
--       'AI Systems Ops: Evaluation, Guardrails & Observability',
--       'System Architecture & Design', 'API Design & Microservices',
--       'Databases & Caching', 'Concurrency & Async Systems',
--       'Data Structures & Algorithms', 'Containers & Orchestration',
--       'CI/CD & GitOps', 'Cloud Architecture & Services',
--       'Infrastructure as Code & Security'
--   );

-- Postcondition Check 1: Verify all 18 concepts map to canonical subjects across entire DB
-- Expected: 0 rows
-- SELECT id, subject, concept, is_active
-- FROM ai_prep_question_bank
-- WHERE (
--     concept IN (
--         'Python & Data Manipulation', 'ML & Deep Learning Fundamentals',
--         'ML Frameworks & Tooling', 'NLP', 'Generative AI & LLMs',
--         'RAG & Retrieval', 'Agentic AI & Multi-Agent Systems',
--         'Models & Context Engineering',
--         'AI Systems Ops: Evaluation, Guardrails & Observability'
--     ) AND subject <> 'AI Engineering'
-- ) OR (
--     concept IN (
--         'System Architecture & Design', 'API Design & Microservices',
--         'Databases & Caching', 'Concurrency & Async Systems',
--         'Data Structures & Algorithms'
--     ) AND subject <> 'Software Engineering'
-- ) OR (
--     concept IN (
--         'Containers & Orchestration', 'CI/CD & GitOps',
--         'Cloud Architecture & Services', 'Infrastructure as Code & Security'
--     ) AND subject <> 'DevOps and Cloud'
-- );

-- Postcondition Check 2: Verify zero incorrectly normalized rows among the 47 targeted questions
-- Expected: 0 rows (incorrectly_normalized_count = 0)
-- SELECT COUNT(*) AS incorrectly_normalized_count
-- FROM ai_prep_question_bank
-- WHERE question_text IN (
--     -- 47 unique question texts enumerated in UPDATE clause above
-- )
-- AND (
--     (concept IN (
--         'Python & Data Manipulation', 'ML & Deep Learning Fundamentals',
--         'ML Frameworks & Tooling', 'NLP', 'Generative AI & LLMs',
--         'RAG & Retrieval', 'Agentic AI & Multi-Agent Systems',
--         'Models & Context Engineering',
--         'AI Systems Ops: Evaluation, Guardrails & Observability'
--     ) AND subject <> 'AI Engineering')
--     OR
--     (concept IN (
--         'System Architecture & Design', 'API Design & Microservices',
--         'Databases & Caching', 'Concurrency & Async Systems',
--         'Data Structures & Algorithms'
--     ) AND subject <> 'Software Engineering')
--     OR
--     (concept IN (
--         'Containers & Orchestration', 'CI/CD & GitOps',
--         'Cloud Architecture & Services', 'Infrastructure as Code & Security'
--     ) AND subject <> 'DevOps and Cloud')
-- );
