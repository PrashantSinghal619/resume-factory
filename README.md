# resume-factory

n8n and LLM instructions for generating resumes customised to job descriptions.

---

## 📁 Repository Structure

```
resume-factory/
│
├── base/
│   └── resume.tex              # Master LaTeX resume (never edit directly)
│
├── output/
│   ├── tex/                    # LLM-generated .tex files (one per application)
│   └── pdf/                    # Compiled PDF resumes
│
├── prompts/
│   ├── jd_parser.txt           # Prompt: extract structured data from a JD
│   ├── resume_optimizer.txt    # Prompt: tailor the resume for a specific JD
│   └── drafts.txt              # Prompt: generate recruiter email + LinkedIn message
│
└── scripts/
    └── compile.sh              # Shell script to compile a .tex file to PDF
```

---

## 🚀 Quick Start

### Prerequisites

- A LaTeX distribution with `latexmk` (e.g. [TeX Live](https://www.tug.org/texlive/) or [MiKTeX](https://miktex.org/))
- Access to an LLM (e.g. ChatGPT, Claude, or any model via n8n)

### 1. Set up your master resume

Edit `base/resume.tex` with your personal details, experience, skills, and education. This file is your single source of truth — **never edit it per application**.

### 2. Parse the job description

Copy the contents of `prompts/jd_parser.txt` into your LLM, then paste the job description where indicated. The LLM returns structured JSON:

```json
{
  "company": "Acme Corp",
  "role": "Senior Backend Engineer",
  "portal": "LinkedIn",
  "keywords": ["Python", "Kubernetes", "REST APIs", ...],
  "priority_keywords": ["Python", "Kubernetes", "microservices", "CI/CD", "REST APIs"],
  "domain": "Backend Engineering"
}
```

### 3. Optimise the resume

Copy the contents of `prompts/resume_optimizer.txt` into your LLM. Provide:
- The full content of `base/resume.tex`
- The `keywords` and `priority_keywords` from Step 2
- The role title and company name

The LLM returns a tailored `.tex` file. Save it to:

```
output/tex/resume_<company>_<role>.tex
```

### 4. Compile to PDF

```bash
./scripts/compile.sh output/tex/resume_acme_backend_engineer.tex
```

The compiled PDF will be saved to `output/pdf/`.

### 5. Generate outreach drafts

Copy the contents of `prompts/drafts.txt` into your LLM. Provide:
- A brief summary of your background
- The role title, company name, and your full name

The LLM generates a recruiter email and a LinkedIn referral message ready to send.

---

## 📄 Prompt Reference

| File | Purpose |
|------|---------|
| `prompts/jd_parser.txt` | Extract ATS keywords and metadata from any job description |
| `prompts/resume_optimizer.txt` | Minimally tailor the master resume for a specific JD |
| `prompts/drafts.txt` | Generate a recruiter cold email and LinkedIn referral message |

---

## ⚙️ compile.sh

```bash
# Usage
./scripts/compile.sh <path-to-tex-file>

# Example
./scripts/compile.sh output/tex/resume_google_swe.tex
```

---

## 📝 Workflow Summary

```
JD → jd_parser.txt → keywords JSON
                          ↓
base/resume.tex → resume_optimizer.txt → output/tex/*.tex → compile.sh → output/pdf/*.pdf
                          ↓
                     drafts.txt → recruiter email + LinkedIn message
```

---

## License

MIT © Prashant Singhal
