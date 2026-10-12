-- =====================================================================
-- Flyway Migration V158: Correct Question Assessment Categories
--
-- Reclassifies miscategorized questions in ai_prep_question_bank into their
-- true evaluation assessment types:
--   - TECHNICAL: Deep coding, language/framework mechanics, ML internals, DSA
--   - RECRUITER: Candidate background, career narrative, logistics, relocation, compensation
--   - SYSTEM_DESIGN: Macro architecture, end-to-end platform design, distributed systems
--   - HIRING_MANAGER: Engineering leadership, STAR behavioral, stakeholder alignment
--
-- Total updates: 266 targeted questions
-- Fully idempotent via WHERE question_text = '...'
-- =====================================================================

-- ---------------------------------------------------------------------
-- Reclassify 243 questions to SYSTEM_DESIGN
-- ---------------------------------------------------------------------
UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you integrate a graph database such as Neo4j into your agentic workflow, and how were graph query results used in generation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you deploy agent-based systems, and what considerations are important for production readiness?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your experience deploying AI agents to production, including reliability, monitoring, and scaling considerations?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you compare system design with and without MCP in terms of scalability and interoperability?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement MCP (Model Context Protocol) in your system, and what was the end-to-end flow from user query to database response?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach balancing work between backend development and AI/ML or agent-based system design?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What parts of the multi-agent system were completed, and what remained before production deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why would you choose an agentic architecture over a traditional programmatic pipeline, and what advantages does it provide?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you use AWS Lambda for event-driven processing in your system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you securely manage AWS access credentials in a production environment, and what role do IAM roles and secrets management play in this setup?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach testing your system, including unit, integration, and end-to-end testing, and how do you automate quality evaluation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach understanding a new and unfamiliar data environment, including schemas, data quality, and dependencies?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What key architectural changes and guardrails did you implement when moving your AI agents from prototype to production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What were the key architectural decisions behind building a reusable platform instead of isolated AI solutions?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why might certain bugs or performance degradation escape non-production environments and only manifest in production, and how do you prevent this?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement conversation history management in your application?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and present source citations to ensure transparency and traceability in responses?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach building production-grade AI systems compared to proof-of-concept prototypes?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What were the most common production issues you encountered, and how did you resolve them?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you control token usage and reduce costs in your system, including techniques like prompt caching?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you provide an overview of your roles and responsibilities, particularly your experience with NLP, LLMs, and production deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement the SQL generation pipeline, including validation and execution steps?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you evaluate and compare different LLMs for a production use case?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you explain how you designed evaluation pipelines for LLM-based systems and what metrics or methods you used to assess performance?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you monitor system performance online, including latency, token usage, and errors?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you scale your LLM-based application from low to high user volume, and what strategies did you use for latency and throughput optimization?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you evaluated and fine-tuned LLMs for domain-specific tasks in a production environment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What techniques would you use to optimize latency in an LLM-based system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What types of data did you handle in your pipeline, and how did you preprocess and structure them for LLM readiness?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your contributions to the ML Ops pipeline and how you supported the overall lifecycle?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you explain a project where you created or worked on an MLOps platform or put a model into production while following best practices?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Detail your process and experience in building a complete machine learning pipeline.';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you deploy your system in production, including tools like Docker and Kubernetes?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you use tools like Prometheus and Grafana for observability and monitoring in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach building and deploying machine learning or AI systems in production environments, particularly in an MLOps context?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you monitor and maintain reliability in production AI systems using tools like CloudWatch and Prometheus?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you monitor models in production, and what tools do you use for observability and tracing?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you used tools like Databricks, MLflow, and DVC to build reproducible ML pipelines and manage model versioning?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What approaches have you used for monitoring and logging in production ML systems?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What criteria do you use to decide whether a model should be registered and deployed to production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What experience do you have with MLOps, particularly in moving machine learning models from prototype to production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What experience do you have with model tracing, ML pipelines, and MLOps practices?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is your process for deploying a machine learning or AI system into production and maintaining it over time?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What observability tools have you used, and how do they help in monitoring ML or Gen AI systems in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What strategies did you use to build and maintain robust ETL pipelines for supporting AI/ML workflows?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your experience with MLOps, including pipeline automation, deployment, and monitoring?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you explain your end-to-end deployment process from code commit to production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Did your work on ML pipelines include managing the underlying infrastructure or platform?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and deploy machine learning models for the loan approval system at LendingClub?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement an end-to-end machine learning pipeline for the insurance recommendation system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you monitor and observe system performance in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach the product development lifecycle for AI/ML systems, from ideation to deployment and post-production monitoring?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you balance responsibilities between MLOps infrastructure and product-focused development in an end-to-end ML workflow?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you evaluate and debug issues in AI/ML pipelines, especially in production environments?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you set up and manage CI/CD pipelines for full-stack applications using tools like GitHub Actions or Jenkins?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How does your experience in MLOps support model deployment and serving in production environments?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you applied MLOps practices, including containerization (Docker), model tracking (MLflow), and deployment pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you designed and implemented end-to-end ML pipelines using tools like MLflow?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How was your solution deployed in production, and what role did AWS EKS, CI/CD, and containerization play?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you approach improving a multi-stage deduction prediction pipeline, particularly in areas like merchant extraction, categorization, and classification?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you approach onboarding into an unfamiliar data environment with existing pipelines and systems?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you approach onboarding yourself to an existing data ecosystem with multiple pipelines and data sources?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you differentiate between failures caused by data issues versus model issues in a production pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you handle password-protected PDFs in an automated data processing pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Once a model is deployed to production, how would you identify and address data drift?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Walk through your systematic process for debugging broken system integrations, including initial steps like log analysis, checking dependencies, and traversing the entire pipeline.';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What approach would you take to design a retraining pipeline for continuously improving a recommendation model?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What are the key steps in taking an ML system from research prototype to production deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What deployment strategies have you used for machine learning or generative AI applications in production environments?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is your process for taking a model from development to production, including testing, evaluation, and deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What monitoring and alerting mechanisms would you implement to detect anomalies and debug production issues?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What monitoring strategies did you use for production ML systems, including latency, error rates, and model drift detection?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What role did you play in setting up MLOps pipelines for real-time model deployment and monitoring, and what tools and frameworks did you use?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What strategy did you use for model deployment and A/B testing in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What trade-offs do you consider when deciding between working on end-to-end ML pipelines versus focusing on specific components of the system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What triggers did you configure in your CI/CD pipeline, and how were they used?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What types of documents were included in your knowledge base, and how did their structure impact your pipeline design?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'As a technical lead, what responsibilities did you handle across prototyping, design, and production deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you explain your experience with CI/CD pipelines and how you have implemented them using GitHub Actions?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Could you clarify how you would configure Airflow to handle retries and error handling during the execution of tasks in a large-scale unstructured data processing pipeline? Additionally, how would you ensure task dependencies are properly managed?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you balance model performance and latency constraints when deploying models for real-time inference?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you containerize your application and manage CI/CD pipelines for deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design the data preprocessing pipeline for handling diverse inputs like call transcripts, emails, and forums?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design the query processing pipeline, including query optimization and preprocessing?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design your data preprocessing pipeline for handling unstructured data, and what tools did you use?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement CI/CD pipelines for ML workflows, and what role did tools like GitHub Actions, Helm charts, and MLflow play?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement CI/CD pipelines for your AI applications?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement security, compliance controls, and guardrails across different stages of the AI pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you preprocess and handle unstructured data such as resumes and job descriptions in your pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you design an end-to-end MLOps pipeline, including data versioning, experiment tracking, model training, and deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you design and deploy end-to-end ML/AI systems using cloud infrastructure and MLOps tools?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you incorporate automated evaluation frameworks (e.g., DeepEval) into CI/CD pipelines, and how do you handle long-running evaluations?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you monitor and evaluate model performance in production environments using tools like CloudWatch or Prometheus?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you designed and deployed infrastructure for AI systems using tools like Kubernetes, Terraform, and CI/CD pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you designed and implemented end-to-end machine learning pipelines, from data preprocessing to deployment and serving?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you implemented CI/CD pipelines for ML systems, and what steps did you include for testing, building, and deploying models into staging and production environments?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you implemented CI/CD pipelines for machine learning systems, and what tools did you use?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What does a CI/CD pipeline for an AI/ML system look like, including testing, evaluation, and deployment stages?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is your experience with MLOps workflows, including model deployment, versioning, and monitoring in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What metrics did you track for system performance, cost, and latency monitoring?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What role did document preprocessing play in your pipeline, and how did you implement it?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What strategies did you use for monitoring model performance, API uptime, and latency using Grafana and Prometheus?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What tools and processes did you use for CI/CD and production deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you explain your experience managing the end-to-end machine learning lifecycle at Lending Club?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you monitor models in production and detect issues such as data drift, model drift, or performance degradation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is model drift, and how would you detect and address it in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you monitor and maintain intent classification performance in production, including handling data drift and class distribution shifts?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is Pydantic, and how does it help enforce data validation and schema consistency in Python applications?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe a real-world machine learning problem you worked on involving RAG or agentic AI, including the end-to-end pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your experience working on agentic AI concepts and how you extended your RAG pipeline into an agent-based system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you provide a high-level overview of your experience working with AI systems, particularly focusing on retrieval-augmented generation (RAG) pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Explain me about any of the RAG pipeline that you have built.';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you ensure your RAG system performs consistently when moving from POC to production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you manage session handling, caching, and credential storage in web applications such as those built with Streamlit?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you update and version your knowledge base using ingestion pipelines and metadata?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How frequently did you run the ingestion pipeline, and what factors influenced this decision?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you leveraged AWS services like Bedrock, Lambda, API Gateway, CloudWatch, and EKS in deploying AI applications?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you used SQL in production systems, particularly for data retrieval and filtering in ML pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'In what scenarios would you use an agent-based system instead of a standard RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What approaches have you used for document ingestion and hybrid retrieval in your RAG pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What are the advantages and drawbacks of using overlapping chunks in text processing pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What chunking strategies have you used in RAG pipelines, and how do overlap and semantic chunking impact retrieval quality?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What considerations did you make when selecting like Milvus and Pinecone, and how did you manage metadata for efficient retrieval?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What considerations did you take into account when selecting and integrating like Milvus into your solution?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What considerations guide your choice and usage of such as ChromaDB or Milvus in a RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What factors influenced your choice of such as ChromaDB, Milvus, and PGVector, and how did you use them in different stages?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What factors influenced your choice of vector database, and why did you select Milvus over alternatives like FAISS or ChromaDB?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is the role of reranking in retrieval pipelines, and how does it impact final responses?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is your understanding of the topics covered in a generative AI program, such as LLMs, prompt engineering, RAG pipelines, MLOps, and AI agents?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What lessons did you learn from building and scaling the evaluation pipeline for your RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What ranking or re-ranking mechanisms have you used in RAG pipelines, and how do they improve retrieval quality?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What role does a vector database like Milvus play in your system, and how is it integrated?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What specific metrics do you track for generation evaluation and retrieval evaluation in your production-level agents, and how do these quantify the Return on Investment (ROI) of your AI projects?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What strategies would you use for chunking and adding metadata to improve retrieval quality in a RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Where do you use Milvus for vector search?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why did you use Neo4j alongside a vector database, and how did it enhance retrieval?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe the RAG-based AI assistant you built, including the full pipeline from data ingestion and preprocessing to embedding generation, storage, and query handling?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your experience building RAG-based applications, including how you handled data ingestion, embedding generation, and retrieval pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you describe your experience designing and deploying RAG pipelines and LLM-powered chatbots, including the tools and frameworks you used?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Can you walk through your experience building and productionizing a RAG-based system from proof of concept to deployment?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Explain the trade-off between fine-tuning a model versus using advanced prompt engineering and RAG, addressing factors such as cost, latency, accuracy requirements, and data volatility.';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and evaluate different chunking strategies, and what factors led you to finalize a specific chunk size and overlap?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement a RAG pipeline using tools like LangChain and such as Milvus, ChromaDB, and PGVector?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement a multi-agent system, and how does it differ from a traditional RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement hybrid retrieval (FAISS + BM25), and what benefits did it provide over single-method retrieval?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement hybrid retrieval methods (dense + keyword search) and reranking mechanisms in your RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement hybrid retrieval pipelines combining semantic embeddings and keyword-based methods like BM25?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement the document ingestion pipeline for sources like PDFs, Confluence pages, and internal knowledge bases?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement the ingestion and query pipelines in your RAG system, and how do they interact during a user query?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement the ingestion pipeline for processing documents such as PDFs and HTMLs?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement the ingestion pipeline, and which tools did you use for scraping and orchestration?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement the retrieval mechanism in your RAG system, and what and embedding models did you use?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and manage the knowledge base, including the choice of like ChromaDB and Milvus?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and manage, including embedding generation and storage strategies?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and use an AI code wiki as a knowledge base, and how did it integrate with your RAG system for code understanding?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design the ingestion and retrieval pipelines, and what were your key responsibilities in these components?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design the query understanding, retrieval, and synthesis stages, and what role did each play in the pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you evaluate and compare like ChromaDB, Faiss, and Milvus before selecting Milvus for production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you evaluate retriever quality and generation quality before production release?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you improve retrieval accuracy and reduce hallucinations in your RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you design and implement the retrieval and generation pipeline, including LLM integration, in a production RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you design similarity search pipelines for retrieving relevant documents from a vector database?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you handle document drift and its impact on retrieval quality in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you implement reranking and query optimization in a RAG pipeline, and what impact do they have on final output quality?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What specific optimization strategies do you employ to reduce end-to-end latency in a Retrieval-Augmented Generation (RAG) system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How does reranking improve retrieval relevance, and how did you implement it in your pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How does your document preprocessing and chunking pipeline work, and how do you manage continuous ingestion of new data?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How does your system handle query optimization, embedding, retrieval, reranking, and response generation in the query pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How have you designed and implemented end-to-end RAG systems that integrate both structured and unstructured data?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you structure a retriever pipeline, including query embedding, similarity computation, and top-k retrieval?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'I see two different vector databases on your CV; what is the difference between Chroma DB and Milvus, and when would you select one versus the other?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did your vector database architecture evolve (e.g., migrating to Milvus) as your data and query volumes scaled to production levels?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What approach did you take to build semantic search systems using like Milvus, and how did you evaluate their effectiveness?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What chunking strategy did you use in your RAG pipeline, and how do chunk size and overlap impact retrieval performance?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What considerations and trade-offs did you encounter when selecting such as Milvus, Pinecone, or others for your RAG systems?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What evaluation metrics and frameworks did you use to assess retrieval and generation quality in your RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What evaluation metrics did you use for your retrieval and generation pipeline, and how did you decide which metrics were most important?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What evaluation metrics did you use to measure retrieval effectiveness and generated response quality in your RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What factors led to your migration from an initial database solution to PGVector and later to Milvus, and what trade-offs did you consider at each stage?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is your experience with like Milvus, and how do they integrate into retrieval-augmented generation systems?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What role did reranking play in your pipeline, and how was it implemented?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What were the critical design decisions you made when building your RAG pipeline, especially regarding data cleaning and chunking strategy?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What were the trade-offs and reasons for choosing like ChromaDB initially and later migrating to Milvus?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why are embeddings critical in a RAG pipeline, and how do they enable efficient semantic retrieval?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why did you choose Milvus as the vector database, and what advantages did it provide?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why did you choose Milvus as your vector database over alternatives like ChromaDB or relational databases?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why did you choose your document processing and embedding tools, and how did they perform in production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Why did you select Milvus as your vector database over alternatives like ChromaDB or Pinecone, and what specific features made it suitable for production scale?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you address latency and hallucination issues in your AI system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you approach preprocessing in your RAG pipeline, and what role did document chunking play in improving retrieval performance?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you compare different embedding models, and what trade-offs led you to choose specific models for production versus experimentation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement a hybrid retrieval system, and what problem did it solve compared to pure semantic search?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and implement hybrid retrieval in your RAG system, and what trade-offs did you consider between semantic and keyword search?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and optimize the knowledge base to ensure accurate retrieval in your RAG system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design and optimize the retrieval component in your RAG system, including embedding generation and similarity search?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement and optimize hybrid retrieval in your RAG pipeline?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement evaluation pipelines using tools like RAGAS, DeepEval, and LLM-as-a-judge?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you implement re-ranking in your retrieval pipeline, and what impact did it have on performance?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you preprocess and chunk documents in your RAG pipeline, and what led you to choose recursive character splitting over other methods?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What strategies did you apply to optimize retrieval and generation performance in your RAG pipelines?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How does the Vault platform architecture support multiple applications like R&D;, quality, safety, and compliance on a shared data foundation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What modifications or enhancements did you make to an existing UVM testbench to improve scalability and functionality?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'Have you worked on designing novel loss functions or custom model architectures for discriminative or generative tasks?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design and implement a scalable UVM testbench architecture from scratch, including key components and their roles?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'What is the difference between dense models and mixture-of-experts models, and how do their architectures impact performance and efficiency?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect a multi-agent workflow that takes a Jira bug ticket, retrieves repository code from GitHub, performs root-cause analysis (RCA), and generates a verified code fix and unit test?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable backend architecture capable of handling concurrent execution of thousands of autonomous agents with high query volumes?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect an autonomous GitHub PR review companion agent that parses git diffs, extracts relevant repository context via ASTs, posts inline suggestions, and knows when to escalate to human reviewers?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect an end-to-end agentic workflow to triage incoming Jira bug reports: reproducing the failure, locating faulty files across the codebase, generating regression unit tests, and proposing candidate patches?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect and implement that workflow using an agent-based approach?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect an agentic system for business alert processing, including the roles of different agents?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system that integrates multiple AI applications through a shared orchestration layer or MCP server?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system that supports multiple agents or agent swarms working together on complex tasks?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design an end-to-end agent pipeline for healthcare use cases such as data curation, imputation, and decision support?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you architect an agent-based orchestrator that optimizes long-term user retention and trust instead of only single-match transactions?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to auto-generate test sequences or test plans using AI within a hardware verification workflow?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to automate extraction of structured data from financial PDFs into a spreadsheet?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to continuously adapt OCR models to new document formats, such as newly introduced tax forms?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system for contract analysis that extracts key clauses, compares them to standard templates, and highlights risks using AI?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system that handles peak loads efficiently while minimizing infrastructure costs during idle periods?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to support reprocessing of files in case of failures or outages?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design an end-to-end MLOps pipeline for training, validating, and deploying models into production?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to identify which stage of the pipeline (ingestion, preprocessing, model, deployment) is responsible for failures?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design an end-to-end fraud detection system, including data, model, and deployment layers?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach system design for integrating multiple ML models into a unified platform with standardized interfaces?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a RAG system for a large corpus of legal contracts, including storage, retrieval, and serving components?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a RAG-based agent system for an insurance claim workflow, including data retrieval, validation, and decision-making?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable knowledge base system in AWS for processing and retrieving information from billions of documents?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system that leverages past user interactions to provide personalized recommendations and insights?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to show users the exact source (sentence or paragraph) of retrieved information in a document?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable ML system architecture for handling multiple AI agents and high query volumes?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to ensure that document retrieval is restricted to a specific department using metadata filtering?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How did you design a scalable framework that allows multiple teams to upload documents and use the AI assistant across domains?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach system design for AI platforms in fast-paced, ambiguous startup environments?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How do you approach system design for scalable, production-grade GenAI applications end-to-end?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable and fault-tolerant message processing system using queues like SQS?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable system for automating healthcare revenue cycle processes using generative AI?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a shared backend system for both mobile and web applications?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to answer questions from both unstructured documents and structured databases?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a REST API to handle large data payloads efficiently without overloading the system?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a system to handle multimodal data (text, images, audio) in a scalable architecture?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a billing and rate-limiting system for an LLM-based application, including token tracking and usage control?';

