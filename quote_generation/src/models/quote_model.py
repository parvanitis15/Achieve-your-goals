"""
Run this model in Python

> pip install azure-ai-inference
"""
import os
from azure.ai.inference import ChatCompletionsClient
from azure.ai.inference.models import SystemMessage, UserMessage
from azure.core.credentials import AzureKeyCredential

def generate_query_response(query: str, model: str = "gpt-4o", temperature: float = 1, max_tokens: int = 4096, top_p: float = 1) -> str:
    """
    Generate a response to a query using the Azure AI Inference API.

    Args:
        query (str): The query to generate a response for.
        model (str): The model to use for the completion.
        temperature (float): The temperature to use for the completion.
        max_tokens (int): The maximum number of tokens to generate.
        top_p (float): The top_p value to use for the completion.

    Returns:
        str: The response to the query.
    """
    # Ensure the GITHUB_TOKEN environment variable is set
    github_token = os.environ.get("GITHUB_TOKEN")
    if not github_token:
        raise EnvironmentError("GITHUB_TOKEN environment variable not set. Please set it before running the script.")

    client = ChatCompletionsClient(
        endpoint="https://models.inference.ai.azure.com",
        credential=AzureKeyCredential(os.environ["GITHUB_TOKEN"]),
    )

    response = client.complete(
        messages=[
            SystemMessage(content=""""""),
            UserMessage(content=query),
        ],
        model=model,
        temperature=temperature,
        max_tokens=max_tokens,
        top_p=top_p
    )

    return response.choices[0].message.content

if __name__ == "__main__":
    print(generate_query_response(query="Generate an inspiring quote about new beginnings, personal growth, or fresh starts. The quote should be concise, no longer than 20 words."))
