Process-Documents-Containing-Scientific-Formulas-and-Charts-using-Anthropic-Claude
# Process Documents Containing Scientific Formulas and Charts using Anthropic Claude

This project demonstrates how to process scientific documents containing formulas, charts, and technical content using Amazon Bedrock's Claude model. The main component is a Jupyter notebook that showcases comprehensive document analysis capabilities.

## Key Features

The `process_scientific_docs.ipynb` notebook demonstrates:

- Converting PDF documents to processable image formats
- Extracting and converting mathematical formulas to LaTeX
- Analyzing charts and graphs with natural language descriptions
- Generating structured metadata from scientific papers
- Creating searchable knowledge bases from processed content


## Repository Structure

```
.
├── deploy.sh
├── README.md
├── sagemaker.yaml
└── notebooks
    ├── process_scientific_docs.ipynb
    └── utils
       └── knowledge_base.py
```

## Getting Started

### Prerequisites

- AWS Account with access to Amazon Bedrock
- Access to Anthropic Claude Sonnet 3.7 model

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Run teh deploy script to upload the code and create a SageMaker notebook instance 
```bash
chmod +x deploy.sh claude-scientific-docs
./deploy.sh
```

3. When the Cloudformaion deployment is complete
   - Go to [SageMaker AI -> Notebooks](https://console.aws.amazon.com/sagemaker/home?#/notebooks-and-git-repos)
   - Choose the notebook named **claude-scientific-docs-notebook** and select **Open JupyterLab** on the right
   - In the notebook, navigate to **notebooks/process_scientific_docs.ipynb** and walk through the sample code


## Using the Notebook

The `process_scientific_docs.ipynb` notebook is organized into the following sections:

1. **Data Preparation**
   - Downloads sample scientific papers from arXiv
   - Converts PDFs to page-by-page images
   - Prepares documents for multi-modal analysis

2. **Formula Extraction**
   - Identifies mathematical formulas in documents
   - Converts formulas to LaTeX format
   - Provides plain language descriptions

3. **Chart and Graph Analysis**
   - Interprets visual data from charts and graphs
   - Extracts trends and relationships
   - Generates textual descriptions of visual content

4. **Metadata Generation**
   - Extracts document metadata (title, authors, etc.)
   - Creates structured JSON metadata
   - Enables searchable document organization

5. **Comprehensive Processing**
   - Combines all analysis capabilities
   - Processes full documents end-to-end
   - Maintains document structure and context

6. **Knowledge Base Integration**
   - Prepares processed content for Bedrock Knowledge Base
   - Demonstrates data upload and organization
   - Enables semantic search capabilities

7. **Query Capabilities**
   - Shows how to query processed documents
   - Retrieves specific information about formulas and charts
   - Demonstrates natural language querying

## Supporting Components

The project includes additional components that support the notebook:

- `utils/knowledge_base.py`: Helper class for managing Bedrock Knowledge Bases
- `sagemaker.yaml`: CloudFormation template for deployment


## Cleanup

The deploy.sh script will generate a cleanup.sh file. When you are done testing the notbook, be sure to run the last step to empty the knowledg base bucket and delete the knowledge base. Then run the cleanup script
```bash
./cleanup.sh
```



## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

## Acknowledgments

- ArXiv for providing access to scientific papers
- Amazon Bedrock and Claude model for document processing capabilities

