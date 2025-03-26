#!/bin/bash
set -eo pipefail

# Check if stack name is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <stack-name>"
    exit 1
fi

STACK_NAME=$1

# Get accountnumber
ACCOUNT_NUMBER=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="$STACK_NAME"-"$ACCOUNT_NUMBER"

#If the bucket doesn't exist, create it
BUCKET_CREATED=false
if ! aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    aws s3 mb s3://"$BUCKET_NAME"
    BUCKET_CREATED=true
fi

# upload notebook
KEY_PATH="$STACK_NAME"-notebooks
aws s3 sync ./notebooks s3://"$BUCKET_NAME"/"$KEY_PATH"

# deploy the stack
aws cloudformation create-stack \
    --stack-name "$STACK_NAME" \
    --template-body file://sagemaker.yaml \
    --parameters ParameterKey=CodeBucket,ParameterValue="$BUCKET_NAME" ParameterKey=CodeKeyPath,ParameterValue="$KEY_PATH" \
    --capabilities CAPABILITY_IAM

echo "Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"

# Create cleanup script
cat > cleanup.sh << EOF
#!/bin/bash

set -eo pipefail
STACK_NAME=$STACK_NAME
BUCKET_NAME=$BUCKET_NAME
BUCKET_CREATED=$BUCKET_CREATED

# Delete the CloudFormation stack
echo "Deleting CloudFormation stack \$STACK_NAME..."
aws cloudformation delete-stack --stack-name "\$STACK_NAME"

echo "Waiting for stack deletion to complete..."
aws cloudformation wait stack-delete-complete --stack-name "\$STACK_NAME"

# Empty and delete the S3 bucket only if we created it
if [ "\$BUCKET_CREATED" = true ]; then
    echo "Emptying and deleting S3 bucket \$BUCKET_NAME..."
    aws s3 rm s3://"\$BUCKET_NAME" --recursive
    aws s3 rb s3://"\$BUCKET_NAME"
fi

echo "Cleanup complete!"
EOF

chmod +x cleanup.sh

echo ""
echo "Stack deployment complete!"
echo "To clean up all resources when done testing, run: ./cleanup.sh"
echo ""

