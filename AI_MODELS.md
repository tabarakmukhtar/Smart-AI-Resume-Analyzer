# AI Models in Smart Resume Analyzer

Smart Resume Analyzer uses advanced AI models to provide detailed analysis and feedback on your resume. This document explains the AI models integrated into the application and how they work.

## Available AI Models

### 1. Google Gemini

Google Gemini is a powerful AI model developed by Google that offers state-of-the-art natural language processing capabilities. In Smart Resume Analyzer, Gemini is used to:

- Analyze resume content and structure
- Identify key skills and missing skills for target roles
- Provide personalized recommendations for improvement
- Score resumes based on quality and relevance

## How AI Analysis Works

When you upload your resume for AI analysis, the following process occurs:

1. **Text Extraction**: The system extracts text from your PDF or DOCX resume
2. **AI Processing**: The selected AI model (Gemini or Claude) analyzes the resume text
3. **Structured Analysis**: The AI generates a structured analysis including:
   - Overall assessment
   - Skills analysis (current and missing skills)
   - Strengths
   - Areas for improvement
   - Recommended courses
   - Resume score (0-100)

## Configuring AI Models

To use these AI models, you need to set up API keys in your `.env` file:

```
# API Keys for AI Models
GOOGLE_API_KEY=your_google_api_key_here
```

- For Google Gemini, you need a Google API key from [Google AI Studio](https://makersuite.google.com/)

## Privacy and Data Handling

When using the AI analysis features:

- Resume data is sent to the respective AI model providers (Google or Anthropic via OpenRouter)
- Analysis results are stored in the local database for reference
- No personal data is shared with third parties beyond what's necessary for analysis
- You can delete your data at any time through the application

## Future AI Integrations

We plan to integrate additional AI models in the future to provide even more comprehensive resume analysis and feedback. Stay tuned for updates! 