UPDATE `ai_prep_question_bank`
SET `category` = 'SYSTEM_DESIGN'
WHERE `question_text` = 'How would you design a scalable LLM application that grows from a few users to millions?';

-- ---------------------------------------------------------------------
-- Reclassify 21 questions to RECRUITER
-- ---------------------------------------------------------------------
UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you evaluate opportunities across different types of companies, such as startups versus established organizations?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How would you present yourself to align with a team culture that values positivity, passion, and collaboration?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'What qualities define an ideal candidate for this role, and how do you evaluate technical disagreements within a team?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'What professional certifications or continuous learning initiatives have you completed, and how have they influenced your engineering practices?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'What questions do you typically ask the hiring team to evaluate team culture, technical autonomy, and engineering practices?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'What would you like to know about the next steps in the hiring process?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you prepare for technical interviews involving Python coding, machine learning concepts, and scenario-based problem solving?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Are you comfortable participating in a live coding interview using Python?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you prepare for coding interviews, particularly those focused on Python and real-time problem solving?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you handle situations where you are unable to demonstrate code execution during an interview or live session?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Are you interested in transitioning into a research-oriented role, and what steps have you taken toward that?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you evaluate risk, runway, and the balance between base cash compensation and long-term equity upside when deciding whether to join an early-stage startup?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Can you walk me through your current role, responsibilities, and recent work in AI/ML systems?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Can you walk me through your overall experience and transition from software engineering to AI/ML, including key projects you''ve worked on?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Do you have experience working in specific domains such as biotech, pharma, or life sciences, and how relevant is your background to those industries?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Give a quick introduction of your work and experiences in this world.';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Have you previously been submitted to a client or company for a similar role, and how do you track such submissions?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'What are your expectations regarding the hiring process and next steps after recruiter screening?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How do you evaluate opportunities that require immediate relocation versus delayed relocation?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'How would you communicate relocation timelines clearly and professionally during interviews?';

UPDATE `ai_prep_question_bank`
SET `category` = 'RECRUITER'
WHERE `question_text` = 'Can you walk us through your background and experience building end-to-end AI systems using RAG and agentic architectures?';

-- ---------------------------------------------------------------------
-- Reclassify 1 questions to HIRING_MANAGER
-- ---------------------------------------------------------------------
UPDATE `ai_prep_question_bank`
SET `category` = 'HIRING_MANAGER'
WHERE `question_text` = 'How do you communicate complex AI system design decisions and trade-offs effectively to both technical and non-technical stakeholders?';

-- ---------------------------------------------------------------------
-- Reclassify 1 questions to TECHNICAL
-- ---------------------------------------------------------------------
UPDATE `ai_prep_question_bank`
SET `category` = 'TECHNICAL'
WHERE `question_text` = 'Given an array of n+1 integers with values ranging from 1 to n, how would you find the duplicate number?';
